local Players = game:GetService("Players")

-- Функция убийства
local function killPlayer(playerName)
    local target = Players:FindFirstChild(playerName)
    if target and target.Character then
        local hum = target.Character:FindFirstChild("Humanoid")
        if hum and hum.Health > 0 then
            hum.Health = 0
            print("Убит: " .. target.Name)
            return true
        end
    end
    return false
end

Players.PlayerAdded:Connect(function(player)
    local killEvent = Instance.new("RemoteEvent")
    killEvent.Name = "KillEvent"
    killEvent.Parent = player
    
    killEvent.OnServerEvent:Connect(function(plr, targetName)
        if plr == player then -- Проверка, что событие от этого игрока
            local success = killPlayer(targetName)
            if not success then
                player:SendNotification("Не удалось убить игрока!")
            end
        end
    end)
end)
