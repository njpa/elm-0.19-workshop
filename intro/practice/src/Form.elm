module Form exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

main =
    Browser.sandbox  { init = init, view = view, update = update }

-- MODEL

type alias Model = 
    { name : String
    , password : String
    , passwordAgain : String
    }

init : Model
init = 
    Model "" "" ""


-- UPDATE

type Msg =
    Name String
    | Password String
    | PasswordAgain String


update : Msg -> Model -> Model
update msg model =
    case msg of 
        Name newName ->
            { model | name = newName }

        Password newPassword ->
            { model | password = newPassword }

        PasswordAgain newPasswordAgain ->
            { model | passwordAgain = newPasswordAgain }


-- VIEW

view : Model -> Html Msg
view model =
    div []
    [ viewInput "text" "Name" model.name Name
    , viewInput "password" "Password" model.password Password
    , viewInput "password" "Password confirmation" model.passwordAgain PasswordAgain
    , viewValidation model
    ]



viewInput : String -> String -> String -> ( String -> Msg ) -> Html Msg
viewInput t p v toMsg =
    input 
        [ type_ t
        , placeholder p 
        , value v
        , onInput toMsg
        ] 
        []

viewValidation : Model -> Html Msg
viewValidation model =
    let
        ( styling, message ) =
            if model.password == model.passwordAgain then
                ( ( style "color" "green"), "OK" )
            else
                ( ( style "color" "red"), "Passwords do not match!" )

    in
        div [ styling ] [ text message ]
