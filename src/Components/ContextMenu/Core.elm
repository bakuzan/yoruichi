module Components.ContextMenu.Core exposing (view)


import Html exposing (Html, div, ul, li, button, text)
import Html.Attributes exposing (class)
import Html.Events exposing(onClick)

import Msgs exposing (Msg)


view : Bool -> Int -> Html Msg
view active taskId =
  if not active
    then text ""
    else div [class "context-menu"]
             [ ul [class "list column one"]
                  [ li []
                       [ button [class "button", onClick (Msgs.EnterCreateMode taskId)]
                                [ text "Edit"
                                ]
                       ]
                  , li []
                       [ button [class "button", onClick (Msgs.PrepareToDelete taskId)]
                                [ text "Delete"
                                ]
                       ]
                  ]
             ]
