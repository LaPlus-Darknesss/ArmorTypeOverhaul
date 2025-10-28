-- Scripts/ATO_LoneWolf.lua
-- Lone Wolf: apply up to 2 stacks of +1 to-hit when you end a turn with no allies within 8 m.
-- Removes all stacks if any ally is within 8 m at your turn end.

local LONE_WOLF_STATUS = "MOD_LONE_WOLF_BUFF"   -- defined in your StatusData
local LONE_WOLF_MAX    = 2
local LONE_WOLF_RANGE  = 8.0

-- Utility: is the handle a valid, conscious party ally of 'who' and not 'who' itself?
local function IsValidAlly(who, candidate)
  if not candidate or candidate == who then return false end
  -- Same party / ally checks; keep simple for now:
  return Osi.IsAlly(who, candidate) == 1 and Osi.IsDead(candidate) == 0
end

-- Utility: returns true if an ally (not self) is within 8 m
local function AllyWithinRange(who, rangeM)
  -- Nearby characters around 'who'
  local nearby = Ext.Entity.Get(who)
  if not nearby then return false end

  -- We’ll query all characters and measure distance. For large maps this is fine at turn end.
  local chars = Osi.DB_IsPlayer:Get(nil) or {}   -- simple broad set; replace with a better query later
  for _, row in ipairs(chars) do
    local other = row[1]
    if IsValidAlly(who, other) then
      local d = Osi.GetDistanceToObject(who, other) or 9999
      if d <= rangeM then
        return true
      end
    end
  end
  return false
end

-- Get current number of stacks on the character for our status
local function GetLoneWolfStacks(who)
  -- Returns count of a matching status; Script Extender exposes status collection via stats/status helpers.
  local statuses = Ext.Entity.Get(who) and Ext.Entity.Get(who).StatusContainer or nil
  if not statuses then return 0 end
  local count = 0
  for _, s in ipairs(statuses.Statuses or {}) do
    if s.StatusId == LONE_WOLF_STATUS then
      count = count + 1
    end
  end
  return count
end

local function ApplyOneStack(who)
  -- Apply our stacking status; duration 6.0s is a round placeholder; your status is configured to stack
  Osi.ApplyStatus(who, LONE_WOLF_STATUS, 6.0, 1, who)
end

local function RemoveAllStacks(who)
  -- Remove all instances of our status
  Osi.RemoveStatus(who, LONE_WOLF_STATUS)
end

-- Core handler: called when a character's turn ends
local function OnCharacterTurnEnded(char)
  -- Only care about characters that actually have our passive later (we’ll add a check when we wire PassiveData).
  -- For now, keep it universal so you can see it trigger during tests.
  local allyNear = AllyWithinRange(char, LONE_WOLF_RANGE)
  if allyNear then
    RemoveAllStacks(char)
    return
  end

  -- No ally within range: add one stack, up to cap
  local stacks = GetLoneWolfStacks(char)
  if stacks < LONE_WOLF_MAX then
    ApplyOneStack(char)
  end
end

-- Hook Osiris "CharacterTurnEnded" AFTER the engine processes the turn
Ext.Osiris.RegisterListener("CharacterTurnEnded", 1, "after", function(char)
  -- char is a GUID/handle string for the character whose turn ended
  OnCharacterTurnEnded(char)
end)
