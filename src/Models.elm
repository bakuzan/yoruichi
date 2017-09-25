module Models exposing(..)


---- MODEL ----


type alias Model =
    { timePeriod: String
    , tasks: Tasks
    }


initialModel : Model
initialModel =
  Model "DAY" [ Task 0 "Buy Milk" False
              , Task 1 "Read Paper" False
              , Task 2 "Cut the grass" False
              , Task 3 "Put the bins out" False
              ]



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



type alias Header =
  { name: String
  , number: Int
  }
