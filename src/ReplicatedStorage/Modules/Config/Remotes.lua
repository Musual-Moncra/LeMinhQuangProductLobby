--[[
    @Create a remotes instance

    @Vaildate Remote Types
    - RemoteEvent
    - RemoteFunction
    - BindableEvent
    - BindableFunction

    @Sample Context: {RemoteType, RemoteName}
]]
local RemoteConfig = {}

RemoteConfig.VaildTypes = {
    "RemoteEvent",
    "RemoteFunction",
    "BindableFunction",
    "BindableEvent"
}

RemoteConfig.List = {
    -- RemoteEvent
    {"RemoteEvent", "Test"}
}

return RemoteConfig

--[[
    Date Logs:

    @17/3/2026: Create config
]]