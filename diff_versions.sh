#!/usr/bin/env bash
# Build a latexdiff between two versions of the manuscript and compile to PDF.
# Usage: ./diff_versions.sh <old.tex> <new.tex> [output_basename]
# Example: ./diff_versions.sh previous_versions/main_v3.tex main_v4.tex diff_v3_v4

set -euo pipefail

OLD=$1
NEW=$2
OUT=$3

# echo $OLD
# echo $NEW
# echo $OUT

cd "$(dirname "$0")"

# --disable-citation-markup                 : don't insert \DIFadd/\DIFdel inside \cite{} args
#                                             (they break \@citew on multi-key citations)
# --math-markup=whole                       : treat math environments as atomic (don't mark up
#                                             internals, which can break soul/ulem)
# --replace-context2cmd="abstract,keywords,title"
#                                             : wlscirep repeats \author in the preamble, which
#                                             makes latexdiff revert to pure line-diff mode
#                                             unless author is excluded from context2cmd
# Move \begin{document} above \begin{abstract} in temporary copies so latexdiff
# marks up edits inside the wlscirep abstract block as well as the title.
# PICTUREENV                                : treat tikzpicture and tabular as atomic blocks
#                                             (the default only covers picture/DIFnomarkup;
#                                             without tikzpicture, latexdiff inserts \DIFaddFL
#                                             inside \node[...] and breaks TikZ; without tabular,
#                                             inserted \DIFaddbeginFL/\DIFaddendFL can land
#                                             between \\ and \bottomrule, triggering a
#                                             "Misplaced \noalign" error from booktabs).
TMP_OLD=$(mktemp /tmp/latexdiff_old_XXXXXX)
TMP_NEW=$(mktemp /tmp/latexdiff_new_XXXXXX)
trap 'rm -f "$TMP_OLD" "$TMP_NEW"' EXIT

python3 - "$OLD" "$TMP_OLD" "$NEW" "$TMP_NEW" <<'PY'
import sys
from pathlib import Path

for src, dst in [(sys.argv[1], sys.argv[2]), (sys.argv[3], sys.argv[4])]:
    s = Path(src).read_text(encoding="utf-8")
    if "\\begin{abstract}" in s and "\\begin{document}" in s:
        if s.index("\\begin{abstract}") < s.index("\\begin{document}"):
            s = s.replace("\\begin{document}\n", "", 1).replace(
                "\\begin{abstract}", "\\begin{document}\n\\begin{abstract}", 1
            )
    Path(dst).write_text(s, encoding="utf-8")
PY

latexdiff \
    --disable-citation-markup \
    --replace-context2cmd="abstract,keywords,title" \
    --math-markup=whole \
    --config "PICTUREENV=(?:picture|tikzpicture|tabular|DIFnomarkup)[\w\d*@]*" \
    "$TMP_OLD" "$TMP_NEW" > "${OUT}.tex"

# Clean stale aux files from any prior run with different content
rm -f "${OUT}.aux" "${OUT}.log" "${OUT}.out" "${OUT}.bbl" "${OUT}.blg" "${OUT}.fdb_latexmk" "${OUT}.fls" "${OUT}.pdf"

# latexmk using lualatex
latexmk -lualatex -bibtex "${OUT}.tex"

echo
echo "Built ${OUT}.pdf"
