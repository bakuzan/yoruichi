module Components.Sidebar.Core exposing (view)

import Html exposing (Html, div, select, option, text)
import Html.Attributes exposing (id, value)


import Models exposing (Model)
import Msgs exposing (Msg)
import Components.RadioButton.Core as RadioButton
import Components.Calendar.Core as Calendar

import Utils.Constants as Constants


view : Model -> Html Msg
view model =
  div [id (Constants.appName ++ "-sidebar")]
      [ RadioButton.viewRadioGroup "timePeriod" model.timePeriod Constants.timePeriods
      , Calendar.view
      ]
