module Counter exposing (..)

import Browser
import Html exposing (Html, div, text, button)
import Html.Events exposing (onClick)

main =
    Browser.sandbox { init = init, view = view, update = update }

-- MODEL

type alias Model = Int

init : Model
init = 
    0

-- UPDATE

type Msg =
    Increment
    | Decrement
    | Reset


update : Msg -> Model -> Model
update msg model =
    case msg of 
        Reset ->
            0

        Increment ->
            model + 1

        Decrement ->
            model - 1

-- VIEW

view : Model -> Html Msg
view model =
    div []
    [ text (String.fromInt model) 
    , button [ onClick Reset ] [ text "reset" ]
    , button [ onClick Increment ] [ text "+" ]
    , button [ onClick Decrement ] [ text "-" ]
    ]
