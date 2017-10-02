module Utils.Common exposing (..)


import Models exposing (Tasks, Task, emptyTaskModel)

import Utils.Constants as Constants



splitList : Int -> List a -> List (List a)
splitList i list =
  case List.take i list of
    [] -> []
    listHead -> listHead :: splitList i (List.drop i list)


findInList : (Task -> Bool) -> Tasks -> Task
findInList f list =
  List.filter f list
    |> List.head
    |> Maybe.withDefault emptyTaskModel


groupListByDayOfWeek : String -> Tasks -> List (Tasks)
groupListByDayOfWeek period tasks =
    if period == (Constants.timePeriod |> .day)
      then [tasks]
      else separateWeekDays 1 tasks


separateWeekDays : Int -> Tasks -> List (Tasks)
separateWeekDays i tasks =
  let
      dayOfWeek =
        List.filter (\x -> x.number == i) Constants.days
         |> List.head
         |> Maybe.withDefault { name = "Unkown", number = 0 }
         |> .name

      grouped =
        List.filter (\x -> x.dayOfWeek == dayOfWeek) tasks

  in
  case i of
    8 -> []
    _ -> grouped :: separateWeekDays (i + 1) tasks
