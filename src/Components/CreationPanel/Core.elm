module Components.CreationPanel.Core exposing (view)


import Html exposing (Html, div, p, button, input, label, text)
import Html.Attributes exposing (id, class, type_, name, value, placeholder, autocomplete)
import Html.Events exposing (onClick, onInput)


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
            if model.isCreateMode && model.task.id /= "0"
              then "Save"
              else "Create"

      actionClick =
        if model.isDeleteMode
          then (Msgs.DeleteTask model.task.id)
          else
            if model.isCreateMode && model.task.id /= "0"
              then Msgs.UpdateTask
              else Msgs.CreateTask

  in
  div [id "task-creation"]
      [ viewCreationBody model
      , div [class "button-group"]
            [ button [class "button", onClick actionClick]
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
    div [id "task-form"]
        [ ClearableInput.view "description" "Description" task.description
        , SelectBox.view Constants.frequencyOptions "repeatFrequency" "Frequency" task.repeatFrequency
        , div [class "has-float-label input-container clearable-input"]
            [ input [ type_ "date", name "reapatDay", placeholder " ", value task.repeatDay, autocomplete False, onInput Msgs.UpdateTaskDate] []
            , label [] [ text "Occurs" ]
            ]
        ]


viewDeleteBody : Model -> Html Msg
viewDeleteBody model =
  div [id "delete-message-container"]
      [ p []
          [ text ("Are you sure you want to delete '" ++ model.task.description ++ "' task?")
          ]
      ]
