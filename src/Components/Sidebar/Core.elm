module Components.Sidebar.Core exposing (view)

import Html exposing (Html, div, button, text)
import Html.Attributes exposing (id, class, classList, value)
import Html.Events exposing (onClick)


import Models exposing (Model)
import Msgs exposing (Msg)
import Components.RadioButton.Core as RadioButton
import Components.Calendar.Core as Calendar

import Utils.Constants as Constants


view : Model -> Html Msg
view model =
  div [id (Constants.appName ++ "-sidebar")]
      [ RadioButton.viewRadioGroup "timePeriod" model.timePeriod Constants.timePeriods
      , Calendar.view model
      , div [class "button-group"]
            [ button [class "button ripple primary", onClick (Msgs.EnterCreateMode 0)]
                     [ text "Create Task"
                     ]
            ]
      ]
