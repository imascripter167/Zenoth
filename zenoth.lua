-- Blox Fruits Ultimate Script v2.0
-- WARNING: Scripting violates Roblox TOS. Use at your own risk.

local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")

-- Load Rayfield UI Library
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

-- Create main window
local Window = Rayfield:CreateWindow({
    Name = "🌟 Blox Fruits Ultimate v2.0",
    LoadingTitle = "Loading Premium Hub...",
    LoadingSubtitle = "by YourName",
    ConfigurationSaving = { Enabled = true, FolderName = "BloxUltimatePlus", FileName = "Config" },
    KeySystem = false, -- Set to true if you want a key system
})

-- Tabs
local MainTab = Window:CreateTab("Main 🚀", 4483362458)
local CombatTab = Window:CreateTab("Combat 🔫", 4483362458)
local QuestTab = Window:CreateTab("Quests 📜", 4483362458)
local FruitTab = Window:CreateTab("Fruits 🍓", 4483362458)
local ChestTab = Window:CreateTab("Chests 🏆", 4483362458)
local SettingsTab = Window:CreateTab("Settings ⚙️", 4483362458)

-- AutoFarm Section
local AutoFarmSection = MainTab:CreateSection("AutoFarm")
local AutoFarmToggle = MainTab:CreateToggle({
    Name = "Enable AutoFarm",
    CurrentValue = false,
    Flag = "AutoFarmToggle",
    Callback = function(Value)
        _G.AutoFarm = Value
        if Value then StartAutoFarm() end
    end,
})

-- Quest Automation
local AutoQuestToggle = QuestTab:CreateToggle({
    Name = "Auto Quest",
    CurrentValue = false,
    Flag = "AutoQuestToggle",
    Callback = function(Value)
        _G.AutoQuest = Value
        if Value then StartQuestAutomation() end
    end,
})

-- Fruit Features
local FruitSection = FruitTab:CreateSection("Fruit Automation")
local FruitNotifierToggle = FruitTab:CreateToggle({
    Name = "Fruit Notifier",
    CurrentValue = false,
    Flag = "FruitNotifierToggle",
    Callback = function(Value)
        _G.FruitNotifier = Value
        if Value then StartFruitNotifier() end
    end,
})

local AutoTeleportToFruit = FruitTab:CreateToggle({
    Name = "Auto-Teleport to Fruit",
    CurrentValue = false,
    Flag = "AutoTeleportFruit",
    Callback = function(Value)
        _G.AutoTeleportFruit = Value
    end,
})

local AutoStoreFruit = FruitTab:CreateToggle({
    Name = "Auto-Store Fruit",
    CurrentValue = false,
    Flag = "AutoStoreFruit",
    Callback = function(Value)
        _G.AutoStoreFruit = Value
    end,
})

local AutoRandomFruit = FruitTab:CreateToggle({
    Name = "Auto-Random Fruit",
    CurrentValue = false,
    Flag = "AutoRandomFruit",
    Callback = function(Value)
        _G.AutoRandomFruit = Value
        if Value then BuyRandomFruit() end
    end,
})

-- Chest Features
local ChestSection = ChestTab:CreateSection("Chest Automation")
local AutoFarmChest = ChestTab:CreateToggle({
    Name = "Auto-Farm Chests",
    CurrentValue = false,
    Flag = "AutoFarmChest",
    Callback = function(Value)
        _G.AutoFarmChest = Value
        if Value then StartChestFarm() end
    end,
})

local ChestESP = ChestTab:CreateToggle({
    Name = "Chest ESP",
    CurrentValue = false,
    Flag = "ChestESP",
    Callback = function(Value)
        _G.ChestESP = Value
        if Value then EnableChestESP() else DisableChestESP() end
    end,
})

-- Combat Features
local AimbotToggle = CombatTab:CreateToggle({
    Name = "Aimbot",
    CurrentValue = false,
    Flag = "AimbotToggle",
    Callback = function(Value)
        _G.Aimbot = Value
        if Value then EnableAimbot() end
    end,
})

