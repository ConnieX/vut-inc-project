# Author: Dominik Harmim <xharmi00@stud.fit.vutbr.cz>

PROJ=zprava
PACK=xharmi00

.PHONY: clean pack

$(PROJ).pdf: $(PROJ).tex
	pdflatex $^

$(PACK).zip: $(PROJ).pdf src/fpga/fsm.vhd src/build/accterm.bin
	zip -j $@ $^

pack: clean $(PACK).zip

clean:
	rm -f $(PROJ).aux $(PROJ).dvi $(PROJ).log $(PROJ).ps $(PROJ).synctex.gz $(PROJ).fls $(PROJ).fdb_latexmk
