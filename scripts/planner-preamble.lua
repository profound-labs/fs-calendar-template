local csv = require("./scripts/csv.lua")
local helpers = require("./scripts/helpers.lua")
local tp = tex.print
local tsp = tex.sprint

local events = processEvents("./data/moondays.csv")

local calendar = loadcsv("./data/calendar.csv")

tp("\\renewcommand\\theCalendarYear{".. calendar.year .."}")
tp("\\renewcommand\\theCalendarAltYear{".. calendar.altyear .."}")

-- \moondaysCalendar

local command = {
  full = "\\FullMoon",
  waning = "\\WaningMoon",
  new = "\\NewMoon",
  waxing = "\\WaxingMoon"
}

tp("\\newcommand{\\moondaysCalendar}{%")
tsp("\\calendar (cal) [dates=".. calendar.year .."-01-01 to ".. calendar.year .."-12-31, planner] ")

local f = csv.open("./data/moondays.csv")
for fields in f:lines() do
  tsp("if (equals="..fields[1]..") [day text="..command[fields[2]].."]%")
end

tsp(";")
tp("")

local command = {
  full = "\\FullAstroMoon",
  waning = "\\WaningAstroMoon",
  new = "\\NewAstroMoon",
  waxing = "\\WaxingAstroMoon"
}

local f = csv.open("./data/astromoondays.csv")
for fields in f:lines() do
  tp("\\draw[gold] node [below right=-3mm and -1.5mm of cal-"..fields[1]..".south east] {"..command[fields[2]].."};%")
end

tp("}")

-- \eventMarks

tp("\\newcommand{\\eventMarks}{%")

local n = 1
for isodate, text in pairsByKeys(events) do
  local above = "-3mm"
  local right = "-1.5mm"
  -- number 6 in Shaker has a lower baseline, so here we can correct its position
  if n == 6 then above = "-2.2mm" end
  tp("\\draw[textbody] node [above right=".. above .." and ".. right .." of cal-".. isodate ..".north east] {\\datefnsize ".. n .."};")
  n = n+1
end

tp("}")

-- \eventNotes

-- \kathinaMarks

tp("\\newcommand{\\kathinaMarks}{%")
tp("}")

-- \kathinaNotes

