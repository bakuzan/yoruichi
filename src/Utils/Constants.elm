module Utils.Constants exposing (..)

import Models exposing (Header)
import Msgs exposing (Msg)

import Components.RadioButton.Core as RadioButton


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

days : List Header
days =
  [{ name = "Sun", number = 0 }
  ,{ name = "Mon", number = 1 }
  ,{ name = "Tue", number = 2 }
  ,{ name = "Wed", number = 3 }
  ,{ name = "Thu", number = 4 }
  ,{ name = "Fri", number = 5 }
  ,{ name = "Sat", number = 6 }
  ]
