# quickstart

**HTML5** + **JavaScript** + **SCSS**, the light way.

## Why?

Because I only need a way to re-compile my code and update my assets when needed.

## What ?

`make` is a great little utility that has been around *forever*. It is relatively easy to set up and smart enough to execute given commands *only* when necessary.

`while sleep n; do something; done` is quite possibly the most resource-friendly and portable way to run `something` every `n` seconds.

If we put them together, we have a relatively smart system that:

* doesn't eat up hundreds of megabytes of memory,
* compiles our JavaScript *only* if a `*.js` files was changed/added/removed,
* compiles our CSS *only* if a `*.scss` file was changed/added/removed,
* copies our pages *only* if a `*.html` file was changed/added/removed,
* copies our `images` directory *only* if something changed in it.

"But Gulp?", you asked? Or was it "But Brunch?"? No thanks.

## How ?

**Clone:**

    $ git clone --depth=1 --branch=master git@github.com:romainl/quickstart.git dir
    $ rm -rf !$/.git

**Install:**

    $ npm install

**Build:**

    $ npm run build

**Compile:**

    $ npm run compile

**Watch:**

    $ npm start
