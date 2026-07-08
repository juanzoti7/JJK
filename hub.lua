local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local Window = Rayfield:CreateWindow({
Name = "🔥 JuanzotiXiter | JJK",
LoadingTitle = "🔥 JuanzotiXiter",
LoadingSubtitle = "Jujutsu Kaisen Hub",
ConfigurationSaving = {
Enabled = true,
FolderName = "JuanzotiXiter",
FileName = "JJKHub"
},
Discord = {
Enabled = false
},
KeySystem = false
})


---

-- ABA MAIN

local MainTab =
Window:CreateTab("Main 🏠", 4483362458)


---

-- TELEPORT / SPECTATE SYSTEM

local SelectedPlayer = nil
local Following = false

local PlayerDropdown


---

-- PLAYER LIST

local function GetPlayerList()

local names = {}  

for _, plr in pairs(Players:GetPlayers()) do  

    if plr ~= LocalPlayer then  
        table.insert(names, plr.Name)  
    end  
end  

return names

end


---

-- DROPDOWN

PlayerDropdown = MainTab:CreateDropdown({
Name = "Selecionar Player",
Options = GetPlayerList(),
CurrentOption = nil,

Callback = function(Option)  

    if typeof(Option) == "table" then  
        SelectedPlayer = Option[1]  
    else  
        SelectedPlayer = Option  
    end  
end,

})


---

-- AUTO UPDATE PLAYERS

local function RefreshDropdown()

PlayerDropdown:Refresh(GetPlayerList())

end

Players.PlayerAdded:Connect(function()

task.wait(1)  
RefreshDropdown()

end)

Players.PlayerRemoving:Connect(function()

task.wait(1)  
RefreshDropdown()

end)


---

-- TELEPORT

MainTab:CreateButton({
Name = "Teleportar AtÃ© Player",

Callback = function()  

    if not SelectedPlayer then  
        return  
    end  

    local target =  
        Players:FindFirstChild(SelectedPlayer)  

    if target  
    and target.Character  
    and target.Character:FindFirstChild("HumanoidRootPart")  
    and LocalPlayer.Character  
    and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then  

        LocalPlayer.Character:PivotTo(  
            target.Character.HumanoidRootPart.CFrame  
            + Vector3.new(0,3,0)  
        )  
    end  
end,

})


---

-- SPECTATE

MainTab:CreateButton({
Name = "Spectate Player",

Callback = function()  

    if not SelectedPlayer then  
        return  
    end  

    local target =  
        Players:FindFirstChild(SelectedPlayer)  

    if target  
    and target.Character  
    and target.Character:FindFirstChild("Humanoid") then  

        Camera.CameraSubject =  
            target.Character.Humanoid  

        Camera.CameraType =  
            Enum.CameraType.Custom  
    end  
end,

})


---

-- FOLLOW

MainTab:CreateToggle({
Name = "Follow Player",
CurrentValue = false,

Callback = function(Value)  

    Following = Value  
end,

})

RunService.RenderStepped:Connect(function()

if Following and SelectedPlayer then  

    local target =  
        Players:FindFirstChild(SelectedPlayer)  

    if target  
    and target.Character  
    and target.Character:FindFirstChild("HumanoidRootPart")  
    and LocalPlayer.Character  
    and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then  

        LocalPlayer.Character:PivotTo(  
            target.Character.HumanoidRootPart.CFrame  
            * CFrame.new(0,0,-3)  
        )  
    end  
end

end)


---

-- STOP

MainTab:CreateButton({
Name = "Stop Spectate / Follow",

Callback = function()  

    Following = false  

    local char = LocalPlayer.Character  

    if char and char:FindFirstChild("Humanoid") then  

        Camera.CameraSubject =  
            char.Humanoid  

        Camera.CameraType =  
            Enum.CameraType.Custom  
    end  
end,

})


---

-- ABA PLAYER

local PlayerTab =
Window:CreateTab("Player ⚡", 4483362458)


---

-- VARIABLES

getgenv().InfiniteJump = false
getgenv().Noclip = false
getgenv().Fly = false
getgenv().BubbleEnabled = false

