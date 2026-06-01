TEX = Patrycja_Dabrowska_CV(PL)
DIR = build

.PHONY: all clean

all: $(DIR)
	xelatex -interaction=nonstopmode -output-directory=$(DIR) "$(TEX).tex"
	xelatex -interaction=nonstopmode -output-directory=$(DIR) "$(TEX).tex"
	cp "$(DIR)/$(TEX).pdf" .

$(DIR):
	mkdir -p $(DIR)

clean:
	rm -rf $(DIR)
