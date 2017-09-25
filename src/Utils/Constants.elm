module Utils.Constants exposing (..)

import Models exposing (Header)
import Msgs exposing (Msg)

import Components.RadioButton.RadioButton as RadioButton


appName : String
appName =
  "yoruichi"


timePeriods : List RadioButton.RadioOption
timePeriods =
  [{ label = "By Day", optionValue = "DAY", action = Msgs.SetTimePeriod "DAY" }
  ,{ label = "By Week", optionValue = "WEEK", action = Msgs.SetTimePeriod "WEEK" }
  ]

months : List Header
months =
  [{ name = "Jan", number = 0 }
  ,{ name = "Feb", number = 1 }
  ,{ name = "Mar", number = 2 }
  ,{ name = "Apr", number = 3 }
  ,{ name = "May", number = 4 }
  ,{ name = "Jun", number = 5 }
  ,{ name = "Jul", number = 6 }
  ,{ name = "Aug", number = 7 }
  ,{ name = "Sep", number = 8 }
  ,{ name = "Oct", number = 9 }
  ,{ name = "Nov", number = 10 }
  ,{ name = "Dec", number = 11 }
  ]