local FlySpeed = 60
local SavedSpeed = 16
local SavedJump = 50


---

-- SPEED

PlayerTab:CreateInput({
    Name = "WalkSpeed",
    PlaceholderText = "Digite a velocidade",
    RemoveTextAfterFocusLost = false,

    Callback = function(Text)

        local Speed = tonumber(Text)

        if Speed then

            SavedSpeed = Speed

            local Char = LocalPlayer.Character

            if Char and Char:FindFirstChild("Humanoid") then
                Char.Humanoid.WalkSpeed = Speed
            end
        end
    end,
})


---

-- JUMP

PlayerTab:CreateInput({
    Name = "JumpPower",
    PlaceholderText = "Digite o Jump",
    RemoveTextAfterFocusLost = false,

    Callback = function(Text)

        local Jump = tonumber(Text)

        if Jump then

            SavedJump = Jump

            local Char = LocalPlayer.Character

            if Char and Char:FindFirstChild("Humanoid") then
                Char.Humanoid.UseJumpPower = true
                Char.Humanoid.JumpPower = Jump
            end
        end
    end,
})


---

-- REAPPLY AFTER RESET

LocalPlayer.CharacterAdded:Connect(function(char)

local hum = char:WaitForChild("Humanoid")  

task.wait(1)  

hum.WalkSpeed = SavedSpeed  

hum.UseJumpPower = true  
hum.JumpPower = SavedJump  

if getgenv().BubbleEnabled then  
    local ff = Instance.new("ForceField")  
    ff.Visible = true  
    ff.Parent = char  
end

end)


---

-- INFINITE JUMP

PlayerTab:CreateToggle({
Name = "Infinite Jump",
CurrentValue = false,

Callback = function(Value)  
    getgenv().InfiniteJump = Value  
end,

})

UserInputService.JumpRequest:Connect(function()

if getgenv().InfiniteJump then  

    local char = LocalPlayer.Character  

    if char and char:FindFirstChild("Humanoid") then  

        char.Humanoid:ChangeState(  
            Enum.HumanoidStateType.Jumping  
        )  
    end  
end

end)


---

-- NOCLIP

PlayerTab:CreateToggle({
Name = "NoClip",
CurrentValue = false,

Callback = function(Value)  
    getgenv().Noclip = Value  
end,

})

RunService.Stepped:Connect(function()

if getgenv().Noclip then  

    local char = LocalPlayer.Character  

    if char then  

        for _, part in pairs(char:GetDescendants()) do  

            if part:IsA("BasePart") then  
                part.CanCollide = false  
            end  
        end  
    end  
end

end)


---

-- FLY

PlayerTab:CreateToggle({
Name = "Fly",
CurrentValue = false,

Callback = function(Value)  

    getgenv().Fly = Value  

    local char = LocalPlayer.Character  
    if not char then return end  

    local HRP =  
        char:FindFirstChild("HumanoidRootPart")  

    if not HRP then return end  

    if Value then  

        local BV = Instance.new("BodyVelocity")  
        BV.Name = "FlyVelocity"  
        BV.MaxForce = Vector3.new(999999,999999,999999)  
        BV.Velocity = Vector3.zero  
        BV.Parent = HRP  

    else  

        local FlyObj =  
            HRP:FindFirstChild("FlyVelocity")  

        if FlyObj then  
            FlyObj:Destroy()  
        end  
    end  
end,

})

RunService.RenderStepped:Connect(function()

if getgenv().Fly then  

    local char = LocalPlayer.Character  
    if not char then return end  

    local HRP =  
        char:FindFirstChild("HumanoidRootPart")  

    local Humanoid =  
        char:FindFirstChild("Humanoid")  

    local BV =  
        HRP and HRP:FindFirstChild("FlyVelocity")  

    if HRP and BV and Humanoid then  

        BV.Velocity =  
            Humanoid.MoveDirection * FlySpeed  

        HRP.AssemblyLinearVelocity =  
            Vector3.zero  
    end  
end

end)


---

-- PROTECTION BUBBLE

