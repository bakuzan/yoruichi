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
  [{ name = "Jan", number = 1 }
  ,{ name = "Feb", number = 2 }
  ,{ name = "Mar", number = 3 }
  ,{ name = "Apr", number = 4 }
  ,{ name = "May", number = 5 }
  ,{ name = "Jun", number = 6 }
  ,{ name = "Jul", number = 7 }
  ,{ name = "Aug", number = 8 }
  ,{ name = "Sep", number = 9 }
  ,{ name = "Oct", number = 10 }
  ,{ name = "Nov", number = 11 }
  ,{ name = "Dec", number = 12 }
  ]

days : List Header
days =
  [{ name = "Mon", number = 1 }
  ,{ name = "Tue", number = 2 }
  ,{ name = "Wed", number = 3 }
  ,{ name = "Thu", number = 4 }
  ,{ name = "Fri", number = 5 }
  ,{ name = "Sat", number = 6 }
  ,{ name = "Sun", number = 7 }
  ]
