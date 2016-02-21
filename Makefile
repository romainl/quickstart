# use bash
SHELL := /bin/bash

# add node modules to $PATH
PATH  := node_modules/.bin:$(PATH)

# is ctags available?
CTAGS := $(shell command -v ctags)

# generic targets
.PHONY: all
all: clean setup copy compile
	@true

.PHONY: build
build: clean setup copy
	@true

.PHONY: start
start:
	@echo ""
	while sleep 1; do make compile; done

.PHONY: clean
clean:
	@echo ""
	rm -rf build

.PHONY: setup
setup:
	@echo ""
	mkdir -p build/{images,js,css,html}

.PHONY: copy
copy:
	@echo ""
	cp -ru source/js/vendor build/js
	cp -ru source/scss/vendor build/css
	cp -ru source/*.html build/
	cp -ru source/html build/
	cp -ru source/images build/

.PHONY: assets
assets: build/images build/html
	@true

.PHONY: compile
compile: build/js/build.js build/css/build.css build/index.html build/images build/html
	@true

# specific targets
# compile js
build/js/build.js: $(wildcard source/js/*.js) $(wildcard source/js/**/*.js)
	@echo ""
	browserify -t debowerify -t hintify source/js/main.js -o build/js/build.js
ifdef CTAGS
	ctags --tag-relative=yes --recurse=yes source/js
endif

# compile scss
build/css/build.css: $(wildcard source/scss/*.scss) $(wildcard source/scss/**/*.scss)
	@echo ""
	node-sass -q --source-map 'true' source/scss/main.scss build/css/build.css

# copy html
build/index.html: source/index.html
	@echo ""
	cp -u source/index.html build/

build/html: $(wildcard source/html/*)
	@echo ""
	cp -ru source/html build/ && touch build/html

# copy images
build/images: $(wildcard source/images/*)
	@echo ""
	cp -ru source/images build/ && touch build/images