PlayerTab:CreateToggle({
Name = "Protection Bubble",
CurrentValue = false,

Callback = function(Value)  

    getgenv().BubbleEnabled = Value  

    local char = LocalPlayer.Character  
    if not char then return end  

    if Value then  

        local ff = Instance.new("ForceField")  
        ff.Visible = true  
        ff.Parent = char  

    else  

        local ff = char:FindFirstChildOfClass("ForceField")  

        if ff then  
            ff:Destroy()  
        end  
    end  
end,

})

---

---------------------------------------------------
-- ABA ESP 👁️
---------------------------------------------------

local ESPTab =
Window:CreateTab("ESP/VISUAL 👁️", 4483362458)

getgenv().ESPEnabled = false
getgenv().ESPNames = true
getgenv().ESPBoxes = true
getgenv().ESPLines = true
getgenv().ESPDistance = true

local ESPObjects = {}

---------------------------------------------------
-- CRIAR ESP
---------------------------------------------------

local function CreateESP(player)

    if player == LocalPlayer then
        return
    end

    local Box = Drawing.new("Square")
    Box.Visible = false
    Box.Color = Color3.fromRGB(255,0,0)
    Box.Thickness = 1
    Box.Filled = false

    local Line = Drawing.new("Line")
    Line.Visible = false
    Line.Color = Color3.fromRGB(255,255,255)
    Line.Thickness = 1

    local Name = Drawing.new("Text")
    Name.Visible = false
    Name.Color = Color3.fromRGB(255,255,255)
    Name.Size = 16
    Name.Center = true
    Name.Outline = true

    local Distance = Drawing.new("Text")
    Distance.Visible = false
    Distance.Color = Color3.fromRGB(0,255,0)
    Distance.Size = 14
    Distance.Center = true
    Distance.Outline = true

    ESPObjects[player] = {
        Box = Box,
        Line = Line,
        Name = Name,
        Distance = Distance
    }

    RunService.RenderStepped:Connect(function()

        if not getgenv().ESPEnabled then

            Box.Visible = false
            Line.Visible = false
            Name.Visible = false
            Distance.Visible = false

            return
        end

        local char = player.Character

        if char
        and char:FindFirstChild("HumanoidRootPart")
        and char:FindFirstChild("Humanoid")
        and char.Humanoid.Health > 0 then

            local HRP = char.HumanoidRootPart
            local Pos, Visible =
                Camera:WorldToViewportPoint(HRP.Position)

            if Visible then

                local scale =
                    1 / (HRP.Position - Camera.CFrame.Position).Magnitude * 100

                local sizeX = 35 * scale
                local sizeY = 50 * scale

                ---------------------------------------------------
                -- BOX
                ---------------------------------------------------

                if getgenv().ESPBoxes then

                    Box.Size = Vector2.new(sizeX, sizeY)

                    Box.Position = Vector2.new(
                        Pos.X - sizeX / 2,
                        Pos.Y - sizeY / 2
                    )

                    Box.Visible = true

                else
                    Box.Visible = false
                end

                ---------------------------------------------------
                -- LINE
                ---------------------------------------------------

                if getgenv().ESPLines then

                    Line.From = Vector2.new(
                        Camera.ViewportSize.X / 2,
                        Camera.ViewportSize.Y
                    )

                    Line.To = Vector2.new(Pos.X, Pos.Y)

                    Line.Visible = true

                else
                    Line.Visible = false
                end

                ---------------------------------------------------
                -- NAME
                ---------------------------------------------------

                if getgenv().ESPNames then

                    Name.Position =
                        Vector2.new(Pos.X, Pos.Y - 35)

                    Name.Text = player.Name

                    Name.Visible = true

                else
                    Name.Visible = false
                end

                ---------------------------------------------------
                -- DISTANCE
                ---------------------------------------------------

                if getgenv().ESPDistance then

                    local magnitude =
                        math.floor(
                            (
                                LocalPlayer.Character.HumanoidRootPart.Position
                                - HRP.Position
                            ).Magnitude
                        )

                    Distance.Position =
                        Vector2.new(Pos.X, Pos.Y + 25)

                    Distance.Text =
                        tostring(magnitude) .. "m"

                    Distance.Visible = true

                else
                    Distance.Visible = false
                end

            else

                Box.Visible = false
                Line.Visible = false
                Name.Visible = false
                Distance.Visible = false
            end

        else

            Box.Visible = false
            Line.Visible = false
            Name.Visible = false
            Distance.Visible = false
        end
    end)
