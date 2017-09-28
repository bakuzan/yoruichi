module Utils.Constants exposing (..)

import Models exposing (Header, FrequencyOption)
import Msgs exposing (Msg)

import Components.RadioButton.Core as RadioButton


appName : String
appName =
  "yoruichi"

timePeriod : { day: String, week: String }
timePeriod =
    { day = "DAY", week = "WEEK" }

timePeriods : List RadioButton.RadioOption
timePeriods =
  [{ label = "By Day", optionValue = timePeriod.day, action = Msgs.SetTimePeriod timePeriod.day }
  ,{ label = "By Week", optionValue = timePeriod.week, action = Msgs.SetTimePeriod timePeriod.week }
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

frequencyOptions : List FrequencyOption
frequencyOptions =
    [{ name = "None", number = 0 }
    ,{ name = "Daily", number = 1 }
    ,{ name = "Weekly", number = 2 }
    ,{ name = "Monthly", number = 3 }
    ,{ name = "Quarterly", number = 4 }
    ,{ name = "Yearly", number = 5 }
    ]
