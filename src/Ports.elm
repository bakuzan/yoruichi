port module Ports exposing (..)



import Models exposing(Task, Tasks, Query)



-- Ports


port fetch : Query -> Cmd msg

port update : Task -> Cmd msg

port delete : Int -> Cmd msg


port tasks : (Tasks -> msg) -> Sub msg

port task : (Task -> msg) -> Sub msg