end

---------------------------------------------------
-- PLAYERS
---------------------------------------------------

for _, player in pairs(Players:GetPlayers()) do
    CreateESP(player)
end

Players.PlayerAdded:Connect(function(player)
    CreateESP(player)
end)

---------------------------------------------------
-- TOGGLES
---------------------------------------------------

ESPTab:CreateToggle({
    Name = "Ativar ESP",
    CurrentValue = false,

    Callback = function(Value)
        getgenv().ESPEnabled = Value
    end,
})

ESPTab:CreateToggle({
    Name = "Mostrar Box",
    CurrentValue = true,

    Callback = function(Value)
        getgenv().ESPBoxes = Value
    end,
})

ESPTab:CreateToggle({
    Name = "Mostrar Linha",
    CurrentValue = true,

    Callback = function(Value)
        getgenv().ESPLines = Value
    end,
})

ESPTab:CreateToggle({
    Name = "Mostrar Nome",
    CurrentValue = true,

    Callback = function(Value)
        getgenv().ESPNames = Value
    end,
})

ESPTab:CreateToggle({
    Name = "Mostrar DistÃ¢ncia",
    CurrentValue = true,

    Callback = function(Value)
        getgenv().ESPDistance = Value
    end,
})

---

-- FULLBRIGHT

PlayerTab:CreateToggle({
Name = "FullBright",
CurrentValue = false,

Callback = function(Value)  

    if Value then  

        Lighting.Brightness = 2  
        Lighting.ClockTime = 14  
        Lighting.FogEnd = 100000  
        Lighting.GlobalShadows = false  
        Lighting.Ambient = Color3.fromRGB(255,255,255)  

    else  

        Lighting.Brightness = 1  
        Lighting.ClockTime = 12  
        Lighting.FogEnd = 1000  
        Lighting.GlobalShadows = true
    end  
end,

})


-- FPS BOOST

PlayerTab:CreateButton({
Name = "FPS Boost",

Callback = function()  

    for _, v in pairs(game:GetDescendants()) do  

        if v:IsA("BasePart") then  
            v.Material = Enum.Material.SmoothPlastic  
            v.Reflectance = 0  

        elseif v:IsA("Decal") then  
            v.Transparency = 1  

        elseif v:IsA("ParticleEmitter") then  
            v.Enabled = false  
        end  
    end  

    Lighting.GlobalShadows = false  
    Lighting.FogEnd = 9e9  

end,

})

---

---------------------------------------------------
-- 🔥 ABA AIM 🎯
---------------------------------------------------

local AimTab =
Window:CreateTab("🔥 AimBot 🎯", 4483362458)

local AimEnabled = false
local AimPart = "HumanoidRootPart"

local FOVSize = 120
local Smoothness = 0.15

---------------------------------------------------
-- FOV
---------------------------------------------------

local FOV = Drawing.new("Circle")
FOV.Visible = true
FOV.Radius = FOVSize
FOV.Color = Color3.fromRGB(255,0,0)
FOV.Thickness = 2
FOV.Filled = false

RunService.RenderStepped:Connect(function()

    FOV.Position = Vector2.new(
        Camera.ViewportSize.X / 2,
        Camera.ViewportSize.Y / 2
    )
end)

---------------------------------------------------
-- PEGAR ALVO
---------------------------------------------------

