module Msgs exposing (..)

import Date exposing (Date)


type Msg
    = NoOp
    | SetTimePeriod String
    | StartUpDate Date
    | UpdateDate Date
    | GoToMonth Date
    | CompleteTask Int
