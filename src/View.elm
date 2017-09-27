
module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

import Models exposing (Model, Task)
import Msgs exposing (Msg)

import Components.Sidebar.Core as Sidebar
import Components.CreationPanel.Core as CreationPanel
import Components.Checkbox.Core as Checkbox
import Components.ContextMenu.Core as ContextMenu

---- VIEW ----


view : Model -> Html Msg
view model =
  let
    displaySidePanel =
      if model.isCreateMode
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
    displayTask =
      viewTaskItem model.openActionMenuFor
  in
  div []
      [ ul [class "item-list"]
           ([] ++ List.map displayTask model.tasks)
      ]


viewTaskItem : Int -> Task -> Html Msg
viewTaskItem actionMenuId task =
  li [class "task-item"]
     [ div []
           [ Checkbox.view task.description [checked task.isComplete, onClick (Msgs.CompleteTask task.id), disabled task.isComplete]
           , div [class "task-item__action-container"]
                 [ button [class "button-icon menu-icon", onClick (Msgs.OpenTaskActions task.id)] []
                 , ContextMenu.view (actionMenuId == task.id) task.id
                 ]
           ]
     ]
