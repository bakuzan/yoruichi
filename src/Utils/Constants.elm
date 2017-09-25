module Utils.Constants exposing (..)


import Msgs exposing (Msg)

import Components.RadioButton.RadioButton as RadioButton


appName : String
appName =
  "APP_NAME"


timePeriods : List RadioButton.RadioOption
timePeriods =
  [{ label = "By Day", optionValue = "DAY", action = Msgs.SetTimePeriod "DAY" }
  ,{ label = "By Week", optionValue = "WEEK", action = Msgs.SetTimePeriod "WEEK" }
  ]
