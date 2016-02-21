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
	while sleep 1; do make compile; done

.PHONY: clean
clean:
	@echo ""
	rm -rf build

.PHONY: setup
setup:
	@echo ""
	mkdir -p build/{images,js,css}

.PHONY: copy
copy:
	@echo ""
	cp -ru source/js/vendor build/js
	cp -ru source/scss/vendor build/css
	cp -ru source/*.html build/
	cp -ru source/images build/

.PHONY: assets
assets: html images
	@true

.PHONY: compile
compile: build/js/build.js build/css/build.css
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
.PHONY: html
html: $(wildcard build/*.html)
	@true

$(wildcard build/*.html): $(wildcard source/*.html)
	@echo ""
	cp -ru $? build/

# copy images
.PHONY: images
images: $(wildcard build/images/*.png)
	@true

$(wildcard build/images/*.png): $(wildcard source/images/*.png)
	@echo ""
	cp -ru $^ build/images/
