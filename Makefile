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
build: build/js/bundle.js build/css/bundle.css
	@true

# $ make -s test
# tests the JS
.PHONY: test
test:
	@tape -r babel-register source/js/test/*.js | tap-diff
	$(OUT) "Tests passed."

# $ make -s watch
# starts the watcher
.PHONY: watch
watch:
	$(OUT) "Watching..."
	@while sleep 1; do make -s build; done



# build js
build/js/bundle.js: $(wildcard source/js/*.js) $(wildcard source/js/modules/*.js) $(wildcard source/js/test/*.js)
ifdef PROD
	@make -s test
	@browserify -t [ babelify --presets [ latest ] ] -t eslintify source/js/main.js | uglifyjs -o build/js/bundle.js
	$(OUT) "'build/js/bundle.js' compiled and minified."
else
	@-make -s test
	@browserify -t [ babelify --presets [ latest ] ] -t eslintify -d source/js/main.js -o build/js/bundle.js
ifdef CTAGS
	@ctags --tag-relative=yes --recurse=yes -f source/tags source/js
endif
	$(OUT) "'build/js/bundle.js' compiled, 'source/tags' generated."
endif

# build scss
build/css/bundle.css: $(wildcard source/scss/*.scss) $(wildcard source/scss/modules/*.scss)
ifdef PROD
	@node-sass -q --output-style 'compressed' source/scss/main.scss build/css/bundle.css
	$(OUT) "'build/css/bundle.css' compiled and minified."
else
	@node-sass -q --source-map-contents 'true' --source-map-embed 'true' source/scss/main.scss build/css/bundle.css
	$(OUT) "'build/css/bundle.css' compiled."
endif



# $ make -s help
# gives some help
.PHONY: help
help:
	@echo ""
	@echo "    A SUPER SIMPLE"
	@echo "                                                          ###"
	@echo "    #####     #####           ###                  #####  ### ###"
	@echo "    #####     #####           ###                 #######     ###"
	@echo "    ######   ######  #######  ###   ###  #######  ###  ## ### ###  #######"
	@echo "    ######   ###### ######### ###   ### ######### ###     ### ### #########"
	@echo "    ### ### ### ### ##    ### ########  ###   ### ######  ### ### ###   ###"
	@echo "    ### ### ### ###  ######## ########  ######### ######  ### ### #########"
	@echo "    ###  #####  ### ######### ###   ### ########  ###     ### ### ########"
	@echo "    ###  #####  ### ###   ### ###   ### ###    ## ###     ### ### ###    ##"
	@echo "    ###   ###   ### ######### ###   ### ######### ###     ### ### #########"
	@echo "    ###   ###   ###  #### ### ###   ###  #######  ###     ### ###  #######"
	@echo ""
	@echo "    FOR FRONT END DEVELOPMENT"
	@echo ""
	@echo "———————————————————————————————— Quick usage ———————————————————————————————————"
	@echo ""
	@echo "Add dependencies ........... '$$ yarn add foo bar'"
	@echo "Add dev dependencies ....... '$$ yarn add -D foo bar'"
	@echo "Update all dependencies .... '$$ yarn'"
	@echo ""
	@echo "Build for development ...... '$$ yarn make' or '$$ make'"
	@echo "Build for production ....... '$$ yarn make:prod' or '$$ PROD=1 make'"
	@echo "Rebuild on change .......... '$$ yarn watch' or '$$ make && make -s watch'"
	@echo ""
	@echo "Show this help ............. '$$ yarn run help' or '$$ make help'"
	@echo ""
	@echo "————————————————————————————————————————————————————————————————————————————————"
	@echo ""
