
module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

import Models exposing (Model, Task)
import Msgs exposing (Msg)

import Components.Sidebar.Core as Sidebar
import Components.Checkbox.Core as Checkbox

---- VIEW ----


view : Model -> Html Msg
view model =
    section [class "flex-row"]
        [ Sidebar.view model
        , div [class "flex-column flex-grow"]
              [ viewTaskList model
              ]
        ]


viewTaskList : Model -> Html Msg
viewTaskList model =
  div []
      [ ul []
           ([] ++ List.map viewTaskItem model.tasks)
      ]


viewTaskItem : Task -> Html Msg
viewTaskItem task =
  li []
     [ Checkbox.view task.description [checked task.isComplete, onClick (Msgs.CompleteTask task.id), disabled task.isComplete]
     ]
