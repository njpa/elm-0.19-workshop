A command is a description of something we want done.  The update tells the runtime that it wants something done and it wants to be notified when it is completed.

### Browser

In Elm 0.19, we used Browser.sandbox to get out programs up and running.  The type notation of `update` was:

```elm
update : Msg -> Model -> Model ->
```

When using `Browser.element`, the `update` function now returns a tuple instead of simply a `Model`.  The type notation of `update` is now:

```elm
update: Msg -> Model -> ( Model, Cmd Msg ) 
```

### Managed effects

One of the guarantees of Elm is that it has no side effects.  It instead focuses on the concept of "managed effects".  What this means is that we are explicitly letting the Elm Runtime perform those side effects which we need to have happen.  For example, to generate a random number, or to make a request from a server and receive a response.  In this respect, Elm is considered to be a language consisting of only 'pure' functions.  





