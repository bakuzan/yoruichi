module Main exposing (..)

import Task
import Date
import Html


import Models exposing (Model, initialModel)
import Msgs exposing (Msg)
import Update exposing (update)
import View exposing (view)
import Ports




init : ( Model, Cmd Msg )
init =
    ( initialModel, Task.perform Msgs.SetStartUpDate Date.now)


---- SUBSCRIPTIONS ----

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch [ Ports.tasks Msgs.ReceiveTasks
            , Ports.task Msgs.ReceiveTask
            ]


---- PROGRAM ----

main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
