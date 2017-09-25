module Utils.Common exposing (..)

import Html exposing (Attribute)
import Html.Attributes exposing (attribute)




setRole : String -> Attribute msg
setRole value =
  attribute "role" value
