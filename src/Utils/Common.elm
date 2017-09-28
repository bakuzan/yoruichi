module Utils.Common exposing (..)


import Html exposing (Attribute)
import Html.Attributes exposing (attribute)

import Models exposing (Tasks, Task, emptyTaskModel)




setRole : String -> Attribute msg
setRole value =
  attribute "role" value


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
