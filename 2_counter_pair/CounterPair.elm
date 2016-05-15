module CounterPair exposing (..)

import Html exposing (div, button, text, Html)
import Html.App as App
import Html.Events exposing (onClick)
import Counter exposing (Model, view, update)

type alias Model =
  { counterA: Counter.Model
  , counterB: Counter.Model
  }


init : Int -> Int -> Model
init a b =
  { counterA = Counter.init a
  , counterB = Counter.init b
  }


type Msg
  = Reset
  | UpdateA Counter.Msg
  | UpdateB Counter.Msg


update : Msg -> Model -> Model
update msg model =
  case msg of
    Reset ->
      init 0 0
    UpdateA counterMsg ->
      { model | counterA = Counter.update counterMsg  model.counterA }
    UpdateB counterMsg ->
      { model | counterB = Counter.update counterMsg  model.counterB }


view : Model -> Html Msg
view model =
  div []
    [ App.map UpdateA (Counter.view model.counterA)
    , App.map UpdateB (Counter.view model.counterB)
    , button [ onClick Reset ] [ text "Reset" ]
    ]


main =
  App.beginnerProgram { model = init 0 0 , view = view , update = update }
