module Utils.Functions exposing (..)


import Date exposing (Date)


import Models exposing (Task)

import Utils.Date as UDate
import Utils.Constants as Constants




fetchOccuranceForTask : Date -> Task -> String
fetchOccuranceForTask date task =
  let
    targetDayOfWeek =
      Date.dayOfWeek date
        |> UDate.dayOfWeekToInteger

    taskDayOfWeek =
      List.filter (\x -> x.name == task.dayOfWeek) Constants.days
       |> List.head
       |> Maybe.withDefault { name = "Unkown", number = 0 }
       |> .number

    dayOffset =
      negate (targetDayOfWeek - taskDayOfWeek)

  in
  UDate.getDateForOffset date dayOffset
    |> UDate.dateToStringFormatted


updateCompletedOccurances : Maybe Date -> Task -> List String
updateCompletedOccurances targetDate task =
  let
    date =
      UDate.extractDate targetDate

  in
  fetchOccuranceForTask date task
    |> List.singleton
    |> List.append task.completedOccurances
