# use bash
SHELL := /bin/bash

# add node modules to $PATH
PATH  := node_modules/.bin:$(PATH)

# is ctags available?
CTAGS := $(shell command -v ctags)

# generic targets
.PHONY: all
all: clean setup code

.PHONY: clean
clean:
	rm -rf build

.PHONY: setup
setup:
	mkdir -p build/{images,js,css}
	cp -ru source/*.html build/
	cp -ru source/js/vendor build/js
	cp -ru source/scss/vendor build/css
	cp -ru source/images build/

.PHONY: code
code: build/js/build.js build/css/build.css $(wildcard build/*.html)

# specific targets
build/js/build.js: $(wildcard source/js/*.js) $(wildcard source/js/**/*.js)
	browserify -t debowerify -t hintify source/js/main.js -o build/js/build.js
ifdef CTAGS
	cd source/js > /dev/null && ctags -R .
endif

build/css/build.css: $(wildcard source/scss/*.scss) $(wildcard source/scss/**/*.scss)
	node-sass -q --source-map 'true' source/scss/main.scss build/css/build.css

$(wildcard build/*.html): $(wildcard source/*.html)
	cp -ru $? build/
