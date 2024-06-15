--[[

	AirHub by Exunys © CC0 1.0 Universal (2023)

	https://github.com/Exunys

]]

local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/xlISInner/NotificationsLibrary/main/Notify.lua"))()

local starttime = tick()

--// Cache

local game, workspace = game, workspace
local loadstring, getgenv, setclipboard, tablefind, camera, UserInputService, RunService = loadstring, getgenv, setclipboard, table.find, workspace.CurrentCamera, game:GetService("UserInputService"), game:GetService("RunService")
local vector3, color3rgb = Vector3.new, Color3.fromRGB
local workcamera = workspace.Camera
local players = game:GetService("Players")
local localplayer = players.LocalPlayer
local replicatedstorage = game:GetService("ReplicatedStorage")

local bodyvel = Instance.new("BodyVelocity")
bodyvel.MaxForce = vector3(math.huge, 0, math.huge)
local animation = Instance.new("Animation")
animation.AnimationId = "rbxassetid://5917459365"

--// Loaded check

if AirHub then
    return Notification.prompt("Error", "You already loaded Shotsetter! If you want to unload the script, use Unload in the Settings menu.", 4)
end

Notification.prompt("Information", "Loading Shotsetter, please wait...", 4)

--// Environment

getgenv().AirHub = {}
getgenv().Options = {} -- "Options is a table added to getgenv() by the library"

--// Load Modules

loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/AirHub/main/Modules/Aimbot.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/AirHub/main/Modules/Wall%20Hack.lua"))()

--// Variables
--local Library = loadstring(game:GetObjects("rbxassetid://7657867786")[1].Source)() -- Pepsi's UI Library

local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Aimbot, WallHack = getgenv().AirHub.Aimbot, getgenv().AirHub.WallHack
local Parts, Fonts, TracersType = {"Head", "HumanoidRootPart", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg", "LeftHand", "RightHand", "LeftLowerArm", "RightLowerArm", "LeftUpperArm", "RightUpperArm", "LeftFoot", "LeftLowerLeg", "UpperTorso", "LeftUpperLeg", "RightFoot", "RightLowerLeg", "LowerTorso", "RightUpperLeg"}, {"UI", "System", "Plex", "Monospace"}, {"Bottom", "Center", "Mouse"}
local GodMode = false
local AntiAim = false
local oldSkybox, anim
local AnimSpeed = 1
local Spin, SpinSpeed = 0, 4
local Jitter, JitterOffset = 0, 0
local YawOffset = 90
local Mouse = localplayer:GetMouse()
local GunChams, ArmChams, GloveChams, SelfChams = false, false, false, false
local FFGunTexture, FFGloveTexture, FFSelfTexture = "None", "None", "None"
local oldarmcol = color3rgb(204, 142, 105)
local GunColor, ArmColor, GloveColor, SelfColor = color3rgb(255, 255, 255), color3rgb(204, 142, 105), color3rgb(255, 255, 255), color3rgb(255,255,255) 
local GunTrans, ArmTrans, GloveTrans, SelfTrans = 0, 0, 0, 0
local GunMaterial, GloveMaterial, SelfMaterial = "ForceField", "ForceField", "ForceField"
local FOV = 75
local TPDistance, ThirdPerson = 12, false
local BhopSpeed = 40
local Guns = {"AK47", 'AUG', 'AWP', 'Bizon', 'CZ', 'XM', 'DesertEagle', 'DualBerettas', 'Famas', 'FiveSeven', 'USP', 'G3SG1', 'Galil', 'Glock', 'M249', 'M4A1', 'M4A4', 'MAC10', 'MAG7', 'MP7', 'MP7-SD', 'MP9', 'P90', 'RG', 'R8', 'SG', 'SawedOff', 'Scout', 'Tec9', 'P2000', 'UMP', 'P250', 'Nova', 'Negev'}
local Other = {'Banana', 'Bayonet', 'Bearded Axe', 'Butterfly Knife', 'Smoke Grenade', 'CT Knife', 'Cleaver', 'Crowbar', 'Falchion Knife', 'Flip Knife', 'Gut Knife', 'T Knife', 'Huntsman Knife', 'Karambit', 'Decoy Grenade', 'Flashbang', 'HE Grenade', 'Incendiary Grenade', 'Molotov', 'C4'}
local Everything = {"AK47", 'AUG', 'AWP', 'Bizon', 'CZ', 'XM', 'DesertEagle', 'DualBerettas', 'Famas', 'FiveSeven', 'USP', 'G3SG1', 'Galil', 'Glock', 'M249', 'M4A1', 'M4A4', 'MAC10', 'MAG7', 'MP7', 'MP7-SD', 'MP9', 'P90', 'RG', 'R8', 'SG', 'SawedOff', 'Scout', 'Tec9', 'P2000', 'UMP', 'P250', 'Nova', 'Negev', 'Banana', 'Bayonet', 'Bearded Axe', 'Butterfly Knife', 'Smoke Grenade', 'CT Knife', 'Cleaver', 'Crowbar', 'Falchion Knife', 'Flip Knife', 'Gut Knife', 'T Knife', 'Huntsman Knife', 'Karambit', 'Decoy Grenade', 'Flashbang', 'HE Grenade', 'Incendiary Grenade', 'Molotov', 'C4'}
local Skyboxes = {
    ["Nebula"] = {
		SkyboxLf = "rbxassetid://159454286",
		SkyboxBk = "rbxassetid://159454299",
		SkyboxDn = "rbxassetid://159454296",
		SkyboxFt = "rbxassetid://159454293",
		SkyboxRt = "rbxassetid://159454300",
		SkyboxUp = "rbxassetid://159454288",
	},
    ["Vaporwave"] = {
		SkyboxLf = "rbxassetid://1417494402",
		SkyboxBk = "rbxassetid://1417494030",
		SkyboxDn = "rbxassetid://1417494146",
		SkyboxFt = "rbxassetid://1417494253",
		SkyboxRt = "rbxassetid://1417494499",
		SkyboxUp = "rbxassetid://1417494643",
	},
	["Clouds"] = {
		SkyboxLf = "rbxassetid://570557620",
		SkyboxBk = "rbxassetid://570557514",
		SkyboxDn = "rbxassetid://570557775",
		SkyboxFt = "rbxassetid://570557559",
		SkyboxRt = "rbxassetid://570557672",
		SkyboxUp = "rbxassetid://570557727",
	},
	["Twilight"] = {
		SkyboxLf = "rbxassetid://264909758",
		SkyboxBk = "rbxassetid://264908339",
		SkyboxDn = "rbxassetid://264907909",
		SkyboxFt = "rbxassetid://264909420",
		SkyboxRt = "rbxassetid://264908886",
		SkyboxUp = "rbxassetid://264907379",
	},
    ["Galaxy"] = {
        SkyboxBk = "http://www.roblox.com/asset/?id=159454299",
        SkyboxDn = "http://www.roblox.com/asset/?id=159454296",
        SkyboxFt = "http://www.roblox.com/asset/?id=159454293",
        SkyboxLf = "http://www.roblox.com/asset/?id=159454286",
        SkyboxRt = "http://www.roblox.com/asset/?id=159454300",
        SkyboxUp = "http://www.roblox.com/asset/?id=159454288"
    },
    ["Pink Sky"] = {
        SkyboxLf = "rbxassetid://271042310",
		SkyboxBk = "rbxassetid://271042516",
		SkyboxDn = "rbxassetid://271077243",
		SkyboxFt = "rbxassetid://271042556",
		SkyboxRt = "rbxassetid://271042467",
		SkyboxUp = "rbxassetid://271077958"
    },
    ["Sunset"] = {
        SkyboxBk = "http://www.roblox.com/asset/?id=458016711",
        SkyboxDn = "http://www.roblox.com/asset/?id=458016826",
        SkyboxFt = "http://www.roblox.com/asset/?id=458016532",
        SkyboxLf = "http://www.roblox.com/asset/?id=458016655",
        SkyboxRt = "http://www.roblox.com/asset/?id=458016782",
        SkyboxUp = "http://www.roblox.com/asset/?id=458016792"
    },
    ["Night"] = {
        SkyboxBk = "rbxassetid://48020371",
        SkyboxDn = "rbxassetid://48020144",
        SkyboxFt = "rbxassetid://48020234",
        SkyboxLf = "rbxassetid://48020211",
        SkyboxRt = "rbxassetid://48020254",
        SkyboxUp = "rbxassetid://48020383"
    },
    ["Evening"] = {
        SkyboxLf = "http://www.roblox.com/asset/?id=7950573918",
        SkyboxBk = "http://www.roblox.com/asset/?id=7950569153",
		SkyboxDn = "http://www.roblox.com/asset/?id=7950570785",
		SkyboxFt = "http://www.roblox.com/asset/?id=7950572449",
		SkyboxRt = "http://www.roblox.com/asset/?id=7950575055",
		SkyboxUp = "http://www.roblox.com/asset/?id=7950627627"
    }
}
local Hitsounds = {
    ["Baimware"] = "6607339542",
    ["Bag"] = "364942410",
    ["Minecraft EXP"] = "1053296915",
    ["Skeet"] = "5447626464",
    ["Neverlose"] = "6534948092",
    ["Rust"] = "5043539486",
    ["Bell"] = "6534947240",
    ["Bubble"] = "6534947588",
    ["Pick"] = "1347140027",
    ["Pop"] = "198598793",
    ["DrainYaw"] = "rbxassetid://11846203640",
    ["Primordial"] = "rbxassetid://11846281136",
    ["Rifk7"] = "rbxassetid://11846211332",
    ["Ding"] = "rbxassetid://7149516994",
    ["TF2"] = "rbxassetid://2868331684",
    ["Bat"] = "rbxassetid://3333907347",
    ["TF2 Critical"] = "rbxassetid://296102734",
    ["Saber"] = "rbxassetid://8415678813",
}
local Killsounds = {
    ["CS:GO"] = "7269900245",
    ["Ultra Kill"] = "937885646",
    ["Killing Spree"] = "937898383",
    ["Ownage"] = "6887181639",
    ["Godlike"] = "7463103082",
    ["Sit NN Dog"] = "5902468562",
    ["Minecraft"] = "6705984236"
}
local Animations = {
    ['Idle'] = 'rbxassetid://2510196951',
	['Fall Over'] = 'rbxassetid://3716468774',
	['Floss'] = 'rbxassetid://5917459365',
    ['T Pose'] = "rbxassetid://3338010159",
    ['Dolphin'] = "rbxassetid://5918726674"
}
local Pitches = {
    ['Down'] = -1,
    ['Up'] = 1,
    ['180'] = 2.5
    -- more will be added soon :)
}
local FFTextures = {
    ['None'] = "rbxassetid://0",
    ['Web'] = "rbxassetid://301464986",
    ['Swirl'] = "rbxassetid://8133639623",
    ['Checkers'] = "rbxassetid://5790215150",
    ['Candy Cane'] = "rbxassetid://6853532738",
    ['Shield'] = "rbxassetid://361073795",
    ['Dots'] = "rbxassetid://5830615971",
    ['Scanning'] = "rbxassetid://5843010904",
    ['Bubbles'] = "rbxassetid://1461576423"
}

