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

# --disable-citation-markup                : don't insert \DIFadd/\DIFdel inside \cite{} args
#                                            (they break \@citew on multi-key citations)
# --math-markup=whole                      : treat math environments as atomic (don't mark up
#                                            internals, which can break soul/ulem)
# --append-context2cmd="abstract,keywords" : treat the abstract and keywords environments 
#                                            as ones that can be diffed
# PICTUREENV                               : treat tikzpicture as an atomic block (the default
#                                            only covers picture/DIFnomarkup; without this,
#                                            latexdiff inserts \DIFaddFL inside \node[...]
#                                            arguments and breaks TikZ parsing)
latexdiff \
    --disable-citation-markup \
    --append-context2cmd="abstract,keywords" \
    --math-markup=whole \
    --config "PICTUREENV=(?:picture|tikzpicture|DIFnomarkup)[\w\d*@]*" \
    "$OLD" "$NEW" > "${OUT}.tex"

# Clean stale aux files from any prior run with different content
rm -f "${OUT}.aux" "${OUT}.log" "${OUT}.out" "${OUT}.bbl" "${OUT}.blg" "${OUT}.pdf"

# latexmk using lualatex
latexmk -lualatex -bibtex "${OUT}.tex"

echo
echo "Built ${OUT}.pdf"
