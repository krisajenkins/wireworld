all: dist/app.js dist/index.html dist/main.css dist/interop.js

dist/%.css: styles/%.css
	cp $< $@

dist/app.js: $(shell find src -type f -name '*.elm' -o -name '*.js') dist
	elm-make src/App.elm --yes --warn --output=$@

dist:
	@mkdir $@

dist/%.html: static/%.html dist
	cp $< $@

dist/%.js: static/%.js dist
	cp $< $@

dist/%.json: static/%.json dist
	cp $< $@
