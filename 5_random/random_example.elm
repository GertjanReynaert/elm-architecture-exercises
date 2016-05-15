import Html.App as App
import Html exposing (Html, div, text, h1, button, ol, li)
import Html.Events exposing (onClick)
import Random

main =
  App.program
    { init = init
    , update = update
    , view = view
    , subscriptions = subscriptions
    }

type alias Model =
  { dieface : Int
  , one : Int
  , two : Int
  , three : Int
  , four : Int
  , five : Int
  , six : Int
  }


init : (Model, Cmd Msg)
init = (Model 1 0 0 0 0 0 0, Cmd.none)


type Msg
  = Roll
  | NewFace Int


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Roll ->
      (model, Random.generate NewFace (Random.int 1 6))

    NewFace face ->
      (updateNewFace face model, Cmd.none)

updateNewFace : Int -> Model -> Model
updateNewFace face model =
  case face of
    1 ->
      { model |
          dieface = face
        , one = model.one + 1
      }

    2 ->
      { model |
          dieface = face
        , two = model.two + 1
      }

    3 ->
      { model |
          dieface = face
        , three = model.three + 1
      }

    4 ->
      { model |
          dieface = face
        , four = model.four + 1
      }

    5 ->
      { model |
          dieface = face
        , five = model.five + 1
      }

    6 ->
      { model |
          dieface = face
        , six = model.six + 1
      }

    default ->
      { model | dieface = face }


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


view : Model -> Html Msg
view model =
  div []
    [ h1 [] [ text (toString model.dieface) ]
    , ol []
        [ li [] [ text ("Occurences: " ++ (toString model.one))]
        , li [] [ text ("Occurences: " ++ (toString model.two))]
        , li [] [ text ("Occurences: " ++ (toString model.three))]
        , li [] [ text ("Occurences: " ++ (toString model.four))]
        , li [] [ text ("Occurences: " ++ (toString model.five))]
        , li [] [ text ("Occurences: " ++ (toString model.six))]
        ]
    , button [ onClick Roll ] [ text "Roll" ]
    ]
