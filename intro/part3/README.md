# Part 3

This is just like last time, except first we'll install the `elm/browser` package so we can create an interactive app in the browser, instead of static HTML.

To install the package, `cd` into the `part3/` directory and run:

```shell
elm install elm/browser
```

Then build everything the same way as last time:

```shell
elm make src/Main.elm --output elm.js
```

Ensure that you have the server from the more advanced exercises up and running (this will be serving your `main.css` file to the `index.html`.

```shell
cd intro/server
npm start
```

Then run it using `elm reactor` back in the part1 folder

```shell
cd intro/part1
elm reactor
```

And finally, select the `index.html` file from the File Navigation pane.

### Note

Your browser may cache the `elm.js` file when you are running `elm reactor` in parts 1, 2, 3 and 4 since the `index.html` specifies the same path over and over again in each exercise.  Remove cached files from your browser to see the relevant `elm.js`.

## Exercise

Open `src/Main.elm` in your editor and resolve the TODOs there.
