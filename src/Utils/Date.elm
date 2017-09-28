module Utils.Date exposing(..)

import Date exposing (Date)



padLeft : String -> String
padLeft str =
    if (String.length str) == 2
      then str
      else ("0" ++ str)


extractDate : Maybe Date -> Date
extractDate date =
  let
    getTime =
      case date of
        Just d -> Date.toTime d
        Nothing -> 0

  in
  Date.fromTime getTime


constructDateFromIntegers : Int -> Int -> Int -> Date
constructDateFromIntegers y m d =
    dateFromString ((toString y) ++ "-" ++ (toString m) ++ "-" ++ (toString d))


dateToStringFormatted : Date -> String
dateToStringFormatted date =
  (toString (Date.year date)) ++ "-" ++ (padLeft (toString (monthNameToInteger (Date.month date)))) ++ "-" ++ (padLeft (toString (Date.day date)))


dateToDisplayString : Date -> String
dateToDisplayString date =
  (toString (Date.day date)) ++ " " ++ (toString (Date.month date)) ++ " " ++ (toString (Date.year date))


createFirstOfTheMonth : Date -> Int -> Date
createFirstOfTheMonth date monthOffset =
  let
    year =
      Date.year date

    month =
      ((monthNameToInteger (Date.month date)) + monthOffset)

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


calculateWeekStart : Date -> Date
calculateWeekStart targetDate =
  calculateDateOffsetWithCondition Date.Mon (\x -> negate (x - 1)) targetDate


calculateWeekEnd : Date -> Date
calculateWeekEnd targetDate =
  calculateDateOffsetWithCondition Date.Sun (\x -> 7 - x) targetDate


calculateDateOffsetWithCondition : Date.Day -> (Int -> Int) -> Date -> Date
calculateDateOffsetWithCondition condition adjustInt targetDate =
  let
      targetDateDoW =
        Date.dayOfWeek targetDate

      dayOffset =
        adjustInt (dayOfWeekToInteger targetDateDoW)

  in
  if targetDateDoW == condition
    then targetDate
    else (getDateForOffset targetDate dayOffset)


getDateForOffset : Date -> Int -> Date
getDateForOffset date offset =
    let
        day =
          (Date.day date) + offset

        month =
          (monthNameToInteger (Date.month date))

        year =
          (Date.year date)

        resolvedYear =
          if day < 1 && (month - 1) < 1
            then year - 1
            else year

        resolvedMonth =
            if day < 1
              then (monthIntegerHandler (month - 1))
              else
                if day > (getMonthLength date)
                  then (monthIntegerHandler (month + 1))
                  else month

        resolvedDay =
          dateIntegerHandler day (getMonthLength date)

    in
    constructDateFromIntegers resolvedYear resolvedMonth resolvedDay


dateIntegerHandler : Int -> Int -> Int
dateIntegerHandler date monthLength =
  if date < 1
    then monthLength + date
    else
      if date > monthLength
        then date - monthLength
        else date


monthIntegerHandler : Int -> Int
monthIntegerHandler month =
    if month > 12
      then month - 12
      else
        if month < 1
          then 12 - month
          else month
