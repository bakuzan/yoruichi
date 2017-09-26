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
    targetDate =
      Common.extractDate model.targetDate

    isWeekActive =
      model.timePeriod == "WEEK" && List.any (\x -> x == (Date.day targetDate)) squares

    len =
      List.length squares

    squaresWithDummies =
      squares ++ (populateArrayForDummies (7 - len))

    constructDay =
      viewDay (Common.extractDate model.today) targetDate

  in
  tr [class "calendar-week", classList [("active", isWeekActive)]]
     ([]
     ++ List.map constructDay squaresWithDummies)


viewDay : Date -> Date -> Int -> Html Msg
viewDay today target dateNum =
  let
    isToday =
      dateNum == (Date.day today) && (Date.month today) == (Date.month target) && (Date.year today) == (Date.year target)

    isDayActive =
      dateNum == (Date.day target)

    isDummyDay =
      dateNum == 0

    dateStr =
      if isDummyDay
        then ""
        else toString dateNum

    date =
      Common.dateFromString ((toString (Date.year target)) ++ "-" ++ (toString (Date.month target)) ++ "-" ++ dateStr)

  in
  td [class "calendar-week__day", classList [("dummy-day", isDummyDay), ("active", isDayActive), ("is-today", isToday)]]
     [ viewDayContent isDummyDay [(text dateStr)] date
     ]


viewDayContent : Bool -> List (Html Msg) -> Date -> Html Msg
viewDayContent blockInteraction children date =
  if blockInteraction
    then div [] ([] ++ children)
    else button [class "button", onClick (Msgs.UpdateDate date)]
                ([]
                ++ children)


-- Helper functions
populateArrayForDummies : Int -> List Int
populateArrayForDummies len =
  if len == 0
    then []
    else List.map (\x -> 0) (List.range 1 len)