--// Functions

local function YROTATION(cframe)
    local x, y, z = cframe:ToOrientation()
    return CFrame.new(cframe.Position) * CFrame.Angles(0,y,0)
end

local function makelist(tbl)
    local fulltbl = {}
    
    table.insert(fulltbl, "None")
    table.insert(fulltbl, "Custom")

    if tbl == Skyboxes or tbl == Animations then
        table.remove(fulltbl, 2)
        for i in pairs(tbl) do -- fuck lua
            table.insert(fulltbl, i)
        end
    else
        for i in pairs(tbl) do
            table.insert(fulltbl, i)
        end
    end

    if tbl == Pitches then
        table.insert(fulltbl, "Random")
    end

    return fulltbl
end

function checkproperty(object, propertyName) -- https://devforum.roblox.com/t/tutorial-check-if-an-object-has-property/1213998
    local success, _ = pcall(function() 
        object[propertyName] = object[propertyName]
    end)
    return success
end

local function applygunchams()
    if GunSignal then
        GunSignal:Disconnect() -- we don't want to actually lag ourselves by making the signal a bunch of times
    end
    if workcamera:FindFirstChild("Arms") then
        if GunChams then
            for i,v in pairs(workcamera.Arms:GetChildren()) do
                if v:IsA("MeshPart") then
                    v.Color = GunColor
                    v.Transparency = GunTrans
                    if GunMaterial ~= "ForceField" then
                        -- system for resetting textureid here...
                        v.Material = GunMaterial
                        if v:FindFirstChild("Mesh") then
                            v.Mesh.TextureId = "rbxassetid://0"
                        else
                            if checkproperty(v, "TextureId") then
                                v.TextureId = "rbxassetid://0"
                            end
                        end
                    else
                        v.Material = "ForceField"
                        print(FFTextures[FFGunTexture])
                        if v:FindFirstChild("Mesh") then
                            v.Mesh.TextureId = FFTextures[FFGunTexture]
                        else
                            if checkproperty(v, "TextureId") then
                                v.TextureId = FFTextures[FFGunTexture]
                            end
                        end
                    end
                end
            end
        else
            if GunSignal then
                GunSignal:Disconnect()
            end
            for i,v in pairs(workcamera.Arms:GetChildren()) do
                if v:IsA("MeshPart") then
                    v.Color = color3rgb(255, 255, 255)
                    v.Transparency = 0
                    v.Material = "Plastic"
                end
            end
        end
    end
    GunSignal = workcamera.ChildAdded:Connect(applygunchams)
end

local function applyarmchams()
    if ArmSignal then
        ArmSignal:Disconnect() -- we don't want to actually lag ourselves by making the signal a bunch of times
    end
    if workcamera:FindFirstChild("Arms") then
        if ArmChams then
            local arm = workcamera.Arms:FindFirstChildOfClass("Model")
            arm['Right Arm'].Color = ArmColor
            arm['Right Arm'].Transparency = ArmTrans
            arm['Left Arm'].Color = ArmColor
            arm['Left Arm'].Transparency = ArmTrans 
        else
            local arm = workcamera.Arms:FindFirstChildOfClass("Model")
            if ArmSignal then
                ArmSignal:Disconnect()
            end
            arm['Right Arm'].Color = oldarmcol
            arm['Right Arm'].Transparency = 0
            arm['Left Arm'].Color = oldarmcol
            arm['Left Arm'].Transparency = 0
        end
    end
    ArmSignal = workcamera.ChildAdded:Connect(applyarmchams)
end

local function applyglovechams()
    if GloveSignal then
        GloveSignal:Disconnect() -- we don't want to actually lag ourselves by making the signal a bunch of times
    end
    if workcamera:FindFirstChild("Arms") then
        if GloveChams then
            local arm = workcamera.Arms:FindFirstChildOfClass("Model")
            arm['Right Arm'].RGlove.Color = GloveColor
            arm['Left Arm'].LGlove.Color = GloveColor
            arm['Right Arm'].RGlove.Transparency = GloveTrans
            arm['Left Arm'].LGlove.Transparency = GloveTrans
            if GloveMaterial ~= "ForceField" then
                -- system for resetting textureid here...
                arm['Right Arm'].RGlove.Material = GloveMaterial
                arm['Left Arm'].LGlove.Material = GloveMaterial
                arm['Right Arm'].RGlove.Mesh.TextureId = ""
                arm['Left Arm'].LGlove.Mesh.TextureId = ""
            else
                arm['Right Arm'].RGlove.Material = "ForceField"
                arm['Left Arm'].LGlove.Material = "ForceField"
                arm['Right Arm'].RGlove.Mesh.TextureId = FFTextures[FFGloveTexture]
                arm['Left Arm'].LGlove.Mesh.TextureId = FFTextures[FFGloveTexture]    
            end
        else
            local arm = workcamera.Arms:FindFirstChildOfClass("Model")
            if GloveSignal then
                GloveSignal:Disconnect()
            end
            arm['Right Arm'].RGlove.Color = color3rgb(255, 255, 255)
            arm['Left Arm'].LGlove.Color = color3rgb(255, 255, 255)
            arm['Right Arm'].RGlove.Transparency = 0
            arm['Left Arm'].LGlove.Transparency = 0
            arm['Right Arm'].RGlove.Material = "Plastic"
            arm['Left Arm'].LGlove.Material = "Plastic"

        end
    end
    GloveSignal = workcamera.ChildAdded:Connect(applyglovechams)
end

