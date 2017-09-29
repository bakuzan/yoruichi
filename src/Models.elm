module Models exposing(..)


import Date exposing (Date)



---- MODEL ----


type alias Model =
    { timePeriod: String
    , today: Maybe Date.Date
    , targetDate: Maybe Date.Date
    , isCreateMode: Bool
    , isDeleteMode: Bool
    , openActionMenuFor: Int
    , tasks: Tasks
    , task: Task
    }


initialModel : Model
initialModel =
  Model "DAY" Nothing Nothing False False 0 [ Task 1 "Buy Milk" False 2 "2017-09-26"
                                            , Task 2 "Read Paper" False 1 "2017-09-26"
                                            , Task 3 "Cut the grass" False 3 "2017-09-26"
                                            , Task 4 "Put the bins out" False 2 "2017-09-27"
                                            ] emptyTaskModel



type alias Tasks =
  List Task


type alias Task =
  { id: Int
  , description: String
  , isComplete: Bool
  , repeatFrequency: Int -- Enum for 0 None, 1 Daily, 2 Weekly, 3 Monthly, 4 Quarterly, 5 Yearly
  , repeatDay: String -- dayOfWeek for weekly, Date for monthly/Quarterly/Yearly
  -- , createdDate: Date
  -- , updatedDate: Date
  }

-- Date hardcoded to the project start date.
-- Will be overwritten in update
emptyTaskModel : Task
emptyTaskModel =
  Task 0 "" False 0 "2017-09-25"



type alias Header =
  { name: String
  , number: Int
  }

type alias FrequencyOption =
  { name: String
  , number: Int
  }

type alias Query =
  { timePeriod: String
  , targetDate: String
  }