local function GetClosestTarget()

    local Closest = nil
    local Distance = FOVSize

    for _, player in pairs(Players:GetPlayers()) do

        if player ~= LocalPlayer
        and player.Character
        and player.Character:FindFirstChild(AimPart) then

            local Part =
                player.Character[AimPart]

            local Pos, Visible =
                Camera:WorldToViewportPoint(
                    Part.Position
                )

            if Visible then

                local Magnitude =
                    (
                        Vector2.new(Pos.X, Pos.Y)
                        - Vector2.new(
                            Camera.ViewportSize.X / 2,
                            Camera.ViewportSize.Y / 2
                        )
                    ).Magnitude

                if Magnitude < Distance then

                    Distance = Magnitude
                    Closest = player
                end
            end
        end
    end

    return Closest
end

---------------------------------------------------
-- LOCK VISUAL
---------------------------------------------------

RunService.RenderStepped:Connect(function()

    if AimEnabled then

        local Target = GetClosestTarget()

        if Target
        and Target.Character
        and Target.Character:FindFirstChild(AimPart) then

            local Part =
                Target.Character[AimPart]
                
            local NewCF = CFrame.lookAt(
                Camera.CFrame.Position,
                Part.Position
            )

            Camera.CFrame =
                Camera.CFrame:Lerp(
                    NewCF,
                    Smoothness
                )
        end
    end
end)

---------------------------------------------------
-- TOGGLE
---------------------------------------------------

AimTab:CreateToggle({
    Name = "Aim Training",
    CurrentValue = false,

    Callback = function(Value)
        AimEnabled = Value
    end,
})

---------------------------------------------------
-- FOV
---------------------------------------------------

AimTab:CreateSlider({
    Name = "FOV",

    Range = {50, 400},
    Increment = 5,

    CurrentValue = 120,

    Callback = function(Value)

        FOVSize = Value
        FOV.Radius = Value
    end,
})

---------------------------------------------------
-- FORÇA
---------------------------------------------------

AimTab:CreateSlider({
    Name = "Aim Strength",

    Range = {1, 100},
    Increment = 1,

    CurrentValue = 15,

    Callback = function(Value)

        Smoothness = Value / 100
    end,
})

---------------------------------------------------
-- PARTE
---------------------------------------------------

AimTab:CreateDropdown({
    Name = "Aim Part",

    Options = {
        "Head",
        "body"
    },

    CurrentOption = {"Body"},

    Callback = function(Option)

        AimPart = Option[1]
    end,
})

---------------------------------------------------
-- MOSTRAR / ESCONDER FOV
---------------------------------------------------

AimTab:CreateToggle({
    Name = "Mostrar FOV",
    CurrentValue = false,

    Callback = function(Value)

        FOV.Visible = Value
    end,
})

---------------------------------------------------
-- MISC
---------------------------------------------------

local MiscTab = Window:CreateTab("Misc ⚒️", 4483362458)

MiscTab:CreateParagraph({
    Title = "Misc",
    Content = "Utilitários e configurações."
})

-- RESET CHARACTER

MiscTab:CreateButton({
Name = "Reset Character",

Callback = function()  

    local char = LocalPlayer.Character  

    if char and char:FindFirstChild("Humanoid") then  
        char.Humanoid.Health = 0  
    end  
end,

})

-- REJOIN

MiscTab:CreateButton({
Name = "Rejoin",

Callback = function()  

    TeleportService:Teleport(  
        game.PlaceId,  
        LocalPlayer  
    )  
end,

})

local AntiAFKConnection

MiscTab:CreateToggle({
    Name = "Anti AFK",
    CurrentValue = false,

    Callback = function(Value)

        if Value then

            local VirtualUser = game:GetService("VirtualUser")

            AntiAFKConnection = LocalPlayer.Idled:Connect(function()

                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new(0,0))

            end)

        else

            if AntiAFKConnection then
                AntiAFKConnection:Disconnect()
                AntiAFKConnection = nil
            end

        end

    end,
})

local Camera = workspace.CurrentCamera

MiscTab:CreateSlider({
    Name = "FOV",
    Range = {70, 150},
    Increment = 1,
    Suffix = " FOV",
    CurrentValue = 70,
    Flag = "FOVSlider",
    Callback = function(Value)
        Camera.FieldOfView = Value
    end,
})

MiscTab:CreateButton({
    Name = "Resetar FOV",
    Callback = function()
        Camera.FieldOfView = 70
    end,
})
