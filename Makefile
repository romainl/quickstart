# use bash
SHELL := /bin/bash

# add node modules to $PATH
PATH  := node_modules/.bin:$(PATH)

# is ctags available?
CTAGS := $(shell command -v ctags)

# cleanup, setup, copy
.PHONY: all
all:
	rm -rf build
	mkdir -p build/{images,js,css,html}
	browserify -t debowerify -t hintify source/js/main.js -o build/js/build.js
	node-sass -q --source-map 'true' source/scss/main.scss build/css/build.css
	cp -ru source/js/vendor build/js
	cp -ru source/scss/vendor build/css
	cp -ru source/*.html build/
	cp -ru source/images build/

# start watcher
.PHONY: start
start:
	while sleep 1; do make compile; done

# compile and copy
.PHONY: compile
compile: build/js/build.js build/css/build.css build build/images
	@true

# compile js
build/js/build.js: $(wildcard source/js/*.js) $(wildcard source/js/**/*.js)
	browserify -t debowerify -t hintify source/js/main.js -o build/js/build.js
ifdef CTAGS
	ctags --tag-relative=yes --recurse=yes source/js
endif

# compile scss
build/css/build.css: $(wildcard source/scss/*.scss) $(wildcard source/scss/**/*.scss)
	node-sass -q --source-map 'true' source/scss/main.scss build/css/build.css

# copy html
build: $(wildcard source/*.html)
	cp -u $? build/ && touch build

# copy images
build/images: $(wildcard source/images/*)
	cp -u $? build/images/ && touch build/images
