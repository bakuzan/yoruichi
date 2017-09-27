module Components.SelectBox.Core exposing (view)


import Html exposing (Html, div, select, option, label, text)
import Html.Attributes exposing (class, name, value)
import Html.Events exposing (onInput)

import Models exposing (FrequencyOption)
import Msgs exposing (Msg)


view : List FrequencyOption -> String -> String -> Int -> Html Msg
view options fieldName fieldLabel fieldValue =
    div [class "has-float-label select-container"]
        [ select [class "select-box", name fieldName, value (toString fieldValue), onInput Msgs.UpdateTaskFrequency]
                 ([]
                 ++ List.map viewOption options)
        , label []
                [ text fieldLabel
                ]
        ]

viewOption : FrequencyOption -> Html Msg
viewOption freq =
    option [ value (toString freq.number) ]
           [ text freq.name ]
