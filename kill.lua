local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RealKillGUI"
screenGui.Parent = game.CoreGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 220, 0, 350)
mainFrame.Position = UDim2.new(0.5, -110, 0.5, -175)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "ВЫБЕРИ ЦЕЛЬ"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.Parent = mainFrame

local playerList = Instance.new("ScrollingFrame")
playerList.Size = UDim2.new(1, -10, 1, -80)
playerList.Position = UDim2.new(0, 5, 0, 35)
playerList.BackgroundTransparency = 1
playerList.CanvasSize = UDim2.new(0, 0, 0, 0)
playerList.ScrollBarThickness = 6
playerList.Parent = mainFrame

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 5)
listLayout.Parent = playerList

local killBtn = Instance.new("TextButton")
killBtn.Size = UDim2.new(1, -10, 0, 40)
killBtn.Position = UDim2.new(0, 5, 1, -50)
killBtn.Text = "УБИТЬ (РЕАЛЬНО)"
killBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
killBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
killBtn.Font = Enum.Font.GothamBold
killBtn.TextSize = 14
killBtn.Parent = mainFrame

local selectedPlayer = nil

local function updateList()
    for _, child in ipairs(playerList:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    
    local yOffset = 0
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 0, 35)
            btn.Text = player.Name
            btn.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 14
            btn.Parent = playerList
            
            btn.MouseButton1Click:Connect(function()
                if selectedPlayer then
                    local old = playerList:FindFirstChild(selectedPlayer.Name)
                    if old then old.BackgroundColor3 = Color3.fromRGB(55, 55, 55) end
                end
                selectedPlayer = player
                btn.BackgroundColor3 = Color3.fromRGB(80, 120, 200)
            end)
            
            yOffset = yOffset + 40
        end
    end
    playerList.CanvasSize = UDim2.new(0, 0, 0, yOffset)
end

local function realKill(target)
    if target and target ~= LocalPlayer then
        local char = target.Character
        if char then
            -- Способ 1: Удалить HumanoidRootPart
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp:Destroy()
            end
            -- Способ 2: Сломать все суставы (работает чаще)
            for _, v in pairs(char:GetChildren()) do
                if v:IsA("BasePart") then
                    v:BreakJoints()
                end
            end
        end
    end
end

killBtn.MouseButton1Click:Connect(function()
    if selectedPlayer then
        realKill(selectedPlayer)
        selectedPlayer = nil
        updateList()
    end
end)

Players.PlayerAdded:Connect(updateList)
Players.PlayerRemoving:Connect(updateList)

updateList()
