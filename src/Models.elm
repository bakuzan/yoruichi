module Models exposing(..)

import Date

---- MODEL ----


type alias Model =
    { timePeriod: String
    , today: Maybe Date.Date
    , targetDate: Maybe Date.Date
    , isCreateMode: Bool
    , openActionMenuFor: Int
    , tasks: Tasks
    , task: Task
    }


initialModel : Model
initialModel =
  Model "DAY" Nothing Nothing False 0 [ Task 1 "Buy Milk" False
                                      , Task 2 "Read Paper" False
                                      , Task 3 "Cut the grass" False
                                      , Task 4 "Put the bins out" False
                                      ] emptyTaskModel



type alias Tasks =
  List Task


type alias Task =
  { id: Int
  , description: String
  , isComplete: Bool
  -- , repeatFrequency: Int // Enum for 0 None, 1 Daily, 2 Weekly, 3 Monthly, 4 Quarterly, 5 Yearly
  -- , reapatDay: Date // dayOfWeek for weekly, Date for monthly/Quarterly/Yearly
  -- , createdDate: Date
  -- , updatedDate: Date
  }

emptyTaskModel : Task
emptyTaskModel =
  Task 0 "" False


type alias Header =
  { name: String
  , number: Int
  }
