module Components.Checkbox.Core exposing (view)

import Msgs exposing (Msg)

import Html exposing (Html, Attribute, div, label, input, span, text)
import Html.Attributes exposing (class, type_)


view : String -> List (Attribute Msg) -> Html Msg
view checkboxLabel inputProps =
  div [class "input-container"]
      [ label [class "tickbox"]
              [ input ([type_ "checkbox"] ++ inputProps) []
              , span [] [text checkboxLabel]
              ]
      ]
