
module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

import Models exposing (Model, Task)
import Msgs exposing (Msg)

import Components.Sidebar.Core as Sidebar
import Components.CreationPanel.Core as CreationPanel
import Components.Checkbox.Core as Checkbox

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
  div []
      [ ul [class "list column one"]
           ([] ++ List.map viewTaskItem model.tasks)
      ]


viewTaskItem : Task -> Html Msg
viewTaskItem task =
  li [class "flex"]
     [ Checkbox.view task.description [checked task.isComplete, onClick (Msgs.CompleteTask task.id), disabled task.isComplete]
     , div [class "flex-grow"]
           [ button [class "button"]
                    [ text "||"
                    ]
           ]
     ]
