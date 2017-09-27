module Components.CreationPanel.Core exposing (view)


import Html exposing (Html, div, p, button, text)
import Html.Attributes exposing (id, class)
import Html.Events exposing (onClick)


import Models exposing (Model)
import Msgs exposing (Msg)
import Components.ClearableInput.Core as ClearableInput
import Components.SelectBox.Core as SelectBox

import Utils.Constants as Constants



view : Model -> Html Msg
view model =
  let
      actionText =
        if model.isDeleteMode
          then "Delete"
          else
            if model.isCreateMode && model.task.id /= 0
              then "Save"
              else "Create"

  in
  div [id "task-creation"]
      [ viewCreationBody model
      , div [class "button-group"]
            [ button [class "button"]
                     [ text actionText
                     ]
            , button [class "button-link", onClick Msgs.ExitCreateOrDeleteMode]
                     [ text "Cancel"
                     ]
            ]
      ]


viewCreationBody : Model -> Html Msg
viewCreationBody model =
    if model.isCreateMode
      then viewCreateBody model
      else viewDeleteBody model


viewCreateBody : Model -> Html Msg
viewCreateBody model =
  let
    task =
      model.task
  in
    div []
        [ ClearableInput.view "description" "Description" task.description
        , SelectBox.view Constants.frequencyOptions "repeatFrequency" "Frequency" task.repeatFrequency
        ]


viewDeleteBody : Model -> Html Msg
viewDeleteBody model =
  div [id "delete-message-container"]
      [ p []
          [ text ("Are you sure you want to delete '" ++ model.task.description ++ "' task?")
          ]
      ]
