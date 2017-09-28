module Msgs exposing (..)

import Date exposing (Date)


type Msg
    = NoOp
    | SetTimePeriod String
    | SetStartUpDate Date
    | UpdateDate Date
    | GoToMonth Date
    | SetDefaultTaskDate Date
    | EnterCreateMode Int
    | PrepareToDelete Int
    | ExitCreateOrDeleteMode
    | OpenTaskActions Int
    | CompleteTask Int
    | UpdateTaskDescription String
    | UpdateTaskFrequency String
    | UpdateTaskDate String
    | DeleteTask Int
    | UpdateTask
    | CreateTask
