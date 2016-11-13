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
# cleanup, setup, copy
.PHONY: all
all:
	@rm -rf build
	@mkdir -p build/{images,js,css}
	@browserify -t debowerify -t hintify source/js/main.js -o build/js/build.js
	@node source/js/test/*.js | tap-diff
	@node-sass -q --source-map 'true' source/scss/main.scss build/css/build.css
	@cp -ru source/js/vendor build/js
	@cp -ru source/scss/vendor build/css
	@cp -ru source/*.html build/
	@cp -ru source/images build/
	$(OUT) "Project compiled."

# $ make watch
# start watcher
.PHONY: watch
watch:
	$(OUT) "Watching..."
	@while sleep 1; do make compile; done

# $ make compile
# compile and copy
.PHONY: compile
compile: build/js/build.js build/css/build.css build build/images
	@true

# $ make test
# test js
.PHONY: test
test:
	@node source/js/test/*.js | tap-diff
	$(OUT) "Tests done."



# compile js
build/js/build.js: $(wildcard source/js/*.js) $(wildcard source/js/modules/*.js)
	@browserify -t debowerify -t hintify source/js/main.js -o build/js/build.js
	@make test
ifdef CTAGS
	@ctags --tag-relative=yes --recurse=yes -f source/tags source/js
endif
	$(OUT) "'build/js/build.js' compiled, 'source/tags' generated."

# compile scss
build/css/build.css: $(wildcard source/scss/*.scss) $(wildcard source/scss/modules/*.scss)
	@node-sass -q --source-map 'true' source/scss/main.scss build/css/build.css
	$(OUT) "'build/css/build.css' compiled."

# copy html
build: $(wildcard source/*.html)
	@cp -u $? build/ && touch build
	$(OUT) \'$?\'" copied to 'build'."

# copy images
build/images: $(wildcard source/images/*)
	@cp -u $? build/images/ && touch build/images
	$(OUT) \'$?\'" copied to 'build/images'."
