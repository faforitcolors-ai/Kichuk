local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "KillGUI"
screenGui.Parent = game.CoreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 300)
frame.Position = UDim2.new(0.5, -100, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "УБИТЬ ИГРОКА"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.Parent = frame

local list = Instance.new("ScrollingFrame")
list.Size = UDim2.new(1, -10, 1, -80)
list.Position = UDim2.new(0, 5, 0, 35)
list.BackgroundTransparency = 1
list.CanvasSize = UDim2.new(0, 0, 0, 0)
list.ScrollBarThickness = 6
list.Parent = frame

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 5)
layout.Parent = list

local killBtn = Instance.new("TextButton")
killBtn.Size = UDim2.new(1, -10, 0, 40)
killBtn.Position = UDim2.new(0, 5, 1, -50)
killBtn.Text = "УБИТЬ"
killBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
killBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
killBtn.Parent = frame

local selected = nil

local function updateList()
    for _, child in ipairs(list:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    
    local y = 0
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 0, 35)
            btn.Text = player.Name
            btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.Parent = list
            
            btn.MouseButton1Click:Connect(function()
                selected = player
                for _, b in ipairs(list:GetChildren()) do
                    if b:IsA("TextButton") then
                        b.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                    end
                end
                btn.BackgroundColor3 = Color3.fromRGB(100, 150, 200)
            end)
            
            y = y + 40
        end
    end
    list.CanvasSize = UDim2.new(0, 0, 0, y)
end

local function kill(target)
    if not target or target == LocalPlayer then return end
    local char = target.Character
    if not char then return end
    char:BreakJoints()
end

killBtn.MouseButton1Click:Connect(function()
    if selected then
        kill(selected)
    end
end)

Players.PlayerAdded:Connect(updateList)
Players.PlayerRemoving:Connect(updateList)

updateList()
