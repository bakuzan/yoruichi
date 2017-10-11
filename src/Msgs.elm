module Msgs exposing (..)

import Date exposing (Date)

import Models exposing (Task, Tasks)



type Msg
    = NoOp
    | SetTimePeriod String
    | SetStartUpDate Date
    | ReceiveTasks Tasks
    | ReceiveTask Task
    | UpdateDate Date
    | GoToMonth Date
    | SetDefaultTaskDate Date
    | EnterCreateMode String
    | PrepareToDelete String
    | ExitCreateOrDeleteMode
    | OpenTaskActions String String
    | CloseTaskActions
    | CompleteTask String String
    | UpdateTaskDescription String
    | UpdateTaskFrequency String
    | UpdateTaskDate String
    | DeleteTask String
    | UpdateTask
    | CreateTask
