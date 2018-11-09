module Clock exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (Html, div, h1, text)
import Task
import Time



-- MAIN


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


type alias Model =
    { time : Time.Posix
    , zone : Time.Zone
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model (Time.millisToPosix 324130000000) Time.utc
    , Task.perform GetTimeZone Time.here
    )



-- UPDATE


type Msg
    = Tick Time.Posix
    | GetTimeZone Time.Zone


update msg model =
    case msg of
        GetTimeZone zone ->
            ( { model | zone = zone }
            , Cmd.none
            )

        Tick newTime ->
            ( { model | time = newTime }
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every 1000 Tick



-- VIEW


view : Model -> Html Msg
view model =
    let
        t =
            { year = Time.toYear model.zone model.time
            , second = Time.toSecond model.zone model.time
            , minute = Time.toMinute model.zone model.time
            , hour = Time.toHour model.zone model.time
            , day = Time.toDay model.zone model.time
            }
    in
    div []
        [ div []
            [ h1 []
                [ text
                    ("Date: "
                        ++ String.fromInt t.day
                        ++ "/"
                        ++ String.fromInt t.year
                    )
                ]
            ]
        , div []
            [ h1 []
                [ text
                    ("The time is: "
                        ++ String.fromInt t.hour
                        ++ ":"
                        ++ String.fromInt t.minute
                        ++ ":"
                        ++ String.fromInt t.second
                    )
                ]
            ]
        ]
