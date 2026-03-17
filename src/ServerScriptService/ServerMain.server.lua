--[[
    @ServerMain

    Feature:
    - ServerConnection to all the server script!
]]

-- Services
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Dependiences
local FrameworkLoader = require(ReplicatedStorage.Modules.Shared.runFramework)
local Locations = {
    ServerStorage.Server,
    ServerStorage.Remotes
}

-- Handle
FrameworkLoader(Locations)

--[[
    DateLog: 
    @17/3/2026: Create server main
]]