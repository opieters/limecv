#!/usr/bin/env bash

echo "Copying files..."

mkdir limecv
mkdir limecv/examples/
cp src/limecv.{dtx,ins} limecv/
cp examples/*.tex limecv/examples
cp examples/limecv-icon.pdf limecv/examples/
cp examples/picture.png limecv/examples/
cp README.md limecv/
cp LICENSE limecv/

echo "Building project..."
pushd limecv/

# create class file
xelatex limecv.ins

cp limecv.cls examples/

# build examples
pushd examples/

pdflatex mwe-latex.tex
pdflatex mwe-latex.tex
pdflatex mwe-latex.tex

xelatex mwe-xelatex.tex
xelatex mwe-xelatex.tex
xelatex mwe-xelatex.tex

lualatex mwe-lualatex.tex
lualatex mwe-lualatex.tex
lualatex mwe-lualatex.tex

rm *.{aux,log,gz,cls,out}

cp mwe-xelatex.pdf ../

popd

# build documentation
xelatex limecv.dtx
xelatex limecv.dtx
xelatex limecv.dtx

echo "Cleaning project..."

rm *.{aux,glo,log,out,toc,cls,idx}
rm mwe-xelatex.pdf

echo "Creating ZIP file"

#ctanify limecv.ins \
#  limecv.dtx \
#  limecv.pdf \
#  --no-skip README.md \
#  --no-skip LICENSE \
#  --no-skip examples/limecv-icon.pdf \
#  --no-skip examples/picture.png \
#  --no-skip examples/mwe-xelatex.tex \
#  --no-skip examples/mwe-xelatex.pdf \
#  --no-skip examples/mwe-latex.tex \
#  --no-skip examples/mwe-latex.pdf \
#  --no-skip examples/mwe-lualatex.tex \
#  --no-skip examples/mwe-lualatex.pdf

popd

COPYFILE_DISABLE=1 tar -pczf limecv.tar.gz limecv/

echo "Cleaning..."

rm -rf limecv

echo "Contents:"

tar -ztvf limecv.tar.gz

echo "Done."




