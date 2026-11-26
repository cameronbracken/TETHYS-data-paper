#!/usr/bin/env bash
# Build clean manuscript/RTR PDFs and tag-based latexdiff PDFs for review sharing.
#
# Environment overrides:
#   MAIN_TEX           Path to current manuscript .tex (auto-detected if unset)
#   RTR_TEX            Path to Response to Reviewers .tex (auto-detected if unset)
#   ENGINE             LaTeX engine for latexmk: lualatex | xelatex | pdflatex (default: lualatex)
#   SUBMITTED_GLOB     Tag glob for journal submission baseline (default: submitted-*)
#   REVIEW_GLOB        Tag glob for co-author review rounds (default: review-*)
#   MAX_REVIEW_TAGS    Max number of recent review tags to diff against HEAD (default: 2)
#   BASE_REF           Optional explicit Git ref (tag or SHA) for an ad-hoc diff
#   RTR_TEXTCMDS       Comma-separated custom text commands for RTR latexdiff (default: response)
#   OUT_DIR            Output directory for final PDFs and RELEASE_NOTES.md (default: dist/review)
#   RELEASE_TAG        Rolling release tag used for download links (default: latest-review)

set -euo pipefail

ROOT_DIR="$(git rev-parse --show-toplevel)"
cd "$ROOT_DIR"

ENGINE="${ENGINE:-lualatex}"
SUBMITTED_GLOB="${SUBMITTED_GLOB:-submitted-*}"
REVIEW_GLOB="${REVIEW_GLOB:-review-*}"
MAX_REVIEW_TAGS="${MAX_REVIEW_TAGS:-2}"
BASE_REF="${BASE_REF:-}"
RTR_TEXTCMDS="${RTR_TEXTCMDS:-response}"
OUT_DIR="${OUT_DIR:-dist/review}"
RELEASE_TAG="${RELEASE_TAG:-latest-review}"

detect_main_tex() {
  if [[ -n "${MAIN_TEX:-}" ]]; then
    echo "$MAIN_TEX"
    return
  fi
  if [[ -f "main.tex" ]]; then
    echo "main.tex"
    return
  fi
  local candidate
  candidate=$(python3 - <<'PY'
import re
from pathlib import Path

files = [p.name for p in Path(".").glob("main*.tex") if p.is_file()]
def sort_key(name: str):
    return [int(tok) if tok.isdigit() else tok for tok in re.split(r"(\d+)", name)]
print(sorted(files, key=sort_key)[-1] if files else "")
PY
)
  if [[ -z "$candidate" ]]; then
    echo "ERROR: Could not auto-detect main .tex file; set MAIN_TEX." >&2
    exit 1
  fi
  echo "$candidate"
}

detect_rtr_tex() {
  if [[ -n "${RTR_TEX:-}" ]]; then
    echo "$RTR_TEX"
    return
  fi
  for p in "revision/response_to_comments.tex" "response_to_comments.tex"; do
    if [[ -f "$p" ]]; then
      echo "$p"
      return
    fi
  done
  echo ""
}

# List tags matching a glob sorted by target commit timestamp descending (works
# identically for both annotated and lightweight tags, including retroactive tags).
tags_by_commit_date_desc() {
  local glob="$1"
  python3 - "$glob" <<'PY'
import subprocess, sys

glob = sys.argv[1]
tags = subprocess.check_output(["git", "tag", "-l", glob], text=True).splitlines()
rows = []
for t in tags:
    if not t:
        continue
    ts = int(subprocess.check_output(["git", "show", "-s", "--format=%ct", f"{t}^{{commit}}"], text=True).strip())
    rows.append((ts, t))
for _, t in sorted(rows, reverse=True):
    print(t)
PY
}

