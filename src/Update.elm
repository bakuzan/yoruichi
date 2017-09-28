module Update exposing (..)

import Task
import Date exposing (Date)

import Msgs exposing (Msg)
import Models exposing (Model, emptyTaskModel)

import Utils.Common as Common
import Utils.Date as UDate

---- UPDATE ----

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    Msgs.SetTimePeriod period ->
      ( { model | timePeriod = period }, Cmd.none)

    Msgs.SetStartUpDate date ->
      ( { model | today = Just date
                , targetDate = Just date
                }, Cmd.none)

    Msgs.UpdateDate date ->
      ( { model | targetDate = Just date }, Cmd.none)

    Msgs.GoToMonth firstOfAMonth ->
      ( { model | targetDate = Just firstOfAMonth }, Cmd.none)

    Msgs.SetDefaultTaskDate date ->
      let
          task =
            model.task

          taskDate =
            if task.id /= 0
              then task.repeatDay
              else (UDate.extractDate (Just date)
                     |> UDate.dateToStringFormatted)

          updatedTask =
            { task | repeatDay = taskDate }

      in
      ( { model | task = updatedTask }, Cmd.none)

    Msgs.EnterCreateMode taskId ->
      let
        task =
          Common.findInList (\x -> x.id == taskId) model.tasks

      in
      ( { model | openActionMenuFor = 0
                , isCreateMode = True
                , isDeleteMode = False
                , task = task
                }, Task.perform Msgs.SetDefaultTaskDate Date.now)

    Msgs.ExitCreateOrDeleteMode ->
      ( { model | isCreateMode = False
                , isDeleteMode = False }, Cmd.none)

    Msgs.OpenTaskActions taskId ->
      ( { model | openActionMenuFor = taskId }, Cmd.none)

    Msgs.PrepareToDelete taskId ->
      let
        task =
          Common.findInList (\x -> x.id == taskId) model.tasks

      in
      ( { model | openActionMenuFor = 0
                , isCreateMode = False
                , isDeleteMode = True
                , task = task }, Cmd.none)

    Msgs.CompleteTask taskId ->
      let
        updateTask t =
          if t.id == taskId then
            { t | isComplete = True }
          else
            t

      in
      ( { model | tasks = List.map updateTask model.tasks }, Cmd.none)

    Msgs.UpdateTaskDescription value ->
      let
        task =
          model.task

      in
      ( { model | task = { task | description = value } }, Cmd.none)

    Msgs.UpdateTaskFrequency value ->
      let
        task =
          model.task

        num =
          String.toInt value
           |> Result.withDefault 0

      in
      ( { model | task = { task | repeatFrequency = num } }, Cmd.none)

    Msgs.UpdateTaskDate value ->
     let
       task =
         model.task

     in
     ( { model | task = { task | repeatDay = value } }, Cmd.none)

    Msgs.DeleteTask taskId ->
      let
        remainingTasks =
          List.filter (\x -> x.id /= taskId) model.tasks

      in
      update Msgs.ExitCreateOrDeleteMode { model | tasks = remainingTasks }

    _ ->
    ( model, Cmd.none )