local function applyselfchams()
    if SelfSignal then
        SelfSignal:Disconnect() -- we don't want to actually lag ourselves by making the signal a bunch of times
    end
    if localplayer.Character then
        if SelfChams then
            for i,v in pairs(localplayer.Character:GetChildren()) do
                if v:IsA("MeshPart") then
                    v.Color = SelfColor
                    v.Transparency = SelfTrans
                    if SelfMaterial ~= "ForceField" then
                        -- system for resetting textureid here...
                        v.Material = SelfMaterial
                        if checkproperty(v, "TextureId") then
                            v.TextureId = "rbxassetid://0"
                        end
                    else
                        v.Material = "ForceField"
                        print(FFTextures[FFSelfTexture])
                        if checkproperty(v, "TextureId") then
                            v.TextureId = FFTextures[FFSelfTexture]
                        end
                    end
                end
            end
        else
            if SelfSignal then
                SelfSignal:Disconnect()
            end
            for i,v in pairs(localplayer.Character:GetChildren()) do
                if v:IsA("MeshPart") then
                    v.Color = color3rgb(255, 255, 255)
                    v.Transparency = 0
                    v.Material = "Plastic"
                end
            end
        end
    end
    SelfSignal = workcamera.ChildAdded:Connect(applyselfchams)
end

--// God Mode

RunService.RenderStepped:Connect(function()
    if GodMode == true then
        for _,plr in ipairs(players:GetPlayers()) do
            if (plr:FindFirstChild("DamageLogs") and not plr.DamageLogs:FindFirstChild(localplayer.Name)) then
                ReplicatedStorage.MapVoting.Submit:FireServer(plr, "DamageLogs")
            end
        end
    else
        replicatedstorage.MapVoting.Submit:FireServer(plr, "")
    end
end)

--// Frame

Library.UnloadCallback = function()
	Aimbot.Functions:Exit()
    WallHack.Functions:Exit()
	getgenv().AirHub = nil
end

local version = game:HttpGet("https://raw.githubusercontent.com/A1thernex/shotsetter/main/version.txt")

