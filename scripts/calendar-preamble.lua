local csv = require("./scripts/csv.lua")
local helpers = require("./scripts/helpers.lua")
local tp = tex.print
local tsp = tex.sprint

local events = processEvents("./data/moondays.csv")

local calendar = loadcsv("./data/calendar.csv")

tp("\\renewcommand\\theCalendarYear{".. calendar.year .."}")
tp("\\renewcommand\\theCalendarAltYear{".. calendar.altyear .."}")
tp("\\renewcommand\\theCopyrightYear{".. calendar.year - 1 .."}")

-- Define Moondays

local command = {
  new    = { ifcmd = "\\ifDateNewMoon",    mooncmd = "\\putMoon{1}" },
  waxing = { ifcmd = "\\ifDateWaxingMoon", mooncmd = "\\putMoon{2}" },
  full   = { ifcmd = "\\ifDateFullMoon",   mooncmd = "\\putMoon{3}" },
  waning = { ifcmd = "\\ifDateWaningMoon", mooncmd = "\\putMoon{4}" },
}

local f = csv.open("./data/moondays.csv")

for phase, cmd in pairs(command) do
  tp("\\renewcommand{".. cmd.ifcmd .."}{%")
  tp("\\ifdate{")

  for fields in f:lines() do
    if fields[2] == phase then
      tp("equals=".. fields[1] ..",")
    end
  end

  tp("}{".. cmd.mooncmd .."}{};%")
  tp("}")
end


