--[[

	AirHub by Exunys © CC0 1.0 Universal (2023)

	https://github.com/Exunys

]]

local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/xlISInner/NotificationsLibrary/main/Notify.lua"))()
Notification.prompt("Information", "Loading Shotsetter, please wait...", 4)

local starttime = tick()

--// Cache
local game, workspace = game, workspace
local loadstring, getgenv, getsenv, setclipboard, tablefind, camera, UserInputService, RunService = loadstring, getgenv, getsenv, setclipboard, table.find, workspace.CurrentCamera, game:GetService("UserInputService"), game:GetService("RunService")
local localplayer = game.Players.LocalPlayer
local replicatedstorage = game.ReplicatedStorage
--local client = getsenv(localplayer.PlayerGui.Client)

local bodyvel = Instance.new("BodyVelocity")
bodyvel.MaxForce = Vector3.new(math.huge, 0, math.huge)
local animation = Instance.new("Animation")
animation.AnimationId = "rbxassetid://5917459365"
--// Loaded check

if AirHub or AirHubV2Loaded then
    return
end

--// Environment

getgenv().AirHub = {}

--// Load Modules

loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/AirHub/main/Modules/Aimbot.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/AirHub/main/Modules/Wall%20Hack.lua"))()

--// Variables
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/A1thernex/pepsilib-modified/main/main.lua"))()
--local Library = loadstring(game:GetObjects("rbxassetid://7657867786")[1].Source)() -- Pepsi's UI Library
local Aimbot, WallHack = getgenv().AirHub.Aimbot, getgenv().AirHub.WallHack
local Parts, Fonts, TracersType = {"Head", "HumanoidRootPart", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg", "LeftHand", "RightHand", "LeftLowerArm", "RightLowerArm", "LeftUpperArm", "RightUpperArm", "LeftFoot", "LeftLowerLeg", "UpperTorso", "LeftUpperLeg", "RightFoot", "RightLowerLeg", "LowerTorso", "RightUpperLeg"}, {"UI", "System", "Plex", "Monospace"}, {"Bottom", "Center", "Mouse"}
local GodMode = false
local AntiAim = false
local oldSkybox, anim
local AnimSpeed = 1
local Spin = 0
local Mouse = localplayer:GetMouse()
local TPDistance, ThirdPerson = 12, false
local Guns = {"AK47", 'AUG', 'AWP', 'Bizon', 'CZ', 'XM', 'DesertEagle', 'DualBerettas', 'Famas', 'FiveSeven', 'USP', 'G3SG1', 'Galil', 'Glock', 'M249', 'M4A1', 'M4A4', 'MAC10', 'MAG7', 'MP7', 'MP7-SD', 'MP9', 'P90', 'RG', 'R8', 'SG', 'SawedOff', 'Scout', 'Tec9', 'P2000', 'UMP', 'P250', 'Nova', 'Negev'}
local Other = {'Banana', 'Bayonet', 'Bearded Axe', 'Butterfly Knife', 'Smoke Grenade', 'CT Knife', 'Cleaver', 'Crowbar', 'Falchion Knife', 'Flip Knife', 'Gut Knife', 'T Knife', 'Huntsman Knife', 'Karambit', 'Decoy Grenade', 'Flashbang', 'HE Grenade', 'Incendiary Grenade', 'Molotov', 'C4'}
local Everything = {"AK47", 'AUG', 'AWP', 'Bizon', 'CZ', 'XM', 'DesertEagle', 'DualBerettas', 'Famas', 'FiveSeven', 'USP', 'G3SG1', 'Galil', 'Glock', 'M249', 'M4A1', 'M4A4', 'MAC10', 'MAG7', 'MP7', 'MP7-SD', 'MP9', 'P90', 'RG', 'R8', 'SG', 'SawedOff', 'Scout', 'Tec9', 'P2000', 'UMP', 'P250', 'Nova', 'Negev', 'Banana', 'Bayonet', 'Bearded Axe', 'Butterfly Knife', 'Smoke Grenade', 'CT Knife', 'Cleaver', 'Crowbar', 'Falchion Knife', 'Flip Knife', 'Gut Knife', 'T Knife', 'Huntsman Knife', 'Karambit', 'Decoy Grenade', 'Flashbang', 'HE Grenade', 'Incendiary Grenade', 'Molotov', 'C4'}
local Skyboxes = {
    ["Nebula"] = {
		SkyboxLf = "rbxassetid://159454286",
		SkyboxBk = "rbxassetid://159454299",
		SkyboxDn = "rbxassetid://159454296",
		SkyboxFt = "rbxassetid://159454293",
		SkyboxLf = "rbxassetid://159454286",
		SkyboxRt = "rbxassetid://159454300",
		SkyboxUp = "rbxassetid://159454288",
	},
    ["Vaporwave"] = {
		SkyboxLf = "rbxassetid://1417494402",
		SkyboxBk = "rbxassetid://1417494030",
		SkyboxDn = "rbxassetid://1417494146",
		SkyboxFt = "rbxassetid://1417494253",
		SkyboxLf = "rbxassetid://1417494402",
		SkyboxRt = "rbxassetid://1417494499",
		SkyboxUp = "rbxassetid://1417494643",
	},
	["Clouds"] = {
		SkyboxLf = "rbxassetid://570557620",
		SkyboxBk = "rbxassetid://570557514",
		SkyboxDn = "rbxassetid://570557775",
		SkyboxFt = "rbxassetid://570557559",
		SkyboxLf = "rbxassetid://570557620",
		SkyboxRt = "rbxassetid://570557672",
		SkyboxUp = "rbxassetid://570557727",
	},
	["Twilight"] = {
		SkyboxLf = "rbxassetid://264909758",
		SkyboxBk = "rbxassetid://264908339",
		SkyboxDn = "rbxassetid://264907909",
		SkyboxFt = "rbxassetid://264909420",
		SkyboxLf = "rbxassetid://264909758",
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
--{"None", "Nebula", "Pink Sky", "Evening", "Twilight", "Night", "Sunset", "Galaxy", "Clouds", "Vaporwave"}
--{"None", "Baimware", "Bag", "Minecraft EXP", "Skeet", "Neverlose", "Rust", "Bell", "Bubble", "Pick", "Pop", "Minecraft Arrow Hit"}
--{"None", "CS:GO", "Ultra Kill", "Killing Spree"}
--// Actual functions

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

--// God Mode

RunService.RenderStepped:Connect(function()
    if GodMode == true then
        for _,plr in ipairs(game.Players:GetPlayers()) do
            if (plr:FindFirstChild("DamageLogs") and not plr.DamageLogs:FindFirstChild(game.Players.LocalPlayer.Name)) then
                game.ReplicatedStorage.MapVoting.Submit:FireServer(plr, "DamageLogs")
            end
        end
    else
        game.ReplicatedStorage.MapVoting.Submit:FireServer(plr, "")
    end
end)

--// Theme initialization (abandoned)
--[[print("hello")
if isfolder("Pepsi Lib") then
    print("again")
    if not isfolder("Pepsi Lib Themes") then
        makefolder("Pepsi Lib Themes")   
    end
    if isfile("Pepsi Lib/Pepsi Lib Themes/AirHub.txt") and isfile("Pepsi Lib/Pepsi Lib Themes/Shotsetter.txt") then
        print("sdasd")
        return
    else
        writefile("Pepsi Lib/Pepsi Lib Themes/AirHub.txt", '{"__Designer.Colors.topGradient":"3F0C64","__Designer.Colors.section":"C259FB","__Designer.Colors.hoveredOptionBottom":"4819B4","__Designer.Background.ImageAssetID":"rbxassetid://4427304036","__Designer.Colors.selectedOption":"4E149C","__Designer.Colors.unselectedOption":"482271","__Designer.Files.WorkspaceFile":"AirHub","__Designer.Colors.unhoveredOptionTop":"310269","__Designer.Colors.outerBorder":"391D57","__Designer.Background.ImageColor":"69009C","__Designer.Colors.tabText":"B9B9B9","__Designer.Colors.elementBorder":"160B24","__Designer.Background.ImageTransparency":100,"__Designer.Colors.background":"1E1237","__Designer.Colors.innerBorder":"531E79","__Designer.Colors.bottomGradient":"361A60","__Designer.Colors.sectionBackground":"21002C","__Designer.Colors.hoveredOptionTop":"6B10F9","__Designer.Colors.otherElementText":"7B44A8","__Designer.Colors.main":"AB26FF","__Designer.Colors.elementText":"9F7DB5","__Designer.Colors.unhoveredOptionBottom":"3E0088","__Designer.Background.UseBackgroundImage":false}')
        writefile("Pepsi Lib/Pepsi Lib Themes/Shotsetter.txt", '{"__Designer.Colors.topGradient":"343434","__Designer.Settings.ShowHideKey":"Enum.KeyCode.RightShift","__Designer.Colors.section":"FFFFFF","__Designer.Colors.hoveredOptionBottom":"4819B4","__Designer.Background.ImageAssetID":"rbxassetid://4427304036","__Designer.Colors.selectedOption":"4E149C","__Designer.Colors.unselectedOption":"482271","__Designer.Files.WorkspaceFile":"AirHub","__Designer.Colors.unhoveredOptionTop":"310269","__Designer.Colors.outerBorder":"000000","__Designer.Background.ImageColor":"69009C","__Designer.Colors.tabText":"B9B9B9","__Designer.Colors.elementBorder":"000000","__Designer.Colors.sectionBackground":"121212","__Designer.Colors.innerBorder":"4E4E4E","__Designer.Background.ImageTransparency":100,"__Designer.Colors.bottomGradient":"0D0D0D","__Designer.Colors.elementText":"FFFFFF","__Designer.Colors.hoveredOptionTop":"FF0083","__Designer.Colors.otherElementText":"FFFFFF","__Designer.Colors.main":"F8F8F8","__Designer.Colors.background":"161616","__Designer.Colors.unhoveredOptionBottom":"3E0088","__Designer.Background.UseBackgroundImage":false}')
    end
else
    makefolder("Pepsi Lib")
    makefolder("Pepsi Lib/Pepsi Lib Themes")
    writefile("Pepsi Lib/Pepsi Lib Themes/AirHub.txt", '{"__Designer.Colors.topGradient":"3F0C64","__Designer.Colors.section":"C259FB","__Designer.Colors.hoveredOptionBottom":"4819B4","__Designer.Background.ImageAssetID":"rbxassetid://4427304036","__Designer.Colors.selectedOption":"4E149C","__Designer.Colors.unselectedOption":"482271","__Designer.Files.WorkspaceFile":"AirHub","__Designer.Colors.unhoveredOptionTop":"310269","__Designer.Colors.outerBorder":"391D57","__Designer.Background.ImageColor":"69009C","__Designer.Colors.tabText":"B9B9B9","__Designer.Colors.elementBorder":"160B24","__Designer.Background.ImageTransparency":100,"__Designer.Colors.background":"1E1237","__Designer.Colors.innerBorder":"531E79","__Designer.Colors.bottomGradient":"361A60","__Designer.Colors.sectionBackground":"21002C","__Designer.Colors.hoveredOptionTop":"6B10F9","__Designer.Colors.otherElementText":"7B44A8","__Designer.Colors.main":"AB26FF","__Designer.Colors.elementText":"9F7DB5","__Designer.Colors.unhoveredOptionBottom":"3E0088","__Designer.Background.UseBackgroundImage":false}')
    writefile("Pepsi Lib/Pepsi Lib Themes/Shotsetter.txt", '{"__Designer.Colors.topGradient":"343434","__Designer.Settings.ShowHideKey":"Enum.KeyCode.RightShift","__Designer.Colors.section":"FFFFFF","__Designer.Colors.hoveredOptionBottom":"4819B4","__Designer.Background.ImageAssetID":"rbxassetid://4427304036","__Designer.Colors.selectedOption":"4E149C","__Designer.Colors.unselectedOption":"482271","__Designer.Files.WorkspaceFile":"AirHub","__Designer.Colors.unhoveredOptionTop":"310269","__Designer.Colors.outerBorder":"000000","__Designer.Background.ImageColor":"69009C","__Designer.Colors.tabText":"B9B9B9","__Designer.Colors.elementBorder":"000000","__Designer.Colors.sectionBackground":"121212","__Designer.Colors.innerBorder":"4E4E4E","__Designer.Background.ImageTransparency":100,"__Designer.Colors.bottomGradient":"0D0D0D","__Designer.Colors.elementText":"FFFFFF","__Designer.Colors.hoveredOptionTop":"FF0083","__Designer.Colors.otherElementText":"FFFFFF","__Designer.Colors.main":"F8F8F8","__Designer.Colors.background":"161616","__Designer.Colors.unhoveredOptionBottom":"3E0088","__Designer.Background.UseBackgroundImage":false}')
end]]
--// Frame

Library.UnloadCallback = function()
	Aimbot.Functions:Exit()
	WallHack.Functions:Exit()
	getgenv().AirHub = nil
end

local MainFrame = Library:CreateWindow({
	Name = "Shotsetter",
	Themeable = {
		--Image = "7059346386",
        Info = {'Original (AirHub) by Exunys', 'Made by A1thernex', 'Some code taken from stormy.so-', 'lutions', "Powered by Pepsi's UI Library"},
		--Info = "\n\n\nOriginal (AirHub) by Exunys\nMade by A1thernex\nSome code taken from\nstormy.solutions\nPowered by Pepsi's UI Library",
		Credit = false
	},
	Background = "",
    Theme = [[{"__Designer.Colors.topGradient":"343434","__Designer.Settings.ShowHideKey":"Enum.KeyCode.RightShift","__Designer.Colors.section":"FFFFFF","__Designer.Colors.hoveredOptionBottom":"303030","__Designer.Background.ImageAssetID":"rbxassetid://4427304036","__Designer.Colors.selectedOption":"403F3F","__Designer.Colors.unselectedOption":"3A3A3A","__Designer.Files.WorkspaceFile":"AirHub","__Designer.Colors.unhoveredOptionTop":"414141","__Designer.Colors.outerBorder":"000000","__Designer.Background.ImageColor":"69009C","__Designer.Colors.tabText":"DBDADA","__Designer.Colors.elementBorder":"000000","__Designer.Colors.sectionBackground":"121212","__Designer.Colors.innerBorder":"525252","__Designer.Background.ImageTransparency":100,"__Designer.Colors.bottomGradient":"0D0D0D","__Designer.Colors.elementText":"FFFFFF","__Designer.Colors.hoveredOptionTop":"666666","__Designer.Colors.otherElementText":"FFFFFF","__Designer.Colors.main":"FFFFFF","__Designer.Colors.background":"161616","__Designer.Colors.unhoveredOptionBottom":"212121","__Designer.Background.UseBackgroundImage":false}]]
    -- airhub default theme
	--Theme = [[{"__Designer.Colors.topGradient":"3F0C64","__Designer.Colors.section":"C259FB","__Designer.Colors.hoveredOptionBottom":"4819B4","__Designer.Background.ImageAssetID":"rbxassetid://4427304036","__Designer.Colors.selectedOption":"4E149C","__Designer.Colors.unselectedOption":"482271","__Designer.Files.WorkspaceFile":"AirHub","__Designer.Colors.unhoveredOptionTop":"310269","__Designer.Colors.outerBorder":"391D57","__Designer.Background.ImageColor":"69009C","__Designer.Colors.tabText":"B9B9B9","__Designer.Colors.elementBorder":"160B24","__Designer.Background.ImageTransparency":100,"__Designer.Colors.background":"1E1237","__Designer.Colors.innerBorder":"531E79","__Designer.Colors.bottomGradient":"361A60","__Designer.Colors.sectionBackground":"21002C","__Designer.Colors.hoveredOptionTop":"6B10F9","__Designer.Colors.otherElementText":"7B44A8","__Designer.Colors.main":"AB26FF","__Designer.Colors.elementText":"9F7DB5","__Designer.Colors.unhoveredOptionBottom":"3E0088","__Designer.Background.UseBackgroundImage":false}]]
})

--// Tabs

local AimbotTab = MainFrame:CreateTab({
	Name = "Aimbot"
})

local VisualsTab = MainFrame:CreateTab({
	Name = "Visuals"
})

local CrosshairTab = MainFrame:CreateTab({
	Name = "Crosshair"
})

local CBTab = MainFrame:CreateTab({
	Name = "CB"
})

local FunctionsTab = MainFrame:CreateTab({
	Name = "Functions"
})

--// Aimbot Sections

local Values = AimbotTab:CreateSection({
	Name = "Values"
})

local Checks = AimbotTab:CreateSection({
	Name = "Checks"
})

local ThirdPerson = AimbotTab:CreateSection({
	Name = "Third Person"
})

local FOV_Values = AimbotTab:CreateSection({
	Name = "Field Of View",
	Side = "Right"
})

local FOV_Appearance = AimbotTab:CreateSection({
	Name = "FOV Circle Appearance",
	Side = "Right"
})

--// Visuals Sections

local WallHackChecks = VisualsTab:CreateSection({
	Name = "Checks"
})

local ESPSettings = VisualsTab:CreateSection({
	Name = "ESP Settings"
})

local BoxesSettings = VisualsTab:CreateSection({
	Name = "Boxes Settings"
})

local ChamsSettings = VisualsTab:CreateSection({
	Name = "Chams Settings"
})

local TracersSettings = VisualsTab:CreateSection({
	Name = "Tracers Settings",
	Side = "Right"
})

local HeadDotsSettings = VisualsTab:CreateSection({
	Name = "Head Dots Settings",
	Side = "Right"
})

local HealthBarSettings = VisualsTab:CreateSection({
	Name = "Health Bar Settings",
	Side = "Right"
})

--// Crosshair Sections

local CrosshairSettings = CrosshairTab:CreateSection({
	Name = "Settings"
})

local CrosshairSettings_CenterDot = CrosshairTab:CreateSection({
	Name = "Center Dot Settings",
	Side = "Right"
})

--// CB Sections

local CBModsSection = CBTab:CreateSection({
	Name = "Modifications",
    Side = 'Left'
})

local CBExploitsSection = CBTab:CreateSection({
	Name = "Exploits",
    Side = 'Left'
})

local CBAASection = CBTab:CreateSection({
    Name = "Anti-Aim",
    Side = 'Left'
})

local CBVisualSection = CBTab:CreateSection({
	Name = "Visual",
    Side = 'Right'
})

local CBOtherSection = CBTab:CreateSection({
	Name = "Other",
    Side = 'Right'
})

--// Functions Sections

local FunctionsSection = FunctionsTab:CreateSection({
	Name = "Functions"
})

--// Aimbot Values

Values:AddToggle({
	Name = "Enabled",
	Value = Aimbot.Settings.Enabled,
	Callback = function(New, Old)
		Aimbot.Settings.Enabled = New
	end
}).Default = Aimbot.Settings.Enabled

Values:AddToggle({
	Name = "Toggle",
	Value = Aimbot.Settings.Toggle,
	Callback = function(New, Old)
		Aimbot.Settings.Toggle = New
	end
}).Default = Aimbot.Settings.Toggle

Aimbot.Settings.LockPart = Parts[1]; Values:AddDropdown({
	Name = "Lock Part",
	Value = Parts[1],
	Callback = function(New, Old)
		Aimbot.Settings.LockPart = New
	end,
	List = Parts,
	Nothing = "Head"
}).Default = Parts[1]

Values:AddTextbox({ -- Using a Textbox instead of a Keybind because the UI Library doesn't support Mouse inputs like Left Click / Right Click...
	Name = "Hotkey",
	Value = Aimbot.Settings.TriggerKey,
	Callback = function(New, Old)
		Aimbot.Settings.TriggerKey = New
	end
}).Default = Aimbot.Settings.TriggerKey

--[[
Values:AddKeybind({
	Name = "Hotkey",
	Value = Aimbot.Settings.TriggerKey,
	Callback = function(New, Old)
		Aimbot.Settings.TriggerKey = stringmatch(tostring(New), "Enum%.[UserInputType]*[KeyCode]*%.(.+)")
	end,
}).Default = Aimbot.Settings.TriggerKey
]]

Values:AddSlider({
	Name = "Sensitivity",
	Value = Aimbot.Settings.Sensitivity,
	Callback = function(New, Old)
		Aimbot.Settings.Sensitivity = New
	end,
	Min = 0,
	Max = 1,
	Decimals = 2
}).Default = Aimbot.Settings.Sensitivity

--// Aimbot Checks

Checks:AddToggle({
	Name = "Team Check",
	Value = Aimbot.Settings.TeamCheck,
	Callback = function(New, Old)
		Aimbot.Settings.TeamCheck = New
	end
}).Default = Aimbot.Settings.TeamCheck

Checks:AddToggle({
	Name = "Wall Check",
	Value = Aimbot.Settings.WallCheck,
	Callback = function(New, Old)
		Aimbot.Settings.WallCheck = New
	end
}).Default = Aimbot.Settings.WallCheck

Checks:AddToggle({
	Name = "Alive Check",
	Value = Aimbot.Settings.AliveCheck,
	Callback = function(New, Old)
		Aimbot.Settings.AliveCheck = New
	end
}).Default = Aimbot.Settings.AliveCheck

--// Aimbot ThirdPerson

ThirdPerson:AddToggle({
	Name = "Enable Third Person",
	Value = Aimbot.Settings.ThirdPerson,
	Callback = function(New, Old)
		Aimbot.Settings.ThirdPerson = New
	end
}).Default = Aimbot.Settings.ThirdPerson

ThirdPerson:AddSlider({
	Name = "Sensitivity",
	Value = Aimbot.Settings.ThirdPersonSensitivity,
	Callback = function(New, Old)
		Aimbot.Settings.ThirdPersonSensitivity = New
	end,
	Min = 0.1,
	Max = 5,
	Decimals = 1
}).Default = Aimbot.Settings.ThirdPersonSensitivity

--// FOV Settings Values

FOV_Values:AddToggle({
	Name = "Enabled",
	Value = Aimbot.FOVSettings.Enabled,
	Callback = function(New, Old)
		Aimbot.FOVSettings.Enabled = New
	end
}).Default = Aimbot.FOVSettings.Enabled

FOV_Values:AddToggle({
	Name = "Visible",
	Value = Aimbot.FOVSettings.Visible,
	Callback = function(New, Old)
		Aimbot.FOVSettings.Visible = New
	end
}).Default = Aimbot.FOVSettings.Visible

FOV_Values:AddSlider({
	Name = "Amount",
	Value = Aimbot.FOVSettings.Amount,
	Callback = function(New, Old)
		Aimbot.FOVSettings.Amount = New
	end,
	Min = 10,
	Max = 300
}).Default = Aimbot.FOVSettings.Amount

--// FOV Settings Appearance

FOV_Appearance:AddToggle({
	Name = "Filled",
	Value = Aimbot.FOVSettings.Filled,
	Callback = function(New, Old)
		Aimbot.FOVSettings.Filled = New
	end
}).Default = Aimbot.FOVSettings.Filled

FOV_Appearance:AddSlider({
	Name = "Transparency",
	Value = Aimbot.FOVSettings.Transparency,
	Callback = function(New, Old)
		Aimbot.FOVSettings.Transparency = New
	end,
	Min = 0,
	Max = 1,
	Decimal = 1
}).Default = Aimbot.FOVSettings.Transparency

FOV_Appearance:AddSlider({
	Name = "Sides",
	Value = Aimbot.FOVSettings.Sides,
	Callback = function(New, Old)
		Aimbot.FOVSettings.Sides = New
	end,
	Min = 3,
	Max = 60
}).Default = Aimbot.FOVSettings.Sides

FOV_Appearance:AddSlider({
	Name = "Thickness",
	Value = Aimbot.FOVSettings.Thickness,
	Callback = function(New, Old)
		Aimbot.FOVSettings.Thickness = New
	end,
	Min = 1,
	Max = 50
}).Default = Aimbot.FOVSettings.Thickness

FOV_Appearance:AddColorpicker({
	Name = "Color",
	Value = Aimbot.FOVSettings.Color,
	Callback = function(New, Old)
		Aimbot.FOVSettings.Color = New
	end
}).Default = Aimbot.FOVSettings.Color

FOV_Appearance:AddColorpicker({
	Name = "Locked Color",
	Value = Aimbot.FOVSettings.LockedColor,
	Callback = function(New, Old)
		Aimbot.FOVSettings.LockedColor = New
	end
}).Default = Aimbot.FOVSettings.LockedColor

--// Wall Hack Settings

WallHackChecks:AddToggle({
	Name = "Enabled",
	Value = WallHack.Settings.Enabled,
	Callback = function(New, Old)
		WallHack.Settings.Enabled = New
	end
}).Default = WallHack.Settings.Enabled

WallHackChecks:AddToggle({
	Name = "Team Check",
	Value = WallHack.Settings.TeamCheck,
	Callback = function(New, Old)
		WallHack.Settings.TeamCheck = New
	end
}).Default = WallHack.Settings.TeamCheck

WallHackChecks:AddToggle({
	Name = "Alive Check",
	Value = WallHack.Settings.AliveCheck,
	Callback = function(New, Old)
		WallHack.Settings.AliveCheck = New
	end
}).Default = WallHack.Settings.AliveCheck

--// Visuals Settings

ESPSettings:AddToggle({
	Name = "Enabled",
	Value = WallHack.Visuals.ESPSettings.Enabled,
	Callback = function(New, Old)
		WallHack.Visuals.ESPSettings.Enabled = New
	end
}).Default = WallHack.Visuals.ESPSettings.Enabled

ESPSettings:AddToggle({
	Name = "Outline",
	Value = WallHack.Visuals.ESPSettings.Outline,
	Callback = function(New, Old)
		WallHack.Visuals.ESPSettings.Outline = New
	end
}).Default = WallHack.Visuals.ESPSettings.Outline

ESPSettings:AddToggle({
	Name = "Display Distance",
	Value = WallHack.Visuals.ESPSettings.DisplayDistance,
	Callback = function(New, Old)
		WallHack.Visuals.ESPSettings.DisplayDistance = New
	end
}).Default = WallHack.Visuals.ESPSettings.DisplayDistance

ESPSettings:AddToggle({
	Name = "Display Health",
	Value = WallHack.Visuals.ESPSettings.DisplayHealth,
	Callback = function(New, Old)
		WallHack.Visuals.ESPSettings.DisplayHealth = New
	end
}).Default = WallHack.Visuals.ESPSettings.DisplayHealth

ESPSettings:AddToggle({
	Name = "Display Name",
	Value = WallHack.Visuals.ESPSettings.DisplayName,
	Callback = function(New, Old)
		WallHack.Visuals.ESPSettings.DisplayName = New
	end
}).Default = WallHack.Visuals.ESPSettings.DisplayName

ESPSettings:AddSlider({
	Name = "Offset",
	Value = WallHack.Visuals.ESPSettings.Offset,
	Callback = function(New, Old)
		WallHack.Visuals.ESPSettings.Offset = New
	end,
	Min = -30,
	Max = 30
}).Default = WallHack.Visuals.ESPSettings.Offset

ESPSettings:AddColorpicker({
	Name = "Text Color",
	Value = WallHack.Visuals.ESPSettings.TextColor,
	Callback = function(New, Old)
		WallHack.Visuals.ESPSettings.TextColor = New
	end
}).Default = WallHack.Visuals.ESPSettings.TextColor

ESPSettings:AddColorpicker({
	Name = "Outline Color",
	Value = WallHack.Visuals.ESPSettings.OutlineColor,
	Callback = function(New, Old)
		WallHack.Visuals.ESPSettings.OutlineColor = New
	end
}).Default = WallHack.Visuals.ESPSettings.OutlineColor

ESPSettings:AddSlider({
	Name = "Text Transparency",
	Value = WallHack.Visuals.ESPSettings.TextTransparency,
	Callback = function(New, Old)
		WallHack.Visuals.ESPSettings.TextTransparency = New
	end,
	Min = 0,
	Max = 1,
	Decimals = 2
}).Default = WallHack.Visuals.ESPSettings.TextTransparency

ESPSettings:AddSlider({
	Name = "Text Size",
	Value = WallHack.Visuals.ESPSettings.TextSize,
	Callback = function(New, Old)
		WallHack.Visuals.ESPSettings.TextSize = New
	end,
	Min = 8,
	Max = 24
}).Default = WallHack.Visuals.ESPSettings.TextSize

ESPSettings:AddDropdown({
	Name = "Text Font",
	Value = Fonts[WallHack.Visuals.ESPSettings.TextFont + 1],
	Callback = function(New, Old)
		WallHack.Visuals.ESPSettings.TextFont = Drawing.Fonts[New]
	end,
	List = Fonts,
	Nothing = "UI"
}).Default = Fonts[WallHack.Visuals.ESPSettings.TextFont + 1]

BoxesSettings:AddToggle({
	Name = "Enabled",
	Value = WallHack.Visuals.BoxSettings.Enabled,
	Callback = function(New, Old)
		WallHack.Visuals.BoxSettings.Enabled = New
	end
}).Default = WallHack.Visuals.BoxSettings.Enabled

BoxesSettings:AddSlider({
	Name = "Transparency",
	Value = WallHack.Visuals.BoxSettings.Transparency,
	Callback = function(New, Old)
		WallHack.Visuals.BoxSettings.Transparency = New
	end,
	Min = 0,
	Max = 1,
	Decimals = 2
}).Default = WallHack.Visuals.BoxSettings.Transparency

BoxesSettings:AddSlider({
	Name = "Thickness",
	Value = WallHack.Visuals.BoxSettings.Thickness,
	Callback = function(New, Old)
		WallHack.Visuals.BoxSettings.Thickness = New
	end,
	Min = 1,
	Max = 5
}).Default = WallHack.Visuals.BoxSettings.Thickness

BoxesSettings:AddSlider({
	Name = "Scale Increase (For 3D)",
	Value = WallHack.Visuals.BoxSettings.Increase,
	Callback = function(New, Old)
		WallHack.Visuals.BoxSettings.Increase = New
	end,
	Min = 1,
	Max = 5
}).Default = WallHack.Visuals.BoxSettings.Increase

BoxesSettings:AddColorpicker({
	Name = "Color",
	Value = WallHack.Visuals.BoxSettings.Color,
	Callback = function(New, Old)
		WallHack.Visuals.BoxSettings.Color = New
	end
}).Default = WallHack.Visuals.BoxSettings.Color

BoxesSettings:AddDropdown({
	Name = "Type",
	Value = WallHack.Visuals.BoxSettings.Type == 1 and "3D" or "2D",
	Callback = function(New, Old)
		WallHack.Visuals.BoxSettings.Type = New == "3D" and 1 or 2
	end,
	List = {"3D", "2D"},
	Nothing = "3D"
}).Default = WallHack.Visuals.BoxSettings.Type == 1 and "3D" or "2D"

BoxesSettings:AddToggle({
	Name = "Filled (2D Square)",
	Value = WallHack.Visuals.BoxSettings.Filled,
	Callback = function(New, Old)
		WallHack.Visuals.BoxSettings.Filled = New
	end
}).Default = WallHack.Visuals.BoxSettings.Filled

ChamsSettings:AddToggle({
	Name = "Enabled",
	Value = WallHack.Visuals.ChamsSettings.Enabled,
	Callback = function(New, Old)
		WallHack.Visuals.ChamsSettings.Enabled = New
	end
}).Default = WallHack.Visuals.ChamsSettings.Enabled

ChamsSettings:AddToggle({
	Name = "Filled",
	Value = WallHack.Visuals.ChamsSettings.Filled,
	Callback = function(New, Old)
		WallHack.Visuals.ChamsSettings.Filled = New
	end
}).Default = WallHack.Visuals.ChamsSettings.Filled

ChamsSettings:AddToggle({
	Name = "Entire Body (For R15 Rigs)",
	Value = WallHack.Visuals.ChamsSettings.EntireBody,
	Callback = function(New, Old)
		WallHack.Visuals.ChamsSettings.EntireBody = New
	end
}).Default = WallHack.Visuals.ChamsSettings.EntireBody

ChamsSettings:AddSlider({
	Name = "Transparency",
	Value = WallHack.Visuals.ChamsSettings.Transparency,
	Callback = function(New, Old)
		WallHack.Visuals.ChamsSettings.Transparency = New
	end,
	Min = 0,
	Max = 1,
	Decimals = 2
}).Default = WallHack.Visuals.ChamsSettings.Transparency

ChamsSettings:AddSlider({
	Name = "Thickness",
	Value = WallHack.Visuals.ChamsSettings.Thickness,
	Callback = function(New, Old)
		WallHack.Visuals.ChamsSettings.Thickness = New
	end,
	Min = 0,
	Max = 3
}).Default = WallHack.Visuals.ChamsSettings.Thickness

ChamsSettings:AddColorpicker({
	Name = "Color",
	Value = WallHack.Visuals.ChamsSettings.Color,
	Callback = function(New, Old)
		WallHack.Visuals.ChamsSettings.Color = New
	end
}).Default = WallHack.Visuals.ChamsSettings.Color

TracersSettings:AddToggle({
	Name = "Enabled",
	Value = WallHack.Visuals.TracersSettings.Enabled,
	Callback = function(New, Old)
		WallHack.Visuals.TracersSettings.Enabled = New
	end
}).Default = WallHack.Visuals.TracersSettings.Enabled

TracersSettings:AddSlider({
	Name = "Transparency",
	Value = WallHack.Visuals.TracersSettings.Transparency,
	Callback = function(New, Old)
		WallHack.Visuals.TracersSettings.Transparency = New
	end,
	Min = 0,
	Max = 1,
	Decimals = 2
}).Default = WallHack.Visuals.TracersSettings.Transparency

TracersSettings:AddSlider({
	Name = "Thickness",
	Value = WallHack.Visuals.TracersSettings.Thickness,
	Callback = function(New, Old)
		WallHack.Visuals.TracersSettings.Thickness = New
	end,
	Min = 1,
	Max = 5
}).Default = WallHack.Visuals.TracersSettings.Thickness

TracersSettings:AddColorpicker({
	Name = "Color",
	Value = WallHack.Visuals.TracersSettings.Color,
	Callback = function(New, Old)
		WallHack.Visuals.TracersSettings.Color = New
	end
}).Default = WallHack.Visuals.TracersSettings.Color

TracersSettings:AddDropdown({
	Name = "Start From",
	Value = TracersType[WallHack.Visuals.TracersSettings.Type],
	Callback = function(New, Old)
		WallHack.Visuals.TracersSettings.Type = tablefind(TracersType, New)
	end,
	List = TracersType,
	Nothing = "Bottom"
}).Default = Fonts[WallHack.Visuals.TracersSettings.Type + 1]

HeadDotsSettings:AddToggle({
	Name = "Enabled",
	Value = WallHack.Visuals.HeadDotSettings.Enabled,
	Callback = function(New, Old)
		WallHack.Visuals.HeadDotSettings.Enabled = New
	end
}).Default = WallHack.Visuals.HeadDotSettings.Enabled

HeadDotsSettings:AddToggle({
	Name = "Filled",
	Value = WallHack.Visuals.HeadDotSettings.Filled,
	Callback = function(New, Old)
		WallHack.Visuals.HeadDotSettings.Filled = New
	end
}).Default = WallHack.Visuals.HeadDotSettings.Filled

HeadDotsSettings:AddSlider({
	Name = "Transparency",
	Value = WallHack.Visuals.HeadDotSettings.Transparency,
	Callback = function(New, Old)
		WallHack.Visuals.HeadDotSettings.Transparency = New
	end,
	Min = 0,
	Max = 1,
	Decimals = 2
}).Default = WallHack.Visuals.HeadDotSettings.Transparency

HeadDotsSettings:AddSlider({
	Name = "Thickness",
	Value = WallHack.Visuals.HeadDotSettings.Thickness,
	Callback = function(New, Old)
		WallHack.Visuals.HeadDotSettings.Thickness = New
	end,
	Min = 1,
	Max = 5
}).Default = WallHack.Visuals.HeadDotSettings.Thickness

HeadDotsSettings:AddSlider({
	Name = "Sides",
	Value = WallHack.Visuals.HeadDotSettings.Sides,
	Callback = function(New, Old)
		WallHack.Visuals.HeadDotSettings.Sides = New
	end,
	Min = 3,
	Max = 60
}).Default = WallHack.Visuals.HeadDotSettings.Sides

HeadDotsSettings:AddColorpicker({
	Name = "Color",
	Value = WallHack.Visuals.HeadDotSettings.Color,
	Callback = function(New, Old)
		WallHack.Visuals.HeadDotSettings.Color = New
	end
}).Default = WallHack.Visuals.HeadDotSettings.Color

HealthBarSettings:AddToggle({
	Name = "Enabled",
	Value = WallHack.Visuals.HealthBarSettings.Enabled,
	Callback = function(New, Old)
		WallHack.Visuals.HealthBarSettings.Enabled = New
	end
}).Default = WallHack.Visuals.HealthBarSettings.Enabled

HealthBarSettings:AddDropdown({
	Name = "Position",
	Value = WallHack.Visuals.HealthBarSettings.Type == 1 and "Top" or WallHack.Visuals.HealthBarSettings.Type == 2 and "Bottom" or WallHack.Visuals.HealthBarSettings.Type == 3 and "Left" or "Right",
	Callback = function(New, Old)
		WallHack.Visuals.HealthBarSettings.Type = New == "Top" and 1 or New == "Bottom" and 2 or New == "Left" and 3 or 4
	end,
	List = {"Top", "Bottom", "Left", "Right"},
	Nothing = "Left"
}).Default = WallHack.Visuals.HealthBarSettings.Type == 1 and "Top" or WallHack.Visuals.HealthBarSettings.Type == 2 and "Bottom" or WallHack.Visuals.HealthBarSettings.Type == 3 and "Left" or "Right"

HealthBarSettings:AddSlider({
	Name = "Transparency",
	Value = WallHack.Visuals.HealthBarSettings.Transparency,
	Callback = function(New, Old)
		WallHack.Visuals.HealthBarSettings.Transparency = New
	end,
	Min = 0,
	Max = 1,
	Decimals = 2
}).Default = WallHack.Visuals.HealthBarSettings.Transparency

HealthBarSettings:AddSlider({
	Name = "Size",
	Value = WallHack.Visuals.HealthBarSettings.Size,
	Callback = function(New, Old)
		WallHack.Visuals.HealthBarSettings.Size = New
	end,
	Min = 2,
	Max = 10
}).Default = WallHack.Visuals.HealthBarSettings.Size

HealthBarSettings:AddSlider({
	Name = "Blue",
	Value = WallHack.Visuals.HealthBarSettings.Blue,
	Callback = function(New, Old)
		WallHack.Visuals.HealthBarSettings.Blue = New
	end,
	Min = 0,
	Max = 255
}).Default = WallHack.Visuals.HealthBarSettings.Blue

HealthBarSettings:AddSlider({
	Name = "Offset",
	Value = WallHack.Visuals.HealthBarSettings.Offset,
	Callback = function(New, Old)
		WallHack.Visuals.HealthBarSettings.Offset = New
	end,
	Min = -30,
	Max = 30
}).Default = WallHack.Visuals.HealthBarSettings.Offset

HealthBarSettings:AddColorpicker({
	Name = "Outline Color",
	Value = WallHack.Visuals.HealthBarSettings.OutlineColor,
	Callback = function(New, Old)
		WallHack.Visuals.HealthBarSettings.OutlineColor = New
	end
}).Default = WallHack.Visuals.HealthBarSettings.OutlineColor

--// Crosshair Settings

CrosshairSettings:AddToggle({
	Name = "Mouse Cursor",
	Value = UserInputService.MouseIconEnabled,
	Callback = function(New, Old)
		UserInputService.MouseIconEnabled = New
	end
}).Default = UserInputService.MouseIconEnabled

CrosshairSettings:AddToggle({
	Name = "Enabled",
	Value = WallHack.Crosshair.Settings.Enabled,
	Callback = function(New, Old)
		WallHack.Crosshair.Settings.Enabled = New
	end
}).Default = WallHack.Crosshair.Settings.Enabled

CrosshairSettings:AddColorpicker({
	Name = "Color",
	Value = WallHack.Crosshair.Settings.Color,
	Callback = function(New, Old)
		WallHack.Crosshair.Settings.Color = New
	end
}).Default = WallHack.Crosshair.Settings.Color

CrosshairSettings:AddSlider({
	Name = "Transparency",
	Value = WallHack.Crosshair.Settings.Transparency,
	Callback = function(New, Old)
		WallHack.Crosshair.Settings.Transparency = New
	end,
	Min = 0,
	Max = 1,
	Decimals = 2
}).Default = WallHack.Crosshair.Settings.Transparency

CrosshairSettings:AddSlider({
	Name = "Size",
	Value = WallHack.Crosshair.Settings.Size,
	Callback = function(New, Old)
		WallHack.Crosshair.Settings.Size = New
	end,
	Min = 8,
	Max = 24
}).Default = WallHack.Crosshair.Settings.Size

CrosshairSettings:AddSlider({
	Name = "Thickness",
	Value = WallHack.Crosshair.Settings.Thickness,
	Callback = function(New, Old)
		WallHack.Crosshair.Settings.Thickness = New
	end,
	Min = 1,
	Max = 5
}).Default = WallHack.Crosshair.Settings.Thickness

CrosshairSettings:AddSlider({
	Name = "Gap Size",
	Value = WallHack.Crosshair.Settings.GapSize,
	Callback = function(New, Old)
		WallHack.Crosshair.Settings.GapSize = New
	end,
	Min = 0,
	Max = 20
}).Default = WallHack.Crosshair.Settings.GapSize

CrosshairSettings:AddSlider({
	Name = "Rotation (Degrees)",
	Value = WallHack.Crosshair.Settings.Rotation,
	Callback = function(New, Old)
		WallHack.Crosshair.Settings.Rotation = New
	end,
	Min = -180,
	Max = 180
}).Default = WallHack.Crosshair.Settings.Rotation

CrosshairSettings:AddDropdown({
	Name = "Position",
	Value = WallHack.Crosshair.Settings.Type == 1 and "Mouse" or "Center",
	Callback = function(New, Old)
		WallHack.Crosshair.Settings.Type = New == "Mouse" and 1 or 2
	end,
	List = {"Mouse", "Center"},
	Nothing = "Mouse"
}).Default = WallHack.Crosshair.Settings.Type == 1 and "Mouse" or "Center"

CrosshairSettings_CenterDot:AddToggle({
	Name = "Center Dot",
	Value = WallHack.Crosshair.Settings.CenterDot,
	Callback = function(New, Old)
		WallHack.Crosshair.Settings.CenterDot = New
	end
}).Default = WallHack.Crosshair.Settings.CenterDot

CrosshairSettings_CenterDot:AddColorpicker({
	Name = "Center Dot Color",
	Value = WallHack.Crosshair.Settings.CenterDotColor,
	Callback = function(New, Old)
		WallHack.Crosshair.Settings.CenterDotColor = New
	end
}).Default = WallHack.Crosshair.Settings.CenterDotColor

CrosshairSettings_CenterDot:AddSlider({
	Name = "Center Dot Size",
	Value = WallHack.Crosshair.Settings.CenterDotSize,
	Callback = function(New, Old)
		WallHack.Crosshair.Settings.CenterDotSize = New
	end,
	Min = 1,
	Max = 6
}).Default = WallHack.Crosshair.Settings.CenterDotSize

CrosshairSettings_CenterDot:AddSlider({
	Name = "Center Dot Transparency",
	Value = WallHack.Crosshair.Settings.CenterDotTransparency,
	Callback = function(New, Old)
		WallHack.Crosshair.Settings.CenterDotTransparency = New
	end,
	Min = 0,
	Max = 1,
	Decimals = 2
}).Default = WallHack.Crosshair.Settings.CenterDotTransparency

CrosshairSettings_CenterDot:AddToggle({
	Name = "Center Dot Filled",
	Value = WallHack.Crosshair.Settings.CenterDotFilled,
	Callback = function(New, Old)
		WallHack.Crosshair.Settings.CenterDotFilled = New
	end
}).Default = WallHack.Crosshair.Settings.CenterDotFilled

--// CB Features

CBOtherSection:AddToggle({
    Name = "Bunny Hop",
    Value = false,
    Key = "Z",
    Callback = function(val)
        Bhop = val
    end
})

--[[CBOtherSection:AddDropdown({
    Name = "Direction",
    Value = 1,
    List = {"Forward", 'Directional', 'Directional 2'},
    Callback = function(val)
        BhopDir = val
    end
})

CBOtherSection:AddDropdown({
    Name = "Type",
    Value = 1,
    List = {"Gyro", "CFrame"},
    Callback = function(val)
        BhopType = val
    end
})
]]
CBOtherSection:AddSlider({
    Name = "Speed",
    Value = 40,
    Min = 1,
    Max = 150,
    Textbox = true,
    Callback = function(val)
        BhopSpeed = val
    end
})

CBOtherSection:AddDropdown({
    Name = "Hitsound",
    Value = 1,
    List = makelist(Hitsounds),
    --List = {"None", "Custom", "Baimware", "Bag", "Minecraft EXP", "Skeet", "Neverlose", "Rust", "Bell", "Bubble", "Pick", "Pop", "Minecraft Arrow Hit"},
    Value = "None",
    Callback = function(val)
        Hitsound = val
    end
})

CBOtherSection:AddTextbox({
    Name = "Custom Hitsound",
    Value = "",
    Placeholder = "Enter sound id here...",
    Callback = function(val)
        CustomHitsound = val
    end
})

CBOtherSection:AddSlider({
    Name = "Volume",
    Value = 3,
    Min = 1,
    Max = 5,
    Textbox = true,
    Callback = function(val)
        HitsoundVolume = val
    end
})

CBOtherSection:AddDropdown({
    Name = "Killsound",
    Value = 1,
    List = makelist(Killsounds),
    --List = {"None", "Custom", "CS:GO", "Ultra Kill", "Killing Spree", "Ownage", "Godlike", "Sit NN Dog", "Minecraft"},
    Value = "None",
    Callback = function(val)
        Killsound = val
    end
})

CBOtherSection:AddTextbox({
    Name = "Custom Killsound",
    Value = "",
    Placeholder = "Enter sound id here...",
    Callback = function(val)
        CustomKillsound = val
    end
})

CBOtherSection:AddSlider({
    Name = "Volume",
    Value = 3,
    Min = 1,
    Max = 5,
    Textbox = true,
    Callback = function(val)
        KillsoundVolume = val
    end
})

CBModsSection:AddToggle({
    Name = "Infinite Money",
    Value = false,
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
    Name = "Infinite Ammo",
    Callback = function()
        for i,v in pairs(game.ReplicatedStorage.Weapons:GetChildren()) do
            if table.find(Guns, v.Name) then
                v.Ammo.Value = 999999
            end
        end
        Notification.prompt("Infinite Ammo", "Re-buy the weapon to get infinite ammo.", 4)
    end
})

CBModsSection:AddButton({
    Name = "No Spread (maybe?)",
    Callback = function()
        for i,v in pairs(game.ReplicatedStorage.Weapons:GetChildren()) do
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
            end
        end
    end
})

CBModsSection:AddButton({
    Name = "Instant Equip",
    Callback = function()
        for i,v in pairs(game.ReplicatedStorage.Weapons:GetChildren()) do
            if table.find(Everything, v.Name) then
                v.EquipTime.Value = 0
            end
        end
    end
})

CBModsSection:AddSlider({
    Name = "Damage Multiplier",
    Value = 1,
    Min = 1,
    Max = 1000,
    Textbox = true,
    Callback = function(val)
        for i,v in pairs(game.ReplicatedStorage.Weapons:GetChildren()) do
            if table.find(Guns, v.Name) then
                v.DMG.Value = 65
                v.DMG.Value = v.DMG.Value * (val / 10)
            end
        end
    end
})

CBExploitsSection:AddToggle({
    Name = "God Mode",
    Value = false,
    Key = "X",
    Callback = function(val)
        GodMode = val
    end
})

CBAASection:AddToggle({
    Name = "Enable Anti-Aim",
    Value = false,
    Key = "",
    Callback = function(val)
        AntiAim = val
    end
})

CBAASection:AddDropdown({
    Name = "Yaw Type",
    Value = "Camera",
    List = {"Camera", "Target", 'Spin', 'Random'},
    Value = "Camera",
    Callback = function(val)
        YawType = val
    end
})

CBAASection:AddSlider({
    Name = "Yaw Offset",
    Value = 90,
    Min = -180,
    Max = 180,
    Textbox = true,
    Callback = function(val)
        YawOffset = val
    end
})

CBAASection:AddSlider({
    Name = "Spin Speed",
    Value = 4,
    Min = 1,
    Max = 48,
    Textbox = true,
    Callback = function(val)
        SpinSpeed = val
    end
})

CBAASection:AddDropdown({
    Name = "Pitch Type",
    Value = 1,
    List = makelist(Pitches),
    --List = {"None", "Down", "Up", "180", "Random", "Custom"},
    Value = "None",
    Callback = function(val)
        PitchType = val
    end
})

CBAASection:AddSlider({
    Name = "Custom Pitch Offset",
    Value = 1,
    Min = 1,
    Max = 100,
    Textbox = true,
    Callback = function(val)
        PitchOffset = val
    end
})

CBAASection:AddToggle({
    Name = "Jitter",
    Value = false,
    Key = "",
    Callback = function(val)
        Jitter = val
    end
})
CBAASection:AddSlider({
    Name = "Jitter Offset",
    Value = 1,
    Min = 1,
    Max = 100,
    Textbox = true,
    Callback = function(val)
        JitterOffset = val
    end
})

CBVisualSection:AddToggle({
    Name = "Third Person",
    Value = false,
    Key = "",
    Callback = function(val)
        ThirdPerson = val
    end
})

CBVisualSection:AddSlider({
    Name = "Distance",
    Value = 12,
    Max = 30,
    Min = 1,
    Textbox = true,
    Callback = function(val)
        TPDistance = val
    end
})

CBVisualSection:AddSlider({
    Name = "Field Of View",
    Value = 75,
    Max = 120,
    Min = 1,
    Textbox = true,
    Callback = function(val)
        FOV = val
        camera.FieldOfView = val
    end
})

CBVisualSection:AddColorpicker({
    Name = "World Color",
    Value = Color3.fromRGB(255, 255, 255),
    Callback = function(val)
        camera.ColorCorrection.TintColor = val
    end
})

CBVisualSection:AddColorpicker({
    Name = "Outdoor Ambient",
    Value = Color3.fromRGB(255, 255, 255),
    Callback = function(val)
        game.Lighting.OutdoorAmbient = val
    end
})

CBVisualSection:AddSlider({
    Name = "Day Time (in hours)",
    Value = 12,
    Max = 23,
    Min = 1,
    Textbox = true,
    Callback = function(val)
        game.Lighting.ClockTime = val
    end
})

CBVisualSection:AddDropdown({
    Name = "Skybox",
    List = makelist(Skyboxes),
    --List = {"None", "Nebula", "Pink Sky", "Evening", "Twilight", "Night", "Sunset", "Galaxy", "Clouds", "Vaporwave"},
    Value = "None",
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

CBVisualSection:AddToggle({
    Name = "Enable Animation",
    Value = false,
    Key = "",
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

CBVisualSection:AddDropdown({
    Name = "Animations",
    List = makelist(Animations),
    Value = "Floss",
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

CBVisualSection:AddSlider({
    Name = "Animation Speed",
    Value = 1,
    Max = 100,
    Min = 0,
    Textbox = true,
    Callback = function(val)
        AnimSpeed = val
        pcall(function()
        anim:Stop()
        end)
    end
})

--// Functions / Functions

FunctionsSection:AddButton({
	Name = "Reset Settings",
	Callback = function()
		Aimbot.Functions:ResetSettings()
		WallHack.Functions:ResetSettings()
		Library.ResetAll()
	end
})

FunctionsSection:AddButton({
	Name = "Restart AirHub Settings",
	Callback = function()
		Aimbot.Functions:Restart()
		WallHack.Functions:Restart()
	end
})

FunctionsSection:AddButton({
	Name = "Exit",
	Callback = Library.Unload,
})

FunctionsSection:AddButton({
	Name = "Copy Original Script Page",
	Callback = function()
		setclipboard("https://github.com/Exunys/AirHub")
	end
})

ThirdPerson = false

RunService.RenderStepped:Connect(function()
if AntiAim then
    if PitchType == "Custom" then
        game.ReplicatedStorage.Events.ControlTurn:FireServer(PitchOffset)
    else if PitchType == "None" then
        game.ReplicatedStorage.Events.ControlTurn:FireServer(CamLook.Y)
    else if PitchType == "Random" then
        RandomPitch = math.random(-10, 10) / 10
        game.ReplicatedStorage.Events.ControlTurn:FireServer(RandomPitch)
    else
        game.ReplicatedStorage.Events.ControlTurn:FireServer(Pitches[PitchType])
    end -- the end tower :)))
    end
    end
    end
end)

RunService.RenderStepped:Connect(function()
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
        vel = vel + workspace.CurrentCamera.CFrame.LookVector
    end
    if UserInputService:IsKeyDown("S") then
        vel = vel - workspace.CurrentCamera.CFrame.LookVector
    end
    if UserInputService:IsKeyDown("A") then
        vel = vel - workspace.CurrentCamera.CFrame.RightVector
    end
    if UserInputService:IsKeyDown("D") then
        vel = vel + workspace.CurrentCamera.CFrame.RightVector
    end

    if vel.Magnitude > 0 then
        vel = Vector3.new(vel.X, 0, vel.Z)
        localplayer.Character.HumanoidRootPart.Velocity = (vel.Unit * (BhopSpeed * 1.5)) + Vector3.new(0, localplayer.Character.HumanoidRootPart.Velocity.Y, 0) -- 1
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
			for _,plr in pairs(game.Players:GetPlayers()) do
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

camera:GetPropertyChangedSignal("FieldOfView"):Connect(function(val)
    if val == FOV then
        return
    else
        camera.FieldOfView = FOV
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
	--sound.SoundId = Hitsound == "Skeet" and "rbxassetid://5447626464" or Hitsound == "Rust" and "rbxassetid://5043539486" or Hitsound == "Bag" and "rbxassetid://364942410" or Hitsound == "Baimware" and "rbxassetid://6607339542" or Hitsound == "Custom" and "rbxassetid://" .. CustomSound or "rbxassetid://6607204501"
	hitsound.Volume = HitsoundVolume
	hitsound.PlayOnRemove = true
	hitsound:Destroy()
end)

--[[localplayer:GetPropertyChangedSignal("CameraMaxZoomDistance"):Connect(function()
if localplayer.CameraMaxZoomDistance == TPDistance then return end
    localplayer.CameraMinZoomDistance = val
    localplayer.CameraMaxZoomDistance = val
end)]]

localplayer.Additionals.OverallKills:GetPropertyChangedSignal("Value"):Connect(function()
    if Killsound == "None" then return end

	local killsound = Instance.new("Sound")
	killsound.Parent = game:GetService("SoundService")
    if Killsound == "Custom" then
        killsound.SoundId = "rbxassetid://" .. CustomKillsound
    else
        killsound.SoundId = "rbxassetid://" .. Killsounds[Killsound]
    end
	--sound.SoundId = Hitsound == "Skeet" and "rbxassetid://5447626464" or Hitsound == "Rust" and "rbxassetid://5043539486" or Hitsound == "Bag" and "rbxassetid://364942410" or Hitsound == "Baimware" and "rbxassetid://6607339542" or Hitsound == "Custom" and "rbxassetid://" .. CustomSound or "rbxassetid://6607204501"
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

local endtime = tick()
local totaltime = math.floor((endtime - starttime) * 10^2) / 10^2 .. "s to load."
Notification.prompt("Information", "Loaded successfully. Took " .. totaltime, 4)