local MainFrame = Library:CreateWindow({
	Title = "Shotsetter",
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

--// Tabs

local AimbotTab = MainFrame:AddTab("Combat")

local VisualsTab = MainFrame:AddTab("Visuals")

local CBTab = MainFrame:AddTab("Miscellaneous")

local SettingsTab = MainFrame:AddTab('Settings')

--// Aimbot Sections

local Values = AimbotTab:AddLeftGroupbox("Aimbot")

local Checks = AimbotTab:AddRightGroupbox("Aimbot Checks")

local FOV_Values = AimbotTab:AddRightGroupbox("Field Of View")

local FOV_Appearance = AimbotTab:AddRightGroupbox("FOV Circle Appearance")

--// Visuals Sections

local WallHackChecks = VisualsTab:AddLeftGroupbox("Checks")

local ESPSettings = VisualsTab:AddLeftGroupbox("ESP Settings")

local BoxesSettings = VisualsTab:AddRightGroupbox("Boxes Settings")

local TracersSettings = VisualsTab:AddRightGroupbox("Tracers Settings")

local HealthBarSettings = VisualsTab:AddRightGroupbox("Health Bar Settings")

local CBWorldSection = VisualsTab:AddLeftGroupbox("World")

local CBSelfSection = VisualsTab:AddLeftGroupbox("Self")

--// CB Sections

local CBModsSection = CBTab:AddLeftGroupbox("Modifications")

local CBExploitsSection = AimbotTab:AddLeftGroupbox("Exploits")

local CBAASection = AimbotTab:AddLeftGroupbox("Anti-Aim")

local CBOtherSection = CBTab:AddRightGroupbox("Other")

Aimbot.Settings.Toggle = true

--// Aimbot Values
Values:AddToggle('AimbotEnabled', {
	Text = "Enabled",
	Default = Aimbot.Settings.Enabled,
	Callback = function(New, Old)
		Aimbot.Settings.Enabled = New
	end
})
Values:AddToggle('AimbotToggle', {
	Text = "Toggle",
	Default = Aimbot.Settings.Toggle,
    Tooltip = "Makes you to be able to enable aimbot with 1 click of a button.",
	Callback = function(New, Old)
		Aimbot.Settings.Toggle = New
	end
})
Aimbot.Settings.LockPart = Parts[1]; Values:AddDropdown('AimbotLockPart', {
	Text = "Lock Part",
	Default = Parts[1],
	Callback = function(New, Old)
		Aimbot.Settings.LockPart = New
	end,
	Values = Parts,
	Nothing = "Head"
})

Values:AddLabel('Hotkey'):AddKeyPicker('AimbotKeybind', {
	Text = "Aimbot Key",
    Mode = "Toggle",
	Default = "MB2",
	Callback = function(val)
		if Options.AimbotKeybind.Value == "MB1" then
            Aimbot.Settings.TriggerKey = "MouseButton1"
        elseif Options.AimbotKeybind.Value == "MB2" then
            Aimbot.Settings.TriggerKey = "MouseButton2"
        else
            Aimbot.Settings.TriggerKey = Options.AimbotKeybind.Value
        end
	end
})

Values:AddSlider('AimbotSensitivity', {
	Text = "Sensitivity",
	Default = Aimbot.Settings.Sensitivity,
	Callback = function(New, Old)
		Aimbot.Settings.Sensitivity = New
	end,
	Min = 0,
	Max = 1,
	Rounding = 2
})

--// Aimbot Checks

Checks:AddToggle('AimbotTeamCheck', {
	Text = "Team Check",
	Default = Aimbot.Settings.TeamCheck,
	Callback = function(New, Old)
		Aimbot.Settings.TeamCheck = New
	end
})

Checks:AddToggle('AimbotWallCheck', {
	Text = "Wall Check",
	Default = Aimbot.Settings.WallCheck,
	Callback = function(New, Old)
		Aimbot.Settings.WallCheck = New
	end
})

Checks:AddToggle('AimbotAliveCheck', {
	Text = "Alive Check",
	Default = Aimbot.Settings.AliveCheck,
	Callback = function(New, Old)
		Aimbot.Settings.AliveCheck = New
	end
})

--// FOV Settings Values

FOV_Values:AddToggle('AimbotFOVEnabled', {
	Text = "Enabled",
	Default = Aimbot.FOVSettings.Enabled,
	Callback = function(New, Old)
		Aimbot.FOVSettings.Enabled = New
	end
})

FOV_Values:AddToggle('AimbotFOVVisible', {
	Text = "Visible",
	Default = Aimbot.FOVSettings.Visible,
	Callback = function(New, Old)
		Aimbot.FOVSettings.Visible = New
	end
})

FOV_Values:AddSlider('AimbotFOVAmount', {
	Text = "Amount",
	Default = Aimbot.FOVSettings.Amount,
	Callback = function(New, Old)
		Aimbot.FOVSettings.Amount = New
	end,
	Min = 10,
	Max = 300,
    Rounding = 0
})

--// FOV Settings Appearance

FOV_Appearance:AddToggle('AimbotFOVFilled', {
	Text = "Filled",
	Default = Aimbot.FOVSettings.Filled,
	Callback = function(New, Old)
		Aimbot.FOVSettings.Filled = New
	end
})

FOV_Appearance:AddSlider('AimbotFOVTransparency', {
	Text = "Transparency",
	Default = Aimbot.FOVSettings.Transparency,
	Callback = function(New, Old)
		Aimbot.FOVSettings.Transparency = New
	end,
	Min = 0,
	Max = 1,
	Rounding = 1
})

FOV_Appearance:AddSlider('AimbotFOVSides', {
	Text = "Sides",
	Default = Aimbot.FOVSettings.Sides,
	Callback = function(New, Old)
		Aimbot.FOVSettings.Sides = New
	end,
	Min = 3,
	Max = 60,
    Rounding = 0
})

FOV_Appearance:AddSlider('AimbotFOVThickness',{
	Text = "Thickness",
	Default = Aimbot.FOVSettings.Thickness,
	Callback = function(New, Old)
		Aimbot.FOVSettings.Thickness = New
	end,
	Min = 1,
	Max = 50,
    Rounding = 0
})

FOV_Appearance:AddLabel('Color'):AddColorPicker('AimbotFOVColor', {
	Title = "FOV Color",
	Default = Aimbot.FOVSettings.Color,
	Callback = function(New, Old)
		Aimbot.FOVSettings.Color = New
	end
})

FOV_Appearance:AddLabel('Locked Color'):AddColorPicker('AimbotFOVLockedColor', {
	Title = "Locked Color",
	Default = Aimbot.FOVSettings.LockedColor,
	Callback = function(New, Old)
		Aimbot.FOVSettings.LockedColor = New
	end
})

--// Wall Hack Settings

WallHackChecks:AddToggle('WHEnabled', {
	Text = "Enabled",
	Default = WallHack.Settings.Enabled,
	Callback = function(New, Old)
		WallHack.Settings.Enabled = New
	end
})

WallHackChecks:AddToggle('WHTeamCheck', {
	Text = "Team Check",
	Default = WallHack.Settings.TeamCheck,
	Callback = function(New, Old)
		WallHack.Settings.TeamCheck = New
	end
})

WallHackChecks:AddToggle('WHAliveCheck', {
	Text = "Alive Check",
	Default = WallHack.Settings.AliveCheck,
	Callback = function(New, Old)
		WallHack.Settings.AliveCheck = New
	end
})

--// Visuals Settings

ESPSettings:AddToggle('WHESPEnabled', {
	Text = "Enabled",
	Default = WallHack.Visuals.ESPSettings.Enabled,
	Callback = function(New, Old)
		WallHack.Visuals.ESPSettings.Enabled = New
	end
})

ESPSettings:AddToggle('WHESPOutline', {
	Text = "Outline",
	Default = WallHack.Visuals.ESPSettings.Outline,
	Callback = function(New, Old)
		WallHack.Visuals.ESPSettings.Outline = New
	end
})

ESPSettings:AddToggle('WHESPDisplayDistance', {
	Text = "Display Distance",
	Default = WallHack.Visuals.ESPSettings.DisplayDistance,
	Callback = function(New, Old)
		WallHack.Visuals.ESPSettings.DisplayDistance = New
	end
})

ESPSettings:AddToggle('WHESPDisplayHealth', {
	Text = "Display Health",
	Default = WallHack.Visuals.ESPSettings.DisplayHealth,
	Callback = function(New, Old)
		WallHack.Visuals.ESPSettings.DisplayHealth = New
	end
})

ESPSettings:AddToggle('WHESPDisplayName', {
	Text = "Display Name",
	Default = WallHack.Visuals.ESPSettings.DisplayName,
	Callback = function(New, Old)
		WallHack.Visuals.ESPSettings.DisplayName = New
	end
})

ESPSettings:AddSlider('WHESPOffset', {
	Text = "Offset",
	Default = WallHack.Visuals.ESPSettings.Offset,
	Callback = function(New, Old)
		WallHack.Visuals.ESPSettings.Offset = New
	end,
	Min = -30,
	Max = 30,
    Rounding = 0
})

ESPSettings:AddLabel('Text Color'):AddColorPicker('WHESPTextColor', {
	Title = "Text Color",
	Default = WallHack.Visuals.ESPSettings.TextColor,
	Callback = function(New, Old)
		WallHack.Visuals.ESPSettings.TextColor = New
	end
})

ESPSettings:AddLabel('Outline Color'):AddColorPicker('WHESPOutlineColor', {
	Title = "Outline Color",
	Default = WallHack.Visuals.ESPSettings.OutlineColor,
	Callback = function(New, Old)
		WallHack.Visuals.ESPSettings.OutlineColor = New
	end
})

ESPSettings:AddSlider('WHESPTextTransparency', {
	Text = "Text Transparency",
	Default = WallHack.Visuals.ESPSettings.TextTransparency,
	Callback = function(New, Old)
		WallHack.Visuals.ESPSettings.TextTransparency = New
	end,
	Min = 0,
	Max = 1,
	Rounding = 2
})

ESPSettings:AddSlider('WHESPTextSize', {
	Text = "Text Size",
	Default = WallHack.Visuals.ESPSettings.TextSize,
	Callback = function(New, Old)
		WallHack.Visuals.ESPSettings.TextSize = New
	end,
	Min = 8,
	Max = 24,
    Rounding = 0
})

ESPSettings:AddDropdown('WHESPTextFont', {
	Text = "Text Font",
	Default = Fonts[WallHack.Visuals.ESPSettings.TextFont + 1],
	Callback = function(New, Old)
		WallHack.Visuals.ESPSettings.TextFont = Drawing.Fonts[New]
	end,
	Values = Fonts,
	Nothing = "UI"
})

BoxesSettings:AddToggle('WHBoxEnabled', {
	Text = "Enabled",
	Default = WallHack.Visuals.BoxSettings.Enabled,
	Callback = function(New, Old)
		WallHack.Visuals.BoxSettings.Enabled = New
	end
})

BoxesSettings:AddSlider('WHBoxTransparency', {
	Text = "Transparency",
	Default = WallHack.Visuals.BoxSettings.Transparency,
	Callback = function(New, Old)
		WallHack.Visuals.BoxSettings.Transparency = New
	end,
	Min = 0,
	Max = 1,
	Rounding = 2
})

BoxesSettings:AddSlider('WHBoxThickness', {
	Text = "Thickness",
	Default = WallHack.Visuals.BoxSettings.Thickness,
	Callback = function(New, Old)
		WallHack.Visuals.BoxSettings.Thickness = New
	end,
	Min = 1,
	Max = 5,
    Rounding = 0
})

BoxesSettings:AddSlider('WHBoxIncrease', {
	Text = "Scale Increase (For 3D)",
	Default = WallHack.Visuals.BoxSettings.Increase,
	Callback = function(New, Old)
		WallHack.Visuals.BoxSettings.Increase = New
	end,
	Min = 1,
	Max = 5,
    Rounding = 0
})

BoxesSettings:AddLabel('Color'):AddColorPicker('WHBoxColor', {
	Title = "Box Color",
	Default = WallHack.Visuals.BoxSettings.Color,
	Callback = function(New, Old)
		WallHack.Visuals.BoxSettings.Color = New
	end
})

BoxesSettings:AddDropdown('WHBoxType', {
	Text = "Type",
	Default = WallHack.Visuals.BoxSettings.Type == 1 and "3D" or "2D",
	Callback = function(New, Old)
		WallHack.Visuals.BoxSettings.Type = New == "3D" and 1 or 2
	end,
	Values = {"3D", "2D"},
	Nothing = "3D"
})

BoxesSettings:AddToggle('WHBoxFilled', {
	Text = "Filled (2D Square)",
	Default = WallHack.Visuals.BoxSettings.Filled,
	Callback = function(New, Old)
		WallHack.Visuals.BoxSettings.Filled = New
	end
})

TracersSettings:AddToggle('WHTracerEnabled', {
	Text = "Enabled",
	Default = WallHack.Visuals.TracersSettings.Enabled,
	Callback = function(New, Old)
		WallHack.Visuals.TracersSettings.Enabled = New
	end
})

TracersSettings:AddSlider('WHTracerTransparency', {
	Text = "Transparency",
	Default = WallHack.Visuals.TracersSettings.Transparency,
	Callback = function(New, Old)
		WallHack.Visuals.TracersSettings.Transparency = New
	end,
	Min = 0,
	Max = 1,
	Rounding = 2
})

TracersSettings:AddSlider('WHTracerThickness', {
	Text = "Thickness",
	Default = WallHack.Visuals.TracersSettings.Thickness,
	Callback = function(New, Old)
		WallHack.Visuals.TracersSettings.Thickness = New
	end,
	Min = 1,
	Max = 5,
    Rounding = 0
})

TracersSettings:AddLabel('Color'):AddColorPicker('WHTracerColor', {
	Title = "Tracer Color",
	Default = WallHack.Visuals.TracersSettings.Color,
	Callback = function(New, Old)
		WallHack.Visuals.TracersSettings.Color = New
	end
})

TracersSettings:AddDropdown('WHTracerStart', {
	Text = "Start From",
	Default = TracersType[WallHack.Visuals.TracersSettings.Type],
	Callback = function(New, Old)
		WallHack.Visuals.TracersSettings.Type = tablefind(TracersType, New)
	end,
	Values = TracersType,
	Nothing = "Bottom"
})

HealthBarSettings:AddToggle('WHHBEnabled', {
	Text = "Enabled",
	Default = WallHack.Visuals.HealthBarSettings.Enabled,
	Callback = function(New, Old)
		WallHack.Visuals.HealthBarSettings.Enabled = New
	end
})

HealthBarSettings:AddDropdown('WHHBPosition', {
	Text = "Position",
	Default = WallHack.Visuals.HealthBarSettings.Type == 1 and "Top" or WallHack.Visuals.HealthBarSettings.Type == 2 and "Bottom" or WallHack.Visuals.HealthBarSettings.Type == 3 and "Left" or "Right",
	Callback = function(New, Old)
		WallHack.Visuals.HealthBarSettings.Type = New == "Top" and 1 or New == "Bottom" and 2 or New == "Left" and 3 or 4
	end,
	Values = {"Top", "Bottom", "Left", "Right"},
	Nothing = "Left"
})

HealthBarSettings:AddSlider('WHHBTransparency', {
	Text = "Transparency",
	Default = WallHack.Visuals.HealthBarSettings.Transparency,
	Callback = function(New, Old)
		WallHack.Visuals.HealthBarSettings.Transparency = New
	end,
	Min = 0,
	Max = 1,
	Rounding = 2
})

HealthBarSettings:AddSlider('WHHBSize', {
	Text = "Size",
	Default = WallHack.Visuals.HealthBarSettings.Size,
	Callback = function(New, Old)
		WallHack.Visuals.HealthBarSettings.Size = New
	end,
	Min = 2,
	Max = 10,
    Rounding = 0
})

HealthBarSettings:AddSlider('WHHBBlue', {
	Text = "Blue",
	Default = WallHack.Visuals.HealthBarSettings.Blue,
	Callback = function(New, Old)
		WallHack.Visuals.HealthBarSettings.Blue = New
	end,
	Min = 0,
	Max = 255,
    Rounding = 0
})

HealthBarSettings:AddSlider('WHHBOffset', {
	Text = "Offset",
	Default = WallHack.Visuals.HealthBarSettings.Offset,
	Callback = function(New, Old)
		WallHack.Visuals.HealthBarSettings.Offset = New
	end,
	Min = -30,
	Max = 30,
    Rounding = 0
})

HealthBarSettings:AddLabel('Outline Color'):AddColorPicker('WHHBOutlineColor', {
	Title = "Outline Color",
	Default = WallHack.Visuals.HealthBarSettings.OutlineColor,
	Callback = function(New, Old)
		WallHack.Visuals.HealthBarSettings.OutlineColor = New
	end
})

--// CB Features

CBOtherSection:AddToggle('BunnyHop', {
    Text = "Bunny Hop",
    Default = false,
    Callback = function(val)
        Bhop = val
    end
}):AddKeyPicker('BunnyHopKB', {
    Text = "Bunny Hop",
    Default = "",
    Mode = 'Toggle',
    Callback = function(val)
        Bhop = val
    end
})

CBOtherSection:AddSlider('BunnyHopSpeed', {
    Text = "Speed",
    Default = 40,
    Min = 1,
    Max = 150,
    Rounding = 0,
    Callback = function(val)
        BhopSpeed = val
    end
})

CBOtherSection:AddDivider()

CBOtherSection:AddDropdown('Hitsound',{
    Text = "Hitsound",
    Default = 1,
    Values = makelist(Hitsounds),
    Callback = function(val)
        Hitsound = val
    end
})

CBOtherSection:AddInput('CustomHitsound', {
    Text = "Custom Hitsound",
    Default = "",
    Numeric = true,
    Placeholder = "Enter sound id here...",
    Callback = function(val)
        CustomHitsound = val
    end
})

CBOtherSection:AddSlider('HitsoundVolume', {
    Text = "Volume",
    Default = 3,
    Min = 1,
    Max = 5,
    Rounding = 0,
    Callback = function(val)
        HitsoundVolume = val
    end
})

CBOtherSection:AddDivider()

CBOtherSection:AddDropdown('Killsound',{
    Text = "Killsound",
    Default = 1,
    Values = makelist(Killsounds),
    Callback = function(val)
        Killsound = val
    end
})

CBOtherSection:AddInput('CustomKillsound', {
    Text = "Custom Killsound",
    Numeric = true,
    Default = "",
    Placeholder = "Enter sound id here...",
    Callback = function(val)
        CustomKillsound = val
    end
})

CBOtherSection:AddSlider('KillsoundVolume', {
    Text = "Volume",
    Default = 3,
    Min = 1,
    Max = 5,
    Rounding = 0,
    Callback = function(val)
        KillsoundVolume = val
    end
})

CBModsSection:AddToggle('InfiniteMoney', {
    Text = "Infinite Money",
    Default = false,
    Callback = function(val)
    -- pasted from hexagon LUL
        if val == true then
		    localplayer.Cash.Value = 99999
		    CashHook = localplayer.Cash:GetPropertyChangedSignal("Value"):connect(function()
			    localplayer.Cash.Value = 99999
		    end)
	    elseif val == false and CashHook then
		    CashHook:Disconnect()
	    end
    end
})

CBModsSection:AddButton({
    Text = "Infinite Ammo",
    Func = function()
        for i,v in pairs(replicatedstorage.Weapons:GetChildren()) do
            if table.find(Guns, v.Name) then
                v.Ammo.Value = 9999
                v.StoredAmmo.Value = 69
            end
        end
        Notification.prompt("Infinite Ammo", "Re-buy the weapon to get infinite ammo.", 4)
    end
})

CBModsSection:AddButton({
    Text = "No Spread",
    Func = function(val)
        Notification.prompt("Warning", "Weapons that break with No Spread applied: Every pistol, AWP.", 5)
        for i,v in pairs(replicatedstorage.Weapons:GetChildren()) do
            if table.find(Guns, v.Name) then
                v.Spread.Value = 0 -- fuck this shit, iteration in lua is so weird
                v.Spread.Stand.Value = 0
                v.Spread.MaxInaccuracy.Value = 0
                v.Spread.Crouch.Value = 0
                if v.Spread:FindFirstChild("Move") then
                    v.Spread.Move.Value = 0
                else
                    v.Spread.Crouch.Move.Value = 0
                end
                v.Spread.Jump.Value = 0
                v.Spread.Land.Value = 0
                v.Spread.Ladder.Value = 0
                v.Spread.RecoveryTime.Value = 0
                v.Spread.RecoveryTime.Crouched.Value = 0
                if v.Spread:FindFirstChild("Fire") then
                    v.Spread.Fire.Value = 0
                end
                if v.Spread:FindFirstChild("TimeToIdle") then
                    v.Spread.TimeToIdle.Value = 0
                end
                v.RangeModifier.Value = 0
                v.AccuracyOffset.Value = 0
                v.AccuracyDivisor.Value = 0
            end
        end
    end
})

CBModsSection:AddButton({
    Text = "Rapid Fire",
    Func = function()
        for i,v in pairs(replicatedstorage.Weapons:GetChildren()) do
            if table.find(Everything, v.Name) then
                v.FireRate.Value = 0
            end
        end
    end
})

CBModsSection:AddButton({
    Text = "Instant Equip",
    Func = function()
        for i,v in pairs(replicatedstorage.Weapons:GetChildren()) do
            if table.find(Everything, v.Name) then
                v.EquipTime.Value = 0.0001 -- setting to 0 doesn't work, sadly
            end
        end
    end
})

CBModsSection:AddButton({
    Text = "Instant Reload",
    Func = function()
        for i,v in pairs(replicatedstorage.Weapons:GetChildren()) do
            if table.find(Everything, v.Name) then
                v.ReloadTime.Value = 0
            end
        end
    end
})

CBModsSection:AddSlider('DMGMultiplier', {
    Text = "Damage Multiplier",
    Default = 1,
    Min = 1,
    Max = 1000,
    Rounding = 0,
    Callback = function(val)
        for i,v in pairs(replicatedstorage.Weapons:GetChildren()) do
            if table.find(Guns, v.Name) then
                v.DMG.Value = 65
                v.DMG.Value = v.DMG.Value * (val / 10)
            end
        end
    end
})

CBExploitsSection:AddToggle('GodMode', {
    Text = "God Mode",
    Default = false,
    Callback = function(val)
        GodMode = val
    end
}):AddKeyPicker('GodModeKB', {
    Text = "God Mode",
    Default = "",
    Type = "Toggle",
    Callback = function(val)
        GodMode = val
    end
})

CBExploitsSection:AddToggle('RifleOnFirstRound', {
    Text = "Rifle On First Round",
    Default = false,
    Callback = function(val)
        RifleFR = val
        for _,v in pairs(replicatedstorage.Weapons:GetChildren()) do
            if val == true then
                if v:FindFirstChild("Primary") and not v:FindFirstChild("Melee") and not v:FindFirstChild("Grenade") and not v:FindFirstChild("Equipment2") then
                    v.Primary.Name = "Secondary"
                    primary = Instance.new("Folder")
                    primary.Parent = v
                    primary.Name = "Primarybak"
                end
            else
                if not v:FindFirstChild("Melee") and not v:FindFirstChild("Grenade") and not v:FindFirstChild("Equipment2") then
                    v.Primarybak.Name = "Primary"
                    v.Secondary:Destroy()
                end
            end
        end
    end
})

CBExploitsSection:AddToggle('AntiFlash', {
    Text = "Anti Flash",
    Default = false,
    Callback = function(val)
        if val then
            localplayer.PlayerGui.Blnd.Blind.Name = "Blindbak"
        else
            localplayer.PlayerGui.Blnd.Blindbak.Name = "Blind"
        end
    end
})

CBExploitsSection:AddToggle('AntiSmoke', {
    Text = "Anti Smoke",
    Default = false,
    Callback = function(val)
        AntiSmoke = val
    end
})

CBAASection:AddToggle('AntiAim', {
    Text = "Enable Anti-Aim",
    Default = false,
    Callback = function(val)
        AntiAim = val
    end
}):AddKeyPicker('AntiAimKB', {
    Text = 'Anti-Aim',
    Default = "",
    Mode = "Toggle",
    Callback = function(val)
        AntiAim = val
    end
})

CBAASection:AddDropdown('YawType', {
    Text = "Yaw Type",
    Default = "Camera",
    Values = {"Camera", "Target", 'Spin', 'Random'},
    Callback = function(val)
        YawType = val
    end
})

CBAASection:AddSlider('YawOffset', {
    Text = "Yaw Offset",
    Default = 90,
    Min = -180,
    Max = 180,
    Rounding = 0,
    Callback = function(val)
        YawOffset = val
    end
})

CBAASection:AddSlider('SpinSpeed', {
    Text = "Spin Speed",
    Default = 4,
    Min = 1,
    Max = 48,
    Rounding = 0,
    Callback = function(val)
        SpinSpeed = val
    end
})

CBAASection:AddDropdown('PitchType', {
    Text = "Pitch Type",
    Default = 1,
    Values = makelist(Pitches),
    Callback = function(val)
        PitchType = val
    end
})

CBAASection:AddSlider('CustomPitchOffset', {
    Text = "Custom Pitch Offset",
    Default = 1,
    Min = 1,
    Max = 100,
    Rounding = 0,
    Callback = function(val)
        PitchOffset = val
    end
})

CBAASection:AddToggle('Jitter', {
    Text = "Jitter",
    Default = false,
    Callback = function(val)
        Jitter = val
    end
})


CBAASection:AddSlider('JitterOffset', {
    Text = "Jitter Offset",
    Default = 1,
    Min = 1,
    Max = 100,
    Rounding = 0,
    Callback = function(val)
        JitterOffset = val
    end
})

CBSelfSection:AddToggle('ThirdPerson', {
    Text = "Third Person",
    Default = false,
    Callback = function(val)
        ThirdPerson = val
    end
}):AddKeyPicker('ThirdPersonKB', {
    Text = 'ThirdPerson',
    Default = "",
    Mode = "Toggle",
    Callback = function(val)
        ThirdPerson = val
    end
})

CBSelfSection:AddSlider('ThirdPersonDistance', {
    Text = "Distance",
    Default = 12,
    Max = 30,
    Min = 1,
    Rounding = 0,
    Callback = function(val)
        TPDistance = val
    end
})

CBSelfSection:AddSlider('FOV', {
    Text = "Field Of View",
    Default = 75,
    Max = 120,
    Min = 1,
    Rounding = 0,
    Callback = function(val)
        FOV = val
        workcamera.FieldOfView = val
    end
})

CBSelfSection:AddDivider()

CBWorldSection:AddToggle('WorldShadows', {
    Text = "World Shadows",
    Default = true,
    Callback = function(val)
        game.Lighting.GlobalShadows = val
    end
})

CBWorldSection:AddSlider('WorldBrightness', {
    Text = "World Brightness",
    Default = 3,
    Max = 10,
    Min = 1,
    Rounding = 0,
    Callback = function(val)
        game.Lighting.Brightness = val
    end
})

CBWorldSection:AddSlider('WorldExposure', {
    Text = "World Exposure", -- not sure if this would be the right name for it...
    Default = 0.1,
    Max = 1,
    Min = 0,
    Rounding = 1,
    Callback = function(val)
        game.Lighting.ExposureCompensation = val
    end
})

CBWorldSection:AddSlider('DayTime', {
    Text = "Day Time (in hours)",
    Default = 12,
    Max = 23,
    Min = 1,
    Rounding = 0,
    Callback = function(val)
        game.Lighting.ClockTime = val
    end
})

CBWorldSection:AddDropdown('Skybox', {
    Text = "Skybox",
    Values = makelist(Skyboxes),
    Default = "None",
    Callback = function(sky)
    ChosenSky = sky
    if sky ~= "none" then
		if game.Lighting:FindFirstChildOfClass("Sky") then game.Lighting:FindFirstChildOfClass("Sky"):Destroy() end
		    local skybox = Instance.new("Sky")
		    skybox.SkyboxLf = Skyboxes[sky].SkyboxLf
		    skybox.SkyboxBk = Skyboxes[sky].SkyboxBk
		    skybox.SkyboxDn = Skyboxes[sky].SkyboxDn
		    skybox.SkyboxFt = Skyboxes[sky].SkyboxFt
		    skybox.SkyboxRt = Skyboxes[sky].SkyboxRt
		    skybox.SkyboxUp = Skyboxes[sky].SkyboxUp
		    skybox.Name = "override"
		    skybox.Parent = game.Lighting
	else
		if game.Lighting:FindFirstChildOfClass("Sky") then game.Lighting:FindFirstChildOfClass("Sky"):Destroy() end
		if oldSkybox ~= nil then oldSkybox:Clone().Parent = game.Lighting end
	end
end
})

CBWorldSection:AddDivider()

CBWorldSection:AddLabel('World Color'):AddColorPicker('WorldColor', {
    Title = "World Color",
    Default = color3rgb(255, 255, 255),
    Callback = function(val)
        workcamera.ColorCorrection.TintColor = val
    end
})

CBWorldSection:AddLabel('Ambient'):AddColorPicker('Ambient', {
    Title = "Ambient Color",
    Default = color3rgb(254, 254, 254), -- pepsi's colorpickers are retarded, doesn't let you change the color itself when the color is set to 255, 255, 255 
    Callback = function(val)
        game.Lighting.Ambient = val
    end
})

CBWorldSection:AddLabel('Outdoor Ambient'):AddColorPicker('OutdoorAmbient', {
    Title = "Outdoor Ambient Color",
    Default = color3rgb(254, 254, 254), -- pepsi's colorpickers are retarded, doesn't let you change the color itself when the color is set to 255, 255, 255 
    Callback = function(val)
        game.Lighting.OutdoorAmbient = val
    end
})

CBWorldSection:AddLabel('Color Shift'):AddColorPicker('ColorShift', {
    Title = "Color Shift",
    Default = color3rgb(255, 230, 100), -- pepsi's colorpickers are retarded, doesn't let you change the color itself when the color is set to 255, 255, 255 
    Callback = function(val)
        game.Lighting.ColorShift_Top = val
    end
})

CBSelfSection:AddToggle('Animation', {
    Text = "Enable Animation",
    Default = false,
    Callback = function(val)
        enableanimation = val
        if not val then
            pcall(function()
                anim:Stop()
            end)
        else
            if localplayer.Character and localplayer.Character:FindFirstChild("Humanoid") then
			    anim = localplayer.Character.Humanoid:LoadAnimation(animation)
			    anim.Priority = Enum.AnimationPriority.Action
			    anim:Play()
                anim:AdjustSpeed(AnimSpeed)
		    end
        end
    end
})

CBSelfSection:AddDropdown('Animations', {
    Text = "Animations",
    Values = makelist(Animations),
    Default = "Floss",
    Callback = function(val)
        animation.AnimationId = Animations[val]
        pcall(function()
            anim:Stop()
        end)

        if enableanimation then
            if localplayer.Character and localplayer.Character:FindFirstChild("Humanoid") then
			    anim = localplayer.Character.Humanoid:LoadAnimation(animation)
			    anim.Priority = Enum.AnimationPriority.Action
			    anim:Play()
                anim:AdjustSpeed(AnimSpeed)
		    end
        end
    end
})

CBSelfSection:AddSlider('AnimationSpeed', {
    Text = "Animation Speed",
    Default = 1,
    Max = 100,
    Min = 0,
    Rounding = 0,
    Callback = function(val)
        AnimSpeed = val
        pcall(function()
        anim:Stop()
        end)
    end
})

CBSelfSection:AddDivider()

CBSelfSection:AddToggle('GunChams', {
    Text = "Gun Chams",
    Default = false,
    Callback = function(val)
        GunChams = val
        applygunchams()
    end
})

CBSelfSection:AddDropdown('GunMaterial', {
    Text = "Gun Material",
    Default = 1,
    Values = {"ForceField", "Plastic", "SmoothPlastic", "Flat", "Glass", "Neon"},
    Callback = function(val)
        GunMaterial = val
        applygunchams()
    end
})

CBSelfSection:AddDropdown('FFGunTexture', {
    Text = "ForceField Texture",
    Default = 1,
    Values = {"None", "Pulse", "Web", "Swirl", "Checkers", "Candy Cane", "Shield", "Dots", "Scanning", "Bubbles"},
    Callback = function(val)
        FFGunTexture = val
        applygunchams()
    end
})

CBSelfSection:AddLabel("Gun Color"):AddColorPicker("GunColor", {
    Title = "Gun Color",
    Default = color3rgb(255, 255, 255),
    Transparency = 0,
    Callback = function(val)
    end
})

Options.GunColor:OnChanged(function()
    GunColor = Options.GunColor.Value--Color3.fromHSV(Options.GunColor.Value)
    GunTrans = Options.GunColor.Transparency
    applygunchams()
end)

CBSelfSection:AddDivider()

CBSelfSection:AddToggle('ArmChams', {
    Text = "Arm Chams",
    Default = false,
    Callback = function(val)
        ArmChams = val
        applyarmchams()
    end
})

CBSelfSection:AddLabel("Arm Color"):AddColorPicker("ArmColor", {
    Title = "Arm Color",
    Default = color3rgb(255, 255, 255),
    Transparency = 0,
    Callback = function(val)
    end
})

Options.ArmColor:OnChanged(function()
    ArmColor = Options.ArmColor.Value
    ArmTrans = Options.ArmColor.Transparency
    applyarmchams()
end)

CBSelfSection:AddDivider()

CBSelfSection:AddToggle('GloveChams', {
    Text = "Glove Chams",
    Default = false,
    Callback = function(val)
        GloveChams = val
        applyglovechams()
    end
})

CBSelfSection:AddDropdown('GloveMaterial', {
    Text = "Glove Material",
    Default = 1,
    Values = {"ForceField", "Plastic", "SmoothPlastic", "Flat", "Glass", "Neon"},
    Callback = function(val)
        GloveMaterial = val
        applyglovechams()
    end
})

CBSelfSection:AddDropdown('FFGloveTexture', {
    Text = "ForceField Texture",
    Default = 1,
    Values = {"None", "Pulse", "Web", "Swirl", "Checkers", "Candy Cane", "Shield", "Dots", "Scanning", "Bubbles"},
    Callback = function(val)
        FFGloveTexture = val
        applyglovechams()
    end
})

CBSelfSection:AddLabel("Glove Color"):AddColorPicker("GloveColor", {
    Title = "Glove Color",
    Default = color3rgb(255, 255, 255),
    Transparency = 0,
    Callback = function(val)
    end
})

Options.GloveColor:OnChanged(function()
    GloveColor = Options.GloveColor.Value
    GloveTrans = Options.GloveColor.Transparency
    applyglovechams()
end)

CBSelfSection:AddDivider()

CBSelfSection:AddToggle('SelfChams', {
    Text = "Self Chams",
    Default = false,
    Callback = function(val)
        SelfChams = val
        applyselfchams()
    end
})

CBSelfSection:AddDropdown('SelfMaterial', {
    Text = "Self Material",
    Default = 1,
    Values = {"ForceField", "Plastic", "SmoothPlastic", "Flat", "Glass", "Neon"},
    Callback = function(val)
        SelfMaterial = val
        applyselfchams()
    end
})

CBSelfSection:AddDropdown('FFSelfTexture', {
    Text = "ForceField Texture",
    Default = 1,
    Values = {"None", "Pulse", "Web", "Swirl", "Checkers", "Candy Cane", "Shield", "Dots", "Scanning", "Bubbles"},
    Callback = function(val)
        FFSelfTexture = val
        applyselfchams()
    end
})

CBSelfSection:AddLabel("Self Color"):AddColorPicker("SelfColor", {
    Title = "Self Color",
    Default = color3rgb(255, 255, 255),
    Transparency = 0,
    Callback = function(val)
    end
})

Options.SelfColor:OnChanged(function()
    SelfColor = Options.SelfColor.Value
    SelfTrans = Options.SelfColor.Transparency
    applyselfchams()
end)

ThirdPerson = false

RunService.RenderStepped:Connect(function()
    local CamLook = camera.CFrame.LookVector

    if AntiAim then
        if PitchType == "Custom" then
            replicatedstorage.Events.ControlTurn:FireServer(PitchOffset)
        elseif PitchType == "None" then
            replicatedstorage.Events.ControlTurn:FireServer(CamLook.Y)
        elseif PitchType == "Random" then
            RandomPitch = math.random(-10, 10) / 10
            replicatedstorage.Events.ControlTurn:FireServer(RandomPitch)
        else
            replicatedstorage.Events.ControlTurn:FireServer(Pitches[PitchType])
        end
    end
--end)

--RunService.RenderStepped:Connect(function() -- why the fuck did i add another loop when i can use the one above LMAO
if ThirdPerson then
    localplayer.CameraMinZoomDistance = TPDistance
    localplayer.CameraMaxZoomDistance = TPDistance
else
    localplayer.CameraMinZoomDistance = 0.5
    localplayer.CameraMaxZoomDistance = 0.5
end

if anim then
    anim:AdjustSpeed(AnimSpeed)
end

local Alive = false
local CamLook = camera.CFrame.LookVector
local hrp = nil

if AntiSmoke then
    for i,v in pairs(workspace.Ray_Ignore.Smokes:GetChildren()) do
        if v.Name == "Smoke" then
            v:Destroy()
        end
    end
end

if localplayer.Character and localplayer.Character:FindFirstChild("Humanoid") and localplayer.Character:FindFirstChild("Humanoid").Health > 0 and localplayer.Character:FindFirstChild("UpperTorso") then
	Alive = true
end
if Alive then
    hrp = localplayer.Character.HumanoidRootPart
    -- pasted from a paste (russianware) LULE
    if Bhop and UserInputService:IsKeyDown("Space") then
        if localplayer.Character:FindFirstChild("jumpcd") then
            localplayer.Character.jumpcd:Destroy()
        end

    local vel = Vector3.zero

    if UserInputService:IsKeyDown("W") then
        vel = vel + camera.CFrame.LookVector
    end
    if UserInputService:IsKeyDown("S") then
        vel = vel - camera.CFrame.LookVector
    end
    if UserInputService:IsKeyDown("A") then
        vel = vel - camera.CFrame.RightVector
    end
    if UserInputService:IsKeyDown("D") then
        vel = vel + camera.CFrame.RightVector
    end

    if vel.Magnitude > 0 then
        vel = vector3(vel.X, 0, vel.Z)

        localplayer.Character.HumanoidRootPart.Velocity = (vel.Unit * (BhopSpeed * 1.5)) + vector3(0, localplayer.Character.HumanoidRootPart.Velocity.Y, 0) -- 1
        localplayer.Character.Humanoid.Jump = true
        end
    end
end
    Spin = math.clamp(Spin + SpinSpeed, 0, 360)
    if Spin == 360 then Spin = 0 end

	if AntiAim and Alive then
        localplayer.Character.Humanoid.AutoRotate = false
		local Angle = -math.atan2(CamLook.Z, CamLook.X) + math.rad(-90)
		if YawType == "Spin" then
			Angle = Angle + math.rad(Spin)
		end
		if YawType == "Random" then
			Angle = Angle + math.rad(math.random(0, 360))
		end
		local Offset = math.rad(-YawOffset - (Jitter and JitterOffset or 0))
		local CFramePos = CFrame.new(hrp.Position) * CFrame.Angles(0, Angle + Offset, 0)
		if YawType == "Targets" then
			local part
			local closest = 9999
			for _,plr in pairs(players:GetPlayers()) do
				if plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character:FindFirstChild("Humanoid").Health > 0 and plr.Team ~= LocalPlayer.Team then
					local pos, onScreen = camera:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position)
					local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
					if closest > magnitude then
						part = plr.Character.HumanoidRootPart
						closest = magnitude
					end
				end
			end
			if part ~= nil then
				CFramePos = CFrame.new(hrp.Position, part.Position) * CFrame.Angles(0, Offset, 0)
			end
		end
        hrp.CFrame = YROTATION(CFramePos)
    end
end)

workcamera:GetPropertyChangedSignal("FieldOfView"):Connect(function()
    if workcamera.FieldOfView == FOV then
        return
    else if workcamera.FieldOfView < 75 and not FOV < 75 then -- we don't want to change the fov when zooming with guns with scopes, do we?
        return
    else if workcamera.FieldOfView == 75 then
        workcamera.FieldOfView = FOV
    end
    end
    end
end)

localplayer.Additionals.TotalDamage:GetPropertyChangedSignal("Value"):Connect(function()
    -- pasted from stormy :))
    if Hitsound == "None" then return end

	local hitsound = Instance.new("Sound")
	hitsound.Parent = game:GetService("SoundService")
    if Hitsound == "Custom" then
        hitsound.SoundId = "rbxassetid://" .. CustomHitsound
    else
        hitsound.SoundId = "rbxassetid://" .. Hitsounds[Hitsound]
    end
	hitsound.Volume = HitsoundVolume
	hitsound.PlayOnRemove = true
	hitsound:Destroy()
