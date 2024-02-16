
-- [[ LOADSTRINGS ]]
local esp 
local watermark_module
local client_info

loadstring(game:HttpGet('https://raw.githubusercontent.com/leakediz/jans/main/uimod'))() --works

watermark_module = loadstring(game:HttpGet("https://raw.githubusercontent.com/leakediz/watermark/main/main"))() --wor
client_info = loadstring(game:HttpGet("https://raw.githubusercontent.com/14212352135124/clientinfo/main/ss"))() -- works


--[[ VARIABLES ]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local UserInputService  = game:GetService("UserInputService")
local RunService        = game:GetService("RunService")
local Workspace         = game:GetService("Workspace")
local Lighting          = game:GetService("Lighting")
local Players           = game:GetService("Players")

local LocalPlayer       = Players.LocalPlayer
local Character         = LocalPlayer.Character
local Humanoid          = LocalPlayer.Character.Humanoid
local Camera            = Workspace.CurrentCamera
local Mouse             = LocalPlayer:GetMouse()

local OldCorrection     = Lighting.ColorCorrection.TintColor
local OldAmbience       = Lighting.OutdoorAmbient
local OldClock          = Lighting.ClockTime
local OldZoom           = LocalPlayer.CameraMaxZoomDistance

local BeforeLoad        = tick()
local TimeTaken         = tick()

local NotiColor         = Color3.fromRGB(0,183,255)

-- [[ SOUND ID'S ]] + [[ TELEPORTS ]]

local SoundTables = {
	Defaults = {
		NukeAlarm = "rbxassetid://3237286675",
		Heal      = "rbxassetid://577886343",
		Explosion = "rbxassetid://3521555808",
		Kill      = "rbxassetid://2868331684",
		Parry     = "rbxassetid://211059855"
	},
	Customs = {
		Default = "",
		TF2   = "rbxassetid://5650646664",
		CSGO  = "rbxassetid://8679627751",
		FART  = "rbxassetid://6999993863",
		BOINK = "rbxassetid://5451260445",
		RAGE  = "rbxassetid://6911556519",
		RUST  = "rbxassetid://5043539486"
	},
	Variables = {
		NUKE       = ReplicatedStorage.Shared.Assets.Sounds.NukeAlarmSound.SoundId,
		HEAL       = ReplicatedStorage.Shared.Assets.Sounds.Heal.SoundId,
		EXPOSION   = ReplicatedStorage.Shared.Assets.Sounds.ExplosionHit.SoundId,
		KILLSOUND  = ReplicatedStorage.Shared.Assets.Sounds.KillSound.SoundId,
		PARRY      = ReplicatedStorage.Shared.Assets.Sounds.Parry.SoundId
	},
	GetNames = function(Tbl,Name)
		local tb = {}
		for i,v in pairs(Tbl[Name]) do
			table.insert(tb,i)
		end
		return tb
	end
}

local Teleports = {
    Crossroads = {
        Teleports = {
            ["Black Mountain"] 		  = CFrame.new(-167, 91, 246),
            ["Black Mountain (Back)"] = CFrame.new(-187, 25, 319),
            ["Brown Mountain"] 		  = CFrame.new(143, 101, 251),
            ["Brown Mountain (Back)"] = CFrame.new(147, 26, 326),
            ["Green Mountain"] 		  = CFrame.new(159, 86, -131),
            ["Green Mountain (Back)"] = CFrame.new(273, 25, -207),

            ["Front Beach"] 		  = CFrame.new(-255, 28, -6),
            ["Left Beach"] 			  = CFrame.new(-46, 22, -231),
            ["Right Beach"] 		  = CFrame.new(-41, 25, 328),
            ["Back Beach"] 			  = CFrame.new(271, 23, 13),

            ["Center"] 				  = CFrame.new(0, 22, 0),
            ["Grey Tower"] 			  = CFrame.new(-48, 60, 55),
            ["Blue Tower"] 		      = CFrame.new(-86, 67, -76),
            ["Red Tower"] 			  = CFrame.new(150, 69, 159),
            ["Basement"] 			  = CFrame.new(157, 26, -80),
            ["Bridge"]	 			  = CFrame.new(-174, 45, -47),
        },
        GetNames = function(Tbl)
            local tb = {}
            for i,v in pairs(Tbl.Teleports) do
                table.insert(tb,i)
            end
            return tb
        end
    }
}

-- [[ KILL SAY ]] + [[ SKY BOXES ]] + [[ BODY PARTS ]]

local R6BodyParts = {
	"Head",
	"Torso",
	"HumanoidRootPart",
	"Left Arm",
	"Right Arm",
	"Left Leg",
	"Right Leg"
}

local KillSayStuff = {
	"YOU SUCK",
	".GG/TICKWARE NERD",
	"Bad at the game? .gg/tickware",
	"get good get tickware.",
	"gg mate ",
	"honestly that was fair",
	"DUDE!",
	"EZEZEEZEEZEEZZEZEZEZ",
	"EZZZ",
	"SHUSH UR ALL EZEZEZZ",
	"i mean im just better",
	"UMMMMMM EGO ALERT!",
	"um guys its a exploiter report them!",
	"coems.",
	"wise words from leaked",
	"sahjdg",
	"imboutakum",
	"mate u wanna go ya",
	"honestly idk.",
	"tickware best script #1",
	"free roblox script 2023 NO VIRUS!",
	"tickware be tapping",
	"um guys whos crashing????!!!",
	"im so kool ok believe trust"
}

local Skyboxes = {
	["none"] = {
		SkyboxLf = "rbxassetid://252760980",
		SkyboxBk = "rbxassetid://252760981",
		SkyboxDn = "rbxassetid://252763035",
		SkyboxFt = "rbxassetid://252761439",
		SkyboxLf = "rbxassetid://252760980",
		SkyboxRt = "rbxassetid://252760986",
		SkyboxUp = "rbxassetid://252762652",
	},
	["nebula"] = {
		SkyboxLf = "rbxassetid://159454286",
		SkyboxBk = "rbxassetid://159454299",
		SkyboxDn = "rbxassetid://159454296",
		SkyboxFt = "rbxassetid://159454293",
		SkyboxLf = "rbxassetid://159454286",
		SkyboxRt = "rbxassetid://159454300",
		SkyboxUp = "rbxassetid://159454288",
	},
	["vaporwave"] = {
		SkyboxLf = "rbxassetid://1417494402",
		SkyboxBk = "rbxassetid://1417494030",
		SkyboxDn = "rbxassetid://1417494146",
		SkyboxFt = "rbxassetid://1417494253",
		SkyboxLf = "rbxassetid://1417494402",
		SkyboxRt = "rbxassetid://1417494499",
		SkyboxUp = "rbxassetid://1417494643",
	},
	["clouds"] = {
		SkyboxLf = "rbxassetid://570557620",
		SkyboxBk = "rbxassetid://570557514",
		SkyboxDn = "rbxassetid://570557775",
		SkyboxFt = "rbxassetid://570557559",
		SkyboxLf = "rbxassetid://570557620",
		SkyboxRt = "rbxassetid://570557672",
		SkyboxUp = "rbxassetid://570557727",
	},
	["twilight"] = {
		SkyboxLf = "rbxassetid://264909758",
		SkyboxBk = "rbxassetid://264908339",
		SkyboxDn = "rbxassetid://264907909",
		SkyboxFt = "rbxassetid://264909420",
		SkyboxLf = "rbxassetid://264909758",
		SkyboxRt = "rbxassetid://264908886",
		SkyboxUp = "rbxassetid://264907379",
	},
}

-- --[[ BYPASS ]]--
-- do
--     local anticheats = {
--         'AntiBodyMoverClient',
--         'AntiFlyClient',
--         'AntiInfJumpClient',
--         'AntiInjectClient',
--         'AntiSpeedClient',
--         'SanityChecksClient',
--         'AntiCheatHandlerClient',
--         'AntiCheatHandler',
--         'LightingUtil'
--     }
--     local reg = getreg()
--     for i=1,#reg do -- anti sanity checks
--         local thread = reg[i]
--         if not (type(thread) == 'thread') then continue end
        
--         local source = debug.info(thread,1,'s')
--         if source then
--             for i,v in pairs(anticheats) do
--                 if source:sub(-v:len(),-1) == v then
--                     task.cancel(thread)
--                 end
--             end
--         end
--     end
--     for i,connection in pairs(getconnections(LocalPlayer.CharacterAdded)) do
--         pcall(function()
--             local src = debug.getinfo(connection.Function,'s').source
--             if src:sub(-22,-1) == 'AntiCheatHandlerClient' then
--                 connection:Disable()
--             end
--         end)
--     end
--     if LocalPlayer.Character then -- additional bypass i need
--         for i,connection in pairs(getconnections(LocalPlayer.CharacterRemoving)) do
--             pcall(function()
--                 local src = debug.getinfo(connection.Function,'s').source
--                 if src:sub(-22,-1) == 'AntiCheatHandlerClient' then
--                     local maid = getupvalue(connection.Function,1)
--                     for i,v in pairs(maid._tasks) do
--                         if typeof(v) == 'table' then
--                             v:Destroy()
--                         end
--                     end
--                 end
--             end)
--         end
--     end 
-- end
local Modules = {Name = {},Id = {}}
local Reducers = {}
local UtilityIds = {}
local WeaponIds = {}
local Nevermore = require(ReplicatedStorage.Framework.Nevermore)
local NevermoreModules = rawget(Nevermore, '_lookupTable') --credits to snnwer for that
for i,v in pairs(NevermoreModules) do
    if i:sub(-7,-1) == 'Reducer' or i:sub(-13,-1) == 'ReducerClient'  or i:sub(-17,-1) == 'ReducerInfoClient' then
        table.insert(Reducers,getupvalue(require(v).reducer,2))
        continue
    end
end
for i,v in pairs(Modules.Name['UtilityIds']) do
    UtilityIds[i:lower()] = v
end
for i,v in pairs(Modules.Name['WeaponIds']) do
    WeaponIds[i:lower()] = v
end
local Network = getupvalue(rawget(getrawmetatable(Modules.Name['Network']),'__index'),1)
local Remotes = getupvalue(getfenv(Network.FireServer).GetEventHandler,1)

-- [[ FRAMEWORK ]]

local Framework = {}

local Hooks = {}
local Modify = {}

local OnFireServer

function Handle(_,Name,...)
    local Args = {...}
    if (Modify[Name] and Modify[Name].check(Name,unpack(Args))) then
        if typeof(Modify[Name].check(Name,unpack(Args))) == "table" then
			table.foreach(Modify[Name].check(Name,unpack(Args)),function(i,v)
				Args[tonumber(i)] = v
			end)
		else
			for i,v in pairs(Modify[Name].Args) do
				Args[tonumber(i)] = v
			end
		end
    end
    if Hooks[Name] then
        return pcall(Hooks[Name],OnFireServer,_,Name,...)
    end
    return OnFireServer(_,Name,unpack(Args))
end

OnFireServer = hookfunction(Network.FireServer,function(_,Name,...)
    return Handle(_,Name,...)
end)

function Framework.AddHook(Table,Name,Function)
	Hooks[Name] = Function
end

function Framework.ArgModify(Table,Name,ToModify,Check)
    Modify[Name] = {Args={ToModify}}
	Modify[Name].check = function(n,...)
		local s,r = pcall(Check,n,...)
	    return r
	end
end

function Framework.RemoveHook(Table,Name)
    table.remove(Hooks,table.find(Hooks,Name))
end

function Framework.RemoveArgModifier(Table,Name,ToModify)
    table.remove(Modify,table.find(Modify,Name))
end

function Framework.FireServer(Table,Name,...)
    Network:FireServer(Name,...)
end

function Framework.InvokeServer(Table,Name, ...)
	Network:FireServer(Name,...)
end

function Framework.HookClient(Table,Name,NewFunction)
    local ToHook
    for i,v in pairs(getconnections(Remotes[Name].OnClientEvent)) do
        ToHook = v.Function
        break
    end
    local OldHook; OldHook = hookfunction(ToHook,function(...)
        return NewFunction(...)
    end)
    return OldHook
end

function Framework.GetMetadata(Table,ItemName,ItemId) 
	if not WeaponIds[ItemName:lower():gsub(' ','')] then 
		return 
	end
	
	return ItemName and Modules.Name["WeaponMetadata"][WeaponIds[ItemName:lower():gsub(' ','')]] or Modules.Name["WeaponMetadata"][ItemId]
end

function Framework.GetUtility(Table,ItemName,ItemId) 
	if not UtilityIds[ItemName:lower():gsub(' ','')] then 
		return 
	end
	
	return ItemName and Modules.Name["UtilityMetadata"][UtilityIds[ItemName:lower():gsub(' ','')]] or Modules.Name["UtilityMetadata"][ItemId]
end

function Framework.GetWeapon(Table,Player) -- dont remove player its for the player stats
	local Player = Player or LocalPlayer
	local Character = Player.Character or Player.CharacterAdded:Wait()

	for i,v in pairs(Character:GetChildren()) do
		if not v:IsA("Tool") then continue end
		if v:GetAttribute("ItemType") == "weapon" and Modules.Name["WeaponMetadata"][v:GetAttribute("ItemId")].class:lower():match("melee") then
			return v
		end
	end
end

function Framework.GetRanged(Table,Player)
	local Player = Player or LocalPlayer
	local Character = Player.Character or Player.CharacterAdded:Wait()

	for i,v in pairs(Character:GetChildren()) do
		if not v:IsA("Tool") then continue end
		if v:GetAttribute("ItemType") == "weapon" and Modules.Name["WeaponMetadata"][v:GetAttribute("ItemId")].class:lower():match("ranged") then
			return v
		end
	end
end

function Framework.GetState(Table)
    return Modules.Name["RoduxStore"]:getState()
end

function Framework.GetSessionData(Table,Player)
    return Modules.Name["DataHandler"].getSessionDataRoduxStoreForPlayer(Player or LocalPlayer)
end

function Framework.GetClosest(Table,Distance,Priority,CheckFunction)
    local function n(Player)
        if (Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and Player.Character:FindFirstChild("Humanoid") and Player.Character.Humanoid.Health ~= 0) then
            return true
        end
    end

	local Distance = Distance or math.huge
	local CheckFunction = CheckFunction or n
	local Player = {}
	
	for i,v in pairs(Players:GetPlayers()) do
		if v == LocalPlayer then continue end
        if not CheckFunction(v) then continue end
		
		local HRP = v.Character.HumanoidRootPart
		local Magnitude = (HRP.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
		
		if Magnitude < Distance  then
			Distance = Magnitude
			Player[v.Name] = v.Character.Humanoid.Health
		end
	end

	table.sort(Player)
	
	return Player
end

function Framework.GetClosestToMouse(Table,Distance,Priority,CheckFunction)
    local function n(Player)
        if (Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and Player.Character:FindFirstChild("Humanoid") and Player.Character.Humanoid.Health ~= 0) then
            return true
        end
    end

	local Distance = Distance or math.huge
	local CheckFunction = CheckFunction or n
	local Player = nil

	local MousePosition = UserInputService:GetMouseLocation()

	for i,v in pairs(Players:GetPlayers()) do
		if v == LocalPlayer then continue end
		if not CheckFunction(v) then continue end

		local HRP = v.Character.HumanoidRootPart

		local vector, onScreen = Camera:WorldToScreenPoint(HRP.Position)
		if onScreen then
			local Magnitude = (MousePosition - Vector2.new(vector.X, vector.Y)).Magnitude

			if Magnitude < Distance then
				Distance = Magnitude
				Player = v
			end
		end
	end

	return Player
end

function Framework.MeleeHit(Table,Melee,Aoe,HitTable)
    local Melee = Melee or Table:GetWeapon(LocalPlayer)
	local Aoe = Aoe or false
	local HitTable = HitTable
	assert(HitTable ~= nil,"No HitTable Found")
	Table:FireServer("MeleeSwing",Melee,math.random(1,4))
	local Hitbox
	for i,v in pairs(CollectionService:GetTagged("_RaycastHitboxV4Managed")) do
		if (v.Name == "RightLegHitbox" or v.Name == "SideKickHitbox") then continue end
		Hitbox = v
	end
	for i,v in pairs(HitTable) do
		if library.flags["KillAuraTP"] then
			if library.flags["KATPTYPE"] == "Behind" then 
			   	LocalPlayer.Character.HumanoidRootPart.CFrame = Players[i].Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, library.flags["KillAuraTPDist"])
			else 
				if not LocalPlayer.Character.HumanoidRootPart:FindFirstChild("KAURA") then
					local Bv = Modules.Name["AntiCheatHandler"].createBodyMover("BodyVelocity")
					Bv.P = 1250
					Bv.MaxForce = Vector3.new(9e9,9e9,9e9)
					Bv.Velocity = Vector3.new(0,0,0)
					Bv.Name = "KAURA"
					Bv.Parent = LocalPlayer.Character.HumanoidRootPart
				end
				LocalPlayer.Character.HumanoidRootPart.CFrame = Players[i].Character.HumanoidRootPart.CFrame * CFrame.new(0, library.flags["KillAuraTPDist"], 0) 
			end
		else
			if LocalPlayer.Character.HumanoidRootPart:FindFirstChild("KAURA") then
				LocalPlayer.Character.HumanoidRootPart:FindFirstChild("KAURA"):Destroy()
			end
		end
		Table:FireServer("MeleeDamage",Melee,v.Head,Hitbox,v.Head.Position,CFrame.new(),Vector3.new())
		if not Aoe then break end
	end
end

local function FASTRESPAWN(delay)
	Network:FireServer("SelfDamage",math.huge,{ignoreForceField = true})
	Network:FireServer("StartFastRespawn")
	wait(delay or 0)
	Network:InvokeServer("CompleteFastRespawn")
	Network:InvokeServer("SpawnCharacter")
end

function Framework.Teleport(Table,CF,FR)
    if FR then
        FASTRESPAWN(1)
        task.wait()
        LocalPlayer.Character.HumanoidRootPart.CFrame = CF
    else
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(10000,10000,10000)
		task.wait(1)
		LocalPlayer.Character.HumanoidRootPart.CFrame = CF
		task.wait()
		LocalPlayer.Character.Humanoid:EquipTool(LocalPlayer.Backpack:GetChildren()[1])
		LocalPlayer.Character.Humanoid:UnequipTools()
    end
end

function Framework.IsParrying(Table,Player)
	local Data = Table:GetSessionData():getState()
	return Data.parry.isParrying
end

function Framework.GetCurrentGameMode(Table)
	local CurrentMap = workspace.Map:FindFirstChildOfClass("Model")
	if CurrentMap then
		local Gamemodes = CurrentMap.MapConfiguration.Gamemodes
		for i,v in pairs(Gamemodes:GetDescendants()) do
			if v:IsA("ObjectValue") then
				return v:FindFirstAncestorOfClass("Folder")
			end
		end
	end
end

function Framework.GetPointEnemyPoint(Table,Gamemode)
    for i,v in pairs(Gamemode:GetDescendants()) do
        if (v:IsA("ObjectValue") and v.Value and v.Value:FindFirstChild("Inner")) then
            if v.Value.Inner.BrickColor ~= LocalPlayer.Team.TeamColor then
                return v.Parent
            end
        end
    end
end

function Framework.GetPointTeamPoint(Table,Gamemode)
    for i,v in pairs(Gamemode:GetDescendants()) do
        if (v:IsA("ObjectValue") and v.Value and v.Value:FindFirstChild("Inner")) then
            if v.Value.Inner.BrickColor == LocalPlayer.Team.TeamColor then
                return v.Parent
            end
        end
    end
end

function Framework.GetClosestCharacterToOrigin(Table,Origin)
	for i,v in pairs(workspace.PlayerCharacters.GetChildren(workspace.PlayerCharacters)) do
		if (v ~= LocalPlayer.Character and v.FindFirstChild(v,"HumanoidRootPart")) then
			local dis = (v.HumanoidRootPart.Position-Origin).Magnitude
			if dis < 15 then
				return v
			end
		end
	end
end

function Framework.GetClosestCharactersToOrigin(Table,Origin)
    local closests = {}
	for i,v in pairs(workspace.PlayerCharacters:GetChildren()) do
		if (v ~= LocalPlayer.Character and v:FindFirstChild("HumanoidRootPart")) then
			local dis = (v.HumanoidRootPart.Position-Origin).Magnitude
			if dis < 15 then
				table.insert(closests,v)
			end
		end
	end
	return closests
end

function Framework.Fly(Table)
	if (library.flags["FLY"] and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character.HumanoidRootPart:FindFirstChild("prettyboy") == nil) then
		local Attachment = Instance.new('Attachment',LocalPlayer.Character.HumanoidRootPart)
		local LinearVelocity = Modules.Name["AntiCheatHandler"].createBodyMover("LinearVelocity")
		LinearVelocity.Name = "prettyboy"
		LinearVelocity.Attachment0 = Attachment
		LinearVelocity.VectorVelocity = Vector3.new()
		LinearVelocity.MaxForce = math.huge
		LinearVelocity.Parent = LocalPlayer.Character.HumanoidRootPart
	elseif (library.flags["FLY"] and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character.HumanoidRootPart:FindFirstChild("prettyboy") ~= nil) then
		local MoveVector = require(LocalPlayer.PlayerScripts:WaitForChild("PlayerModule")):GetControls():GetMoveVector()
		local LinearVelocity = LocalPlayer.Character.HumanoidRootPart.prettyboy
		LinearVelocity.VectorVelocity = ((workspace.CurrentCamera.CFrame.LookVector * (-MoveVector.Z)) * library.flags["FLYvalue"]) + ((workspace.CurrentCamera.CFrame.RightVector * MoveVector.X) * library.flags["FLYvalue"])
	end
	if (not library.flags["FLY"] and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character.HumanoidRootPart:FindFirstChild("prettyboy") ~= nil) then
		LocalPlayer.Character.HumanoidRootPart.prettyboy:Destroy()
	end
end

function Framework.Chance(Table,number) 
	return (math.floor(Random.new().NextNumber(Random.new(),0,1) * 100) / 100) <= math.floor(number) / 100
end

function Framework.IsPartClose(Table,Part,Distance)
	local Character = LocalPlayer.Character
	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
	if not HumanoidRootPart then return end
	if (Part and Part:IsA('BasePart')) then
		local Mag = (Part.Position - HumanoidRootPart.Position).Magnitude
		return Mag <= Distance
	end
end

local Plrs = {}
local items = {}
local rangedOg = {}

local ranged = {
	'specRpg',
	'rpg',
	'tommygun',
	'specTommyGun',
	'airdropRPG',
	'longbow',
	'heavybow',
	'crossbow',
	'throwableKunai'
}

for i,v in pairs(ranged) do
	local m = Framework:GetMetadata(v) or Framework:GetUtility(v)
	if m then
		table.insert(rangedOg,{Name = v,OG = table.clone(m)})
	end
end

function modifyRanged(name,val)
	for i,v in pairs(rangedOg) do
		local m = Framework:GetMetadata(v.Name) or Framework:GetUtility(v.Name)
		if m[name] then
			m[name] = val
		end
	end
end

function revertRanged(name)
	for i,v in pairs(rangedOg) do
		local m = Framework:GetMetadata(v.Name) or Framework:GetUtility(v.Name)
		if m[name] then
			m[name] = v.OG[name]
		end
	end
end

for i,v in pairs(Players:GetPlayers()) do
    if v ~= LocalPlayer then
        table.insert(Plrs,v.Name)
    end
end

for i,v in pairs(Enum.Material:GetEnumItems()) do
    table.insert(items,v.Name)
end

Players.PlayerAdded:Connect(function(Plr)
    library.options["PLRT"]:AddValue(Plr.Name)
end)

Players.PlayerRemoving:Connect(function(Plr)
    library.options["PLRT"]:RemoveValue(Plr.Name)
end)

-- [[ MAIN TABS ]]
local CombatTab = library:AddTab("Combat"); 
local Ranged = library:AddTab("Ranged");
local PlayerTab = library:AddTab("Player"); 
local Miscellaneous = library:AddTab("Misc");
local Teleport = library:AddTab("Misc 2");
local Visuals = library:AddTab("Visuals");
local SettingsTab = library:AddTab("Settings");

local CombatSec1 = CombatTab:AddColumn();
local CombatSec2 = CombatTab:AddColumn();
local ParryTab = CombatSec1:AddSection("Auto Parry")
local AntiParryTab = CombatSec2:AddSection("Anti Parry")
local FinishAuraTab = CombatSec1:AddSection("Finish Aura's")
local CombatMiscTab = CombatSec1:AddSection("Misc")
local KillAuraTab = CombatSec2:AddSection("Kill Aura")

local RangedSec1 = Ranged:AddColumn()
local RangedSec2 = Ranged:AddColumn()
local Main = RangedSec1:AddSection("Main")
local Mods = RangedSec2:AddSection("Ranged Mod's")

local PlayerSec1 = PlayerTab:AddColumn();
local PlayerSec2 = PlayerTab:AddColumn();
local CharacterTab = PlayerSec1:AddSection("Character")                                
local CharacterModsTab = PlayerSec2:AddSection("Character Mods")  
local FasterModsTab = PlayerSec1:AddSection("Faster Mods")                               
local MiscTab = PlayerSec1:AddSection("Misc")
local AnimationTab = PlayerSec2:AddSection("Animations [FE]")
local CrouchTab = PlayerSec1:AddSection("Crouch Mods")

local MiscSec1 = Miscellaneous:AddColumn();
local MiscSec2 = Miscellaneous:AddColumn();
local MiscTab1 = MiscSec1:AddSection("Exploits")
local MiscTab2 = MiscSec1:AddSection("Misc")
local MiscTab3 = MiscSec2:AddSection("Servers")
local MiscTab4 = MiscSec2:AddSection("Menu")
local MiscTab5 = MiscSec2:AddSection("Kill Feed Spammer")
local MiscTab6 = MiscSec2:AddSection("Custom Sounds")
local MiscTab7 = MiscSec2:AddSection("Sound Volumes")
local MiscTab8 = MiscSec1:AddSection("Cat Things")
local MiscTab9 = MiscSec2:AddSection("Chat Related")

local TeleSec1 = Teleport:AddColumn()
local TeleSec2 = Teleport:AddColumn()
local TeleTab1 = TeleSec1:AddSection("Click Teleport")
local TeleTab2 = TeleSec2:AddSection("Map(s) Teleports")
local TeleTab3 = TeleSec1:AddSection("Gamemode Fucker")

local VisualSec1 = Visuals:AddColumn();
local VisualSec2 = Visuals:AddColumn();
local VisualTab1 = VisualSec1:AddSection("ESP")
local VisualTab2 = VisualSec1:AddSection("Player") 
local VisualTab3 = VisualSec2:AddSection("Sky Boxes")
local VisualTab4 = VisualSec2:AddSection("World")

local SettingsColumn = SettingsTab:AddColumn()
local SettingsColumn2 = SettingsTab:AddColumn() 
local SettingSection = SettingsColumn:AddSection("Menu") 
local WatermarkSection = SettingsColumn:AddSection("Watermark", "Left")
local FPSSection = SettingsColumn2:AddSection("Fps Cap")
local NotificationSec = SettingsColumn2:AddSection("Notifications")
local ConfigSection = SettingsColumn2:AddSection("Configs")
local Warning = library:AddWarning({type = "confirm"})

ParryTab:AddToggle{text = "Auto Parry", flag = "AutoParry", false} 
ParryTab:AddSlider{text = "Parry Range", flag = "ParryRange", min = 0, max = 25, value = 25, suffix = " stud/s"}
ParryTab:AddSlider{text = "Auto Parry Chance", flag = "ParryChance", min = 0, max = 100, value = 100, suffix = "%"}
ParryTab:AddList({text = "Auto Parry Method", flag = "ParryMethod", value = "remote", values = {"Remote", "Key"}});
AntiParryTab:AddToggle{text = "Anti Parry", flag = "AntiParry", false}
FinishAuraTab:AddToggle{text = "Glory Aura", flag = "GloryAura", false}
FinishAuraTab:AddSlider{text = "Glory Aura Delay", flag = "GloryDelay", min = 0.1, max = 10, value = 0, suffix = "/s"}
KillAuraTab:AddToggle{text = "Kill Aura", flag = "KillAura", false}
KillAuraTab:AddToggle{text = "Kill Aura Parry Check", flag = "KillAuraPC", false}
KillAuraTab:AddToggle{text = "Use Weapons Cooldown", flag = "KAWEAPONCOOLDOWN", false}
KillAuraTab:AddList({text = "Kill Aura Priority", flag = "KAPRIORITY", value = "Health", values = {"None", "Health"}});
KillAuraTab:AddList({text = "Kill Aura Type", flag = "KATYPE", value = "Attack One", values = {"Attack One", "Attack Multiple"}});
KillAuraTab:AddSlider{text = "Kill Aura Range", flag = "KillAuraRange", min = 0, max = 20, value = 20, suffix = " stud/s"}
KillAuraTab:AddSlider{text = "Kill Aura Cooldown", flag = "KACOOLDOWN", min = 0.1, max = 5, value = 0.1, suffix = "/s"}
KillAuraTab:AddToggle{text = "Kill Aura Teleport", flag = "KillAuraTP", false}
KillAuraTab:AddSlider{text = "Teleport Distance", flag = "KillAuraTPDist", min = 0.1, max = 15, value = 0.1, suffix = " stud"}
KillAuraTab:AddList({text = "Kill Aura Teleport Type", flag = "KATPTYPE", value = "Behind", values = {"Behind", "Ontop"}});
KillAuraTab:AddToggle{text = "Range Indicator", flag = "KAindicator", false}:AddColor({ flag = "RangeIndicatorColor", color = Color3.fromRGB(255,255,255) });

CharacterTab:AddToggle{text = "Walkspeed", flag = "WS", false, callback = function(bool) if not library.flags["WS"] then if (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")) then Modules.Name["WalkSpeedHandlerClient"].getValueContainer():setBaseValue(16) end end end}
CharacterTab:AddSlider{text = "Walkspeed value", flag = "WSValue", min = 16, max = 60, value = 16, suffix = " ws"}
CharacterTab:AddToggle{text = "TP Walk", flag = "TPW", false}
CharacterTab:AddSlider{text = "TP Walk Value", flag = "TPWVal", min = 1, max = 3, value = 1, suffix = " ws"}
CharacterTab:AddToggle{text = "Jump Power", flag = "JP", false, callback = function(bool) if not library.flags["JP"] then if (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")) then LocalPlayer.Character.Humanoid.UseJumpPower = true LocalPlayer.Character.Humanoid.JumpPower = 50 end end end}
CharacterTab:AddSlider{text = "Jump Power value", flag = "JPValue", min = 50, max = 1000, value = 50, suffix = " jp"}
CharacterTab:AddToggle{text = "Infinite Jump", flag = "IJ", false}
CharacterTab:AddSlider{text = "Inf Jump Value", flag = "IJvalue", min = 1, max = 1000, value = 19, suffix = " stud/s"}
CharacterTab:AddDivider("Others");
CharacterTab:AddToggle{text = "Fly", flag = "FLY", false}
CharacterTab:AddSlider{text = "Fly Speed", flag = "FLYvalue", min = 1, max = 60, value = 60, suffix = " stud/s"}

CharacterModsTab:AddToggle{text = "Infinite Stamina", flag = "IS", false}
CharacterModsTab:AddToggle{text = "Infinite Air", flag = "IA", false, callback = function(bool)
	if bool then
		Modules.Name["AirConstants"].AIR_TO_ADD_PER_SECOND_WHILE_SWIMMING = 0
	else
		Modules.Name["AirConstants"].AIR_TO_ADD_PER_SECOND_WHILE_SWIMMING = -15
	end
end}
CharacterModsTab:AddToggle{text = "Can Always Jump", flag = "CAJ", false}
CharacterModsTab:AddToggle{text = "No Jump Cooldown", flag = "NJCD", false, callback = function(bool)
	if bool then
		Modules.Name["JumpConstants"].JUMP_DELAY_ADD = 0
	else
		Modules.Name["JumpConstants"].JUMP_DELAY_ADD = 1
	end
end}
CharacterModsTab:AddToggle{text = "No Dash Cooldown", flag = "NDCD", false, callback = function(bool)
	if bool then
		Modules.Name["DashConstants"].DASH_COOLDOWN = 0
	else
		Modules.Name["DashConstants"].DASH_COOLDOWN = 3
	end
end}
CharacterModsTab:AddToggle{text = "No Name Tag", flag = "NNT", false, callback = function(bool)
    Network:FireServer("UpdateIsCrouching",bool)
end}
CharacterModsTab:AddToggle{text = "No Utilities Damage", flag = "NFBD", false}
CharacterModsTab:AddToggle{text = "No Flash Bomb", flag = "AFB", false}
CharacterModsTab:AddToggle{text = "No Fall Damage", flag = "NFD", false, callback = function(bool)
	Framework:GetSessionData():getState().fallDamageClient.isDisabled = bool
end}
CharacterModsTab:AddToggle{text = "No Ragdoll", flag = "NR", false}
CharacterModsTab:AddToggle{text = "No Knockback", flag = "NKB", false}
CharacterModsTab:AddToggle{text = "Auto Revive", flag = "AUTOREV", false}
CharacterModsTab:AddToggle{text = "Anti Stomp", flag = "AS", false}
CharacterModsTab:AddToggle{text = "Walk On Water", flag = "WOW", false, callback = function(bool)
	workspace.Map:FindFirstChildOfClass("Model").MapConfiguration.WaterAreas.WaterArea.CanCollide = bool
end}

MiscTab1:AddToggle{text = "Semi Invisible", flag = "SI", false}
MiscTab1:AddToggle{text = "Server Crash", flag = "SC", false}
MiscTab1:AddToggle{text = "Custom Finisher Crater", flag = "CFCM", false}:AddColor({flag = "CFCMC", color = Color3.fromRGB(255,255,255)})
MiscTab1:AddList({text = "Finisher Crater Material", flag = "FCM", value = "Neon", values = items})
MiscTab1:AddBox({text = "Finisher Crater Size", flag = "CFCMS", value = "8"})
MiscTab1:AddBox({text = "Rectangle Crater Length", flag = "RCL", value = "8"})
MiscTab1:AddBox({text = "Rectangle Crater Width", flag = "RCW", value = "8"})
MiscTab2:AddButton{text = "Unlock All Emotes",callback = function() for i,v in pairs(Modules.Name["EmotesInOrder"]) do if typeof(v) == "table" then Framework:GetState().OwnedEmotes[v.id] = 1;end;end;end}
MiscTab2:AddToggle{text = "Invisible Weapon", flag = "IW", false}
MiscTab2:AddToggle{text = "Auto Airdrop Claimer", flag = "AAC", false}
MiscTab3:AddButton({text = "Rejoin", callback = function() game:GetService("TeleportService"):Teleport(game.PlaceId,LocalPlayer) end})
MiscTab4:AddToggle{text = "Auto Respawn", flag = "AR2", false}
MiscTab4:AddToggle{text = "No Menu Blur", flag = "MBLUR", false}
MiscTab6:AddList({text = "Nuke Alarm", flag = "NukeSound", value = "Default", values = SoundTables:GetNames("Customs")})
MiscTab6:AddList({text = "Heal", flag = "HealSound", value = "Default", values = SoundTables:GetNames("Customs")})
MiscTab6:AddList({text = "Explosion", flag = "ExpSound", value = "Default", values = SoundTables:GetNames("Customs")})
MiscTab6:AddList({text = "Kill Sound", flag = "KillSound", value = "Default", values = SoundTables:GetNames("Customs")})
MiscTab6:AddList({text = "Parry Sound", flag = "ParrySound", value = "Default", values = SoundTables:GetNames("Customs")})
MiscTab8:AddButton({text = "Get Cat", callback = function() Framework:FireServer("ExecuteCommand","getCat",{}) end})
MiscTab8:AddToggle{text = "Squeeze Others Cats", flag = "SQOC", false}

TeleTab1:AddToggle({text = "Use Fast Respawn", flag = "UFR", false})
TeleTab1:AddToggle({text = "Click TP (R)", flag = "CLTP", false})
TeleTab1:AddList({text = "Player Teleport", skipflag = true, value = "", flag = "PLRT", values = Plrs})
TeleTab1:AddButton({text = "Teleport To Player", callback = function()
    if Players:FindFirstChild(library.flags["PLRT"]) then
        local Player = Players:FindFirstChild(library.flags["PLRT"])
        if (Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")) then
            Teleport(Player.Character:FindFirstChild("HumanoidRootPart").CFrame,library.flags["UFR"])
        end
    end
end})
TeleTab2:AddList({text = "Crossroads Teleports", skipflag = true, value = "Center", flag = "CRT", values = Teleports.Crossroads:GetNames()})
TeleTab2:AddButton({text = "Teleport To Selected", callback = function()
	Teleport(Teleports.Crossroads.Teleports[library.flags["CRT"]],library.flags["UFR"])
end})
TeleTab2:AddButton({text = "Claim Flag", callback = function()
    local cur = Framework:GetCurrentGameMode()
    if (cur and cur.Name == "ctf") then
        local point = Framework:GetPointEnemyPoint(cur)
        local point2 = Framework:GetPointTeamPoint(cur)
        if (point and point2) then
            Framework:Teleport(point.CFrame*CFrame.new(0,-5,0),true)
            task.wait(0.5)
            LocalPlayer.Character.HumanoidRootPart.CFrame = point2.CFrame
        end
    end
end})
TeleTab2:AddButton({text = "Delete Enemy Flag", callback = function()
    local cur = Framework:GetCurrentGameMode()
    if (cur and cur.Name == "ctf") then
        local point = Framework:GetPointEnemyPoint(cur)
        local point2 = Framework:GetPointTeamPoint(cur)
        if (point and point2) then
            Framework:Teleport(point.CFrame*CFrame.new(0,-5,0),true)
            task.wait(0.5)
            LocalPlayer.Character.HumanoidRootPart.CFrame *= CFrame.new(0,-300,0)
            task.wait(0.5)
            LocalPlayer.Character.Humanoid:UnequipTools()
        end
    end
end})

Main:AddToggle{text = "Silent Aim", flag = "SA", false}
Main:AddToggle{text = "FOV", flag = "FOV", false}:AddColor({ flag = "FOVColor", color = Color3.fromRGB(255,255,255) })
Main:AddSlider{text = "FOV Size", flag = "FOVSIZE", min = 70, max = 500, value = 500}
Main:AddToggle{text = "Highlight Target", flag = "HT", false}:AddColor({ flag = "HighlightColor", color = Color3.fromRGB(255,255,255) })
Main:AddToggle{text = "Resolver", flag = "RESOLVE", false}
Main:AddToggle{text = "Wallbang", flag = "WB", false}
Main:AddToggle{text = "Always Head", flag = "AH", false}
Main:AddToggle{text = "Hit Multiple", flag = "HM", false}
Main:AddSlider{text = "Hit Chance", flag = "HITCHANCE", min = 1, max = 100, value = 100, suffix = "%"}
Main:AddList({text = "Hit Part", flag = "HITPART", value = "Head", values = {"Head","Torso"}})
Mods:AddToggle{text = "No Spread", flag = "NS", false, callback = function(bool)
	if bool then
		modifyRanged("minSpread",0)
		modifyRanged("maxSpread",0)
	else
		revertRanged("minSpread")
		revertRanged("maxSpread")
	end
end}
Mods:AddToggle{text = "No Recoil", flag = "NR", false, callback = function(bool)
	if bool then
		modifyRanged("recoilAmount",0)
	else
		revertRanged("recoilAmount")
	end
end}
Mods:AddToggle{text = "No Gravity", flag = "NG", false, callback = function(bool)
	if bool then
		modifyRanged("gravity",Vector3.new(0,0,0))
	else
		revertRanged("gravity")
	end
end}
Mods:AddToggle{text = "No Reload Cancel", flag = "NRC", false}
Mods:AddToggle{text = "Instant Charge", flag = "IC", false, callback = function(bool)
	if bool then
		modifyRanged("chargeOffDuration",0)
		modifyRanged("chargeOnDuration",0)
	else
		revertRanged("chargeOffDuration")
		revertRanged("chargeOnDuration")
	end
end}
Mods:AddToggle{text = "Shoot When Fully Charged", flag = "SWFC", false, callback = function(bool)
	if bool then
		modifyRanged("startShootingAfterCharge",true)
	else
		revertRanged("startShootingAfterCharge")
	end
end}

VisualTab1:AddToggle{text = "Box", flag = "BoxEsp", false, callback = function(state) 
	esp.Box = state
end}:AddColor({
	flag = "BoxColor", 
	color = Color3.fromRGB(255,255,255),
	callback = function(color)
		esp.BoxColor = color
	end
});
VisualTab1:AddToggle{text = "Name", flag = "NameEsp", false, callback = function(state) 
	esp.Names = state
end}:AddColor({
	flag = "NameColor",
	color = Color3.fromRGB(255,255,255),
	callback = function(color)
		esp.NamesColor = color
	end
});
VisualTab1:AddToggle{text = "Health", flag = "HealthEsp", false, callback = function(state) 
	esp.HealthBar = state
	esp.HealthBarSide = "Left"
end}

--[[ LIBRARY SETTINGS UI ]]

SettingSection:AddBind({text = "Open / Close", flag = "UI Toggle", nomouse = true, key = "End", callback = function()
	library:Close();
end});

SettingSection:AddColor({text = "Accent Color", flag = "Menu Accent Color", color = Color3.new(9,175,240), callback = function(color)
	if library.currentTab then
		library.currentTab.button.TextColor3 = color;
	end
	for i,v in pairs(library.theme) do
		v[(v.ClassName == "TextLabel" and "TextColor3") or (v.ClassName == "ImageLabel" and "ImageColor3") or "BackgroundColor3"] = color;
	end
end});

-- [Background List]
local backgroundlist = {
	Floral = "rbxassetid://5553946656",
	Flowers = "rbxassetid://6071575925",
	Circles = "rbxassetid://6071579801",
	Hearts = "rbxassetid://6073763717",
	Default = "rbxassetid://2151741365"
};

-- [Background List]
local back = SettingSection:AddList({text = "Background", max = 4, flag = "background", values = {"Floral", "Flowers", "Circles", "Hearts", "Default"}, value = "Default", callback = function(v)
	if library.main then
		library.main.Image = backgroundlist[v];
	end
end});

-- [Background Color Picker]
back:AddColor({flag = "backgroundcolor", color = Color3.new(), callback = function(color)
	if library.main then
		library.main.ImageColor3 = color;
	end
end, trans = 1, calltrans = function(trans)
	if library.main then
		library.main.ImageTransparency = 1 - trans;
	end
end});

-- [Tile Size Slider]
SettingSection:AddSlider({text = "Tile Size", min = 50, max = 500, value = 50, callback = function(size)
	if library.main then
		library.main.TileSize = UDim2.new(0, size, 0, size);
	end
end});

-- [Config Box]
ConfigSection:AddBox({text = "Config Name", skipflag = true});

-- [Config List]
ConfigSection:AddList({text = "Configs", skipflag = true, value = "", flag = "Config List", values = library:GetConfigs()});

-- [Create Button]
ConfigSection:AddButton({text = "Create", callback = function()
	library:GetConfigs();
	writefile(library.foldername .. "/" .. library.flags["Config Name"] .. library.fileext, "{}");
	library.options["Config List"]:AddValue(library.flags["Config Name"]);
end});

-- [Save Button]
ConfigSection:AddButton({text = "Save", callback = function()
	local r, g, b = library.round(library.flags["Menu Accent Color"]);
	Warning.text = "Are you sure you want to save the current settings to config <font color='rgb(" .. r .. "," .. g .. "," .. b .. ")'>" .. library.flags["Config List"] .. "</font>?";
	if Warning:Show() then
		library:SaveConfig(library.flags["Config List"]);
	end
end});

-- [Load Button]
ConfigSection:AddButton({text = "Load", callback = function()
	local r, g, b = library.round(library.flags["Menu Accent Color"]);
	Warning.text = "Are you sure you want to load config <font color='rgb(" .. r .. "," .. g .. "," .. b .. ")'>" .. library.flags["Config List"] .. "</font>?";
	if Warning:Show() then
		library:LoadConfig(library.flags["Config List"]);
	end
end});

-- [Delete Button]
ConfigSection:AddButton({text = "Delete", callback = function()
	local r, g, b = library.round(library.flags["Menu Accent Color"]);
	Warning.text = "Are you sure you want to delete config <font color='rgb(" .. r .. "," .. g .. "," .. b .. ")'>" .. library.flags["Config List"] .. "</font>?";
	if Warning:Show() then
		local config = library.flags["Config List"];
		if table.find(library:GetConfigs(), config) and isfile(library.foldername .. "/" .. config .. library.fileext) then
			library.options["Config List"]:RemoveValue(config);
			delfile(library.foldername .. "/" .. config .. library.fileext);
		end
	end
end});

WatermarkSection:AddToggle{text = "Watermark", flag = "WaterMark", false, callback = function(state)
	watermark_module.visible = state
end}:AddColor({flag = "WaterMarkColor", color = Color3.new(9,175,240), callback = function(color)
	watermark_module.accent = color
end});

WatermarkSection:AddBox({text = "Custom Name", skipflag = true, callback = function(name)
	watermark_module.name = name
end});

FPSSection:AddSlider{text = "FPS Cap", flag = "FpsCap", min = 70, max = 1000, value = 300, suffix = "", callback = function(state)
	setfpscap(state)
end}

NotificationSec:AddToggle{text = "Notifications", flag = "Notific", false}

CreateNotification("Tickware Loaded : "..math.floor((tick() - TimeTaken) * 1000).. "ms", NotiColor)

-- [[Init]]
library:Init();
library:selectTab(library.tabs[1]);

task.wait(1.5)

if library.currentTab then
	library.currentTab.button.TextColor3 = Color3.fromRGB(0,183,255);
end
for i,v in pairs(library.theme) do
	v[(v.ClassName == "TextLabel" and "TextColor3") or (v.ClassName == "ImageLabel" and "ImageColor3") or "BackgroundColor3"] = Color3.fromRGB(0,183,255);
end
library.main.Image = "rbxassetid://5553946656"
library.main.TileSize = UDim2.new(0, 135, 0, 135)

-- [[ KILL AURA INDICATOR RANGE ]]
local newPart = Instance.new("Part")
newPart.Name = "KAIndicater"
newPart.Shape = Enum.PartType.Cylinder
newPart.Transparency = 1
newPart.Size = Vector3.new(0.001,12,12)
newPart.Anchored = true
newPart.CanCollide = false
newPart.Parent = workspace

local gui = Instance.new('SurfaceGui')
gui.Face = "Right"
gui.Adornee = newPart
gui.AlwaysOnTop = true
gui.Parent = newPart

local image = Instance.new("ImageLabel")
image.Size = UDim2.new(1,0,1,0)
image.BackgroundTransparency = 1
image.Image = "rbxassetid://7185003058"
image.ImageColor3 = Color3.fromRGB(255,255,255)
image.ImageTransparency = 0.5
image.Parent = gui

local gui2 = Instance.new('SurfaceGui')
gui2.Face = "Left"
gui2.Adornee = newPart
gui2.AlwaysOnTop = true
gui2.Parent = newPart

local image2 = Instance.new("ImageLabel")
image2.Size = UDim2.new(1,0,1,0)
image2.BackgroundTransparency = 1
image2.Image = "rbxassetid://7185003058"
image2.ImageColor3 = Color3.fromRGB(255,0,0)
image2.ImageTransparency = 0.5
image2.Parent = gui2

local circle = Drawing.new('Circle')
circle.Position = Vector2.new(0,0)
circle.Radius = 500
circle.Thickness = 1
circle.Filled = false
circle.Transparency = 0
circle.NumSides = 360
circle.Visible = true
circle.Color = library.flags["FOVColor"]
Mouse.Move:Connect(function()
	if library.flags["FOV"] then
		circle.Color = library.flags["FOVColor"]
		circle.Radius = library.flags["FOVSIZE"]
		circle.Transparency = 1
		circle.Position = Vector2.new(Mouse.X,Mouse.Y+36)
	else
		circle.Color = library.flags["FOVColor"]
		circle.Radius = library.flags["FOVSIZE"]
		circle.Transparency = 0
		circle.Position = Vector2.new(Mouse.X,Mouse.Y+36)
	end
end)

UserInputService.InputBegan:Connect(function(i,gp)
    if gp then return end
    if (i.UserInputType == Enum.UserInputType.MouseButton1 and UserInputService:IsKeyDown(Enum.KeyCode.R) and library.flags["CLTP"]) then
        Framework:Teleport(Mouse.Hit,library.flags["UFR"])
    end
	if (library.flags["IJ"] and LocalPlayer.Character:FindFirstChild("Humanoid") and i.KeyCode == Enum.KeyCode.Space) then
		LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

workspace.Airdrops.ChildAdded:Connect(function(Airdrop)
    if (library.flags["AAC"] and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")) then
        task.wait()
        LocalPlayer.Character.HumanoidRootPart.CFrame = Airdrop:WaitForChild("Crate").Base.CFrame
        task.wait(.2)
        fireproximityprompt(Airdrop:WaitForChild("Crate").Hitbox.ProximityPrompt)
    end
end)

workspace.PlayerCharacters.DescendantAdded:Connect(function(Inst)
    if (Inst:IsA("Sound") and tonumber(Inst.Name) and not Inst:IsDescendantOf(LocalPlayer.Character)) then
        if (library.flags["AutoParry"] and Framework:IsPartClose(Inst:FindFirstAncestorOfClass("BasePart"),library.flags["ParryRange"]) and Framework:Chance(library.flags["ParryChance"])) then
            if library.flags["ParryMethod"] == "Remote" then
                Network:FireServer("Parry")
            else
                Modules.Name["MeleeWeaponClient"]:parry()
            end
        end
    end
end)

local OldPos
LPH_JIT_MAX(function()
	RunService.RenderStepped:Connect(LPH_JIT_MAX(function(gg)
		gui.Enabled = library.flags["KAindicator"] and true or false
		gui2.Enabled = library.flags["KAindicator"] and true or false
		if (library.flags["KAindicator"]) then
			local range = library.flags["KillAuraRange"]
			newPart.Size = Vector3.new(0.001,range * 2,range * 2)
			image.ImageColor3 = library.flags["RangeIndicatorColor"] 
			image2.ImageColor3 = library.flags["RangeIndicatorColor"]
			if (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild('HumanoidRootPart')) then
				newPart.Position = LocalPlayer.Character.HumanoidRootPart.Position+Vector3.new(0,-3,0)
				newPart.Orientation = Vector3.new(0,0,90)
			end
		end
		if library.flags["IS"] then
			local Stamina = Modules.Name["DefaultStaminaHandlerClient"].getDefaultStamina()
			if Stamina then
				Stamina:setStamina(math.huge)
			end
		end
		if library.flags["NDCD"] then
			Framework:GetSessionData():getState().dashClient.isDashing = false
		end
		if library.flags["WS"] then
			if (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")) then
				Modules.Name["WalkSpeedHandlerClient"].getValueContainer():setBaseValue(library.flags["WSValue"])
			end
		end
		if library.flags["JP"] then
			if (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")) then
				LocalPlayer.Character.Humanoid.UseJumpPower = true
				LocalPlayer.Character.Humanoid.JumpPower = library.flags["JPValue"]
			end
		end
		if library.flags["TPW"] then
			if (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")) then
				if LocalPlayer.Character.Humanoid.MoveDirection.Magnitude > 0 then
				   LocalPlayer.Character:TranslateBy(LocalPlayer.Character.Humanoid.MoveDirection * library.flags["TPWVal"])
				end
			end
		end
		if (library.flags["AS"] and LocalPlayer.Character) then
			if LocalPlayer.Character.Humanoid.Health <= 15 then
				if not LocalPlayer.Character.HumanoidRootPart:FindFirstChild("AS") then
					local Bv = Modules.Name["AntiCheatHandler"].createBodyMover("BodyVelocity")
					Bv.P = 1250
					Bv.MaxForce = Vector3.new(9e9,9e9,9e9)
					Bv.Velocity = Vector3.new(0,0,0)
					Bv.Name = "AS"
					Bv.Parent = LocalPlayer.Character.HumanoidRootPart
				end
				LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(OldPos.X,-250,OldPos.Z)
			else
				if LocalPlayer.Character.HumanoidRootPart:FindFirstChild("AS") then
					LocalPlayer.Character.HumanoidRootPart:FindFirstChild("AS"):Destroy()
				end
				OldPos = LocalPlayer.Character.HumanoidRootPart.CFrame

				LocalPlayer.Character.HumanoidRootPart.CFrame = OldPos
			end 
		end
		if game.Lighting:FindFirstChild("Blur") then
			game.Lighting.Blur.Enabled = not library.flags["MBLUR"]
		end
		if Framework:GetSessionData():getState().mainMenuClient.isIn and library.flags["AR2"] then
			Modules.Name["SpawnHandlerClient"].spawnCharacter(true)
		end
		if library.flags["SQOC"] then
			for i,v in pairs(Players:GetPlayers()) do
				if (v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("Cat")) then
					Network:FireServer("SqueezeCat",v.Character.Cat)
				end
			end
		end
		if library.flags["AUTOREV"] then
			if (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") and LocalPlayer.Character.Humanoid.Health <= 15) then
				Network:FireServer("SelfReviveStart")
                task.wait(.1)
				Network:FireServer("SelfRevive")
			end
		end
		Framework:Fly()
		workspace.Map:FindFirstChildOfClass("Model"):WaitForChild("MenuConfiguration").LightingObjects.Blur.Enabled = not state
		if library.flags["NukeSound"] ~= "Default" then
			ReplicatedStorage.Shared.Assets.Sounds.NukeAlarmSound.SoundId = SoundTables.Customs[library.flags["NukeSound"]]
		else
			ReplicatedStorage.Shared.Assets.Sounds.NukeAlarmSound.SoundId = SoundTables.Defaults.NukeAlarm
		end
		if library.flags["HealSound"] ~= "Default" then
			ReplicatedStorage.Shared.Assets.Sounds.Heal.SoundId = SoundTables.Customs[library.flags["HealSound"]]
		else
			ReplicatedStorage.Shared.Assets.Sounds.Heal.SoundId = SoundTables.Defaults.Heal
		end
		if library.flags["ExpSound"] ~= "Default" then
			ReplicatedStorage.Shared.Assets.Sounds.ExplosionHit.SoundId = SoundTables.Customs[library.flags["ExpSound"]]
		else
			ReplicatedStorage.Shared.Assets.Sounds.ExplosionHit.SoundId = SoundTables.Defaults.Explosion
		end
		if library.flags["KillSound"] ~= "Default" then
			ReplicatedStorage.Shared.Assets.Sounds.KillSound.SoundId = SoundTables.Customs[library.flags["KillSound"]]
		else
			ReplicatedStorage.Shared.Assets.Sounds.KillSound.SoundId = SoundTables.Defaults.Kill
		end
		if library.flags["ParrySound"] ~= "Default" then
			ReplicatedStorage.Shared.Assets.Sounds.Parry.SoundId = SoundTables.Customs[library.flags["ParrySound"]]
		else
			ReplicatedStorage.Shared.Assets.Sounds.Parry.SoundId = SoundTables.Defaults.Parry
		end
	end))
end)()

local ArrowResult
local CanTerminate = true
local ActiveCast = require(game:GetService("ReplicatedStorage").Packages["_Index"]["aulkhami_fastcastredux@13.2.1"].fastcastredux.ActiveCast)
local old;old = hookfunction(ActiveCast.new,LPH_NO_UPVALUES(function(...)
    local results = old(...)
    local names = {}
    for i = 3,10 do
        pcall(function()
            if getinfo(i).name ~= "" then
			    table.insert(names,getinfo(i).name)
            end
        end)
    end
    if table.find(names,"shoot") then
        ArrowResult = results
        results.RayInfo.CanPierceCallback = function(...)
            return not CanTerminate
        end
    end
    return results
end))

RunService.RenderStepped:Connect(function(dt)
    if (ArrowResult and ArrowResult.StateInfo and ArrowResult.StateInfo.UpdateConnection ~= nil) then
        local Origin = ActiveCast.GetPosition(ArrowResult)
        if not library.flags["HM"] then
            local Closest = Framework:GetClosestCharacterToOrigin(Origin)
            if (Closest and Closest:FindFirstChild(library.flags["HITPART"]) and library.flags["SA"]) then
                local Distance = (Origin - Closest:FindFirstChild(library.flags["HITPART"]).Position).Magnitude
				if Distance > 3 then
                	ActiveCast.AddPosition(ArrowResult,CFrame.lookAt(Origin,Closest:FindFirstChild(library.flags["HITPART"]).Position).LookVector*Distance)
				end
            end
        else
            CanTerminate = false
            local Closests = Framework:GetClosestCharactersToOrigin(Origin)
            for i,v in pairs(Closests) do
                if (v and v:FindFirstChild(library.flags["HITPART"]) and library.flags["SA"]) then
                    local Distance = (Origin - v:FindFirstChild(library.flags["HITPART"]).Position).Magnitude
					if Distance > 3 then
                    	ActiveCast.AddPosition(ArrowResult,CFrame.lookAt(Origin,v:FindFirstChild(library.flags["HITPART"]).Position).LookVector*Distance)
					end
                end
                task.wait()
            end
            CanTerminate = true
        end
        if library.flags["WB"] then
            local Tbl = ArrowResult.RayInfo.Parameters.FilterDescendantsInstances
            table.insert(Tbl,workspace.Map)
            table.insert(Tbl,workspace.Terrain)
            ArrowResult.RayInfo.Parameters.FilterDescendantsInstances = Tbl
        end
    elseif (ArrowResult and ArrowResult.StateInfo and ArrowResult.StateInfo.UpdateConnection == nil) then
        ArrowResult = nil
    end
end)
