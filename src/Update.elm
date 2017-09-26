module Update exposing (..)


import Msgs exposing (Msg)
import Models exposing (Model)


---- UPDATE ----

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    Msgs.SetTimePeriod period ->
      ( { model | timePeriod = period }, Cmd.none)

    Msgs.StartUpDate date ->
      ( { model | today = Just date
                , targetDate = Just date
                }, Cmd.none)

    Msgs.UpdateDate date ->
      ( { model | targetDate = Just date }, Cmd.none)

    Msgs.GoToMonth firstOfAMonth ->
      ( { model | targetDate = Just firstOfAMonth }, Cmd.none)

    Msgs.CompleteTask taskId ->
      let
        updateTask t =
          if t.id == taskId then
            { t | isComplete = True }
          else
            t

      in
      ( { model | tasks = List.map updateTask model.tasks }, Cmd.none)

    _ ->
    ( model, Cmd.none )
