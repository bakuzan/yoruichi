module Components.CreationPanel.Core exposing (view)


import Html exposing (Html, div, button, text)
import Html.Attributes exposing (id, class, classList)
import Html.Events exposing (onClick)


import Models exposing (Model)
import Msgs exposing (Msg)



view : Model -> Html Msg
view model =
  div [id "task-creation", classList [("hidden", not model.isCreateMode)]]
      [ div [class "button-group"]
            [ button [class "button", onClick Msgs.ExitCreateMode]
                     [ text "X"
                     ]
            ]
      ]
