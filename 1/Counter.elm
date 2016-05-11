module Counter exposing (..)

import Html exposing (Html, div, button, text)
import Html.App as Html
import Html.Events exposing (onClick)


-- Model

type alias Model = Int

model : Model
model = 0


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

main =
  Html.beginnerProgram { model = model , view = view , update = update }
