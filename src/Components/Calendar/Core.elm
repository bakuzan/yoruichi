module Components.Calendar.Core exposing (view)

import Html exposing (Html, div, table, thead, tbody, tr, th, td, text)
import Html.Attributes exposing (class)

import Msgs exposing (Msg)

import Utils.Constants as Constants



view : Html Msg
view =
  div [class "calendar"]
      [ viewControls
      , viewCalendar
      ]


viewControls : Html Msg
viewControls =
  div [class "calendar__controls"]
      [
      ]


viewCalendar : Html Msg
viewCalendar =
  table [class "calendar__table"]
      [ viewDayNameHeader
      , viewCalendarBody
      ]


viewDayNameHeader : Html Msg
viewDayNameHeader =
  let
    viewHeaderCell day =
      th [] [ text day.name
            ]

  in
  thead []
        [ tr []
             ([] ++ List.map viewHeaderCell Constants.days)
        ]


viewCalendarBody : Html Msg
viewCalendarBody =
  tbody []
        [
        ]
