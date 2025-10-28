-- Scripts/ATO_Events.lua
-- Stubs for Engine Notes so we have a safe place to add logic gradually.

-- E1: Return thrown weapon to inventory (not auto-equip)
function ATO_ReturnThrownToInventory(params)
  -- TODO: implement using Community Library helpers (see [E1] in spec)
end

-- E2: Safe teleport within a radius, rejecting hazardous tiles
function ATO_SafeTeleport(entity, radiusMin, radiusMax)
  -- TODO: use Script Extender safe-tile selection (see [E2])
end

-- E3: Reaction “graze” behavior (half damage on miss) + advantage handling
function ATO_ReactionGraze(attacker, target)
  -- TODO: roll override and damage adjust (see [E3])
end
