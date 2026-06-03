local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Функция для полного сокрытия персонажа
local function makeInvisible(character)
    if not character then return end
    
    -- Проходим по всем потомкам персонажа: частям тела, одежде, аксессуарам
    for _, descendant in ipairs(character:GetDescendants()) do
        -- Делаем прозрачными все части (BasePart) и наклейки/лица (Decal)
        if descendant:IsA("BasePart") or descendant:IsA("Decal") then
            descendant.Transparency = 1
        end
        -- Также обрабатываем MeshPart (часто используются для волос/одежды)
        if descendant:IsA("MeshPart") then
            descendant.Transparency = 1
        end
    end
end

-- Ждем, пока персонаж появится в игре
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
makeInvisible(character)

-- Если игрок переродится, снова делаем его невидимым
LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    -- Небольшая задержка, чтобы персонаж полностью загрузился
    task.wait(0.5)
    makeInvisible(newCharacter)
end)

-- Отключаем тень персонажа (дополнительно)
LocalPlayer.CharacterAdded:Connect(function(character)
    local hrp = character:WaitForChild("HumanoidRootPart")
    if hrp then
        hrp.ShadowSize = 0
    end
end)

print("Ты стал невидимым!")