end)

localplayer.Additionals.OverallKills:GetPropertyChangedSignal("Value"):Connect(function()
    if Killsound == "None" then return end

	local killsound = Instance.new("Sound")
	killsound.Parent = game:GetService("SoundService")
    if Killsound == "Custom" then
        killsound.SoundId = "rbxassetid://" .. CustomKillsound
    else
        killsound.SoundId = "rbxassetid://" .. Killsounds[Killsound]
    end
    killsound.Volume = KillsoundVolume
	killsound.PlayOnRemove = true
	killsound:Destroy()
end)

if workspace:FindFirstChild("Map") and workspace:FindFirstChild("Map"):FindFirstChild("Origin") then
	if workspace.Map.Origin.Value == "de_cache" or workspace.Map.Origin.Value == "de_vertigo" or workspace.Map.Origin.Value == "de_nuke" or workspace.Map.Origin.Value == "de_aztec" then
		oldSkybox = game.Lighting:FindFirstChildOfClass("Sky"):Clone()
	end
end

workspace.ChildAdded:Connect(function(obj)
	if obj.Name == "Map" then
		wait(5)

		if oldSkybox ~= nil then
			oldSkybox:Destroy()
			oldSkybox = nil
		end
		local Origin = workspace:WaitForChild("Map"):WaitForChild("Origin")

		if workspace.Map.Origin.Value == "de_cache" or workspace.Map.Origin.Value == "de_vertigo" or workspace.Map.Origin.Value == "de_nuke" or workspace.Map.Origin.Value == "de_aztec" then
			oldSkybox = game.Lighting:FindFirstChildOfClass("Sky"):Clone()
 
			local sky = ChosenSky
			if sky ~= "none" then
				game.Lighting:FindFirstChildOfClass("Sky"):Destroy()
				local skybox = Instance.new("Sky")
				skybox.SkyboxLf = Skyboxes[sky].SkyboxLf
				skybox.SkyboxBk = Skyboxes[sky].SkyboxBk
				skybox.SkyboxDn = Skyboxes[sky].SkyboxDn
				skybox.SkyboxFt = Skyboxes[sky].SkyboxFt
				skybox.SkyboxRt = Skyboxes[sky].SkyboxRt
				skybox.SkyboxUp = Skyboxes[sky].SkyboxUp
				skybox.Name = "override"
				skybox.Parent = game.Lighting
			end
		else
			local sky = ChosenSky
			if sky ~= "none" then
				local skybox = Instance.new("Sky")
				skybox.SkyboxLf = Skyboxes[sky].SkyboxLf
				skybox.SkyboxBk = Skyboxes[sky].SkyboxBk
				skybox.SkyboxDn = Skyboxes[sky].SkyboxDn
				skybox.SkyboxFt = Skyboxes[sky].SkyboxFt
				skybox.SkyboxRt = Skyboxes[sky].SkyboxRt
				skybox.SkyboxUp = Skyboxes[sky].SkyboxUp
				skybox.Name = "override"
				skybox.Parent = Lighting
			end
		end
	end
end)
game.Lighting.ChildAdded:Connect(function(obj)
    if obj:IsA("Sky") and obj.Name ~= "override" then
		oldSkybox = obj:Clone()
    end
end)
localplayer.CharacterAdded:Connect(function()
    if enableanimation then
        if not localplayer.Character:FindFirstChild("Humanoid") then
            repeat task.wait() until localplayer.Character:FindFirstChild("Humanoid")
        end
        if localplayer.Character:FindFirstChild("Humanoid") then
		    anim = localplayer.Character.Humanoid:LoadAnimation(animation)
		    anim.Priority = Enum.AnimationPriority.Action
		    anim:Play()
            anim:AdjustSpeed(AnimSpeed)
        end
	end
end)

