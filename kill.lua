local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "KillGUI"
screenGui.Parent = game.CoreGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 250, 0, 400)
mainFrame.Position = UDim2.new(0.5, -125, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.Text = "СПИСОК ИГРОКОВ"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.Parent = mainFrame

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -10, 1, -90)
scrollFrame.Position = UDim2.new(0, 5, 0, 40)
scrollFrame.BackgroundTransparency = 1
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.ScrollBarThickness = 6
scrollFrame.Parent = mainFrame

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 5)
listLayout.Parent = scrollFrame

local function killPlayer(target)
    if not target or target == LocalPlayer then return end
    local char = target.Character
    if not char then return end
    
    -- УБИВАЕМ ПО-НАСТОЯЩЕМУ
    local humanoid = char:FindFirstChildWhichIsA("Humanoid")
    if humanoid then
        humanoid.Health = 0
        humanoid:Destroy()
    end
    
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp:Destroy()
    end
    
    char:BreakJoints()
end

local function updatePlayerList()
    for _, child in ipairs(scrollFrame:GetChildren()) do
        if child:IsA("Frame") then child:Destroy() end
    end
    
    local yOffset = 0
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local row = Instance.new("Frame")
            row.Size = UDim2.new(1, 0, 0, 40)
            row.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            row.Parent = scrollFrame
            
            local nameLabel = Instance.new("TextLabel")
            nameLabel.Size = UDim2.new(0.7, -10, 1, 0)
            nameLabel.Position = UDim2.new(0, 5, 0, 0)
            nameLabel.Text = player.Name
            nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            nameLabel.TextXAlignment = Enum.TextXAlignment.Left
            nameLabel.BackgroundTransparency = 1
            nameLabel.Font = Enum.Font.Gotham
            nameLabel.TextSize = 16
            nameLabel.Parent = row
            
            local killBtn = Instance.new("TextButton")
            killBtn.Size = UDim2.new(0.3, -10, 1, -10)
            killBtn.Position = UDim2.new(0.7, 5, 0, 5)
            killBtn.Text = "УБИТЬ"
            killBtn.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
            killBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            killBtn.Font = Enum.Font.GothamBold
            killBtn.TextSize = 14
            killBtn.Parent = row
            
            killBtn.MouseButton1Click:Connect(function()
                killPlayer(player)
            end)
            
            yOffset = yOffset + 45
        end
    end
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, yOffset)
end

Players.PlayerAdded:Connect(updatePlayerList)
Players.PlayerRemoving:Connect(updatePlayerList)

updatePlayerList()
