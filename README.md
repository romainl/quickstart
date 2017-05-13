# quickstart

**HTML5** + **JavaScript** + **SCSS**, the light way.

## Why?

Because I only need a simple way to re-compile my code and update my assets on change.

## What ?

I'm sick of Grunt, Gulp, Brunch, Broccoli, Mimosa and friends. They are all too large, too opinionated, too hungry, too complex, too verbose, too tightly coupled to the JavaScript ecosystem…

Why use all those warthogs when there is `make`, a great little program that has been around *forever*? It is relatively easy to set up and smart enough to execute given commands *only* when necessary.

And there is the mind-blowingly simple `while sleep n; do something; done`, which is quite possibly the most resource-friendly way to run `something` every `n` seconds.

Putting them together should give us a relatively smart system that:

* doesn't eat up hundreds of megabytes of memory,
* compiles our JavaScript *only* if a `*.js` files was changed/added/removed,
* compiles our CSS *only* if a `*.scss` file was changed/added/removed,
* does whatever else we need it to do…

Actually, it doesn't even eat up *one* megabyte of memory, happily leaves in a single thread and doesn't even have a measurable processor usage. It feels like having your files built out of thin air.

## How ?

**Clone:**

    $ git clone --depth=1 --branch=master git@github.com:romainl/quickstart.git path/to/directory
    $ rm -rf !$/.git

**Install dependencies:**

    $ yarn

**Build:**

    $ yarn make

1. The JavaScript test suite is executed with Tape.
2. The JavaScript is linted (via Eslint) and compiled (via Babel if necessary) with Browserify.
3. The SCSS is compiled with Node-sass.

NOTE:

* To keep the compile cycle as short as possible, failing tests are non-blocking.
* The resulting bundles are properly sourcemapped.

**Watch:**

    $ yarn watch

1. The project is built once.
2. `$ make -s build` is executed in a 1s loop, rebuilding what must be built when it must be built.

NOTE:

* To keep the compile cycle as short as possible, failing tests are non-blocking.
* The resulting bundles are properly sourcemapped.

**Build for production:**

    $ yarn make:prod

1. The JavaScript test suite is executed with Tape.
2. The JavaScript is linted (via Eslint) and compiled (via Babel if necessary) with Browserify before being minified with Uglify-js.
3. The SCSS is compiled and minified with Node-sass.

NOTE:

* Failing tests are blocking.
* The resulting bundles don't contain sourcemaps.

![screenshot](http://romainl.github.io/images/quickstart.png)
