
import Html.App as App
import Html exposing (Html, div, input, text)
import Html.Events exposing (onInput)
import Html.Attributes exposing (type', placeholder)

main =
  App.beginnerProgram
    { view = view
    , model = model
    , update = update
    }

model : Model
model = Model "" "" ""

type alias Model =
  { name: String
  , password: String
  , password2: String
  }

type alias FieldName = String

type Msg
  = UpdateName String
  | UpdatePassword String
  | UpdatePassword2 String

update : Msg -> Model -> Model
update msg model =
  case msg of
    UpdateName str ->
      { model | name = str}

    UpdatePassword str ->
      { model | password = str}

    UpdatePassword2 str ->
      { model | password2 = str}

view : Model -> Html Msg
view model =
  div []
    [ input [ type' "text", placeholder "Name", ( onInput UpdateName ) ] []
    , input [ type' "password", placeholder "Password", onInput UpdatePassword ] []
    , input [ type' "password", placeholder "Password again", onInput UpdatePassword2 ] []
    , viewValidation model
    ]

viewValidation: Model -> Html Msg
viewValidation model =
  let
    equal = model.password == model.password2
    warningText = if equal then
      "Your passwords are equal"
    else
      "Your passwords should match"
  in
    div []
      [ text warningText ]