workspace.Status.Rounds:GetPropertyChangedSignal("Value"):Connect(function()
    if RifleFR and workspace.Status.Rounds.Value == 1 then
        for _,v in pairs(weapons:GetChildren()) do
            if v:FindFirstChild("Primary") and not v:FindFirstChild("Melee") and not v:FindFirstChild("Grenade") and not v:FindFirstChild("Equipment2") then
                v.Primary.Name = "Secondary"
                primary = Instance.new("Folder")
                primary.Parent = v
                primary.Name = "Primarybak"
            end
        end
    elseif RifleFR and workspace.Status.Rounds.Value > 1 then
        for _,v in pairs(replicatedstorage.Weapons:GetChildren()) do
            if v:FindFirstChild("Primarybak") and not v:FindFirstChild("Melee") and not v:FindFirstChild("Melee") and not v:FindFirstChild("Grenade") and not v:FindFirstChild("Equipment2") then
                v.Primarybak.Name = "Primary"
                v.Secondary:Destroy()
            end
        end
    end
end)

local FrameTimer = tick()
local FrameCounter = 0;
local FPS = 60;

local WatermarkConnection = game:GetService('RunService').RenderStepped:Connect(function()
    FrameCounter += 1;

    if (tick() - FrameTimer) >= 1 then
        FPS = FrameCounter;
        FrameTimer = tick();
        FrameCounter = 0;
    end;

    Library:SetWatermark(('Shotsetter %s%s fps | %s ms | %s'):format(
        version,
        math.floor(FPS),
        math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue()),
        os.date("%H:%M:%S")
    ));
