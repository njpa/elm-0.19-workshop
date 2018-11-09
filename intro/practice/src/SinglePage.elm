module SinglePage exposing (Model, Msg(..), init, main, update)

import Browser
import Browser.Navigation as Nav
import Html exposing (Html, a, div, li, text, ul)
import Html.Attributes exposing (href)
import Url



-- MAIN


main =
    Browser.application
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        , onUrlRequest = LinkClicked
        , onUrlChange = ChangeUrl
        }



-- MODEL


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( Model key url
    , Cmd.none
    )



-- UPDATE


type Msg
    = LinkClicked Browser.UrlRequest
    | ChangeUrl Url.Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model
                    , Nav.pushUrl model.key (Url.toString url)
                    )

                Browser.External href ->
                    ( model
                    , Nav.load href
                    )

        ChangeUrl url ->
            ( { model | url = url }
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> Browser.Document Msg
view model =
    { title = "Hello world!"
    , body =
        [ div []
            [ div []
                [ text
                    ("Current url is: "
                        ++ Url.toString model.url
                    )
                ]
            , div []
                [ ul []
                    [ linkTo "/" "Home"
                    , linkTo "/profile" "Profile"
                    , linkTo "/about" "About"
                    ]
                ]
            ]
        ]
    }


linkTo : String -> String -> Html Msg
linkTo path label =
    li []
        [ a [ href path ]
            [ text label ]
        ]
