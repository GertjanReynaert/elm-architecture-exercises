import Html exposing (div, h2, text, button, br, img, Html)
import Html.App as App
import Html.Attributes exposing (placeholder, src)
import Html.Events exposing (onClick)
import Http
import Json.Decode as Json
import Task

main =
  App.program
    { init = init "cats"
    , update = update
    , view = view
    , subscriptions = subscriptions
    }

-- init


type alias Model =
  { topic : String
  , gifUrl : String
  }

init : String -> ( Model, Cmd Msg )
init topic =
  (
    Model topic "waiting.gif"
    , getRandomGif topic
  )

-- Update


type Msg
  = MorePlease
  | FetchSucceed String
  | FetchFail Http.Error


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    MorePlease ->
      ( model, getRandomGif model.topic )

    FetchSucceed gifUrl ->
      ( { model | gifUrl = gifUrl }, Cmd.none )

    FetchFail error ->
      ( model, Cmd.none )


-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ h2 [] [text model.topic]
    , button [ onClick MorePlease ] [ text "More Please!" ]
    , br [] []
    , img [src model.gifUrl] []
    ]


-- subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

-- HTTP

getRandomGif : String -> Cmd Msg
getRandomGif topic =
  let
    url =
      "//api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ topic
  in
    Task.perform FetchFail FetchSucceed (Http.get decodeGifUrl url)


decodeGifUrl : Json.Decoder String
decodeGifUrl =
  Json.at ["data", "image_url"] Json.string
