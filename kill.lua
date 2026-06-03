— Скрипт для включения и выключения невидимости в Roblox 
 
Кстати, если вы нажмете «E» на клавиатуре, то станете невидимым для других игроков, но на экране вы по-прежнему будете видеть себя, чтобы вам было проще ориентироваться. 
 
 
--Настройки: 
локальный скрипт запущен = false 
local Keybind = "E" -- Задайте любое значение, которое вам нужно, но оно должно быть именем перечисления KeyCode. 
local Transparency = true — делает вас слегка прозрачными, когда вы невидимы. Нет смысла отключать эту функцию. 
local NoClip = false -- сделает вашего поддельного персонажа невидимым. 
 
local Player = game:GetService("Players").Локальный игрок 
local RealCharacter = Player.Character или Player.CharacterAdded:Wait() 
 
local IsInvisible = false 
 
RealCharacter.Archivable = true 
local FakeCharacter = RealCharacter:Clone() 
локальная Часть 
Part = Instance.new("Part", workspace) 
Part.Anchored = true 
Part.Size = Vector3.new(200, 1, 200) 
Part.CFrame = CFrame.new(0, -500, 0) — установите любое значение, но подальше от карты. 
Part.CanCollide = true 
FakeCharacter.Parent = workspace 
FakeCharacter.HumanoidRootPart.CFrame = Part.CFrame * CFrame.new(0, 5, 0) 
 
for i, v in pairs(RealCharacter:GetChildren()) do 
 if v:IsA("LocalScript") then 
      local clone = v:Clone()
      clone.Disabled = true
      clone.Parent = FakeCharacter
  end
end
if Transparency then
  for i, v in pairs(FakeCharacter:GetDescendants()) do
      if v:IsA("BasePart") then
          v.Transparency = 0.7
      end
  end
end
local CanInvis = true
function RealCharacterDied()
  CanInvis = false
  RealCharacter:Destroy()
  RealCharacter = Player.Character
  CanInvis = true
  isinvisible = false
  FakeCharacter:Destroy()
  workspace.CurrentCamera.CameraSubject = RealCharacter.Humanoid
 
  RealCharacter.Archivable = true
  FakeCharacter = RealCharacter:Clone()
  Part:Destroy()
  Part = Instance.new("Part", workspace)
  Part.Anchored = true
  Part.Size = Vector3.new(200, 1, 200)
  Part.CFrame = CFrame.new(9999, 9999, 9999) --Set this to whatever you want, just far away from the map.
  Part.CanCollide = true
  FakeCharacter.Parent = workspace
  FakeCharacter.HumanoidRootPart.CFrame = Part.CFrame * CFrame.new(0, 5, 0)
 
  for i, v in pairs(RealCharacter:GetChildren()) do
      if v:IsA("LocalScript") then
          local clone = v:Clone()
          clone.Disabled = true
          clone.Parent = FakeCharacter
      end
  end
  if Transparency then
      for i, v in pairs(FakeCharacter:GetDescendants()) do
          if v:IsA("BasePart") then
              v.Transparency = 0.7
          end
      end
  end
 RealCharacter.Humanoid.Died:Connect(function()
 RealCharacter:Destroy()
 FakeCharacter:Destroy()
 end)
 Player.CharacterAppearanceLoaded:Connect(RealCharacterDied)
end
RealCharacter.Humanoid.Died:Connect(function()
 RealCharacter:Destroy()
 FakeCharacter:Destroy()
 end)
Player.CharacterAppearanceLoaded:Connect(RealCharacterDied)
local PseudoAnchor
game:GetService "RunService".RenderStepped:Connect(
  function()
      if PseudoAnchor ~= nil then
          PseudoAnchor.CFrame = Part.CFrame * CFrame.new(0, 5, 0)
      end
       if NoClip then
      FakeCharacter.Humanoid:ChangeState(11)
       end
  end
)
 
PseudoAnchor = FakeCharacter.HumanoidRootPart
local function Invisible()
  if IsInvisible == false then
      local StoredCF = RealCharacter.HumanoidRootPart.CFrame
      RealCharacter.HumanoidRootPart.CFrame = FakeCharacter.HumanoidRootPart.CFrame
      FakeCharacter.HumanoidRootPart.CFrame = StoredCF
      RealCharacter.Humanoid:UnequipTools()
      Player.Character = FakeCharacter
      workspace.CurrentCamera.CameraSubject = FakeCharacter.Humanoid
      PseudoAnchor = RealCharacter.HumanoidRootPart
      for i, v in pairs(FakeCharacter:GetChildren()) do
          if v:IsA("LocalScript") then
              v.Disabled = false
          end
      end
 
      IsInvisible = true
  else
      local StoredCF = FakeCharacter.HumanoidRootPart.CFrame
 FakeCharacter.HumanoidRootPart.CFrame = RealCharacter.HumanoidRootPart.CFrame 
 
 RealCharacter.HumanoidRootPart.CFrame = StoredCF 
 
 Фальшивый персонаж.Гуманоид: без инструментов () 
 Player.Character = RealCharacter 
 workspace.CurrentCamera.CameraSubject = RealCharacter.Humanoid 
 Псевдоякорь = FakeCharacter.HumanoidRootPart 
 for i, v in pairs(FakeCharacter:GetChildren()) do 
 if v:IsA("LocalScript") then 
 v.Отключено = true 
 конец 
 конец 
 IsInvisible = ложь 
 конец 
конец 
 
game:GetService("UserInputService").InputBegan: подключение ( 
 function(key, gamep) 
 если игра, то 
 Возврат 
 конец 
 if key.KeyCode.Name:lower() == Keybind:lower() and CanInvis and RealCharacter and FakeCharacter then 
 if RealCharacter:FindFirstChild("HumanoidRootPart") and FakeCharacter:FindFirstChild("HumanoidRootPart") then 
 Невидимый () 
 конец 
 конец 
 конец 
)
local Sound = Instance.new("Sound",game:GetService ("SoundService")) 
Sound.SoundId = "rbxassetid://232127604" 
Звук:Воспроизведение() 
game:GetService("StarterGui"):SetCore("SendNotification",{["Title"] = "Невидимый переключатель активирован",["Text"] = "Нажмите "..Привязка клавиш..", чтобы изменить видимость.",["Duration"] = 20,["Button1"] = "Хорошо."})
