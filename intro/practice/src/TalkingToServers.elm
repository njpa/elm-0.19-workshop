module TalkingToServers exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Http



-- MODEL


type alias Article =
    { title : String
    , description : String
    , body : String
    , tags : List String
    , slug : String
    }


type alias Model =
    { articles : List Article
    , status : String
    }


initialModel : Model
initialModel =
    { articles = []
    , status = ""
    }

-- MSG

type Msg =
    ClickedGetArticles
    | CompletedLoadArticles (Result Http.Error String)


-- UPDATE

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ClickedGetArticles ->
            ( { model | status = "getting it" }
            , getArticles )
        CompletedLoadArticles (Ok result) ->
            ( { model | status = "got it" }
            , Cmd.none
            )
        CompletedLoadArticles (Err error) ->
            ( { model | status = "there was an error" }
            , Cmd.none
            )



-- COMMANDS

getArticles : (Result Http.Error (String)) 
getArticles =
    Http.getString "/api/users"
        |> Http.send (\result -> CompletedLoadArticles result)

-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick ClickedGetArticles ] [ text "Request articles"]
        , viewArticles model.articles 
        , text model.status
        ]

    
viewArticle : Article -> Html Msg
viewArticle article =
    div []
        [ h1 [] [ text article.title ]
        , p [] [ text article.description ]
        ]



viewArticles: List Article -> Html Msg
viewArticles articles =
    div [] 
        (List.map viewArticle articles)


-- MAIN


main : Program () Model Msg
main =
    Browser.element
        { init =  \() -> ( initialModel, Cmd.none)
        , subscriptions = \_ -> Sub.none
        , view = view
        , update = update
        }
