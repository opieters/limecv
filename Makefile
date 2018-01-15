# Originally from nyradr/limecv

RM=rm -rf *.aux *.log *.out mwe*.pdf *.glo *.idx *.cls

all: src/limecv.cls

src/limecv.cls: src/limecv.dtx src/limecv.ins
	cd src; $(RM); pdflatex limecv.ins

examples: examples/limecv-icon.pdf examples/mwe-latex.tex examples/mwe-lualatex.tex examples/mwe-xelatex.tex examples/picture.png src/limecv.cls
	cp src/limecv.cls examples/limecv.cls
	cd examples; pdflatex mwe-latex.tex;    pdflatex mwe-latex.tex
	cd examples; xelatex mwe-xelatex.tex;   xelatex mwe-xelatex.tex
	cd examples; lualatex mwe-lualatex.tex; lualatex mwe-lualatex.tex

clean:
	$(RM)
	cd src; $(RM)
	cd examples; $(RM)

