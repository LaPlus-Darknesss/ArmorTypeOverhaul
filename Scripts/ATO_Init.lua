-- Scripts/ATO_Init.lua
-- Initializes Armor Type Overhaul (ATO). Hooks basic events and loads helpers.

Ext.Require("Scripts/ATO_Events.lua")

Ext.Events.SessionLoaded:Subscribe(function (_)
  Ext.Utils.Print("[ATO] SessionLoaded")
end)
