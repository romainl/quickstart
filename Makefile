# A SUPER SIMPLE
#                                                       ###
# #####     #####           ###                  #####  ### ###
# #####     #####           ###                 #######     ###
# ######   ######  #######  ###   ###  #######  ###  ## ### ###  #######
# ######   ###### ######### ###   ### ######### ###     ### ### #########
# ### ### ### ### ##    ### ########  ###   ### ######  ### ### ###   ###
# ### ### ### ###  ######## ########  ######### ######  ### ### #########
# ###  #####  ### ######### ###   ### ########  ###     ### ### ########
# ###  #####  ### ###   ### ###   ### ###    ## ###     ### ### ###    ##
# ###   ###   ### ######### ###   ### ######### ###     ### ### #########
# ###   ###   ###  #### ### ###   ###  #######  ###     ### ###  #######
#
# FOR FRONT END DEVELOPMENT



# use bash
SHELL := /bin/bash

# add node modules to $PATH
PATH  := node_modules/.bin:$(PATH)

# is ctags available?
CTAGS := $(shell command -v ctags)

# feedback
OUT    = @echo `date +[\ %F\ -\ %T\ ]`



# $ make -s all
# sets up the build directories and build the JS and CSS
.PHONY: all
all: setup build
	@true
	$(OUT) "Project compiled."

# $ make -s setup
# creates build directories if needed
.PHONY: setup
setup:
	@mkdir -p build/{js,css}
	$(OUT) "Setup done."

# $ make -s build
# builds the JS and CSS
.PHONY: build
build: build/js/build.js build/css/build.css
	@true

# $ make -s test
# tests the JS
.PHONY: test
test:
	@node source/js/test/*.js | tap-diff
	$(OUT) "Tests passed."

# $ make -s watch
# starts the watcher
.PHONY: watch
watch:
	$(OUT) "Watching..."
	@while sleep 1; do make -s build; done



# build js
build/js/build.js: $(wildcard source/js/*.js) $(wildcard source/js/modules/*.js) $(wildcard source/js/test/*.js)
ifdef PROD
	@make -s test
	@browserify -t [ babelify --presets [ latest ] ] -t eslintify source/js/main.js | uglifyjs -o build/js/build.js
	$(OUT) "'build/js/build.js' compiled and minified."
else
	@-make -s test
	@browserify -t [ babelify --presets [ latest ] ] -t eslintify -d source/js/main.js -o build/js/build.js
ifdef CTAGS
	@ctags --tag-relative=yes --recurse=yes -f source/tags source/js
endif
	$(OUT) "'build/js/build.js' compiled, 'source/tags' generated."
endif

# build scss
build/css/build.css: $(wildcard source/scss/*.scss) $(wildcard source/scss/modules/*.scss)
ifdef PROD
	@node-sass -q --output-style 'compressed' source/scss/main.scss build/css/build.css
	$(OUT) "'build/css/build.css' compiled and minified."
else
	@node-sass -q --source-map-contents 'true' --source-map-embed 'true' source/scss/main.scss build/css/build.css
	$(OUT) "'build/css/build.css' compiled."
endif



# $ make -s help
# gives some help
.PHONY: help
help:
	@echo ""
	@echo "————————————————————————————————————————————————————————————————————————————————"
	@echo ""
	@echo "                                 Quick usage"
	@echo "                                 ———————————"
	@echo ""
	@echo "Add dependencies: ........... '$$ yarn add foo bar'"
	@echo "Add dev dependencies: ....... '$$ yarn add -D foo bar'"
	@echo "Update all dependencies: .... '$$ yarn'"
	@echo ""
	@echo "Build for development: ...... '$$ make -s all' or '$$ yarn run make'"
	@echo "Build for production: ....... '$$ PROD=1 make -s all' or '$$ yarn run make:prod'"
	@echo "Rebuild on change: .......... '$$ make -s watch' or '$$ yarn run watch'"
	@echo ""
	@echo "Show this help: ............. '$$ make -s help' or '$$ yarn run help'"
	@echo ""
	@echo "————————————————————————————————————————————————————————————————————————————————"
	@echo ""
