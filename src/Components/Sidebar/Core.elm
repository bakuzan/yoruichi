module Components.Sidebar.Core exposing (view)

import Html exposing (Html, div, text)
import Html.Attributes exposing (id)

import Models exposing (Model)
import Msgs exposing (Msg)

import Utils.Constants as Constants


view : Model -> Html Msg
view model =
  div [id (Constants.appName ++ "-sidebar")]
      [ text model.test
      ]
