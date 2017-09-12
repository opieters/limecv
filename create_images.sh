#!/bin/bash

pushd examples
xelatex mwe-xelatex.tex
xelatex mwe-xelatex.tex
xelatex mwe-xelatex.tex
pdf2svg mwe-xelatex.pdf cv%d.svg all
mv cv1.svg ../images/cv.svg
mv cv2.svg ../images/cover_letter.svg
convert -density 100 -border 2 -bordercolor black ../images/cv.svg ../images/cv.png
convert -density 100 -border 2 -bordercolor black ../images/cover_letter.svg ../images/cover_letter.png
popd

 