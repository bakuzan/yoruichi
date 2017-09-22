module Models exposing(..)


---- MODEL ----


type alias Model =
    { test: String
    , tasks: Tasks
    }


initialModel : Model
initialModel =
  Model "MY TEST STRING" [Task 0 "Buy Milk" False, Task 1 "Read Paper" False]



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
