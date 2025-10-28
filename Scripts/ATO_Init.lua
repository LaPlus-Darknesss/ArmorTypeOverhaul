-- Scripts/ATO_Init.lua
-- Initializes Armor Type Overhaul (ATO). Hooks basic events and loads helpers.

Ext.Require("Scripts/ATO_Events.lua")

Ext.Require("Scripts/ATO_LoneWolf.lua")

Ext.Events.SessionLoaded:Subscribe(function (_)
  Ext.Utils.Print("[ATO] SessionLoaded")
end)

local LONE_WOLF_ATTACH_PASSIVE = "MOD_LONE_WOLF_ATTACH"
Ext.Events.SessionLoaded:Subscribe(function (_)
  local host = Osi.GetHostCharacter()
  if host and Osi.HasPassive(host, LONE_WOLF_ATTACH_PASSIVE) == 0 then
    Osi.AddPassive(host, LONE_WOLF_ATTACH_PASSIVE)
    Ext.Utils.Print("[ATO] Added test attach passive for Lone Wolf to host")
  end
end)


