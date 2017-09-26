module Msgs exposing (..)

import Date exposing (Date)


type Msg
    = NoOp
    | SetTimePeriod String
    | SetStartUpDate Date
    | UpdateDate Date
    | GoToMonth Date
    | EnterCreateMode Int
    | ExitCreateMode
    | CompleteTask Int
