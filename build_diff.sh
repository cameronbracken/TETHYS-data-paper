#!/usr/bin/env bash
# Build a latexdiff between two versions of the manuscript and compile to PDF.
# Usage: ./build_diff.sh <old.tex> <new.tex> [output_basename]
# Example: ./build_diff.sh previous_versions/main_v2.tex main_v3.tex diff_v2_v3

set -euo pipefail

OLD="${1:-previous_versions/main_v2.tex}"
NEW="${2:-main_v3.tex}"
OUT="${3:-diff_v2_v3}"

cd "$(dirname "$0")"

# --disable-citation-markup : don't insert \DIFadd/\DIFdel inside \cite{} args
#                             (they break \@citew on multi-key citations)
# --math-markup=whole       : treat math environments as atomic (don't mark up
#                             internals, which can break soul/ulem)
# PICTUREENV                : treat tikzpicture as an atomic block (the default
#                             only covers picture/DIFnomarkup; without this,
#                             latexdiff inserts \DIFaddFL inside \node[...]
#                             arguments and breaks TikZ parsing)
latexdiff \
    --disable-citation-markup \
    --math-markup=whole \
    --config "PICTUREENV=(?:picture|tikzpicture|DIFnomarkup)[\w\d*@]*" \
    "$OLD" "$NEW" > "${OUT}.tex"

# Clean stale aux files from any prior run with different content
rm -f "${OUT}.aux" "${OUT}.log" "${OUT}.out" "${OUT}.bbl" "${OUT}.blg" "${OUT}.pdf"

# Standard pdflatex -> bibtex -> pdflatex x2 cycle
pdflatex -interaction=nonstopmode -halt-on-error "${OUT}.tex"
bibtex "${OUT}" || true
pdflatex -interaction=nonstopmode -halt-on-error "${OUT}.tex"
pdflatex -interaction=nonstopmode -halt-on-error "${OUT}.tex"

echo
echo "Built ${OUT}.pdf"
