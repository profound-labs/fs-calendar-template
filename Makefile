LATEX=lualatex
LATEX_OPTS=-interaction=nonstopmode -halt-on-error

none:
	echo "desk or wall?"

wall:
	$(LATEX) $(LATEX_OPTS) wall_main.tex

wall-cutouts:
	pdftk wall_main.pdf cat 15 output src-images/cutouts/planner-page.pdf
	pdftk wall_main.pdf cat 16 output src-images/cutouts/thumbs-page.pdf

desk:
	$(LATEX) $(LATEX_OPTS) desk_main.tex

wall-and-desk:
	@echo "Wall once... "
	$(LATEX) $(LATEX_OPTS) wall_main.tex > out.log 2>&1
	@echo "Wall twice... "
	$(LATEX) $(LATEX_OPTS) wall_main.tex > out.log 2>&1
	@echo "Making cutouts... "
	pdftk wall_main.pdf cat 15 output src-images/cutouts/planner-page.pdf > out.log 2>&1
	pdftk wall_main.pdf cat 16 output src-images/cutouts/thumbs-page.pdf > out.log 2>&1
	@echo "Desk once... "
	$(LATEX) $(LATEX_OPTS) desk_main.tex > out.log 2>&1
	@echo "Desk twice... "
	$(LATEX) $(LATEX_OPTS) desk_main.tex > out.log 2>&1
	@echo "OK, see wall_main.pdf and desk_main.pdf"

planner-insert-wall:
	$(LATEX) $(LATEX_OPTS) planner_main_insert_wall.tex

planner-insert-desk:
	$(LATEX) $(LATEX_OPTS) planner_main_insert_desk.tex

planner-a4:
	$(LATEX) $(LATEX_OPTS) planner_main_a4.tex

get-moondays:
	cp --backup=numbered ./data/moondays.csv ./data/moondays.csv.bak
	go run ./scripts/get-moondays.go > ./data/moondays.csv

get-astromoondays:
	cp --backup=numbered ./data/astromoondays.csv ./data/astromoondays.csv.bak
	go run ./scripts/get-astromoondays.go > ./data/astromoondays.csv

clean:
	+rm -fv *.{dvi,ps,aux,log,bbl,blg}
