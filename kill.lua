local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
hrp.Size = Vector3.new(0.1, 0.1, 0.1)
for _, part in ipairs(game.Players.LocalPlayer.Character:GetChildren()) do
    if part:IsA("BasePart") then
        part.Size = Vector3.new(0.1, 0.1, 0.1)
    end
end