end);

Library:OnUnload(function()
    WatermarkConnection:Disconnect()

    Library.Unloaded = true
end)

local MenuGroup = SettingsTab:AddLeftGroupbox('Menu')

MenuGroup:AddButton('Unload', function() Library:Unload() Library.UnloadCallback() end)
MenuGroup:AddLabel('Menu Bind'):AddKeyPicker('MenuKeybind', { Default = 'RightShift', NoUI = true, Text = 'Menu keybind' })
MenuGroup:AddToggle('KeybindList', {
    Text = "Keybind List",
    Default = false,
    Callback = function(val)
        Library.KeybindFrame.Visible = val
    end
})

Library.ToggleKeybind = Options.MenuKeybind

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()

SaveManager:SetIgnoreIndexes({'MenuKeybind'})

ThemeManager:SetFolder('Shotsetter')
SaveManager:SetFolder('Shotsetter/Configs')

SaveManager:BuildConfigSection(SettingsTab)

ThemeManager:ApplyToTab(SettingsTab)

SaveManager:LoadAutoloadConfig()

local CreditsSection = SettingsTab:AddRightGroupbox("About")

CreditsSection:AddLabel("\nShotsetter " .. version)
CreditsSection:AddLabel("Created by A1thernex")
CreditsSection:AddLabel("Original (AirHub) by Exunys")
CreditsSection:AddLabel("Some code taken from various")
CreditsSection:AddLabel("cheats, so thanks to them.")
CreditsSection:AddButton({
    Text = "Copy Original Script's GitHub Page",
    Func = function()
        setclipboard("https://github.com/Exunys/AirHub") -- <3
    end
})

local endtime = tick()
local totaltime = math.floor((endtime - starttime) * 10^2) / 10^2 .. "s to load."
Notification.prompt("Information", "Loaded successfully. Took " .. totaltime, 4)
