module Counter exposing (Model, init, update, view, Msg)

import Html exposing (Html, div, button, text)
import Html.Events exposing (onClick)


-- Model

type alias Model = Int

model : Model
model = 0

init : Int -> Model
init initialValue =
  initialValue


-- Update
type Msg = Increment | Decrement


update: Msg -> Model -> Model
update msg model =
  case msg of
    Increment ->
      model + 1
    Decrement ->
      model - 1

-- View
view : Model -> Html Msg
view model =
  div []
    [ button [onClick Increment] [text "Increment"]
    , div [] [ text (toString model) ]
    , button [onClick Decrement] [text "Decrement"]
    ]
