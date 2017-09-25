module Utils.Common exposing (..)

import Date exposing (Date)
import Html exposing (Attribute)
import Html.Attributes exposing (attribute)




setRole : String -> Attribute msg
setRole value =
  attribute "role" value


getMonthLength : Date -> Int
getMonthLength date =
  let
    monthStart =
      Date.fromString ("1" ++ (toString date))
        |> Date.toTime

    monthEnd =
      Date.fromString ("1" ++ (toString date))
        |> Date.toTime

  in
  round ((monthEnd - monthStart) / (1000 * 60 * 60 * 24))
