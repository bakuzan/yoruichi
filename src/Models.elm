module Models exposing(..)


import Date exposing (Date)



---- MODEL ----


type alias Model =
    { timePeriod: String
    , today: Maybe Date.Date
    , targetDate: Maybe Date.Date
    , isCreateMode: Bool
    , isDeleteMode: Bool
    , openActionMenuFor: String
    , tasks: Tasks
    , task: Task
    }


initialModel : Model
initialModel =
  Model "DAY" Nothing Nothing False False "0" [] emptyTaskModel



type alias Tasks =
  List Task


type alias Task =
  { id: String
  , description: String
  , isComplete: Bool
  , repeatFrequency: Int -- Enum for 0 None, 1 Daily, 2 Weekly, 3 Monthly, 4 Quarterly, 5 Yearly
  , repeatDay: String -- dayOfWeek for weekly, Date for monthly/Quarterly/Yearly
  , dayOfWeek: String
  -- , createdDate: Date
  -- , updatedDate: Date
  }

-- Date hardcoded to the project start date.
-- Will be overwritten in update
emptyTaskModel : Task
emptyTaskModel =
  Task "0" "" False 0 "2017-09-25" "Mon"



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
