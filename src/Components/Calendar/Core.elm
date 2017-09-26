module Components.Calendar.Core exposing (view)

import Date exposing (Date)
import Html exposing (Html, div, table, thead, tbody, tr, th, td, button, text)
import Html.Attributes exposing (class, classList)
import Html.Events exposing (onClick)

import Models exposing (Model)
import Msgs exposing (Msg)

import Utils.Constants as Constants
import Utils.Common as Common



view : Model -> Html Msg
view model =
  div [class "calendar"]
      [ viewControls model.targetDate
      , viewCalendar model
      ]


viewControls : Maybe Date -> Html Msg
viewControls targetDate =
  let
    date =
      Common.extractDate targetDate

    year =
      Date.year date

    month =
      Date.month date

    nextMonth =
      Common.createFirstOfTheMonth date 1

    prevMonth =
      Common.createFirstOfTheMonth date -1

  in
  div [class "calendar__controls"]
      [ button [class "button", onClick (Msgs.GoToMonth prevMonth)] [text "prev"]
      , div [class "calendar__month-text"]
            [ text ((toString month) ++ " " ++ (toString year))
            ]
      , button [class "button", onClick (Msgs.GoToMonth nextMonth)] [text "next"]
      ]


viewCalendar : Model -> Html Msg
viewCalendar model =
  table [class "calendar__table"]
      [ viewDayNameHeader
      , viewCalendarBody model
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


viewCalendarBody : Model -> Html Msg
viewCalendarBody model =
  let
    date =
      Common.extractDate model.targetDate

    year =
      Date.year date

    month =
      Date.month date

    monthLength =
      Common.getMonthLength date

    dayOfWeekNumber =
      Common.dateFromString ((toString year) ++ (toString month) ++ "-1")
        |> Date.dayOfWeek
        |> Common.dayOfWeekToInteger

    dummyDays =
      dayOfWeekNumber - 1

    squares =
      (populateArrayForDummies dummyDays) ++ (List.range 1 monthLength)

    squaresInRows =
      Common.splitList 7 squares

  in
  tbody []
        ([]
        ++ List.map (viewCalendarWeek model) squaresInRows)


viewCalendarWeek : Model -> List Int -> Html Msg
viewCalendarWeek model squares =
  let
    len =
      List.length squares

    squaresWithDummies =
      squares ++ (populateArrayForDummies (7 - len))

  in
  tr [class "calendar-week"]
     ([]
     ++ List.map viewDay squaresWithDummies)


viewDay : Int -> Html Msg
viewDay dateNum =
  let
    isDummyDay =
      dateNum == 0

    date =
      if isDummyDay
        then ""
        else toString dateNum

  in
  td [class "calendar-week__day", classList [("dummy-day", isDummyDay)]]
     [ viewDayContent isDummyDay [(text date)]
     ]

viewDayContent : Bool -> List (Html Msg) -> Html Msg
viewDayContent blockInteraction children =
  if blockInteraction
    then div [] ([] ++ children)
    else button [class "button"] ([] ++ children)


-- Helper functions
populateArrayForDummies : Int -> List Int
populateArrayForDummies len =
  if len == 0
    then []
    else List.map (\x -> 0) (List.range 1 len)
