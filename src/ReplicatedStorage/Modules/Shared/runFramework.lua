local LocalizationService = game:GetService("LocalizationService")

--[[
    @Frameworkloader
]]

return function (Locations: table)
    local pendingModules = {}
    
    -- Lặp qua từng Folder (ví dụ: ServerStorage.Server, ServerStorage.Remotes)
    for _, Folder in ipairs(Locations) do
        local Children = Folder:GetChildren()

        -- 1. Yêu cầu (require) tất cả các module và lưu vào danh sách chờ
        for _, Object in ipairs(Children) do
            if Object:IsA("ModuleScript") then
                local Content = require(Object)
                
                -- Hỗ trợ cho Table (có Order và hàm Init)
                if typeof(Content) == "table" and typeof(Content.Init) == "function" then
                    table.insert(pendingModules, {
                        Name = Object.Name,
                        Order = typeof(Content.Order) == "number" and Content.Order or 100, -- Mặc định Order là 100 nếu không thiết lập
                        Execute = Content.Init
                    })
                elseif typeof(Content) == "function" then
                    table.insert(pendingModules, {
                        Name = Object.Name,
                        Order = 100, -- Mặc định Order là 100 cho function thường
                        Execute = Content
                    })
                end
            end
        end
    end

    -- 2. Sắp xếp danh sách dựa trên Order (Số nhỏ hơn sẽ chạy trước) - CHỈ SẮP XẾP 1 LẦN DƯỚI ĐÂY
    table.sort(pendingModules, function(a, b)
        return a.Order < b.Order
    end)

    -- 3. Tiến hành chạy hàm khởi tạo theo đúng thứ tự - CHỈ CHẠY 1 LẦN DƯỚI ĐÂY
    for _, moduleData in ipairs(pendingModules) do
        -- print("Đang chạy module:", moduleData.Name, "- Order:", moduleData.Order)
        moduleData.Execute()
    end
end

--[[
    DateLog:

    @17/3/2026: Create framework loader 
]]