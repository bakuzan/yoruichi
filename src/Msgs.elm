module Msgs exposing (..)

import Date exposing (Date)


type Msg
    = NoOp
    | SetTimePeriod String
    | UpdateDate Date
    | CompleteTask Int
