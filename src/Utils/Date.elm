module Utils.Date exposing(..)

import Date exposing (Date)




extractDate : Maybe Date -> Date
extractDate date =
  let
    getTime =
      case date of
        Just d -> Date.toTime d
        Nothing -> 0

  in
  Date.fromTime getTime


dateToStringFormatted : Date -> String
dateToStringFormatted date =
  let
    padLeft str =
      if (String.length str) == 2
        then str
        else ("0" ++ str)

  in
  (toString (Date.year date)) ++ "-" ++ (padLeft (toString (monthNameToInteger (Date.month date)))) ++ "-" ++ (padLeft (toString (Date.day date)))


createFirstOfTheMonth : Date -> Int -> Date
createFirstOfTheMonth date num =
  let
    year =
      Date.year date

    month =
      ((monthNameToInteger (Date.month date)) + num)

    yearMonthPair =
      if month > 12
        then (toString (year + 1)) ++ "-1"
        else if month < 1
          then (toString (year - 1)) ++ "-12"
          else ((toString year) ++ "-" ++ (toString month))

  in
  dateFromString (yearMonthPair ++ "-1")



dateFromString : String -> Date
dateFromString str =
  Date.fromString str
    |> Result.withDefault (Date.fromTime 0)


getMonthLength : Date -> Int
getMonthLength date =
  let
    buildDate num =
      createFirstOfTheMonth date num
        |> Date.toTime

    monthStart =
      buildDate 0

    monthEnd =
      buildDate 1

  in
  round ((monthEnd - monthStart) / (1000 * 60 * 60 * 24))


monthNameToInteger : Date.Month -> Int
monthNameToInteger month =
  case month of
    Date.Jan -> 1
    Date.Feb -> 2
    Date.Mar -> 3
    Date.Apr -> 4
    Date.May -> 5
    Date.Jun -> 6
    Date.Jul -> 7
    Date.Aug -> 8
    Date.Sep -> 9
    Date.Oct -> 10
    Date.Nov -> 11
    Date.Dec -> 12


dayOfWeekToInteger : Date.Day -> Int
dayOfWeekToInteger day =
  case day of
    Date.Mon -> 1
    Date.Tue -> 2
    Date.Wed -> 3
    Date.Thu -> 4
    Date.Fri -> 5
    Date.Sat -> 6
    Date.Sun -> 7