# Resolve which .tex path corresponds to a target file at a given Git ref.
resolve_tex_at_ref() {
  local ref="$1"
  local current_path="$2"
  if git cat-file -e "${ref}:${current_path}" 2>/dev/null; then
    echo "$current_path"
    return
  fi
  # Fallback for versioned root filenames (e.g. main_v5.tex -> main_v6.tex)
  if [[ "$current_path" == main*.tex && "$current_path" != */* ]]; then
    python3 - "$ref" <<'PY'
import re, subprocess, sys

ref = sys.argv[1]
names = subprocess.check_output(["git", "ls-tree", "--name-only", ref], text=True).splitlines()
cands = [n for n in names if re.match(r"^main.*\.tex$", n)]
def sort_key(name: str):
    return [int(tok) if tok.isdigit() else tok for tok in re.split(r"(\d+)", name)]
print(sorted(cands, key=sort_key)[-1] if cands else "")
PY
    return
  fi
  echo ""
}

# Move \begin{document} above \begin{abstract} when a journal class (e.g. wlscirep)
# places the abstract in the preamble, so latexdiff marks up abstract edits too.
normalize_abstract_for_latexdiff() {
  local src="$1"
  local dst="$2"
  python3 - "$src" "$dst" <<'PY'
import sys
from pathlib import Path

src, dst = Path(sys.argv[1]), Path(sys.argv[2])
s = src.read_text(encoding="utf-8")
if "\\begin{abstract}" in s and "\\begin{document}" in s:
    if s.index("\\begin{abstract}") < s.index("\\begin{document}"):
        s = s.replace("\\begin{document}\n", "", 1).replace(
            "\\begin{abstract}", "\\begin{document}\n\\begin{abstract}", 1
        )
dst.write_text(s, encoding="utf-8")
PY
}

latexmk_engine_flag() {
  case "$ENGINE" in
    lualatex) echo "-lualatex" ;;
    xelatex)  echo "-xelatex" ;;
    pdflatex) echo "-pdf" ;;
    *)
      echo "ERROR: Unsupported ENGINE='$ENGINE' (use lualatex, xelatex, or pdflatex)" >&2
      exit 1
      ;;
  esac
}

compile_tex() {
  local tex_path="$1"
  local use_bibtex="$2"
  local dir base flag
  dir="$(dirname "$tex_path")"
  base="$(basename "$tex_path")"
  flag="$(latexmk_engine_flag)"

  (
    cd "$dir"
    if [[ "$use_bibtex" == "yes" ]]; then
      latexmk "$flag" -bibtex -interaction=nonstopmode -halt-on-error "$base"
    else
      latexmk "$flag" -interaction=nonstopmode -halt-on-error "$base"
    fi
  )
}

sanitize_name() {
  echo "$1" | sed -E 's/[^A-Za-z0-9._-]+/-/g'
}

MAIN_TEX="$(detect_main_tex)"
RTR_TEX="$(detect_rtr_tex)"

echo "Repository root: $ROOT_DIR"
echo "Manuscript:      $MAIN_TEX"
echo "RTR:             ${RTR_TEX:-<none>}"
echo "Engine:          $ENGINE"

rm -rf "$OUT_DIR"
mkdir -p "$OUT_DIR"

TMP_WORK="$(mktemp -d "${TMPDIR:-/tmp}/review_diffs_XXXXXX")"
CREATED_TEMP_FILES=()
cleanup() {
  rm -rf "$TMP_WORK"
  if (( ${#CREATED_TEMP_FILES[@]} > 0 )); then
    for f in "${CREATED_TEMP_FILES[@]}"; do
      rm -f "$f" "${f%.tex}".{aux,bbl,blg,fdb_latexmk,fls,log,out,pdf,toc,xdv}
    done
  fi
}
trap cleanup EXIT

HEAD_SHA="$(git rev-parse --short HEAD)"
HEAD_FULL="$(git rev-parse HEAD)"
HEAD_DATE="$(git show -s --format='%cs' HEAD)"
HEAD_SUBJ="$(git show -s --format='%s' HEAD)"

# Track rows for RELEASE_NOTES.md: "filename|label|details"
NOTES_ROWS=()

# 1. Build clean manuscript PDF
echo "=== Building clean manuscript: $MAIN_TEX ==="
compile_tex "$MAIN_TEX" "yes"
MAIN_PDF="${MAIN_TEX%.tex}.pdf"
MAIN_PDF_NAME="$(basename "$MAIN_PDF")"
cp "$MAIN_PDF" "${OUT_DIR}/${MAIN_PDF_NAME}"
NOTES_ROWS+=("${MAIN_PDF_NAME}|Clean manuscript|Current \`${MAIN_TEX}\` at \`${HEAD_SHA}\` (${HEAD_DATE})")

# 2. Build clean RTR PDF if present
if [[ -n "$RTR_TEX" ]]; then
  echo "=== Building clean RTR: $RTR_TEX ==="
  compile_tex "$RTR_TEX" "no"
  RTR_PDF="${RTR_TEX%.tex}.pdf"
  RTR_PDF_NAME="$(basename "$RTR_PDF")"
  cp "$RTR_PDF" "${OUT_DIR}/${RTR_PDF_NAME}"
  NOTES_ROWS+=("${RTR_PDF_NAME}|Clean Response to Reviewers|Current \`${RTR_TEX}\` at \`${HEAD_SHA}\` (${HEAD_DATE})")
fi

# 3. Collect baseline refs to diff against HEAD (deduplicated, ordered)
DIFF_REFS=()
add_ref_if_new() {
  local ref="$1"
  [[ -z "$ref" ]] && return
  local sha
  sha="$(git rev-parse "${ref}^{commit}" 2>/dev/null || true)"
  [[ -z "$sha" ]] && return
  if [[ "$sha" == "$HEAD_FULL" ]]; then
    echo "Skipping ref '$ref' (points to HEAD)"
    return
  fi
  if (( ${#DIFF_REFS[@]} > 0 )); then
    for existing in "${DIFF_REFS[@]}"; do
      if [[ "$existing" == "$ref" ]]; then
        return
      fi
    done
  fi
  DIFF_REFS+=("$ref")
}

if [[ -n "$BASE_REF" ]]; then
  add_ref_if_new "$BASE_REF"
fi

LATEST_SUBMITTED="$(tags_by_commit_date_desc "$SUBMITTED_GLOB" | head -n 1 || true)"
if [[ -n "$LATEST_SUBMITTED" ]]; then
  add_ref_if_new "$LATEST_SUBMITTED"
fi

review_count=0
while IFS= read -r tag; do
  [[ -z "$tag" ]] && continue
  tag_sha="$(git rev-parse "${tag}^{commit}" 2>/dev/null || true)"
  [[ "$tag_sha" == "$HEAD_FULL" ]] && continue
  add_ref_if_new "$tag"
  review_count=$((review_count + 1))
  if (( review_count >= MAX_REVIEW_TAGS )); then
    break
  fi
done < <(tags_by_commit_date_desc "$REVIEW_GLOB")

if (( ${#DIFF_REFS[@]} > 0 )); then
  echo "Baseline refs selected for diffs: ${DIFF_REFS[*]}"
else
  echo "Baseline refs selected for diffs: <none>"
fi

# 4. Build manuscript + RTR latexdiff PDFs for each selected baseline ref
if (( ${#DIFF_REFS[@]} > 0 )); then
  for ref in "${DIFF_REFS[@]}"; do
    safe_ref="$(sanitize_name "$ref")"
    ref_sha="$(git rev-parse --short "${ref}^{commit}")"
    ref_date="$(git show -s --format='%cs' "${ref}^{commit}")"

    # Manuscript diff
    old_main_path="$(resolve_tex_at_ref "$ref" "$MAIN_TEX")"
    if [[ -n "$old_main_path" ]]; then
      old_raw="${TMP_WORK}/old_main_${safe_ref}.tex"
      old_norm="${TMP_WORK}/old_main_${safe_ref}_norm.tex"
      new_norm="${TMP_WORK}/new_main_norm.tex"
      git show "${ref}:${old_main_path}" > "$old_raw"

      if cmp -s "$old_raw" "$MAIN_TEX"; then
        echo "Skipping manuscript diff for '$ref' (no changes vs HEAD)"
      else
        echo "=== Building manuscript diff: ${ref} (${old_main_path}) -> ${MAIN_TEX} ==="
        normalize_abstract_for_latexdiff "$old_raw" "$old_norm"
        normalize_abstract_for_latexdiff "$MAIN_TEX" "$new_norm"

        diff_base="_ci_diff_ms_${safe_ref}"
        diff_tex="$(dirname "$MAIN_TEX")/${diff_base}.tex"
        diff_tex="${diff_tex#./}"
        CREATED_TEMP_FILES+=("$diff_tex")

        latexdiff \
          --disable-citation-markup \
          --replace-context2cmd="abstract,keywords,title" \
          --math-markup=whole \
          --config "PICTUREENV=(?:picture|tikzpicture|tabular|DIFnomarkup)[\w\d*@]*" \
          "$old_norm" "$new_norm" > "$diff_tex"

        compile_tex "$diff_tex" "yes"
        out_pdf="diff_${safe_ref}_to_latest.pdf"
        cp "${diff_tex%.tex}.pdf" "${OUT_DIR}/${out_pdf}"
        NOTES_ROWS+=("${out_pdf}|Manuscript diff: \`${ref}\` -> latest|Changes from \`${ref}\` (\`${ref_sha}\`, ${ref_date}) to \`${HEAD_SHA}\`")
      fi
    fi

    # Response to Reviewers diff (when RTR existed at ref and changed)
    if [[ -n "$RTR_TEX" ]]; then
      old_rtr_path="$(resolve_tex_at_ref "$ref" "$RTR_TEX")"
      if [[ -n "$old_rtr_path" ]]; then
        old_rtr_raw="${TMP_WORK}/old_rtr_${safe_ref}.tex"
        git show "${ref}:${old_rtr_path}" > "$old_rtr_raw"

        if cmp -s "$old_rtr_raw" "$RTR_TEX"; then
          echo "Skipping RTR diff for '$ref' (no changes vs HEAD)"
        else
          echo "=== Building RTR diff: ${ref} (${old_rtr_path}) -> ${RTR_TEX} ==="
          rtr_diff_base="_ci_diff_rtr_${safe_ref}"
          rtr_diff_tex="$(dirname "$RTR_TEX")/${rtr_diff_base}.tex"
          rtr_diff_tex="${rtr_diff_tex#./}"
          CREATED_TEMP_FILES+=("$rtr_diff_tex")

          latexdiff_args=(
            --math-markup=whole
            --config "PICTUREENV=(?:picture|tikzpicture|tabular|DIFnomarkup)[\w\d*@]*"
          )
          if [[ -n "$RTR_TEXTCMDS" ]]; then
            latexdiff_args+=(--append-textcmd="$RTR_TEXTCMDS")
          fi

          latexdiff "${latexdiff_args[@]}" "$old_rtr_raw" "$RTR_TEX" > "$rtr_diff_tex"

          compile_tex "$rtr_diff_tex" "no"
          out_rtr_pdf="diff_rtr_${safe_ref}_to_latest.pdf"
          cp "${rtr_diff_tex%.tex}.pdf" "${OUT_DIR}/${out_rtr_pdf}"
          NOTES_ROWS+=("${out_rtr_pdf}|RTR diff: \`${ref}\` -> latest|Response to Reviewers changes from \`${ref}\` (\`${ref_sha}\`, ${ref_date}) to \`${HEAD_SHA}\`")
        fi
      fi
    fi
  done
fi

# 5. Write release notes with direct download links
BASE_DL_URL=""
if [[ -n "${GITHUB_SERVER_URL:-}" && -n "${GITHUB_REPOSITORY:-}" ]]; then
  BASE_DL_URL="${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}/releases/download/${RELEASE_TAG}"
fi

{
  echo "## Latest Review PDFs"
  echo ""
  echo "- **Commit:** \`${HEAD_SHA}\` (${HEAD_DATE}) -- ${HEAD_SUBJ}"
  echo "- **Manuscript source:** \`${MAIN_TEX}\`"
  echo ""
  echo "| PDF | What it shows | Details |"
  echo "| --- | --- | --- |"
  for row in "${NOTES_ROWS[@]}"; do
    IFS='|' read -r fname label details <<< "$row"
    if [[ -n "$BASE_DL_URL" ]]; then
      echo "| [${fname}](${BASE_DL_URL}/${fname}) | ${label} | ${details} |"
    else
      echo "| \`${fname}\` | ${label} | ${details} |"
    fi
  done
  echo ""
  echo "_Built automatically with \`latexdiff\` and \`latexmk (${ENGINE})\`. Additions appear in blue underline; deletions appear in red strikethrough._"
} > "${OUT_DIR}/RELEASE_NOTES.md"

echo "=== Built outputs in ${OUT_DIR} ==="
ls -lh "$OUT_DIR"
