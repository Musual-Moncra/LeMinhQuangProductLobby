--[[
    @ServerDataManager
    
    @Handle all the logic of Data
    - Data Library (Created path: ReplicatedStorage/Modules/Config/Data)
]]

-- Statements
local DataManager = {}
DataManager.Order = 1
DataManager.SaveTick = 120

-- Services
local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Dependiences
local DataLibrary = require(ReplicatedStorage.Modules.Config.Data)
local DataStore = DataStoreService:GetDataStore(DataLibrary.DataVersion)

-- Conditions
local VaildClass = {"IntValue", "NumberValue", "StringValue", "BoolValue"}

-- Utilise Function
local function CreateStatObject(ClassName: string, DefaultValue: any, Clamp: {any}, IsSave: boolean, ObjectName: string)
    if not table.find(VaildClass, ClassName) then 
        ClassName = "IntValue" 
        DefaultValue = 1
    end

    local Object = Instance.new(ClassName) :: ObjectValue
    Object.Name = ObjectName
    Object.Value = DefaultValue

    if ClassName == "IntValue" or ClassName == "NumberValue" then
        local Enable = Clamp[1] :: boolean
        local Value = Clamp[2] :: number

        if Enable then
            Object.Changed:Connect(function()
                if Object.Value > Value then
                    Object.Value = Value
                end
            end)
        end
    end

    if IsSave then
        Object:SetAttribute("IsSave", true)
    else
        Object:SetAttribute("IsSave", false)
    end

    return Object
end

-- BaseFolder
local PlayerDataFolder = Instance.new("Folder")
PlayerDataFolder.Name = "PlayerData"
PlayerDataFolder.Parent = ReplicatedStorage

-- Create Data
local DataCreator = {}

function DataCreator.Stats(pData: Folder)
    -- Stats Folder
    local Stats = Instance.new("Folder")
    Stats.Name = "Stats"
    Stats.Parent = pData

    -- Create Stats Instance
    for StatName, StatValue in pairs(DataLibrary.Folder.Stats) do
        local Object = CreateStatObject(StatValue.ClassName, StatValue.DefaultValue, StatValue.Clamp, StatValue.ToSave, StatName)
        Object.Parent = Stats
    end

    return Stats
end
-- Load Data
local DataLoader = {}

function DataLoader.Stats(folderData: any, PlayerData: Folder)
    local folderInstance = PlayerData:FindFirstChild("Stats")
    if folderInstance and folderData then
        for statName, statValue in pairs(folderData) do
            local statInstance = folderInstance:FindFirstChild(statName)
            if statInstance and statInstance:GetAttribute("IsSave") then
                statInstance.Value = statValue
            end
        end
    end
end

-- Save Data
local DataSaver = {}

function DataSaver.Stats(PlayerData: Folder)
    local statsDataToSave = {}
    local folderInstance = PlayerData:FindFirstChild("Stats")
    
    if folderInstance then
        for _, statInstance in ipairs(folderInstance:GetChildren()) do
            if statInstance:GetAttribute("IsSave") then
                statsDataToSave[statInstance.Name] = statInstance.Value
            end
        end
    end
    
    return statsDataToSave
end

-- Handle & Connection
function DataManager.CreateData(Player: Player)

    -- PlayerFolder
    local PlayerData = Instance.new("Folder")
    PlayerData.Name = Player.UserId
    PlayerData.Parent = PlayerDataFolder

    -- Connetions
    DataCreator.Stats(PlayerData)
    
    -- Load Data
    DataManager.Load(Player, PlayerData)

    return PlayerData
end

function DataManager.Load(Player: Player, PlayerData: Folder)
    local Success, Result = pcall(function()
        return DataStore:GetAsync(tostring(Player.UserId))
    end)

    if Success and Result then
        -- Load data modularly
        if Result.Stats then
            DataLoader.Stats(Result.Stats, PlayerData)
        end
        -- Add more loaders here if needed (e.g., Inventory)
    elseif not Success then
        warn("Failed to load data for player " .. Player.Name .. ": " .. tostring(Result))
    end
end

function DataManager.Save(Player: Player, PlayerData: Folder)
    local dataToSave = {}
    
    -- Save data modularly
    dataToSave.Stats = DataSaver.Stats(PlayerData)
    -- Add more savers here if needed (e.g., Inventory)

    local Success, Result = pcall(function()
        DataStore:SetAsync(tostring(Player.UserId), dataToSave)
    end)

    if not Success then
        warn("Failed to save data for player " .. Player.Name .. ": " .. tostring(Result))
    end
end

function DataManager.Init()
    -- Player Join
    Players.PlayerAdded:Connect(function(Player)
        DataManager.CreateData(Player)
    end)

    -- Player Leave
    Players.PlayerRemoving:Connect(function(Player)
        local PlayerData = PlayerDataFolder:FindFirstChild(tostring(Player.UserId))
        if PlayerData then
            DataManager.Save(Player, PlayerData)
            PlayerData:Destroy()
        end
    end)
    
    -- Server close
    game:BindToClose(function()
        for _, Player in ipairs(Players:GetPlayers()) do
            local PlayerData = PlayerDataFolder:FindFirstChild(tostring(Player.UserId))
            if PlayerData then
                DataManager.Save(Player, PlayerData)
            end
        end
    end)
    
    -- Auto Save Loop
    task.spawn(function()
        while task.wait(DataManager.SaveTick) do
            for _, Player in ipairs(Players:GetPlayers()) do
                local PlayerData = PlayerDataFolder:FindFirstChild(tostring(Player.UserId))
                if PlayerData then
                    DataManager.Save(Player, PlayerData)
                end
            end
        end
    end)
end

return DataManager
