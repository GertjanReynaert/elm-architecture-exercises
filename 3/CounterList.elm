module CounterPair exposing (..)

import Html exposing (div, button, text, Html)
import Html.App as App
import Html.Events exposing (onClick)
import Counter exposing (Model, view, update)

type alias ID = Int

type alias Model =
  { counters: List (ID, Counter.Model)
  , nextId: ID
  }


init : Model
init =
  { counters = []
  , nextId = 0
  }


type Msg
  = Insert
  | Remove ID
  | Update ID Counter.Msg

isCounterForId : ID -> (ID, Counter.Model) -> Bool
isCounterForId id (counterId, counter) =
  counterId == counterId

update : Msg -> Model -> Model
update msg model =
  case msg of
    Insert ->
      let
        newCounter = (model.nextId, Counter.init 0)
        newCounters = model.counters ++ [newCounter]
      in
        { model |
            counters = newCounters
          , nextId = model.nextId + 1
        }

    Remove id ->
      let
        filteredCounters = List.filter (isCounterForId id) model.counters
      in
        { model | counters = filteredCounters }

    Update id counterMsg ->
      let updateCounter (counterId, counter) =
        if counterId == id then
          (counterId, Counter.update counterMsg counter)
        else
          (counterId, counter)
      in
        { model |
          counters = List.map updateCounter model.counters
        }


view : Model -> Html Msg
view model =
  let
    counters = List.map viewCounter model.counters
    insert =
      button [ onClick Insert ] [ text "Add new counter" ]
  in
    div []
      ([insert] ++ counters)


viewCounter : (ID, Counter.Model) -> Html Msg
viewCounter (counterId, counterModel) =
  div []
    [ App.map (Update counterId) (Counter.view counterModel)
    , deleteButton counterId
    ]


deleteButton: ID -> Html Msg
deleteButton counterId =
  button [ onClick (Remove counterId) ] [ text "Remove" ]


main =
  App.beginnerProgram { model = init , view = view , update = update }
