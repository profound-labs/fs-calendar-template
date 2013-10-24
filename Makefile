LATEX=lualatex
LATEX_OPTS=-interaction=nonstopmode -halt-on-error

none:
	echo "desk or wall?"

wall:
	$(LATEX) $(LATEX_OPTS) wall_main.tex

wall-cutouts:
	pdftk wall_main.pdf cat 2 output src-images/cutouts/frontmatter-page.pdf
	pdftk wall_main.pdf cat 15 output src-images/cutouts/planner-page.pdf
	pdftk wall_main.pdf cat 16 output src-images/cutouts/thumbs-page.pdf
	pdftk wall_main.pdf cat 17 output src-images/cutouts/address-page.pdf

desk:
	$(LATEX) $(LATEX_OPTS) desk_main.tex

wall-and-desk:
	@echo "Wall once... "
	$(LATEX) $(LATEX_OPTS) wall_main.tex > out.log 2>&1
	@echo "Wall twice... "
	$(LATEX) $(LATEX_OPTS) wall_main.tex > out.log 2>&1
	@echo "Making cutouts... "
	pdftk wall_main.pdf cat 2 output src-images/cutouts/frontmatter-page.pdf > out.log 2>&1
	pdftk wall_main.pdf cat 15 output src-images/cutouts/planner-page.pdf > out.log 2>&1
	pdftk wall_main.pdf cat 16 output src-images/cutouts/thumbs-page.pdf > out.log 2>&1
	pdftk wall_main.pdf cat 17 output src-images/cutouts/address-page.pdf > out.log 2>&1
	@echo "Desk once... "
	$(LATEX) $(LATEX_OPTS) desk_main.tex > out.log 2>&1
	@echo "Desk twice... "
	$(LATEX) $(LATEX_OPTS) desk_main.tex > out.log 2>&1
	@echo "OK, see wall_main.pdf and desk_main.pdf"

planner-a4:
	$(LATEX) $(LATEX_OPTS) planner_main_a4.tex

planner-a3:
	$(LATEX) $(LATEX_OPTS) planner_main_a3.tex

planner-a2:
	$(LATEX) $(LATEX_OPTS) planner_main_a2.tex

clean:
	+rm -fv *.{dvi,ps,aux,log,bbl,blg}
