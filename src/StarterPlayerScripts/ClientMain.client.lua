--[[
    @ClientMain

    @Connect the script with client side
]]

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Dependiences
local runFramework = require(ReplicatedStorage.Modules.Shared.runFramework)

local Locations = {}

-- Handle
runFramework(Locations)