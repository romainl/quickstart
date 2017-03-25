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



# $ make all
# sets up the build directories and build the JS and CSS
.PHONY: all
all: setup build
	@true
	$(OUT) "Project compiled."

# $ make watch
# starts the watcher
.PHONY: watch
watch:
	$(OUT) "Watching..."
	@while sleep 1; do make build; done

# $ make setup
# creates build directories if needed
.PHONY: setup
setup:
	@mkdir -p build/{js,css}
	$(OUT) "Setup done."

# $ make build
# builds the JS and CSS
.PHONY: build
build: build/js/build.js build/css/build.css
	@true

# $ make test
# tests the JS
.PHONY: test
test:
	@node source/js/test/*.js | tap-diff
	$(OUT) "Tests done."



# build js
build/js/build.js: $(wildcard source/js/*.js) $(wildcard source/js/modules/*.js) $(wildcard source/js/test/*.js)
ifdef PROD
	@make test
	@browserify -t [ babelify --presets [ latest ] ] -t eslintify source/js/main.js | uglifyjs -o build/js/build.js
	$(OUT) "'build/js/build.js' compiled and minified."
else
	@make test
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
