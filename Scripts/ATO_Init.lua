-- Scripts/ATO_Init.lua
Ext.Require("Scripts/ATO_Events.lua")

Ext.Events.SessionLoaded:Subscribe(function (_)
  Ext.Utils.Print("[ATO] SessionLoaded")
end)
