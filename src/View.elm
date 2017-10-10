module View exposing (..)


import Date exposing (Date)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

import Models exposing (Model, Task, Tasks)
import Msgs exposing (Msg)

import Components.Sidebar.Core as Sidebar
import Components.CreationPanel.Core as CreationPanel
import Components.Checkbox.Core as Checkbox
import Components.ContextMenu.Core as ContextMenu

import Utils.Common as Common
import Utils.Constants as Constants
import Utils.Date as UDate
import Utils.Functions as Functions


---- VIEW ----


view : Model -> Html Msg
view model =
  let
    displaySidePanel =
      if model.isCreateMode || model.isDeleteMode
        then CreationPanel.view model
        else Sidebar.view model

  in
    section [class "flex-row"]
        [ displaySidePanel
        , div [class "flex-column flex-grow"]
              [ viewTaskList model
              ]
        ]


viewTaskList : Model -> Html Msg
viewTaskList model =
  let
    taskList =
      Common.groupListByDayOfWeek model.timePeriod model.tasks

    displayTasks =
      viewTaskItems model.timePeriod targetDate model.openActionMenuFor

    targetDate =
      UDate.extractDate model.targetDate

    dateRange =
      if model.timePeriod == (Constants.timePeriod |> .day)
        then (UDate.dateToDisplayString targetDate)
        else (UDate.dateToDisplayString (UDate.calculateWeekStart targetDate)) ++ " - " ++ (UDate.dateToDisplayString (UDate.calculateWeekEnd targetDate))

  in
  div []
      [ h4 [id "task-list-header"]
           [ text ("Tasks for " ++ dateRange)
           ]
      , ul [class "item-list"]
           (List.map displayTasks taskList |> List.concat)
      ]


viewTaskItems : String -> Date -> String -> Tasks -> List (Html Msg)
viewTaskItems period targetDate actionMenuId tasks =
  let
    dayOfWeek =
      List.head tasks
        |> Maybe.withDefault Models.emptyTaskModel
        |> .dayOfWeek

    singleTask =
      viewTaskItem targetDate actionMenuId

    taskListItems =
      List.map singleTask tasks

  in
    if period == (Constants.timePeriod |> .day)
      then List.map singleTask tasks
      else
        if (List.length taskListItems) == 0
          then []
          else ([ li [class "task-item day-of-week-header"] [text dayOfWeek] ]
               ++ taskListItems)


viewTaskItem : Date -> String -> Task -> Html Msg
viewTaskItem targetDate actionMenuId task =
  let
    isTaskComplete =
      if task.repeatFrequency == 0
        then task.isComplete
        else existsInOccurances

    occuranceDate =
      Functions.fetchOccuranceForTask targetDate task

    existsInOccurances =
      List.any (\x -> x == occuranceDate) task.completedOccurances

  in
  li [class "task-item"]
     [ div []
           [ Checkbox.view task.description [checked isTaskComplete, onClick (Msgs.CompleteTask task.id task.dayOfWeek), disabled isTaskComplete]
           , div [class "task-item__action-container"]
                 [ button [class "button-icon ripple menu-icon", onClick (Msgs.OpenTaskActions task.id)] []
                 , ContextMenu.view (actionMenuId == task.id) task.id
                 ]
           ]
     ]
