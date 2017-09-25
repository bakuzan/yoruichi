module Components.Calendar.Core exposing (view)

import Date exposing (Date)
import Html exposing (Html, div, table, thead, tbody, tr, th, td, button, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)

import Models exposing (Model)
import Msgs exposing (Msg)

import Utils.Constants as Constants



view : Model -> Html Msg
view model =
  div [class "calendar"]
      [ viewControls model.targetDate
      , viewCalendar
      ]


viewControls : Maybe Date -> Html Msg
viewControls targetDate =
  let
    extractDate date =
      case date of
        Just d -> Date.toTime d
        Nothing -> 0

    year =
      extractDate targetDate
        |> Date.fromTime
        |> Date.year

    month =
      extractDate targetDate
        |> Date.fromTime
        |> Date.month

  in
  div [class "calendar__controls"]
      [ button [class "button", onClick (Msgs.GoToMonth)] [text "prev"]
      , div [class "calendar__month-text"]
            [ text ((toString month) ++ " " ++ (toString year))
            , text (toString targetDate)
            ]
      , button [class "button", onClick (Msgs.GoToMonth)] [text "next"]
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
