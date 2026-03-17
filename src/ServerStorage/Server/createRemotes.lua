--[[
    @Create a Remote Instances
]]

-- Startup
local CreateRemote = {}
CreateRemote.Order = 1

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Dependiences
local Config = require(ReplicatedStorage.Modules.Config.Remotes)

-- Functions
local function CreateObject(ClassName, Name)
    if ClassName ~= table.find(Config.VaildTypes, ClassName) then ClassName = "RemoteEvent" end

    local Object = Instance.new(ClassName)
    Object.Name = Name
    
    return Object
end

-- Init
function CreateRemote.Init()
    -- Base Folder
    local Remotes = Instance.new("Folder")
    Remotes.Name = "Remotes"
    Remotes.Parent = ReplicatedStorage

    for _, v in ipairs(Config.List) do
        local Object = CreateObject(v[1], v[2])
        Object.Parent = Remotes
    end
end

return CreateRemote


