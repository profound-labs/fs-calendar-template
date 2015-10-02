local csv = require("./scripts/csv.lua")
local date = require("./scripts/date.lua")
local insert = table.insert
local tp = tex.print
local tsp = tex.sprint

function loadcsv(csv_path)
  local f = csv.open(csv_path)
  local data = {}
  for fields in f:lines() do
    data[fields[1]] = fields[2]
  end
  return data
end

-- Traverses a table following the order of its keys
-- Programming in Lua 5.1
function pairsByKeys (t, f)
  local a = {}
  for n in pairs(t) do table.insert(a, n) end
  table.sort(a, f)
  local i = 0      -- iterator variable
  local iter = function ()   -- iterator function
    i = i + 1
    if a[i] == nil then return nil
    else return a[i], t[a[i]]
    end
  end
  return iter
end

function dayText(isodate)
  local d = date(isodate)
  return string.format("%s %i", d:fmt("%b"), d:getday())
end

function dayTextFull(isodate)
  local d = date(isodate)
  return string.format("%i %s", d:getday(), d:fmt("%B"))
end

function nextDay(isodate)
  local d = date(isodate)
  local nd = date(d):adddays(1)
  return nd:fmt("%Y-%m-%d")
end

-- Sets the LaTeX macros to reference dates
-- Returns a table of events:
-- events = {
--   "2017-01-16" = { "\\textAjahnChahMemorialDay", }
--   ...
-- }
function processEvents(moondays_csv_path)

  local events = {}

  -- Anniversaries

  local d = "2017-01-16"
  tp("\\newcommand\\dateAjahnChahMemorialDay{".. d .."}")
  tp("\\newcommand\\dateTextAjahnChahMemorialDay{".. dayText(d) .."}")
  tp("\\newcommand\\dateTextFullAjahnChahMemorialDay{".. dayTextFull(d) .."}")
  if not events[d] then events[d] = {} end
  insert(events[d], "\\textAjahnChahMemorialDay")

  local d = "2017-06-17"
  tp("\\newcommand\\dateAjahnChahBirthDay{".. d .."}")
  tp("\\newcommand\\dateTextAjahnChahBirthDay{".. dayText(d) .."}")
  tp("\\newcommand\\dateTextFullAjahnChahBirthDay{".. dayTextFull(d) .."}")
  if not events[d] then events[d] = {} end
  insert(events[d], "\\textAjahnChahBirthDay")

  -- Major Moons and Vassa

  local f = csv.open(moondays_csv_path)
  for fields in f:lines() do

    local d = fields[1]
    local textdate = dayText(d)
    local textfulldate = dayTextFull(d)

    if fields[3] == "magha" then

      tp("\\newcommand\\dateMaghaPuja{".. d .."}")
      tp("\\newcommand\\dateTextMaghaPuja{".. textdate .."}")
      tp("\\newcommand\\dateTextFullMaghaPuja{".. textfulldate .."}")
      if not events[d] then events[d] = {} end
      insert(events[d], "\\textMaghaPuja")

    elseif fields[3] == "vesakha" then

      tp("\\newcommand\\dateVesakhaPuja{".. d .."}")
      tp("\\newcommand\\dateTextVesakhaPuja{".. textdate .."}")
      tp("\\newcommand\\dateTextFullVesakhaPuja{".. textfulldate .."}")
      if not events[d] then events[d] = {} end
      insert(events[d], "\\textVesakhaPuja")

    elseif fields[3] == "asalha" then

      tp("\\newcommand\\dateAsalhaPuja{".. d .."}")
      tp("\\newcommand\\dateTextAsalhaPuja{".. textdate .."}")
      tp("\\newcommand\\dateTextFullAsalhaPuja{".. textfulldate .."}")
      if not events[d] then events[d] = {} end
      insert(events[d], "\\textAsalhaPuja")

      local d = nextDay(fields[1])
      local textdate = dayText(d)
      local textfulldate = dayTextFull(d)
      tp("\\newcommand\\dateFirstDayOfVassa{".. d .."}")
      tp("\\newcommand\\dateTextFirstDayOfVassa{".. textdate .."}")
      tp("\\newcommand\\dateTextFullFirstDayOfVassa{".. textfulldate .."}")
      if not events[d] then events[d] = {} end
      insert(events[d], "\\textFirstDayOfVassa")

    elseif fields[3] == "pavarana" then

      tp("\\newcommand\\datePavarana{".. d .."}")
      tp("\\newcommand\\dateTextPavarana{".. textdate .."}")
      tp("\\newcommand\\dateTextFullPavarana{".. textfulldate .."}")
      if not events[d] then events[d] = {} end
      insert(events[d], "\\textPavarana")

      tp("\\newcommand\\dateLastDayOfVassa{\\datePavarana}")
      tp("\\newcommand\\dateTextLastDayOfVassa{\\dateTextPavarana}")
      tp("\\newcommand\\dateTextFullLastDayOfVassa{\\dateTextFullPavarana}")

    end
  end

  return events
end
