module DiceRoll exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Random
import Svg exposing (..)
import Svg.Attributes exposing (..)


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MODEL


type alias Model =
    { face1 : Int
    , face2 : Int
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model 0 0
    , Cmd.none
    )



-- UPDATES


type Msg
    = Roll
    | NewFace1 Int
    | NewFace2 Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( model
            , Random.generate NewFace1 (Random.int 1 6)
            )

        NewFace1 i ->
            ( { model | face1 = i }
            , Random.generate NewFace2 (Random.int 1 6)
            )

        NewFace2 i ->
            ( { model | face2 = i }
            , Cmd.none
            )


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ button [ onClick Roll ] [ Html.text "Roll" ]
            ]
        , div [] [ face model.face1 ]
        , div [] [ face model.face2 ]
        ]


face : Int -> Html Msg
face i =
    let
        dot1 =
            Svg.ellipse
                [ rx "1"
                , ry "1"
                , cx "10"
                , cy "10"
                , fill "#000000"
                ]
                []
    in
    svg [ viewBox "0 0 100 100" ]
        [ dot1
        , Svg.ellipse
            [ rx "1"
            , ry "1"
            , cx "10"
            , cy "13"
            , fill "#000000"
            ]
            []
        , Svg.ellipse
            [ rx "1"
            , ry "1"
            , cx "10"
            , cy "16"
            , fill "#000000"
            ]
            []
        , Svg.ellipse
            [ stroke "#000000"
            , rx "1"
            , ry "1"
            , cx "16"
            , cy "10"
            , strokeWidth "0"
            , fill "#000000"
            ]
            []
        , Svg.ellipse
            [ rx "1"
            , ry "1"
            , cx "16"
            , cy "13"
            , fill "#000000"
            ]
            []
        , Svg.ellipse
            [ rx "1"
            , ry "1"
            , cx "16"
            , cy "16"
            , fill "#000000"
            ]
            []
        ]
