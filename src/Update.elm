module Update exposing (..)

import Task
import Date exposing (Date)

import Msgs exposing (Msg)
import Models exposing (Model, Query, emptyTaskModel)
import Ports

import Utils.Common as Common
import Utils.Date as UDate
import Utils.Functions as Functions

---- UPDATE ----

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  let
    query period date =
        Query period (UDate.dateToStringFormatted date)

  in
  case msg of
    Msgs.ReceiveTasks tasks ->
      ( { model | tasks = tasks }, Cmd.none)

    Msgs.ReceiveTask task ->
      let
        date =
          UDate.extractDate model.targetDate
      in
      ( model, Ports.fetch (query model.timePeriod date))

    Msgs.SetTimePeriod period ->
      let
        date =
          UDate.extractDate model.targetDate
      in
      ( { model | timePeriod = period }, Ports.fetch (query period date))

    Msgs.SetStartUpDate date ->
      ( { model | today = Just date
                , targetDate = Just date
                }, Ports.fetch (query model.timePeriod date))

    Msgs.UpdateDate date ->
      ( { model | targetDate = Just date }, Ports.fetch (query model.timePeriod date))

    Msgs.GoToMonth firstOfAMonth ->
      ( { model | targetDate = Just firstOfAMonth }, Ports.fetch (query model.timePeriod firstOfAMonth))

    Msgs.SetDefaultTaskDate date ->
      let
          task =
            model.task

          taskDate =
            if task.id /= "0"
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
      ( { model | openActionMenuFor = "0"
                , isCreateMode = True
                , isDeleteMode = False
                , task = task
                }, Task.perform Msgs.SetDefaultTaskDate Date.now)

    Msgs.ExitCreateOrDeleteMode ->
      ( { model | isCreateMode = False
                , isDeleteMode = False }, Cmd.none)

    Msgs.OpenTaskActions taskId ->
      ( { model | openActionMenuFor = taskId }, Cmd.none)

    Msgs.CloseTaskActions ->
      ( { model | openActionMenuFor = "0" }, Cmd.none)

    Msgs.PrepareToDelete taskId ->
      let
        task =
          Common.findInList (\x -> x.id == taskId) model.tasks

      in
      ( { model | openActionMenuFor = "0"
                , isCreateMode = False
                , isDeleteMode = True
                , task = task }, Cmd.none)

    Msgs.CompleteTask taskId dayOfWeek ->
      let
        updateTask t =
          if t.id == taskId && t.dayOfWeek == dayOfWeek then
            { t | isComplete = (t.repeatFrequency == 0)
                , completedOccurances = (Functions.updateCompletedOccurances model.targetDate t)
                }
          else
            t

        updatedTasks =
          List.map updateTask model.tasks

        task =
          Common.findInList (\t -> t.id == taskId) updatedTasks

      in
      ( { model | tasks = updatedTasks }, Ports.update task)

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

    Msgs.CreateTask ->
      ( { model | isCreateMode = False }, Ports.create model.task)

    Msgs.UpdateTask ->
      ( { model | isCreateMode = False }, Ports.update model.task)

    Msgs.DeleteTask taskId ->
      let
        remainingTasks =
          List.filter (\x -> x.id /= taskId) model.tasks

      in
      ( { model | tasks = remainingTasks
                , isDeleteMode = False }, Ports.delete taskId)

    _ ->
    ( model, Cmd.none )
