--[[
    @Data Library
]]

local DataLibrary = {}

DataLibrary.DataVersion = "Demo 1.0"

DataLibrary.Folder = {
    Stats = {
        ["VND"] = {
            ClassName = "IntValue", -- ClassName of Instance
            DefaultValue = 0, -- Default value
            Clamp = {true, 1000000}, -- This is for IntValue and NumberValue {Toggle, Value}
            Leaderstats = {true, 1}, -- this is decision for Value that will show up leaderstats {Toggle, Priority}
            ToSave = true -- this is decision for Value that will save to datastore {Toggle}
        }
    }
}

return DataLibrary