local AutoClickToggle = CombatTab:CreateToggle({
    Name = "Auto-Clicker",
    CurrentValue = false,
    Flag = "AutoClickToggle",
    Callback = function(Value)
        _G.AutoClick = Value
    end,
})

-- Stats Tracking
local StatsSection = MainTab:CreateSection("Stats")
local KillsLabel = MainTab:CreateLabel("Kills: 0")
local BeliLabel = MainTab:CreateLabel("Beli Earned: $0")
local XPLabel = MainTab:CreateLabel("XP Gained: 0")
local QuestsLabel = MainTab:CreateLabel("Quests Completed: 0")
local FruitsLabel = MainTab:CreateLabel("Fruits Collected: 0")
local ChestsLabel = MainTab:CreateLabel("Chests Opened: 0")

-- ===== FUNCTIONS ===== --

-- AutoFarm Function
function StartAutoFarm()
    spawn(function()
        while _G.AutoFarm and task.wait() do
            if not Character or Humanoid.Health <= 0 then
                Character = Player.Character or Player.CharacterAdded:Wait()
                HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
                Humanoid = Character:WaitForChild("Humanoid")
            end

            local Target = FindNearestEnemy()
            if Target then
                Humanoid:MoveTo(Target.HumanoidRootPart.Position)
                if _G.AutoClick then
                    AttackTarget(Target)
                end
            end
        end
    end)
end

-- Fruit Notifier
function StartFruitNotifier()
    spawn(function()
        while _G.FruitNotifier and task.wait(5) do
            for _, fruit in pairs(workspace:GetChildren()) do
                if fruit.Name:find("Fruit") and fruit:FindFirstChild("Handle") then
                    Rayfield:Notify({
                        Title = "Fruit Spawned!",
                        Content = fruit.Name .. " has appeared at " .. tostring(fruit.Handle.Position),
                        Duration = 6.5,
                        Image = 4483362458,
                    })
                    if _G.AutoTeleportFruit then
                        TeleportTo(fruit.Handle.Position)
                    end
                end
            end
        end
    end)
end

-- Auto-Store Fruit
function StoreFruit(fruitName)
    -- Implementation depends on game's storage system
    -- Example: game:GetService("ReplicatedStorage").Remotes.StoreFruit:InvokeServer(fruitName)
end

-- Auto-Random Fruit
function BuyRandomFruit()
    -- Implementation depends on game's fruit dealer system
    -- Example: game:GetService("ReplicatedStorage").Remotes.BuyRandomFruit:InvokeServer()
end

-- Chest Farming
function StartChestFarm()
    spawn(function()
        while _G.AutoFarmChest and task.wait() do
            for _, chest in pairs(workspace:GetChildren()) do
                if chest.Name:find("Chest") and chest:FindFirstChild("CFrame") then
                    TeleportTo(chest.CFrame.Position)
                    -- Add chest opening logic here
                    _G.ChestsOpened = (_G.ChestsOpened or 0) + 1
                    ChestsLabel:Set("Chests Opened: ".._G.ChestsOpened)
                    task.wait(1)
                end
            end
        end
    end)
end

-- Chest ESP
function EnableChestESP()
    for _, chest in pairs(workspace:GetChildren()) do
        if chest.Name:find("Chest") then
            local highlight = Instance.new("Highlight")
            highlight.Parent = chest
            highlight.FillColor = Color3.fromRGB(255, 215, 0) -- Gold color
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        end
    end
end

function DisableChestESP()
    for _, chest in pairs(workspace:GetChildren()) do
        if chest:FindFirstChild("Highlight") then
            chest.Highlight:Destroy()
        end
    end
end

-- Teleport Function
function TeleportTo(position)
    if HumanoidRootPart and Humanoid.Health > 0 then
        HumanoidRootPart.CFrame = CFrame.new(position)
    end
end

-- Initialize
Rayfield:LoadConfiguration()
