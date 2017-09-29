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
