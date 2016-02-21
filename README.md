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
* copies our pages *only* if a `*.html` file was changed/added/removed,
* copies our `images` directory *only* if something changed in it,
* whatever else we need it to do…

Actually, it doesn't even eat up *one* megabyte of memory, happily leaves in a single thread and doesn't even have a measurable processor usage. It feels like having your files built out of thin air.

## How ?

**Clone:**

    $ git clone --depth=1 --branch=master git@github.com:romainl/quickstart.git path/to/directory
    $ rm -rf !$/.git

**Install:**

    $ npm install

**Build:**

    $ npm run build

or

    $ make build

**Compile:**

    $ npm run compile

or

    $ make compile

**Watch:**

    $ npm start

or

    $ make start
