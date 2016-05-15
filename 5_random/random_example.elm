import Html.App as App
import Html exposing (Html, div, text, h1, button)
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
  }


init : (Model, Cmd Msg)
init = (Model 1, Cmd.none)


type Msg
  = Roll
  | NewFace Int


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Roll ->
      (model, Random.generate NewFace (Random.int 1 6))

    NewFace face ->
      ({ model | dieface =  face }, Cmd.none)


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


view : Model -> Html Msg
view model =
  div []
    [ h1 [] [ text (toString model.dieface) ]
    , button [ onClick Roll ] [ text "Roll" ]
    ]
