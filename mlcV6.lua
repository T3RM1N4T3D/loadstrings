local STOPEVERYTHING = false

local resetBindable = Instance.new("BindableEvent")
resetBindable.Event:connect(function()
	STOPEVERYTHING = true
	game:GetService("Players").LocalPlayer:LoadCharacter()
end)
game:GetService("StarterGui"):SetCore("ResetButtonCallback", resetBindable)

local ChatEnabled = false
local FlingModeSky = false

local DelLScript = 0
local DelREvent = 0
local DelRFunction = 0
local DelTool = 0
local RService = game:GetService("RunService")

RService.RenderStepped:Connect(function()
	if STOPEVERYTHING then return end -- it works :shrug:
	pcall(function() settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Disabled end)
	pcall(function() settings().Physics.AllowSleep = false end)

	pcall(function() setsimulationradius(math.huge) end)

	pcall(function() game:FindFirstChildOfClass("Players").LocalPlayer.MaximumSimulationRadius = math.pow(math.huge, math.huge) end)

	pcall(function() sethiddenproperty(game:FindFirstChildOfClass("Players").LocalPlayer, "SimulationRadius", math.huge * math.huge) end)
end)

coroutine.resume(coroutine.create(function()
	while true do
		if STOPEVERYTHING then return end
		RService.RenderStepped:Wait()

		pcall(function()
			for i, v in pairs(game:GetChildren()) do
				RService.RenderStepped:Wait()

				if v.Name ~= "Chat" and v.Name ~= "Teams" and v.Name ~= "CoreGui" then  
					for o, b in pairs(v:GetDescendants()) do
						RService.RenderStepped:Wait()

						if b:IsA("LocalScript") and b.Name ~= "Animate" and b.Name ~= "BubbleChat" and b.Name ~= "ChatScript" then
							b.Disabled = true
						elseif b:IsA("RemoteEvent") then
							if b.Parent and b.Parent.Name == "DefaultChatSystemChatEvents" then
								continue
							end

							b:Destroy()
						elseif b:IsA("RemoteFunction") then
							if b.Parent and b.Parent.Name == "DefaultChatSystemChatEvents" then
								continue
							end

							b:Destroy()
						elseif b:IsA("Tool") then
							DelTool = DelTool + 1
							b:Destroy()
						end
					end
				end
			end
		end)
	end
end))

coroutine.resume(coroutine.create(function()
	while true do
		if STOPEVERYTHING then return end
		RService.RenderStepped:Wait()

		pcall(function()
			for i, v in pairs(game:GetChildren()) do
				RService.RenderStepped:Wait()

				if v.Name ~= "Chat" and v.Name ~= "Teams" and v.Name ~= "CoreGui" then  
					for o, b in pairs(v:GetDescendants()) do
						RService.RenderStepped:Wait()

						if b:IsA("LocalScript") and b.Name ~= "Animate" and b.Name ~= "BubbleChat" and b.Name ~= "ChatScript" then
							b.Disabled = true
						end
					end
				end
			end
		end)
	end
end))

local Plrs = game.Players
local Plr = Plrs.LocalPlayer
local Char = Plr.Character

local Clone_Character_Name = game:GetService("HttpService"):GenerateGUID()

coroutine.resume(coroutine.create(function()
	while true do
		if STOPEVERYTHING then return end
		RService.RenderStepped:Wait()

		Char.Parent = workspace
	end
end))

for i,v in next, game:GetService("Players").LocalPlayer.Character:GetDescendants() do
	if v:IsA("BasePart") then 
		game:GetService("RunService").Heartbeat:connect(function()
			v.Velocity = Vector3.new(30,0,0)
		end)
	end
end

function AntiAFK()
	if STOPEVERYTHING then return end
	local GC = getconnections or get_signal_cons
	for i,v in pairs(GC(Plr.Idled)) do
		if v["Disable"] then
			v["Disable"](v)
		elseif v["Disconnect"] then
			v["Disconnect"](v)
		end
	end
end

function AntiClientKick()
	if STOPEVERYTHING then return end
	local mt = getrawmetatable(game)
	local old = mt.__namecall
	local protect = newcclosure or protect_function

	if not protect then
		notify("Incompatible Exploit Warning", "Your exploit does not support protection against stack trace errors, resulting to fallback function")
		protect = function(f) return f end
	end

	setreadonly(mt, false)

	mt.__namecall = protect(function(self, ...)
		local method = getnamecallmethod()
		if method == "Kick" then
			wait(9e9)
			return
		end
		return old(self, ...)
	end)

	hookfunction(Plrs.LocalPlayer.Kick,protect(function() wait(9e9) end))
end

function AntiSpam()
	COREGUI.PurchasePromptApp.Enabled = false
end

function AntiClientTeleport()
	if STOPEVERYTHING then return end
	local TeleportService, tp, tptpi = game:GetService("TeleportService")
	tp = hookfunction(TeleportService.Teleport, function(id, ...)
		if allow_rj and id == game.Placeid then
			return tp(id, ...)
		end
		return wait(9e9)
	end)

	tptpi = hookfunction(TeleportService.TeleportToPlaceInstance, function(id, server, ...)
		if allow_rj and id == game.Placeid and server == game.JobId then
			return tp(id, server, ...)
		end
		return wait(9e9)
	end)
end

function BypassAntiCheat()
	if STOPEVERYTHING then return end
	local v11 = Instance.new("Hint", game:GetService("Workspace"))
	v11.Text = "Simple Anti Cheat Bypasser loaded!"

	wait(1.5)

	coroutine.resume(coroutine.create(function() 
		while true do
			if STOPEVERYTHING then return end
			for i,v in next, game:GetService("Players").LocalPlayer.Character:GetDescendants() do
				if v:IsA("BasePart") then 
					game:GetService("RunService").Heartbeat:connect(function()
						v.Anchored = false
					end)
				end

				game:GetService("RunService").RenderStepped:Wait()
			end

			game:GetService("RunService").RenderStepped:Wait()
		end
	end))

	--[[ for i, v in pairs(game:GetChildren()) do
		if v.Name ~= "Chat" and v.Name ~= "Teams" and v.Name ~= "CoreGui" then  
			for o, b in pairs(v:GetDescendants()) do
				if b:IsA("LocalScript") and b.Name ~= "Animate" and b.Name ~= "BubbleChat" and b.Name ~= "ChatScript" then
					DelLScript = DelLScript + 1
				elseif b:IsA("RemoteEvent") and b.Parent.Name ~= "DefaultChatSystemChatEvents" then
					DelREvent = DelREvent + 1
				elseif b:IsA("RemoteFunction") and b.Parent.Name ~= "DefaultChatSystemChatEvents" then
					DelRFunction = DelRFunction + 1
				elseif b:IsA("Tool") then
					DelTool = DelTool + 1
				end
			end
		end
	end --]]

	v11:Destroy()

	local v11 = Instance.new("Hint", game:GetService("Workspace"))
	v11.Text = "Total " .. DelLScript .. " Local Script(s), " .. DelREvent .. " Remote Event(s), " .. DelRFunction .. " Remote Function(s), " .. DelTool .. " Tool(s) Detected"

	wait(1.5)

	v11:Destroy()

	local v11 = Instance.new("Hint", game:GetService("Workspace"))
	v11.Text = "Removing.."

	wait(1.5)

	--[[ for i, v in pairs(game:GetChildren()) do
		if v.Name ~= "Chat" and v.Name ~= "Teams" and v.Name ~= "CoreGui" then  
			for o, b in pairs(v:GetDescendants()) do
				if b:IsA("LocalScript") and b.Name ~= "Animate" and b.Name ~= "BubbleChat" and b.Name ~= "ChatScript" then
					b.Disabled = true
				elseif b:IsA("RemoteEvent") and b.Parent.Name ~= "DefaultChatSystemChatEvents" then
					b:Destroy()
				elseif b:IsA("RemoteFunction") and b.Parent.Name ~= "DefaultChatSystemChatEvents" then
					b:Destroy()
				elseif b:IsA("Tool") then
					b:Destroy()
				end
			end
		end
	end --]]

	v11:Destroy()

	local v11 = Instance.new("Hint", game:GetService("Workspace"))
	v11.Text = "Done! Total " .. DelLScript .. " Local Script(s), " .. DelREvent .. " Remote Event(s), " .. DelRFunction .. " Remote Function(s), " .. DelTool .. " Tool(s) Removed or Disabled"

	wait(1.5)

	v11:Destroy()

	_G.ANTICHEAT_BYPASS_DONE = true
end

local index = 1

for _,v in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
	if v.Name == "MeshPartAccessory" and v.Handle.Size == Vector3.new(4, 4, 1) then
		v.Name = "MPASword" .. index
		index = index + 1
	elseif v.Name == "MeshPartAccessory" and v.Handle.Size == Vector3.new(2.5,2.5,2.5) then
		if v.Handle.SpecialMesh.MeshId == "rbxassetid://5507041951" then
			v.Name = "MPAWing1"
		elseif v.Handle.SpecialMesh.MeshId == "rbxassetid://5507042353" then
			v.Name = "MPAWing2"
		end
	elseif v.Name == "MeshPartAccessory" and v.Handle.Size == Vector3.new(3,3,3) then
		v.Name = "MPAAura"
	end
end

if Char:FindFirstChild("MeshPartAccessory") ~= nil then
	if Char:FindFirstChild("MeshPartAccessory").Handle:FindFirstChildOfClass("SpecialMesh") ~= nil then
		Char:FindFirstChild("MeshPartAccessory").Handle:FindFirstChildOfClass("SpecialMesh"):Destroy()
	end
end

for i, v in pairs(Char:GetDescendants()) do
	if v:IsA("Decal") and v.Name == 'face' then
		v:Destroy()
	end
end

local ANCHOR_PLAYER = game:GetService("Players").LocalPlayer
local PLAYER_HRP = ANCHOR_PLAYER.Character.HumanoidRootPart

local ORIGIN_POS = PLAYER_HRP.CFrame

local RunService = game:GetService("RunService")

_G.REANIMATE_DONE = false

coroutine.resume(coroutine.create(function() 
	while not _G.REANIMATE_DONE do
		if STOPEVERYTHING then return end
		PLAYER_HRP.CFrame = CFrame.new(ORIGIN_POS.Position.X, 500, ORIGIN_POS.Position.Z)
		RunService.RenderStepped:Wait()
	end
end))

local S = Instance.new("Sound")

function CreateSoundP(ID, PARENT, VOLUME, PITCH, DOESLOOP)
	local NEWSOUND
	coroutine.resume(coroutine.create(function()
		NEWSOUND = S:Clone()
		NEWSOUND.Parent = PARENT
		NEWSOUND.Volume = 2
		NEWSOUND.Pitch = PITCH
		NEWSOUND.EmitterSize = VOLUME * 3
		NEWSOUND.SoundId = "http://www.roblox.com/asset/?id=" .. ID
		NEWSOUND:play()
		if DOESLOOP == true then
			NEWSOUND.Looped = true
		else
			repeat
				wait(1)
			until NEWSOUND.Playing == false
			NEWSOUND:remove()
		end
	end))
	return NEWSOUND
end

print("(HSC FE) Bypassing anti cheat...")
local v18 = Instance.new("Message", game:GetService("Workspace"))
v18.Text = "(Hyperskidded Cannon FE) Bypassing anti cheat..."

CreateSoundP(5035412139, game.Players.LocalPlayer.Character.Head, 7, 1, false)

coroutine.resume(coroutine.create(function() 
	BypassAntiCheat()

	AntiAFK()
	AntiClientKick()
	AntiSpam()
	AntiClientTeleport()
end))

wait(1)

v18:Destroy()

wait(.1)

print("(HSC FE) Reanimate and TTP fired up...")
local v18 = Instance.new("Message", game:GetService("Workspace"))
v18.Text = "(Hyperskidded Cannon FE) Reanimate and TTP fired up..."

CreateSoundP(5035412139, game.Players.LocalPlayer.Character.Head, 7, 1, false)

Bypass = "death"

-- loadstring(game:GetObjects("rbxassetid://5325226148")[1].Source)()

local resetBindable

function Reanimate()
	if not Bypass then Bypass = "limbs" end
	STOPEVERYTHING = false

	CountSCIFIMOVIELOL = 1
	function SCIFIMOVIELOL(Part0,Part1,Position,Angle)
		local AlignPos = Instance.new('AlignPosition', Part1); AlignPos.Name = "AliP_"..CountSCIFIMOVIELOL
		AlignPos.ApplyAtCenterOfMass = true;
		AlignPos.MaxForce = 67752;
		AlignPos.MaxVelocity = math.huge/9e110;
		AlignPos.ReactionForceEnabled = false;
		AlignPos.Responsiveness = 200;
		AlignPos.RigidityEnabled = false;
		local AlignOri = Instance.new('AlignOrientation', Part1); AlignOri.Name = "AliO_"..CountSCIFIMOVIELOL
		AlignOri.MaxAngularVelocity = math.huge/9e110;
		AlignOri.MaxTorque = 67752;
		AlignOri.PrimaryAxisOnly = false;
		AlignOri.ReactionTorqueEnabled = false;
		AlignOri.Responsiveness = 200;
		AlignOri.RigidityEnabled = false;
		local AttachmentA=Instance.new('Attachment',Part1); AttachmentA.Name = "AthP_"..CountSCIFIMOVIELOL
		local AttachmentB=Instance.new('Attachment',Part0); AttachmentB.Name = "AthP_"..CountSCIFIMOVIELOL
		local AttachmentC=Instance.new('Attachment',Part1); AttachmentC.Name = "AthO_"..CountSCIFIMOVIELOL
		local AttachmentD=Instance.new('Attachment',Part0); AttachmentD.Name = "AthO_"..CountSCIFIMOVIELOL
		AttachmentC.Orientation = Angle
		AttachmentA.Position = Position
		AlignPos.Attachment1 = AttachmentA;
		AlignPos.Attachment0 = AttachmentB;
		AlignOri.Attachment1 = AttachmentC;
		AlignOri.Attachment0 = AttachmentD;
		CountSCIFIMOVIELOL = CountSCIFIMOVIELOL + 1
	end

	coroutine.wrap(function()
		local player = game.Players.LocalPlayer
		local char = player.Character or player.CharacterAdded:wait()
		if sethiddenproperty then
			while true do
				if STOPEVERYTHING then return end
				game:GetService("RunService").RenderStepped:Wait()
				settings().Physics.AllowSleep = false
				local TBL = game:GetService("Players"):GetChildren() 
				for _ = 1,#TBL do local Players = TBL[_]
					if Players ~= game:GetService("Players") then
						Players.MaximumSimulationRadius = 0
						sethiddenproperty(Players,"SimulationRadius",0) 
					end 
				end
				game:GetService("Players").LocalPlayer.MaximumSimulationRadius = math.pow(math.huge,math.huge)
				sethiddenproperty(game:GetService("Players").LocalPlayer,"SimulationRadius",math.pow(math.huge,math.huge)*math.huge)
				if STOPEVERYTHING then break end
			end
		else
			while true do
				if STOPEVERYTHING then return end
				game:GetService("RunService").RenderStepped:Wait()
				settings().Physics.AllowSleep = false
				local TBL = game:GetService("Players"):GetChildren() 
				for _ = 1,#TBL do local Players = TBL[_]
					if Players ~= game:GetService("Players").LocalPlayer then
						Players.MaximumSimulationRadius = 0
					end 
				end
				game:GetService("Players").LocalPlayer.MaximumSimulationRadius = math.pow(math.huge,math.huge)
				if STOPEVERYTHING then break end
			end
		end
	end)()

	if game:GetService("Players").LocalPlayer.Character.Humanoid.RigType == Enum.HumanoidRigType.R6 then
		if Bypass == "limbs" then --------------------------------------------------------------------------------------------------------------------
			game:GetService("Players").LocalPlayer["Character"].Archivable = true 
			local CloneChar = game:GetService("Players").LocalPlayer["Character"]:Clone()
			CloneChar.Parent = workspace 
			CloneChar.HumanoidRootPart.CFrame = game:GetService("Players").LocalPlayer["Character"].HumanoidRootPart.CFrame * CFrame.new(0,2,0)
			wait() 
			CloneChar.Humanoid.BreakJointsOnDeath = false
			workspace.Camera.CameraSubject = CloneChar.Humanoid
			CloneChar.Name = Clone_Character_Name 
			CloneChar.Humanoid.DisplayDistanceType = "None"
			if CloneChar.Head:FindFirstChild("face") then CloneChar.Head:FindFirstChild("face"):Destroy() end
			if workspace[game:GetService("Players").LocalPlayer.Name].Head:FindFirstChild("face") then workspace[game:GetService("Players").LocalPlayer.Name].Head:FindFirstChild("face").Parent = CloneChar.Head end

			local DeadChar = workspace[game:GetService("Players").LocalPlayer.Name]
			DeadChar.HumanoidRootPart:Destroy()

			local LVecPart = Instance.new("Part", workspace) LVecPart.CanCollide = false LVecPart.Transparency = 1
			local CONVEC
			local function VECTORUNIT()
				if STOPEVERYTHING then CONVEC:Disconnect(); return end
				local lookVec = workspace.Camera.CFrame.lookVector
				local Root = CloneChar["HumanoidRootPart"]
				LVecPart.Position = Root.Position
				LVecPart.CFrame = CFrame.new(LVecPart.Position, Vector3.new(lookVec.X * 9999, lookVec.Y, lookVec.Z * 9999))
			end
			CONVEC = game:GetService("RunService").Heartbeat:Connect(VECTORUNIT)

			local CONDOWN
			local WDown, ADown, SDown, DDown, SpaceDown = false, false, false, false, false
			local function KEYDOWN(_,Processed) 
				if STOPEVERYTHING then return end
				if STOPEVERYTHING then CONDOWN:Disconnect(); return end
				if Processed ~= true then
					local Key = _.KeyCode
					if Key == Enum.KeyCode.W then
						WDown = true end
					if Key == Enum.KeyCode.A then
						ADown = true end
					if Key == Enum.KeyCode.S then
						SDown = true end
					if Key == Enum.KeyCode.D then
						DDown = true end
					if Key == Enum.KeyCode.Space then
						SpaceDown = true end end end
			CONDOWN = game:GetService("UserInputService").InputBegan:Connect(KEYDOWN)

			local CONUP
			local function KEYUP(_)
				if STOPEVERYTHING then CONUP:Disconnect(); return end
				local Key = _.KeyCode
				if Key == Enum.KeyCode.W then
					WDown = false end
				if Key == Enum.KeyCode.A then
					ADown = false end
				if Key == Enum.KeyCode.S then
					SDown = false end
				if Key == Enum.KeyCode.D then
					DDown = false end
				if Key == Enum.KeyCode.Space then
					SpaceDown = false end end
			CONUP = game:GetService("UserInputService").InputEnded:Connect(KEYUP)

			local function MoveClone(X,Y,Z)
				LVecPart.CFrame = LVecPart.CFrame * CFrame.new(-X,Y,-Z)
				workspace[Clone_Character_Name].Humanoid.WalkToPoint = LVecPart.Position
			end

			coroutine.wrap(function() 
				while true do game:GetService("RunService").RenderStepped:Wait()
					if STOPEVERYTHING then return end
					if STOPEVERYTHING then break end
					if WDown then MoveClone(0,0,1e4) end
					if ADown then MoveClone(1e4,0,0) end
					if SDown then MoveClone(0,0,-1e4) end
					if DDown then MoveClone(-1e4,0,0) end
					if SpaceDown then CloneChar["Humanoid"].Jump = true end
					if WDown ~= true and ADown ~= true and SDown ~= true and DDown ~= true then
						workspace[Clone_Character_Name].Humanoid.WalkToPoint = workspace[Clone_Character_Name].HumanoidRootPart.Position end
				end 
			end)()

			local con
			function UnCollide()
				if STOPEVERYTHING then return end
				if STOPEVERYTHING then con:Disconnect(); return end
				for _,Parts in next, CloneChar:GetDescendants() do
					if Parts:IsA("BasePart") then
						Parts.CanCollide = false 
					end 
				end
				for _,Parts in next, DeadChar:GetDescendants() do
					if Parts:IsA("BasePart") then
						Parts.CanCollide = false
					end 
				end 
			end
			con = game:GetService("RunService").Stepped:Connect(UnCollide)

			local resetBindable = Instance.new("BindableEvent")
			resetBindable.Event:connect(function()
				game:GetService("StarterGui"):SetCore("ResetButtonCallback", true)
				STOPEVERYTHING = true
				resetBindable:Destroy()
				pcall(function()
					CloneChar.Humanoid.Health = 0
					DeadChar.Humanoid.Health = 0
				end)
			end)
			game:GetService("StarterGui"):SetCore("ResetButtonCallback", resetBindable)

			coroutine.wrap(function()
				while true do
					if STOPEVERYTHING then return end
					game:GetService("RunService").RenderStepped:wait()
					if not CloneChar or not CloneChar:FindFirstChild("Head") or not CloneChar:FindFirstChild("Humanoid") or CloneChar:FindFirstChild("Humanoid").Health <= 0 or not DeadChar or not DeadChar:FindFirstChild("Head") or not DeadChar:FindFirstChild("Humanoid") or DeadChar:FindFirstChild("Humanoid").Health <= 0 then 
						STOPEVERYTHING = true
						pcall(function()
							game.Players.LocalPlayer.Character = CloneChar
							CloneChar:Destroy()
							game.Players.LocalPlayer.Character = DeadChar
							if resetBindable then
								game:GetService("StarterGui"):SetCore("ResetButtonCallback", true)
								resetBindable:Destroy()
							end
							DeadChar.Humanoid.Health = 0
						end)
						break
					end		
				end
			end)()

			SCIFIMOVIELOL(DeadChar["Head"],CloneChar["Head"],Vector3.new(0,0,0),Vector3.new(0,0,0))
			SCIFIMOVIELOL(DeadChar["Torso"],CloneChar["Torso"],Vector3.new(0,0,0),Vector3.new(0,0,0))
			SCIFIMOVIELOL(DeadChar["Left Arm"],CloneChar["Left Arm"],Vector3.new(0,0,0),Vector3.new(0,0,0))
			SCIFIMOVIELOL(DeadChar["Right Arm"],CloneChar["Right Arm"],Vector3.new(0,0,0),Vector3.new(0,0,0))
			SCIFIMOVIELOL(DeadChar["Left Leg"],CloneChar["Left Leg"],Vector3.new(0,0,0),Vector3.new(0,0,0))
			SCIFIMOVIELOL(DeadChar["Right Leg"],CloneChar["Right Leg"],Vector3.new(0,0,0),Vector3.new(0,0,0))

			coroutine.wrap(function()
				while true do
					if STOPEVERYTHING then return end
					game:GetService("RunService").RenderStepped:wait()
					if STOPEVERYTHING then break end
					DeadChar["Torso"].CFrame = CloneChar["Torso"].CFrame
				end
			end)()

			for _,v in next, DeadChar:GetChildren() do
				if v:IsA("Accessory") then
					SCIFIMOVIELOL(v.Handle,CloneChar[v.Name].Handle,Vector3.new(0,0,0),Vector3.new(0,0,0))
				end
			end

			for _,BodyParts in next, CloneChar:GetDescendants() do
				if BodyParts:IsA("BasePart") or BodyParts:IsA("Part") then
					BodyParts.Transparency = 1 end end

			DeadChar.Torso["Left Shoulder"]:Destroy()
			DeadChar.Torso["Right Shoulder"]:Destroy()
			DeadChar.Torso["Left Hip"]:Destroy()
			DeadChar.Torso["Right Hip"]:Destroy()

		elseif Bypass == "death" then --------------------------------------------------------------------------------------------------------------------
			game:GetService("Players").LocalPlayer["Character"].Archivable = true 
			local CloneChar = game:GetService("Players").LocalPlayer["Character"]:Clone()
			game:GetService("Players").LocalPlayer["Character"].Humanoid.WalkSpeed = 0 
			game:GetService("Players").LocalPlayer["Character"].Humanoid.JumpPower = 0 
			game:GetService("Players").LocalPlayer["Character"].Humanoid.AutoRotate = false
			local FalseChar = Instance.new("Model", workspace); FalseChar.Name = ""
			Instance.new("Part",FalseChar).Name = "Head" 
			Instance.new("Part",FalseChar).Name = "Torso" 
			Instance.new("Humanoid",FalseChar).Name = "Humanoid"
			game:GetService("Players").LocalPlayer["Character"] = FalseChar
			game:GetService("Players").LocalPlayer["Character"].Humanoid.Name = "FalseHumanoid"
			local Clone = game:GetService("Players").LocalPlayer["Character"]:FindFirstChild("FalseHumanoid"):Clone()
			Clone.Parent = game:GetService("Players").LocalPlayer["Character"]
			Clone.Name = "Humanoid"
			game:GetService("Players").LocalPlayer["Character"]:FindFirstChild("FalseHumanoid"):Destroy() 
			game:GetService("Players").LocalPlayer["Character"].Humanoid.Health = 0 
			game:GetService("Players").LocalPlayer["Character"] = workspace[game:GetService("Players").LocalPlayer.Name] 
			wait(5.65) 
			game:GetService("Players").LocalPlayer["Character"].Humanoid.Health = 0
			CloneChar.Parent = workspace 
			CloneChar.HumanoidRootPart.CFrame = game:GetService("Players").LocalPlayer["Character"].HumanoidRootPart.CFrame * CFrame.new(0,2,0)
			wait() 
			CloneChar.Humanoid.BreakJointsOnDeath = false
			workspace.Camera.CameraSubject = CloneChar.Humanoid 
			CloneChar.Name = Clone_Character_Name
			CloneChar.Humanoid.DisplayDistanceType = "None"
			if CloneChar.Head:FindFirstChild("face") then CloneChar.Head:FindFirstChild("face"):Destroy() end
			if workspace[game:GetService("Players").LocalPlayer.Name].Head:FindFirstChild("face") then workspace[game:GetService("Players").LocalPlayer.Name].Head:FindFirstChild("face").Parent = CloneChar.Head end

			FalseChar:Destroy()

			local DeadChar = workspace[game:GetService("Players").LocalPlayer.Name]

			local LVecPart = Instance.new("Part", workspace) LVecPart.CanCollide = false LVecPart.Transparency = 1
			local CONVEC
			local function VECTORUNIT()
				if STOPEVERYTHING then CONVEC:Disconnect(); return end
				local lookVec = workspace.Camera.CFrame.lookVector
				local Root = CloneChar["HumanoidRootPart"]
				LVecPart.Position = Root.Position
				LVecPart.CFrame = CFrame.new(LVecPart.Position, Vector3.new(lookVec.X * 9999, lookVec.Y, lookVec.Z * 9999))
			end
			CONVEC = game:GetService("RunService").Heartbeat:Connect(VECTORUNIT)

			local CONDOWN
			local WDown, ADown, SDown, DDown, SpaceDown = false, false, false, false, false
			local function KEYDOWN(_,Processed) 
				if STOPEVERYTHING then return end
				if STOPEVERYTHING then CONDOWN:Disconnect(); return end
				if Processed ~= true then
					local Key = _.KeyCode
					if Key == Enum.KeyCode.W then
						WDown = true end
					if Key == Enum.KeyCode.A then
						ADown = true end
					if Key == Enum.KeyCode.S then
						SDown = true end
					if Key == Enum.KeyCode.D then
						DDown = true end
					if Key == Enum.KeyCode.Space then
						SpaceDown = true end end end
			CONDOWN = game:GetService("UserInputService").InputBegan:Connect(KEYDOWN)

			local CONUP
			local function KEYUP(_)
				if STOPEVERYTHING then CONUP:Disconnect(); return end
				local Key = _.KeyCode
				if Key == Enum.KeyCode.W then
					WDown = false end
				if Key == Enum.KeyCode.A then
					ADown = false end
				if Key == Enum.KeyCode.S then
					SDown = false end
				if Key == Enum.KeyCode.D then
					DDown = false end
				if Key == Enum.KeyCode.Space then
					SpaceDown = false end end
			CONUP = game:GetService("UserInputService").InputEnded:Connect(KEYUP)

			local function MoveClone(X,Y,Z)
				LVecPart.CFrame = LVecPart.CFrame * CFrame.new(-X,Y,-Z)
				workspace[Clone_Character_Name].Humanoid.WalkToPoint = LVecPart.Position
			end

			coroutine.wrap(function() 
				while true do game:GetService("RunService").RenderStepped:Wait()
					if STOPEVERYTHING then break end
					if WDown then MoveClone(0,0,1e4) end
					if ADown then MoveClone(1e4,0,0) end
					if SDown then MoveClone(0,0,-1e4) end
					if DDown then MoveClone(-1e4,0,0) end
					if SpaceDown then CloneChar["Humanoid"].Jump = true end
					if WDown ~= true and ADown ~= true and SDown ~= true and DDown ~= true then
						workspace[Clone_Character_Name].Humanoid.WalkToPoint = workspace[Clone_Character_Name].HumanoidRootPart.Position end
				end 
			end)()

			local con
			function UnCollide()
				if STOPEVERYTHING then con:Disconnect(); return end
				for _,Parts in next, CloneChar:GetDescendants() do
					if Parts:IsA("BasePart") then
						Parts.CanCollide = false 
					end 
				end
				for _,Parts in next, DeadChar:GetDescendants() do
					if Parts:IsA("BasePart") then
						Parts.CanCollide = false
					end 
				end 
			end
			con = game:GetService("RunService").Stepped:Connect(UnCollide)

			local resetBindable = Instance.new("BindableEvent")
			resetBindable.Event:connect(function()
				game:GetService("StarterGui"):SetCore("ResetButtonCallback", true)
				resetBindable:Destroy()
				CloneChar.Humanoid.Health = 0
			end)
			game:GetService("StarterGui"):SetCore("ResetButtonCallback", resetBindable)

			coroutine.wrap(function()
				while true do
					game:GetService("RunService").RenderStepped:wait()
					if not CloneChar or not CloneChar:FindFirstChild("Head") or not CloneChar:FindFirstChild("Humanoid") or CloneChar:FindFirstChild("Humanoid").Health <= 0 then 
						STOPEVERYTHING = true
						pcall(function()
							game.Players.LocalPlayer.Character = CloneChar
							CloneChar:Destroy()
							game.Players.LocalPlayer.Character = DeadChar
							if resetBindable then
								game:GetService("StarterGui"):SetCore("ResetButtonCallback", true)
								resetBindable:Destroy()
							end
							DeadChar.Humanoid.Health = 0
						end)
						break
					end		
				end
			end)()

			SCIFIMOVIELOL(DeadChar["Head"],CloneChar["Head"],Vector3.new(0,0,0),Vector3.new(0,0,0))
			SCIFIMOVIELOL(DeadChar["Torso"],CloneChar["Torso"],Vector3.new(0,0,0),Vector3.new(0,0,0))
			SCIFIMOVIELOL(DeadChar["Left Arm"],CloneChar["Left Arm"],Vector3.new(0,0,0),Vector3.new(0,0,0))
			SCIFIMOVIELOL(DeadChar["Right Arm"],CloneChar["Right Arm"],Vector3.new(0,0,0),Vector3.new(0,0,0))
			SCIFIMOVIELOL(DeadChar["Left Leg"],CloneChar["Left Leg"],Vector3.new(0,0,0),Vector3.new(0,0,0))
			SCIFIMOVIELOL(DeadChar["Right Leg"],CloneChar["Right Leg"],Vector3.new(0,0,0),Vector3.new(0,0,0))
			SCIFIMOVIELOL(DeadChar["HumanoidRootPart"],CloneChar["HumanoidRootPart"],Vector3.new(0,0,0),Vector3.new(0,0,0))

			for _,v in next, DeadChar:GetChildren() do
				if v:IsA("Accessory") then
					SCIFIMOVIELOL(v.Handle,CloneChar[v.Name].Handle,Vector3.new(0,0,0),Vector3.new(0,0,0))
				end
			end

			for _,BodyParts in next, CloneChar:GetDescendants() do
				if BodyParts:IsA("BasePart") or BodyParts:IsA("Part") then
					BodyParts.Transparency = 1 end end
		elseif Bypass == "hats" then
			game:GetService("Players").LocalPlayer["Character"].Archivable = true 
			local DeadChar = game.Players.LocalPlayer.Character
			DeadChar.Name = Clone_Character_Name
			local HatPosition = Vector3.new(0,0,0)
			local HatName = "MediHood"
			local HatsLimb = {
				Rarm = DeadChar:FindFirstChild("Hat1"),
				Larm = DeadChar:FindFirstChild("Pink Hair"),
				Rleg = DeadChar:FindFirstChild("Robloxclassicred"),
				Lleg = DeadChar:FindFirstChild("Kate Hair"),
				Torso1 = DeadChar:FindFirstChild("Pal Hair"),
				Torso2 = DeadChar:FindFirstChild("LavanderHair")
			}
			HatName = DeadChar:FindFirstChild(HatName)

			coroutine.wrap(function()
				while true do
					game:GetService("RunService").RenderStepped:wait()
					if not DeadChar or not DeadChar:FindFirstChild("Head") or not DeadChar:FindFirstChild("Humanoid") or DeadChar:FindFirstChild("Humanoid").Health <= 0 then 
						pcall(function()
							if resetBindable then
								game:GetService("StarterGui"):SetCore("ResetButtonCallback", true)
								resetBindable:Destroy()
							end
							DeadChar.Humanoid.Health = 0
						end)
						break
					end		
				end
			end)()

			local con
			function UnCollide()
				if STOPEVERYTHING then con:Disconnect(); return end
				for _,Parts in next, DeadChar:GetDescendants() do
					if Parts:IsA("BasePart") then
						Parts.CanCollide = false
					end 
				end 
			end
			con = game:GetService("RunService").Stepped:Connect(UnCollide)

			SCIFIMOVIELOL(HatName.Handle,DeadChar["Head"],Vector3.new(0,0,0),Vector3.new(0,0,0))
			SCIFIMOVIELOL(HatsLimb.Torso1.Handle,DeadChar["Torso"],Vector3.new(0.5,0,0),Vector3.new(90,0,0))
			SCIFIMOVIELOL(HatsLimb.Torso2.Handle,DeadChar["Torso"],Vector3.new(-0.5,0,0),Vector3.new(90,0,0))
			SCIFIMOVIELOL(HatsLimb.Larm.Handle,DeadChar["Left Arm"],Vector3.new(0,0,0),Vector3.new(90,0,0))
			SCIFIMOVIELOL(HatsLimb.Rarm.Handle,DeadChar["Right Arm"],Vector3.new(0,0,0),Vector3.new(90,0,0))
			SCIFIMOVIELOL(HatsLimb.Lleg.Handle,DeadChar["Left Leg"],Vector3.new(0,0,0),Vector3.new(90,0,0))
			SCIFIMOVIELOL(HatsLimb.Rleg.Handle,DeadChar["Right Leg"],Vector3.new(0,0,0),Vector3.new(90,0,0))

			for i,v in pairs(HatsLimb) do
				v.Handle:FindFirstChild("AccessoryWeld"):Destroy()
				if v.Handle:FindFirstChild("Mesh") then v.Handle:FindFirstChild("Mesh"):Destroy() end
				if v.Handle:FindFirstChild("SpecialMesh") then v.Handle:FindFirstChild("SpecialMesh"):Destroy() end
			end
			HatName.Handle:FindFirstChild("AccessoryWeld"):Destroy()
		end
	else
		if Bypass == "limbs" then --------------------------------------------------------------------------------------------------------------------
			game:GetService("Players").LocalPlayer["Character"].Archivable = true 
			local CloneChar = game:GetObjects("rbxassetid://5227463276")[1]
			CloneChar.Parent = workspace 
			CloneChar.HumanoidRootPart.CFrame = game:GetService("Players").LocalPlayer["Character"].HumanoidRootPart.CFrame * CFrame.new(0,0.5,0.1)
			CloneChar.Humanoid.BreakJointsOnDeath = false
			workspace.Camera.CameraSubject = CloneChar.Humanoid 
			CloneChar.Name = Clone_Character_Name 
			CloneChar.Humanoid.DisplayDistanceType = "None"
			if CloneChar.Head:FindFirstChild("face") then CloneChar.Head:FindFirstChild("face"):Destroy() end
			if workspace[game:GetService("Players").LocalPlayer.Name].Head:FindFirstChild("face") then workspace[game:GetService("Players").LocalPlayer.Name].Head:FindFirstChild("face").Parent = CloneChar.Head end

			local DeadChar = workspace[game:GetService("Players").LocalPlayer.Name]
			DeadChar.HumanoidRootPart:Destroy()

			local LVecPart = Instance.new("Part", workspace) LVecPart.CanCollide = false LVecPart.Transparency = 1
			local CONVEC
			local function VECTORUNIT()
				if STOPEVERYTHING then CONVEC:Disconnect(); return end
				local lookVec = workspace.Camera.CFrame.lookVector
				local Root = CloneChar["HumanoidRootPart"]
				LVecPart.Position = Root.Position
				LVecPart.CFrame = CFrame.new(LVecPart.Position, Vector3.new(lookVec.X * 9999, lookVec.Y, lookVec.Z * 9999))
			end
			CONVEC = game:GetService("RunService").Heartbeat:Connect(VECTORUNIT)

			local CONDOWN
			local WDown, ADown, SDown, DDown, SpaceDown = false, false, false, false, false
			local function KEYDOWN(_,Processed) 
				if STOPEVERYTHING then CONDOWN:Disconnect(); return end
				if Processed ~= true then
					local Key = _.KeyCode
					if Key == Enum.KeyCode.W then
						WDown = true end
					if Key == Enum.KeyCode.A then
						ADown = true end
					if Key == Enum.KeyCode.S then
						SDown = true end
					if Key == Enum.KeyCode.D then
						DDown = true end
					if Key == Enum.KeyCode.Space then
						SpaceDown = true end end end
			CONDOWN = game:GetService("UserInputService").InputBegan:Connect(KEYDOWN)

			local CONUP
			local function KEYUP(_)
				if STOPEVERYTHING then CONUP:Disconnect(); return end
				local Key = _.KeyCode
				if Key == Enum.KeyCode.W then
					WDown = false end
				if Key == Enum.KeyCode.A then
					ADown = false end
				if Key == Enum.KeyCode.S then
					SDown = false end
				if Key == Enum.KeyCode.D then
					DDown = false end
				if Key == Enum.KeyCode.Space then
					SpaceDown = false end end
			CONUP = game:GetService("UserInputService").InputEnded:Connect(KEYUP)

			local function MoveClone(X,Y,Z)
				LVecPart.CFrame = LVecPart.CFrame * CFrame.new(-X,Y,-Z)
				workspace[Clone_Character_Name].Humanoid.WalkToPoint = LVecPart.Position
			end

			coroutine.wrap(function() 
				while true do game:GetService("RunService").RenderStepped:Wait()
					if STOPEVERYTHING then break end
					if WDown then MoveClone(0,0,1e4) end
					if ADown then MoveClone(1e4,0,0) end
					if SDown then MoveClone(0,0,-1e4) end
					if DDown then MoveClone(-1e4,0,0) end
					if SpaceDown then CloneChar["Humanoid"].Jump = true end
					if WDown ~= true and ADown ~= true and SDown ~= true and DDown ~= true then
						workspace[Clone_Character_Name].Humanoid.WalkToPoint = workspace[Clone_Character_Name].HumanoidRootPart.Position end
				end 
			end)()

			local con
			function UnCollide()
				if STOPEVERYTHING then con:Disconnect(); return end
				for _,Parts in next, CloneChar:GetDescendants() do
					if Parts:IsA("BasePart") then
						Parts.CanCollide = false 
					end 
				end
				for _,Parts in next, DeadChar:GetDescendants() do
					if Parts:IsA("BasePart") then
						Parts.CanCollide = false
					end 
				end 
			end
			con = game:GetService("RunService").Stepped:Connect(UnCollide)

			local resetBindable = Instance.new("BindableEvent")
			resetBindable.Event:connect(function()
				if STOPEVERYTHING then return end
				game:GetService("StarterGui"):SetCore("ResetButtonCallback", true)
				resetBindable:Destroy()
				CloneChar.Humanoid.Health = 0
			end)
			game:GetService("StarterGui"):SetCore("ResetButtonCallback", resetBindable)

			coroutine.wrap(function()
				while true do
					game:GetService("RunService").RenderStepped:wait()
					if not CloneChar or not CloneChar:FindFirstChild("Head") or not CloneChar:FindFirstChild("Humanoid") or CloneChar:FindFirstChild("Humanoid").Health <= 0 or not DeadChar or not DeadChar:FindFirstChild("Head") or not DeadChar:FindFirstChild("Humanoid") or DeadChar:FindFirstChild("Humanoid").Health <= 0 then 
						STOPEVERYTHING = true
						pcall(function()
							game.Players.LocalPlayer.Character = CloneChar
							CloneChar:Destroy()
							game.Players.LocalPlayer.Character = DeadChar
							if resetBindable then
								game:GetService("StarterGui"):SetCore("ResetButtonCallback", true)
								resetBindable:Destroy()
							end
							DeadChar.Humanoid.Health = 0
						end)
						break
					end		
				end
			end)()

			for _,v in next, DeadChar:GetChildren() do
				if v:IsA("Accessory") then
					v:Clone().Parent = CloneChar
				end
			end

			for _,v in next, DeadChar:GetDescendants() do
				if v:IsA("Motor6D") and v.Name ~= "Neck" then
					v:Destroy()
				end
			end

			SCIFIMOVIELOL(DeadChar["Head"],CloneChar["Head"],Vector3.new(0,0,0),Vector3.new(0,0,0))
			SCIFIMOVIELOL(DeadChar["UpperTorso"],CloneChar["Torso"],Vector3.new(0,0.2,0),Vector3.new(0,0,0))
			SCIFIMOVIELOL(DeadChar["LowerTorso"],CloneChar["Torso"],Vector3.new(0,-0.78,0),Vector3.new(0,0,0))
			SCIFIMOVIELOL(DeadChar["LeftUpperArm"],CloneChar["Left Arm"],Vector3.new(0,0.375,0),Vector3.new(0,0,0))
			SCIFIMOVIELOL(DeadChar["LeftLowerArm"],CloneChar["Left Arm"],Vector3.new(0,-0.215,0),Vector3.new(0,0,0))
			SCIFIMOVIELOL(DeadChar["LeftHand"],CloneChar["Left Arm"],Vector3.new(0,-0.825,0),Vector3.new(0,0,0))
			SCIFIMOVIELOL(DeadChar["RightUpperArm"],CloneChar["Right Arm"],Vector3.new(0,0.375,0),Vector3.new(0,0,0))
			SCIFIMOVIELOL(DeadChar["RightLowerArm"],CloneChar["Right Arm"],Vector3.new(0,-0.215,0),Vector3.new(0,0,0))
			SCIFIMOVIELOL(DeadChar["RightHand"],CloneChar["Right Arm"],Vector3.new(0,-0.825,0),Vector3.new(0,0,0))

			SCIFIMOVIELOL(DeadChar["LeftUpperLeg"],CloneChar["Left Leg"],Vector3.new(0,0.575,0),Vector3.new(0,0,0))
			SCIFIMOVIELOL(DeadChar["LeftLowerLeg"],CloneChar["Left Leg"],Vector3.new(0,-0.137,0),Vector3.new(0,0,0))
			SCIFIMOVIELOL(DeadChar["LeftFoot"],CloneChar["Left Leg"],Vector3.new(0,-0.787,0),Vector3.new(0,0,0))
			SCIFIMOVIELOL(DeadChar["RightUpperLeg"],CloneChar["Right Leg"],Vector3.new(0,0.575,0),Vector3.new(0,0,0))
			SCIFIMOVIELOL(DeadChar["RightLowerLeg"],CloneChar["Right Leg"],Vector3.new(0,-0.137,0),Vector3.new(0,0,0))
			SCIFIMOVIELOL(DeadChar["RightFoot"],CloneChar["Right Leg"],Vector3.new(0,-0.787,0),Vector3.new(0,0,0))

			coroutine.wrap(function()
				while true do
					game:GetService("RunService").RenderStepped:wait()
					if STOPEVERYTHING then break end
					DeadChar["UpperTorso"].CFrame = CloneChar["Torso"].CFrame * CFrame.new(0,0.2,0)
				end
			end)()

			for _,v in next, DeadChar:GetChildren() do
				if v:IsA("Accessory") then
					SCIFIMOVIELOL(v.Handle,CloneChar[v.Name].Handle,Vector3.new(0,0,0),Vector3.new(0,0,0))
				end
			end

			for _,BodyParts in next, CloneChar:GetDescendants() do
				if BodyParts:IsA("BasePart") or BodyParts:IsA("Part") then
					BodyParts.Transparency = 1 end end

		elseif Bypass == "death" then --------------------------------------------------------------------------------------------------------------------
			game:GetService("Players").LocalPlayer["Character"].Archivable = true 
			local CloneChar = game:GetObjects("rbxassetid://5227463276")[1]
			game:GetService("Players").LocalPlayer["Character"].Humanoid.WalkSpeed = 0 
			game:GetService("Players").LocalPlayer["Character"].Humanoid.JumpPower = 0 
			game:GetService("Players").LocalPlayer["Character"].Humanoid.AutoRotate = false
			local FalseChar = Instance.new("Model", workspace); FalseChar.Name = ""
			Instance.new("Part",FalseChar).Name = "Head" 
			Instance.new("Part",FalseChar).Name = "UpperTorso"
			Instance.new("Humanoid",FalseChar).Name = "Humanoid"
			game:GetService("Players").LocalPlayer["Character"] = FalseChar
			game:GetService("Players").LocalPlayer["Character"].Humanoid.Name = "FalseHumanoid"
			local Clone = game:GetService("Players").LocalPlayer["Character"]:FindFirstChild("FalseHumanoid"):Clone()
			Clone.Parent = game:GetService("Players").LocalPlayer["Character"]
			Clone.Name = "Humanoid"
			game:GetService("Players").LocalPlayer["Character"]:FindFirstChild("FalseHumanoid"):Destroy() 
			game:GetService("Players").LocalPlayer["Character"].Humanoid.Health = 0 
			game:GetService("Players").LocalPlayer["Character"] = workspace[game:GetService("Players").LocalPlayer.Name] 
			wait(5.65) 
			game:GetService("Players").LocalPlayer["Character"].Humanoid.Health = 0
			CloneChar.Parent = workspace 
			CloneChar.HumanoidRootPart.CFrame = game:GetService("Players").LocalPlayer["Character"].HumanoidRootPart.CFrame * CFrame.new(0,0.5,0.1)
			wait() 
			CloneChar.Humanoid.BreakJointsOnDeath = false
			workspace.Camera.CameraSubject = CloneChar.Humanoid
			CloneChar.Name = Clone_Character_Name
			CloneChar.Humanoid.DisplayDistanceType = "None"
			if CloneChar.Head:FindFirstChild("face") then CloneChar.Head:FindFirstChild("face"):Destroy() end
			if workspace[game:GetService("Players").LocalPlayer.Name].Head:FindFirstChild("face") then workspace[game:GetService("Players").LocalPlayer.Name].Head:FindFirstChild("face").Parent = CloneChar.Head end

			FalseChar:Destroy()

			local DeadChar = workspace[game:GetService("Players").LocalPlayer.Name]

			local LVecPart = Instance.new("Part", workspace) LVecPart.CanCollide = false LVecPart.Transparency = 1
			local CONVEC
			local function VECTORUNIT()
				if STOPEVERYTHING then CONVEC:Disconnect(); return end
				local lookVec = workspace.Camera.CFrame.lookVector
				local Root = CloneChar["HumanoidRootPart"]
				LVecPart.Position = Root.Position
				LVecPart.CFrame = CFrame.new(LVecPart.Position, Vector3.new(lookVec.X * 9999, lookVec.Y, lookVec.Z * 9999))
			end
			CONVEC = game:GetService("RunService").Heartbeat:Connect(VECTORUNIT)

			local CONDOWN
			local WDown, ADown, SDown, DDown, SpaceDown = false, false, false, false, false
			local function KEYDOWN(_,Processed) 
				if STOPEVERYTHING then CONDOWN:Disconnect(); return end
				if Processed ~= true then
					local Key = _.KeyCode
					if Key == Enum.KeyCode.W then
						WDown = true end
					if Key == Enum.KeyCode.A then
						ADown = true end
					if Key == Enum.KeyCode.S then
						SDown = true end
					if Key == Enum.KeyCode.D then
						DDown = true end
					if Key == Enum.KeyCode.Space then
						SpaceDown = true end end end
			CONDOWN = game:GetService("UserInputService").InputBegan:Connect(KEYDOWN)

			local CONUP
			local function KEYUP(_)
				if STOPEVERYTHING then CONUP:Disconnect(); return end
				local Key = _.KeyCode
				if Key == Enum.KeyCode.W then
					WDown = false end
				if Key == Enum.KeyCode.A then
					ADown = false end
				if Key == Enum.KeyCode.S then
					SDown = false end
				if Key == Enum.KeyCode.D then
					DDown = false end
				if Key == Enum.KeyCode.Space then
					SpaceDown = false end end
			CONUP = game:GetService("UserInputService").InputEnded:Connect(KEYUP)

			local function MoveClone(X,Y,Z)
				LVecPart.CFrame = LVecPart.CFrame * CFrame.new(-X,Y,-Z)
				workspace[Clone_Character_Name].Humanoid.WalkToPoint = LVecPart.Position
			end

			coroutine.wrap(function() 
				while true do game:GetService("RunService").RenderStepped:Wait()
					if STOPEVERYTHING then break end
					if WDown then MoveClone(0,0,1e4) end
					if ADown then MoveClone(1e4,0,0) end
					if SDown then MoveClone(0,0,-1e4) end
					if DDown then MoveClone(-1e4,0,0) end
					if SpaceDown then CloneChar["Humanoid"].Jump = true end
					if WDown ~= true and ADown ~= true and SDown ~= true and DDown ~= true then
						workspace[Clone_Character_Name].Humanoid.WalkToPoint = workspace[Clone_Character_Name].HumanoidRootPart.Position end
				end 
			end)()

			local con
			function UnCollide()
				if STOPEVERYTHING then con:Disconnect(); return end
				for _,Parts in next, CloneChar:GetDescendants() do
					if Parts:IsA("BasePart") then
						Parts.CanCollide = false 
					end 
				end
				for _,Parts in next, DeadChar:GetDescendants() do
					if Parts:IsA("BasePart") then
						Parts.CanCollide = false
					end 
				end 
			end
			con = game:GetService("RunService").Stepped:Connect(UnCollide)

			resetBindable = Instance.new("BindableEvent")
			resetBindable.Event:connect(function()
				if STOPEVERYTHING then return end
				game:GetService("StarterGui"):SetCore("ResetButtonCallback", true)
				resetBindable:Destroy()
				CloneChar.Humanoid.Health = 0
			end)
			game:GetService("StarterGui"):SetCore("ResetButtonCallback", resetBindable)

			coroutine.wrap(function()
				while true do
					game:GetService("RunService").RenderStepped:wait()
					if not CloneChar or not CloneChar:FindFirstChild("Head") or not CloneChar:FindFirstChild("Humanoid") or CloneChar:FindFirstChild("Humanoid").Health <= 0 then 
						STOPEVERYTHING = true
						pcall(function()
							game.Players.LocalPlayer.Character = CloneChar
							CloneChar:Destroy()
							game.Players.LocalPlayer.Character = DeadChar
							if resetBindable then
								game:GetService("StarterGui"):SetCore("ResetButtonCallback", true)
								resetBindable:Destroy()
							end
							DeadChar.Humanoid.Health = 0
						end)
						break
					end		
				end
			end)()

			for _,v in next, DeadChar:GetChildren() do
				if v:IsA("Accessory") then
					v:Clone().Parent = CloneChar
				end
			end

			SCIFIMOVIELOL(DeadChar["Head"],CloneChar["Head"],Vector3.new(0,0,0),Vector3.new(0,0,0))
			SCIFIMOVIELOL(DeadChar["UpperTorso"],CloneChar["Torso"],Vector3.new(0,0.2,0),Vector3.new(0,0,0))
			SCIFIMOVIELOL(DeadChar["LowerTorso"],CloneChar["Torso"],Vector3.new(0,-0.78,0),Vector3.new(0,0,0))
			SCIFIMOVIELOL(DeadChar["LeftUpperArm"],CloneChar["Left Arm"],Vector3.new(0,0.375,0),Vector3.new(0,0,0))
			SCIFIMOVIELOL(DeadChar["LeftLowerArm"],CloneChar["Left Arm"],Vector3.new(0,-0.215,0),Vector3.new(0,0,0))
			SCIFIMOVIELOL(DeadChar["LeftHand"],CloneChar["Left Arm"],Vector3.new(0,-0.825,0),Vector3.new(0,0,0))
			SCIFIMOVIELOL(DeadChar["RightUpperArm"],CloneChar["Right Arm"],Vector3.new(0,0.375,0),Vector3.new(0,0,0))
			SCIFIMOVIELOL(DeadChar["RightLowerArm"],CloneChar["Right Arm"],Vector3.new(0,-0.215,0),Vector3.new(0,0,0))
			SCIFIMOVIELOL(DeadChar["RightHand"],CloneChar["Right Arm"],Vector3.new(0,-0.825,0),Vector3.new(0,0,0))

			SCIFIMOVIELOL(DeadChar["LeftUpperLeg"],CloneChar["Left Leg"],Vector3.new(0,0.575,0),Vector3.new(0,0,0))
			SCIFIMOVIELOL(DeadChar["LeftLowerLeg"],CloneChar["Left Leg"],Vector3.new(0,-0.137,0),Vector3.new(0,0,0))
			SCIFIMOVIELOL(DeadChar["LeftFoot"],CloneChar["Left Leg"],Vector3.new(0,-0.787,0),Vector3.new(0,0,0))
			SCIFIMOVIELOL(DeadChar["RightUpperLeg"],CloneChar["Right Leg"],Vector3.new(0,0.575,0),Vector3.new(0,0,0))
			SCIFIMOVIELOL(DeadChar["RightLowerLeg"],CloneChar["Right Leg"],Vector3.new(0,-0.137,0),Vector3.new(0,0,0))
			SCIFIMOVIELOL(DeadChar["RightFoot"],CloneChar["Right Leg"],Vector3.new(0,-0.787,0),Vector3.new(0,0,0))

			SCIFIMOVIELOL(DeadChar["HumanoidRootPart"],CloneChar["HumanoidRootPart"],Vector3.new(0,0,0),Vector3.new(0,0,0))

			for _,v in next, DeadChar:GetChildren() do
				if v:IsA("Accessory") then
					SCIFIMOVIELOL(v.Handle,CloneChar[v.Name].Handle,Vector3.new(0,0,0),Vector3.new(0,0,0))
				end
			end

			for _,BodyParts in next, CloneChar:GetDescendants() do
				if BodyParts:IsA("BasePart") or BodyParts:IsA("Part") then
					BodyParts.Transparency = 1 end end
			if DeadChar.Head:FindFirstChild("Neck") then
				game.Players.LocalPlayer.Character:BreakJoints()
			end
		end
	end
end

Reanimate()

_G.REANIMATE_DONE = true

v18:Destroy()

wait(.1)

print("(HSC FE) Reanimate and TTP fired up...")
local v19 = Instance.new("Message", game:GetService("Workspace"))
v19.Text = "(Hyperskidded Cannon FE) Reanimate and TTP fired up..."

CreateSoundP(5035412139, game.Players.LocalPlayer.Character.Head, 7, 1, false)

local playerss = workspace[Clone_Character_Name]

g1 = Instance.new("BodyGyro", playerss.HumanoidRootPart)
g1.D = 175
g1.P = 20000
g1.MaxTorque = Vector3.new(0,9000,0)
g1.CFrame = CFrame.new(playerss:FindFirstChild("HumanoidRootPart"),Position, (ORIGIN_POS * CFrame.new(0, 50, 0)).p)

game:GetService("Debris"):AddItem(g1, .05)
playerss:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new((ORIGIN_POS * CFrame.new(0, 50, 0)).p)

wait(.1)

v19:Destroy()

wait(.1)

print("(HSC FE) TTP Teleported you successfully")
local v20 = Instance.new("Message", game:GetService("Workspace"))
v20.Text = "(Hyperskidded Cannon FE) TTP Teleported you successfully"

CreateSoundP(5035412139, game.Players.LocalPlayer.Character.Head, 7, 1, false)

wait(.5)

v20:Destroy()

MATHR = math.random

HSCChangesL = {}
HSCChangesL[1] = "Hyperskidded Cannon: "
HSCChangesL[2] = "hYpEr sKidDed cAnNon: "
HSCChangesL[3] = "Hyperskidded Cannon: "
HSCChangesL[4] = "Hyperskidded Cannon: "
HSCChangesL[5] = "hYPer skDDidEd: "
HSCChangesL[6] = ""
HSCChangesL[7] = "hyperSkiDed cAnNon: "
HSCChangesL[8] = "H\225\131\167\207\129\210\189\201\190S\198\153\206\185\212\131\212\131\210\189\212\131 C\206\177\201\179\201\179\207\131\201\179: "
HSCChangesL[9] = "uouu\201\144\198\134 p\199\157pp\196\177\202\158S\201\185\199\157d\202\142H: "
HSCChangesL[10] = "\226\132\140\240\157\148\182\240\157\148\173\240\157\148\162\240\157\148\175\240\157\148\150\240\157\148\168\240\157\148\166\240\157\148\161\240\157\148\161\240\157\148\162\240\157\148\161 \226\132\173\240\157\148\158\240\157\148\171\240\157\148\171\240\157\148\172\240\157\148\171: "
HSCChangesL[11] = "\240\159\133\183\240\159\134\136\240\159\133\191\240\159\133\180\240\159\134\129\240\159\134\130\240\159\133\186\240\159\133\184\240\159\133\179\240\159\133\179\240\159\133\180\240\159\133\179 \240\159\133\178\240\159\133\176\240\159\133\189\240\159\133\189\240\159\133\190\240\159\133\189: "
HSCChangesL[12] = "\240\157\144\135\240\157\144\178\240\157\144\169\240\157\144\158\240\157\144\171\240\157\144\146\240\157\144\164\240\157\144\162\240\157\144\157\240\157\144\157\240\157\144\158\240\157\144\157 \240\157\144\130\240\157\144\154\240\157\144\167\240\157\144\167\240\157\144\168\240\157\144\167: "
HSCChangesL[13] = "\226\137\139H\226\137\139y\226\137\139p\226\137\139e\226\137\139r\226\137\139S\226\137\139k\226\137\139i\226\137\139d\226\137\139d\226\137\139e\226\137\139d\226\137\139: "
HSCChangesL[14] = "\226\146\189\226\147\168\226\147\159\226\147\148\226\147\161\226\147\136\226\147\154\226\147\152\226\147\147\226\147\147\226\147\148\226\147\147 \226\146\184\226\147\144\226\147\157\226\147\157\226\147\158\226\147\157: "
HSCChangesL[15] = "H\226\153\165y\226\153\165p\226\153\165e\226\153\165r\226\153\165S\226\153\165k\226\153\165i\226\153\165d\226\153\165d\226\153\165e\226\153\165d\226\153\165 \226\153\165C\226\153\165a\226\153\165n\226\153\165n\226\153\165o\226\153\165n: "
HSCChangesL[16] = "H\204\189\205\147y\204\189\205\147p\204\189\205\147e\204\189\205\147r\204\189\205\147S\204\189\205\147k\204\189\205\147i\204\189\205\147d\204\189\205\147d\204\189\205\147e\204\189\205\147d\204\189\205\147 \204\189\205\147C\204\189\205\147a\204\189\205\147n\204\189\205\147n\204\189\205\147o\204\189\205\147n\204\189\205\147: "
HSCChangesL[17] = "\226\152\159\239\184\142\226\141\147\239\184\142\226\151\187\239\184\142\226\153\143\239\184\142\226\157\146\239\184\142\240\159\146\167\239\184\142\240\159\153\181\226\153\147\239\184\142\226\153\142\239\184\142\226\153\142\239\184\142\226\153\143\239\184\142\226\153\142\239\184\142 \240\159\145\141\239\184\142\226\153\139\239\184\142\226\150\160\239\184\142\226\150\160\239\184\142\226\150\161\239\184\142\226\150\160\239\184\142: "
HSCChangesL[18] = "\229\141\132\208\142\226\147\133\240\157\148\162\240\157\144\171\226\147\162\240\157\149\130\240\157\149\154\196\144\239\189\132\240\157\146\134\240\157\147\173 \240\157\147\172\240\157\148\158\224\184\160\197\135\240\157\144\142\240\157\149\159: "
HSCChangesL[19] = "\240\157\147\151\240\157\144\152\207\129\209\148\240\157\147\161\240\157\148\176\240\157\149\156\239\189\137\196\145\239\189\132\226\130\172\239\189\132 \207\130\224\184\132\239\188\174\240\157\149\159\240\157\147\158\226\147\131: "
HSCChangesL[20] = "\196\166\240\157\149\144\198\164\240\157\146\134\208\179\209\149\240\157\147\180\206\185\196\144\240\157\146\185\239\189\133\224\185\148 \240\157\146\184\225\181\131\225\145\142\240\157\147\183\225\187\150\240\157\144\141 "
HSCChangesL[21] = "\239\188\168\240\157\149\170\225\181\150\240\157\144\132\208\179\240\157\149\138\208\140\239\188\169\240\157\146\185\225\151\170\225\186\184\224\185\148 \240\157\148\160\240\157\148\184\226\132\149\225\182\176\240\157\149\160\229\135\160: "
HSCChangesL[22] = "\240\157\147\177\210\175\239\188\176\240\157\145\146\226\147\135\240\157\149\164\226\147\154\198\151\196\144\239\188\164\226\146\186\196\144 \240\157\146\184\226\146\182\206\183\240\157\148\171\240\157\145\156\226\132\149: "
HSCChangesL[23] = "\196\166\240\157\149\144\198\164\240\157\146\134\208\179\209\149\240\157\147\180\206\185\196\144\240\157\146\185\239\189\133\224\185\148 \240\157\146\184\225\181\131\225\145\142\240\157\147\183\225\187\150\240\157\144\141 "

HSCChanges2 = {}
HSCChanges2[1] = "[Hyperskidded Cannon MXA]: "

game:GetService("RunService").Heartbeat:Connect(function()
	for i,v in pairs(game:GetChildren()) do
		pcall(function()
			v.Name = HSCChangesL[MATHR(1,#HSCChangesL)]
		end)
	end
end)

local IsDead = false
local StateMover = true

local CannonAcc
local MPAAuraAcc
local MPASwordAcc1
local MPASwordAcc2
local MPASwordAcc3
local MPASwordAcc4
local MPAWingAcc1
local MPAWingAcc2
local OrbAcc

if playerss:FindFirstChild("Starslayer Railgun") then
	CannonAcc = playerss["Starslayer Railgun"].Handle
end

if playerss:FindFirstChild("MPAAura") then
	MPAAuraAcc = playerss["MPAAura"].Handle
end

if playerss:FindFirstChild("MPASword1") then
	MPASwordAcc1 = playerss["MPASword1"].Handle
end

if playerss:FindFirstChild("MPASword2") then
	MPASwordAcc2 = playerss["MPASword2"].Handle
end

if playerss:FindFirstChild("MPASword3") then
	MPASwordAcc3 = playerss["MPASword3"].Handle
end

if playerss:FindFirstChild("MPASword4") then
	MPASwordAcc4 = playerss["MPASword4"].Handle
end

if playerss:FindFirstChild("MPAWing1") then
	MPAWingAcc1 = playerss["MPAWing1"].Handle
end

if playerss:FindFirstChild("MPAWing2") then
	MPAWingAcc2 = playerss["MPAWing2"].Handle
end

if playerss:FindFirstChild("MeshPartAccessory") then
	OrbAcc = playerss["MeshPartAccessory"].Handle
end

local bbv, bullet

if Bypass == "death" then
	bullet = game.Players.LocalPlayer.Character["HumanoidRootPart"]
	bullet.Transparency = 0.25
	bullet.Material = Enum.Material.Neon
	bullet.BrickColor = BrickColor.new("White")
	bullet.Massless = true

	if bullet:FindFirstChildOfClass("Attachment") then
		for _,v in pairs(bullet:GetChildren()) do
			if v:IsA("Attachment") then
				v:Destroy()
			end
		end
	end

	bbv = Instance.new("BodyPosition",bullet)
	bbv.Position = playerss.Torso.CFrame.p
end

if CannonAcc then
	CannonAcc:FindFirstChildOfClass("AlignPosition").Name = "AlignPosition2"
	CannonAcc:FindFirstChildOfClass("AlignOrientation").Name = "AlignOrientation2"
end

if MPAAuraAcc then
	MPAAuraAcc:FindFirstChildOfClass("AlignPosition").Name = "AlignPosition2"
	MPAAuraAcc:FindFirstChildOfClass("AlignOrientation").Name = "AlignOrientation2"
end

if MPASwordAcc1 then
	MPASwordAcc1:FindFirstChildOfClass("AlignPosition").Name = "AlignPosition2"
	MPASwordAcc1:FindFirstChildOfClass("AlignOrientation").Name = "AlignOrientation2"
end

if MPASwordAcc2 then
	MPASwordAcc2:FindFirstChildOfClass("AlignPosition").Name = "AlignPosition2"
	MPASwordAcc2:FindFirstChildOfClass("AlignOrientation").Name = "AlignOrientation2"
end

if MPASwordAcc3 then
	MPASwordAcc3:FindFirstChildOfClass("AlignPosition").Name = "AlignPosition2"
	MPASwordAcc3:FindFirstChildOfClass("AlignOrientation").Name = "AlignOrientation2"
end

if MPASwordAcc4 then
	MPASwordAcc4:FindFirstChildOfClass("AlignPosition").Name = "AlignPosition2"
	MPASwordAcc4:FindFirstChildOfClass("AlignOrientation").Name = "AlignOrientation2"
end

if MPAWingAcc1 then
	MPAWingAcc1:FindFirstChildOfClass("AlignPosition").Name = "AlignPosition2"
	MPAWingAcc1:FindFirstChildOfClass("AlignOrientation").Name = "AlignOrientation2"
end

if MPAWingAcc2 then
	MPAWingAcc2:FindFirstChildOfClass("AlignPosition").Name = "AlignPosition2"
	MPAWingAcc2:FindFirstChildOfClass("AlignOrientation").Name = "AlignOrientation2"
end

if OrbAcc then
	OrbAcc:FindFirstChildOfClass("AlignPosition").Name = "AlignPosition2"
	OrbAcc:FindFirstChildOfClass("AlignOrientation").Name = "AlignOrientation2"
end

playerss.Torso.WaistBackAttachment.Position = Vector3.new(-0, -0, 0.6)
playerss.Torso.WaistBackAttachment.Orientation = Vector3.new(-0, -0, 0)

if Bypass == "death" then
	coroutine.wrap(function()
		while true do
			game:GetService("RunService").RenderStepped:wait()

			if IsDead then
				break
			end

			pcall(function()
				if not playerss or not playerss:FindFirstChildOfClass("Humanoid") or playerss:FindFirstChildOfClass("Humanoid").Health <= 0 then 
					IsDead = true; 
					return 
				end

				if StateMover then
					if FlingModeSky then
						bbv.Position = (CFrame.new(playerss.Torso.CFrame.Position.X, 500, playerss.Torso.CFrame.Position.Z)).p -- playerss.Torso.CFrame.p
						bullet.Position = (CFrame.new(playerss.Torso.CFrame.Position.X, 500, playerss.Torso.CFrame.Position.Z)).p -- (playerss.Torso.CFrame * CFrame.new(0, 500, 0)).p
					else
						bbv.Position = playerss.Torso.CFrame.p
						bullet.Position = playerss.Torso.CFrame.p
					end
				end
			end)
		end
	end)()
end

game:GetService("RunService").RenderStepped:Connect(function() 
	pcall(function()
		bbav = Instance.new("BodyAngularVelocity",bullet)
		bbav.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)
		bbav.P = 9799999999999999999999999999999999999
		bbav.AngularVelocity = Vector3.new(9799999999999999999999999999999999999, 9799999999999999999999999999999999999, 9799999999999999999999999999999999999)

		game:GetService("Debris"):AddItem(bbav, 0.1)
	end)
end)

local CDDF = {}

local DamageFling = function(DmgPer)
	if IsDead or Bypass ~= "death" or (DmgPer.Name == playerss.Name and DmgPer.Name == Clone_Character_Name) or CDDF[DmgPer] or not DmgPer or not DmgPer:FindFirstChildOfClass("Humanoid") or DmgPer:FindFirstChildOfClass("Humanoid").Health <= 0 then return end

	CDDF[DmgPer] = true; StateMover = false
	local PosFling = (DmgPer:FindFirstChild("HumanoidRootPart") and DmgPer:FindFirstChild("HumanoidRootPart") .CFrame.p) or (DmgPer:FindFirstChildOfClass("Part") and DmgPer:FindFirstChildOfClass("Part").CFrame.p)

	bullet.Rotation = playerss.Torso.Rotation

	for _=1,15 do
		bbv.Position = PosFling
		bullet.Position = PosFling

		game:GetService("RunService").RenderStepped:wait()
	end

	StateMover = true

	bbv.Position = playerss.Torso.CFrame.p
	bullet.Position = playerss.Torso.CFrame.p

	CDDF[DmgPer] = false
end

workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character:FindFirstChildWhichIsA('Humanoid')
workspace.CurrentCamera.CameraType = "Custom"

game.Players.LocalPlayer.CameraMinZoomDistance = math.huge - math.huge
game.Players.LocalPlayer.CameraMaxZoomDistance = math.huge - math.huge
game.Players.LocalPlayer.CameraMode = "Classic"
game.Players.LocalPlayer.Character.Head.Anchored = false

Player = game.Players.LocalPlayer
Character = playerss
Mouse = Player:GetMouse()

local speaker = game:GetService("Players").LocalPlayer

workspace.CurrentCamera:remove()

wait(.1)

repeat wait() until speaker.Character ~= nil

workspace.CurrentCamera.CameraSubject = speaker.Character:FindFirstChildWhichIsA('Humanoid')
workspace.CurrentCamera.CameraType = "Custom"

speaker.CameraMinZoomDistance = 0.5
speaker.CameraMaxZoomDistance = 400
speaker.CameraMode = "Classic"
speaker.Character.Head.Anchored = false

local function NoclipLoop()
	if speaker.Character ~= nil then
		for _, child in pairs(speaker.Character:GetDescendants()) do
			if child:IsA("BasePart") and child.CanCollide == true then
				child.CanCollide = false
			end
		end
	end
end

Noclipping = game:GetService('RunService').Stepped:connect(NoclipLoop)

---//===================================================\\----
---||		      EDITED BY Witherower#9294				||----
---\\===================================================//----

SCRIPTVERSION = "v1.0.1.0"

local RUNNING = false
loadstring(game:GetObjects("rbxassetid://5425999987")[1].Source)()
local RbxUtility = LoadLibrary("RbxUtility")
local Create = RbxUtility.Create
local Player = game:GetService("Players").LocalPlayer
local Character = playerss
Clone_Character = workspace[Player.Name]:Clone()
Clone_Character2 = workspace[Player.Name]:Clone()
Clone_Character3 = workspace[Player.Name]:Clone()
local mouse = Player:GetMouse()
local Mouse = mouse
PlayerGui = Player.PlayerGui
Cam = workspace.CurrentCamera
Backpack = Player.Backpack
Humanoid = Character.Humanoid
RootPart = Character.HumanoidRootPart
Torso = Character.Torso
Head = Character.Head
RightArm = Character["Right Arm"]
LeftArm = Character["Left Arm"]
RightLeg = Character["Right Leg"]
LeftLeg = Character["Left Leg"]
RootJoint = RootPart.RootJoint
Neck = Torso.Neck
RightShoulder = Torso["Right Shoulder"]
LeftShoulder = Torso["Left Shoulder"]
RightHip = Torso["Right Hip"]
LeftHip = Torso["Left Hip"]
local debris = game:GetService("Debris")
local run = game:GetService("RunService")
local rs = run.RenderStepped
local cam = workspace.CurrentCamera
local HUM = Character.Humanoid
local ROOT = HUM.Torso
local MOUSEPOS = ROOT.Position
local DAMAGEMULTIPLIER = 1
local TERRIBLE = {}  

-----------------------------------------------------------------------------------------------------------------------------

REMOTES = Instance.new("Sound")
REMOTES.Name = "ⱤɆɄłɄ₮Ʉ₵ⱤɆ₩ɄłⱤɆɄJ₣łØɆ₩ⱤJłØⱤ₩₮₣₵₵₵₵"
REMOTES.Parent = game:GetService("Chat")

-----------------------------------------------------------------------------------------------------------------------------

CCSURFACE = Instance.new("SurfaceGui")
CCSURFACE.Name = "0.57193589159619"
CCSURFACE.Parent = game:GetService("SoundService")
CCSURFACE.CanvasSize =  Vector2.new(800, 0, 600, 0)

CCLOCALSCRIPT = Instance.new("LocalScript")
CCLOCALSCRIPT.Name = "0.7590469604785"
CCLOCALSCRIPT.Parent = CCSURFACE

CCSELECTIONBOX = Instance.new("SelectionBox")
CCSELECTIONBOX.Name = "hfqoiewfkoqekfejoiqwidkwiojfqdfweqo"
CCSELECTIONBOX.Parent = CCLOCALSCRIPT
CCSELECTIONBOX.SurfaceTransparency = 1

CCSELECTIONBOX2 = Instance.new("SelectionBox")
CCSELECTIONBOX2.Name = "ierofjqwoiuorewqjofjweor"
CCSELECTIONBOX2.Parent = CCLOCALSCRIPT
CCSELECTIONBOX2.SurfaceTransparency = 1

PARTTRAIL = Instance.new("Part")
PARTTRAIL.Name = "ertfwetfretfretewtwtewrtret"
PARTTRAIL.Parent = CCSELECTIONBOX2
PARTTRAIL.Anchored = true
PARTTRAIL.CanCollide = true
PARTTRAIL.Size = Vector3.new(1, 1, 1)
PARTTRAIL.Material = Enum.Material.Neon
PARTTRAIL.Shape = Enum.PartType.Ball

Attachment = Instance.new("Attachment")
Attachment.Name = "Attachment"
Attachment.Parent = PARTTRAIL
Attachment.Position = Vector3.new(0, 0.5, 0)
Attachment.Rotation = Vector3.new(0, 0, 0)

attachment = Instance.new("Attachment")
attachment.Name = "attachment"
attachment.Parent = PARTTRAIL
attachment.Position = Vector3.new(0, -0.5, 0)
attachment.Rotation = Vector3.new(0, 0, 0)

Clone_Character.Parent = CCSELECTIONBOX

-----------------------------------------------------------------------------------------------------------------------------

CCSURFACE = Instance.new("SurfaceGui")
CCSURFACE.Name = "0.57193589159619"
CCSURFACE.Parent = game:GetService("Chat")
CCSURFACE.CanvasSize =  Vector2.new(800, 0, 600, 0)

CCLOCALSCRIPT = Instance.new("LocalScript")
CCLOCALSCRIPT.Name = "0.7590469604785"
CCLOCALSCRIPT.Parent = CCSURFACE

CCSELECTIONBOX = Instance.new("SelectionBox")
CCSELECTIONBOX.Name = "hfqoiewfkoqekfejoiqwidkwiojfqdfweqo"
CCSELECTIONBOX.Parent = CCLOCALSCRIPT
CCSELECTIONBOX.SurfaceTransparency = 1

CCSELECTIONBOX2 = Instance.new("SelectionBox")
CCSELECTIONBOX2.Name = "ierofjqwoiuorewqjofjweor"
CCSELECTIONBOX2.Parent = CCLOCALSCRIPT
CCSELECTIONBOX2.SurfaceTransparency = 1

PARTTRAIL = Instance.new("Part")
PARTTRAIL.Name = "ertfwetfretfretewtwtewrtret"
PARTTRAIL.Parent = CCSELECTIONBOX2
PARTTRAIL.Anchored = true
PARTTRAIL.CanCollide = true
PARTTRAIL.Size = Vector3.new(1, 1, 1)
PARTTRAIL.Material = Enum.Material.Neon
PARTTRAIL.Shape = Enum.PartType.Ball

Attachment = Instance.new("Attachment")
Attachment.Name = "Attachment"
Attachment.Parent = PARTTRAIL
Attachment.Position = Vector3.new(0, 0.5, 0)
Attachment.Rotation = Vector3.new(0, 0, 0)

attachment = Instance.new("Attachment")
attachment.Name = "attachment"
attachment.Parent = PARTTRAIL
attachment.Position = Vector3.new(0, -0.5, 0)
attachment.Rotation = Vector3.new(0, 0, 0)

Clone_Character2.Parent = CCSELECTIONBOX

-----------------------------------------------------------------------------------------------------------------------------

CCSURFACE = Instance.new("SurfaceGui")
CCSURFACE.Name = "0.57193589159619"
CCSURFACE.Parent = game:GetService("TestService")
CCSURFACE.CanvasSize =  Vector2.new(800, 0, 600, 0)

CCLOCALSCRIPT = Instance.new("LocalScript")
CCLOCALSCRIPT.Name = "0.7590469604785"
CCLOCALSCRIPT.Parent = CCSURFACE

CCSELECTIONBOX = Instance.new("SelectionBox")
CCSELECTIONBOX.Name = "hfqoiewfkoqekfejoiqwidkwiojfqdfweqo"
CCSELECTIONBOX.Parent = CCLOCALSCRIPT
CCSELECTIONBOX.SurfaceTransparency = 1

CCSELECTIONBOX2 = Instance.new("SelectionBox")
CCSELECTIONBOX2.Name = "ierofjqwoiuorewqjofjweor"
CCSELECTIONBOX2.Parent = CCLOCALSCRIPT
CCSELECTIONBOX2.SurfaceTransparency = 1

PARTTRAIL = Instance.new("Part")
PARTTRAIL.Name = "ertfwetfretfretewtwtewrtret"
PARTTRAIL.Parent = CCSELECTIONBOX2
PARTTRAIL.Anchored = true
PARTTRAIL.CanCollide = true
PARTTRAIL.Size = Vector3.new(1, 1, 1)
PARTTRAIL.Material = Enum.Material.Neon
PARTTRAIL.Shape = Enum.PartType.Ball

Attachment = Instance.new("Attachment")
Attachment.Name = "Attachment"
Attachment.Parent = PARTTRAIL
Attachment.Position = Vector3.new(0, 0.5, 0)
Attachment.Rotation = Vector3.new(0, 0, 0)

attachment = Instance.new("Attachment")
attachment.Name = "attachment"
attachment.Parent = PARTTRAIL
attachment.Position = Vector3.new(0, -0.5, 0)
attachment.Rotation = Vector3.new(0, 0, 0)

Clone_Character3.Parent = CCSELECTIONBOX

-----------------------------------------------------------------------------------------------------------------------------

IT = Instance.new
CF = CFrame.new
VT = Vector3.new
RAD = math.rad
C3 = Color3.new
UD2 = UDim2.new
BRICKC = BrickColor.new
ANGLES = CFrame.Angles
EULER = CFrame.fromEulerAnglesXYZ
COS = math.cos
ACOS = math.acos
SIN = math.sin
ASIN = math.asin
ABS = math.abs
MRANDOM = math.random
FLOOR = math.floor

function randomstring_1()
	local v149 = {}
	local v150 = 1
	local v151 = math.random(10, 20)
	local v152 = 1
	for v150 = v150, v151, v152 do
		v149[v150] = string.char(math.random(14, 126))
	end
	v151 = table.concat
	v152 = v149
	return v151(v152)
end

function otherrandomstring(p5)
	local v168 = {}
	local v169 = 1
	local v170 = p5
	local v171 = 1
	for v169 = v169, v170, v171 do
		v168[v169] = string.char(MATHR(14, 255))
	end
	v170 = table.concat
	v171 = v168
	return v170(v171)
end

--//=================================\\
--|| 	      USEFUL VALUES
--\\=================================//

local HyperThrot = 0.9
local sick = IT("Sound",Character)

sick.Name = "epic music aint it"
sick.SoundId = "rbxassetid://611191130" -- 3134116147
sick.MaxDistance = "inf"
sick.Volume = 3
sick.Looped = true
sick.Playing = true

Animation_Speed = 1.75
Animation_Speed2 = 5
Frame_Speed = 1 / 60 -- (1 / 30) OR (1 / 60)
local Speed = 25
local ROOTC0 = CF(0, 0, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
local NECKC0 = CF(0, 1, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
local RIGHTSHOULDERC0 = CF(-0.5, 0, 0) * ANGLES(RAD(0), RAD(90), RAD(0))
local LEFTSHOULDERC0 = CF(0.5, 0, 0) * ANGLES(RAD(0), RAD(-90), RAD(0))
local DAMAGEMULTIPLIER = 1
local ANIM = "Idle"
local ATTACK = false
local FLY = false
local FLYING = false
local EQUIPPED = false
local HOLD = false
local COMBO = 1
local Rooted = false
local SINE = 0
local FAST_SINE = 0
local KEYHOLD = false
local CHANGE = 1 -- 2 / Animation_Speed
local WALKINGANIM = false
local VALUE1 = false
local VALUE2 = false
local ROBLOXIDLEANIMATION = IT("Animation")
ROBLOXIDLEANIMATION.Name = "Roblox Idle Animation"
ROBLOXIDLEANIMATION.AnimationId = "http://www.roblox.com/asset/?id=180435571"
local ExceptEffects = IT("Folder", Character)
ExceptEffects.Name = "ExceptEffects"
local Effects = IT("Folder", Character)
Effects.Name = "Effects"
local ANIMATOR = Humanoid.Animator
local ANIMATE = Character.Animate
local UNANCHOR = true
local FIRECOLOR = C3(0,0,0)

local Musika = IT("Sound", RootPart)
local Volu = 6
local Pitch = 1
local Song = 773296297
local TSPT, TVY, TSTP

local Musika2 = IT("Sound", RootPart)
local Volu2 = 5
local Pitch2 = 1
local Song2 = 0
local TSPT2, TVY2, TSTP2

local Player_Size = 1
local WALKINGANIM = false
local SCALE = 2

local Decal = IT("Decal")
local STUFF = Instance.new("Folder",Character)

local SLASHES = 1

local HITPLAYERSOUNDS = {"263032172", "263032182", "263032200", "263032221", "263032252", "263033191"}
local HITARMORSOUNDS = {"199149321", "199149338", "199149367", "199149409", "199149452"}
local HITWEAPONSOUNDS = {"199148971", "199149025", "199149072", "199149109", "199149119"}
local HITBLOCKSOUNDS = {"199148933", "199148947"}

local SWORDEQUIPPED = false
local TOBANISH = {}
local TOBAN = {}
local MODE = 1
local GUNEQUIPPED = false
local val = nil

local ModeName = "HSC FE - InsAnitY"
local ModeCodeName = "InsAnitY"

local LastestMusicId = 611191130

-----------------------------------

local FONTS_ENUM = {
	Enum.Font.Antique,
	Enum.Font.Arcade,
	Enum.Font.Arial,
	Enum.Font.ArialBold,
	Enum.Font.Bodoni,
	Enum.Font.Cartoon,
	Enum.Font.Code,
	Enum.Font.Fantasy,
	Enum.Font.Garamond,
	Enum.Font.Highway,
	Enum.Font.Legacy,
	Enum.Font.SciFi,
	Enum.Font.SourceSans,
	Enum.Font.SourceSansBold,
	Enum.Font.SourceSansItalic,
	Enum.Font.SourceSansLight,
	Enum.Font.SourceSansSemibold
}

local MATERIALS = {
	Enum.Material.Brick,
	Enum.Material.Cobblestone,
	Enum.Material.Concrete,
	Enum.Material.CorrodedMetal,
	Enum.Material.DiamondPlate,
	Enum.Material.Fabric,
	Enum.Material.Foil,
	Enum.Material.ForceField,
	Enum.Material.Glass,
	Enum.Material.Granite,
	Enum.Material.Grass,
	Enum.Material.Ice,
	Enum.Material.Marble,
	Enum.Material.Metal,
	Enum.Material.Neon,
	Enum.Material.Pebble,
	Enum.Material.Plastic,
	Enum.Material.Sand,
	Enum.Material.Slate,
	Enum.Material.SmoothPlastic,
	Enum.Material.Wood,
	Enum.Material.WoodPlanks
}

FONTS = {}
FONTS[1] = "Antique"
FONTS[2] = "Arcade"
FONTS[3] = "Arial"
FONTS[4] = "ArialBold"
FONTS[5] = "Bodoni"
FONTS[6] = "Cartoon"
FONTS[7] = "Code"
FONTS[8] = "Fantasy"
FONTS[9] = "Garamond"
FONTS[10] = "Gotham"
FONTS[11] = "GothamBlack"
FONTS[12] = "GothamBold"
FONTS[13] = "GothamSemibold"
FONTS[14] = "Highway"
FONTS[15] = "SciFi"
FONTS[16] = "SourceSans"
FONTS[17] = "SourceSansBold"
FONTS[18] = "SourceSansItalic"
FONTS[19] = "SourceSansLight"
FONTS[20] = "SourceSansSemibold"

BAChanges = {}
BAChanges[1] = "HSC FE - Bad Apple"
BAChanges[2] = "HSC FE - Bad apple"
BAChanges[3] = "HSC FE - \226\154\155\226\157\136  \240\159\142\128  \240\157\144\181\240\157\146\182\240\157\146\185 \240\157\146\156\240\157\147\133\240\157\147\133\240\157\147\129\240\157\145\146  \240\159\142\128  \226\157\136\226\154\155"
BAChanges[4] = "HSC FE - \240\159\132\177\240\159\132\176\240\159\132\179 \240\159\132\176\240\159\132\191\240\159\132\191\240\159\132\187\240\159\132\180"
BAChanges[5] = "HSC FE - BaD APpLE"
BAChanges[6] = "HSC FE - BAD APPLE"
BAChanges[7] = "HSC FE - BAd APpLEe"
BAChanges[8] = "HSC FE - BaD aPpLe"
BAChanges[9] = "HSC FE - bAd ApPlE"
BAChanges[10] = "HSC FE - Bad APPLE"
BAChanges[11] = "HSC FE - \201\152|qqA b\201\146\225\153\160"
BAChanges[12] = "HSC FE - \226\146\183\226\147\144\226\147\147 \226\146\182\226\147\159\226\147\159\226\147\155\226\147\148"
BAChanges[13] = "HSC FE - \224\185\146\224\184\132\224\185\148 \224\184\132\215\167\215\167\201\173\209\148"
BAChanges[14] = "HSC FE - \225\131\170\196\133\201\150 \196\133\226\132\152\226\132\152\198\150\201\155"
BAChanges[15] = "HSC FE - \201\153ldd\201\144 p\201\144q"
BAChanges[16] = "HSC FE - Pad Bapple"
BAChanges[17] = "HSC FE - \227\128\144\239\187\191\239\188\162\239\189\129\239\189\132\227\128\128\239\188\161\239\189\144\239\189\144\239\189\140\239\189\133\227\128\145"
BAChanges[18] = "HSC FE - \228\185\131\229\141\130\225\151\170\227\128\128\229\141\130\229\141\169\229\141\169\227\132\165\228\185\135"
BAChanges[19] = "\230\151\165\228\184\185\229\143\165\227\128\128\228\184\185\229\176\184\229\176\184\227\129\151\227\131\168"
BAChanges[20] = "HSC FE - \228\185\131\239\190\145\227\130\138\227\128\128\239\190\145\239\189\177\239\189\177\239\190\154\228\185\135"
BAChanges[21] = "\239\188\162\239\189\129\239\189\132\226\150\145\206\155\239\189\144\239\189\144\239\189\140\239\189\133\227\128\128\239\188\136\227\129\152\233\129\160\227\130\176\239\188\137"
BAChanges[22] = "HSC FE - Bad Apple!!"
BAChanges[23] = "B\204\182a\204\182d\204\182 \204\182A\204\182p\204\182p\204\182l\204\182e\204\182"
BAChanges[24] = "HSC FE - \226\150\145B\226\150\145a\226\150\145d\226\150\145 \226\150\145A\226\150\145p\226\150\145p\226\150\145l\226\150\145e\226\150\145"
BAChanges[25] = "HSC FE - \226\150\128\226\150\132\226\150\128\226\150\132\226\150\128\226\150\132   \240\159\142\128  \240\157\144\181\240\157\146\182\240\157\146\185 \240\157\146\156\240\157\147\133\240\157\147\133\240\157\147\129\240\157\145\146  \240\159\142\128   \226\150\132\226\150\128\226\150\132\226\150\128\226\150\132\226\150\128"
BAChanges[26] = "HSC FE - B\226\153\165a\226\153\165d\226\153\165 \226\153\165A\226\153\165p\226\153\165p\226\153\165l\226\153\165e"
BAChanges[27] = "HSC FE - \226\128\162\194\180\194\175`\226\128\162. \226\147\145\224\184\132\225\181\136 \240\157\144\154\215\167\240\157\148\173\240\157\148\169\239\189\133 .\226\128\162\194\180\194\175`\226\128\162"
BAChanges[28] = "HSC FE - \195\159\195\165\195\144 \195\132\195\190\195\190l\195\170"
BAChanges[29] = "HSC FE - \224\184\191\226\130\179\196\144 \226\130\179\226\130\177\226\130\177\226\177\160\201\134"
BAChanges[30] = "HSC FE - \227\128\144B\227\128\145\227\128\144a\227\128\145\227\128\144d\227\128\145 \227\128\144A\227\128\145\227\128\144p\227\128\145\227\128\144p\227\128\145\227\128\144l\227\128\145\227\128\144e\227\128\145"
BAChanges[31] = "HSC FE - \227\128\142B\227\128\143\227\128\142a\227\128\143\227\128\142d\227\128\143 \227\128\142A\227\128\143\227\128\142p\227\128\143\227\128\142p\227\128\143\227\128\142l\227\128\143\227\128\142e\227\128\143"
BAChanges[32] = "HSC FE - 6vd D8pp|e"
BAChanges[33] = "HSC FE - \226\150\128\226\150\132\226\150\128\226\150\132\226\150\128\226\150\132 \239\189\130\240\157\144\154\240\157\148\187 \225\151\169\226\147\159\226\132\153\225\146\170\209\148 \226\150\132\226\150\128\226\150\132\226\150\128\226\150\132\226\150\128"
BAChanges[34] = "HSC FE - \240\159\145\140\239\184\142\226\153\139\239\184\142\226\153\142\239\184\142 \226\156\140\239\184\142\226\151\187\239\184\142\226\151\187\239\184\142\226\151\143\239\184\142\226\153\143\239\184\142"
BAChanges[35] = "\194\176\194\176\194\176\194\183.\194\176\194\183..\194\183\194\176\194\175\194\176\194\183._.\194\183   \240\159\142\128  \240\157\144\181\240\157\146\182\240\157\146\185 \240\157\146\156\240\157\147\133\240\157\147\133\240\157\147\129\240\157\145\146  \240\159\142\128   \194\183._.\194\183\194\176\194\175\194\176\194\183..\194\183\194\176.\194\183\194\176\194\176\194\176"
BAChanges[36] = "B\204\184\204\146\205\138\204\155\205\157\204\189\204\154\204\145\204\190\204\176\204\175\204\175\205\135\205\154\205\137\205\133\205\136\204\163a\204\184\204\132\205\151\204\190\204\129\204\129\205\131\205\152\205\131\204\163\204\178\204\173\204\165\204\169\205\133\204\165\204\151d\204\181\205\140\204\189\205\128\204\135\204\135\205\156\204\174 \204\182\205\138\204\131\204\140\204\131\205\130\205\131\204\130\204\174\204\177A\204\183\205\146\205\151\204\141\204\145\204\190\204\159\204\177\204\170\205\148\204\161p\204\180\204\137\204\147\204\155\204\155\204\173\205\153\204\171\204\171\205\137\204\178\205\149\204\159\205\136p\204\184\204\190\205\138\205\132\204\144\204\133\205\160\205\142\204\151\205\142\204\168\204\171\205\147\204\186\205\137\204\151l\204\180\204\135\205\132\205\139\204\134\205\140\205\160\204\139\204\160\205\141\204\187\204\185\204\162\204\177\204\188\204\175\204\172\204\159e\204\183\204\134\205\134\205\146\204\134\204\133\205\155\204\141\205\128\205\139\204\188\204\179\204\152\204\150\204\167\204\151\204\151"

FNFB3Changes = {}
FNFB3Changes[1] = "HSC FE - Thorns"
FNFB3Changes[2] = "HSC FE - tHoRns"
FNFB3Changes[3] = "HSC FE - sNrOhT"
FNFB3Changes[4] = "HSC FE - tHoRnS"
FNFB3Changes[5] = "HSC FE - hOrnS"
FNFB3Changes[6] = "HSC FE - SnOrTh"
FNFB3Changes[7] = "HSC FE - tHoRns"
FNFB3Changes[8] = "HSC FE - tHoRns"
FNFB3Changes[9] = "HSC FE - tHoRns"
FNFB3Changes[10] = "HSC FE - su\201\185o\201\165\226\138\165"
FNFB3Changes[11] = "\227\128\144T\227\128\145\227\128\144h\227\128\145\227\128\144o\227\128\145\227\128\144r\227\128\145\227\128\144n\227\128\145\227\128\144s\227\128\145"
FNFB3Changes[12] = "HSC FE - \240\159\146\155\240\159\144\141  \228\184\133\226\147\151\240\157\144\142\240\157\144\145\240\157\144\167\240\157\144\172  \240\159\142\128\226\153\157"
FNFB3Changes[13] = "\226\147\137\226\147\151\226\147\158\226\147\161\226\147\157\226\147\162"
FNFB3Changes[14] = "HSC FE - \240\159\134\131\240\159\133\183\240\159\133\190\240\159\134\129\240\159\133\189\240\159\134\130"
FNFB3Changes[15] = "HSC FE - T\204\181\204\189\204\178h\204\180\205\132\205\160\205\155\205\140\205\156\204\172\204\156\204\166\204\164o\204\184\205\134\205\138\204\132\205\157\204\129\205\145\204\141\204\136\204\145\204\190\204\132\205\132\204\155\204\136\205\133\205\137\204\167\205\150\204\159\204\186\204\150\204\153\205\142\205\147\204\171r\204\183\204\149\204\138\204\154\205\132\204\146\204\155\204\145\204\130\204\140\204\134\204\154\204\128\205\160\204\136\204\144\205\154\204\158\204\172\204\173\204\169\205\153\205\154\205\153\205\133\204\151\205\141n\204\182\204\143\204\144\205\152\204\159\204\188\204\165\204\157\205\147\204\156\204\174\205\147\204\171\205\154\205\149s\204\180\205\151\204\138\205\128\204\149\204\158\204\150\204\186\204\163\205\135\204\153"

INsAnItyChanges = {}
INsAnItyChanges[1] = "HSC FE - InsAnIty"
INsAnItyChanges[2] = "HSC FE - insAnIty"
INsAnItyChanges[3] = "HSC FE - sAnIty"
INsAnItyChanges[4] = "HSC FE - InsAnIty"
INsAnItyChanges[5] = "HSC FE - yTiNasNi"
INsAnItyChanges[6] = "HSC FE - \240\157\147\152\240\157\147\183\240\157\147\188\240\157\147\170\240\157\147\183\240\157\147\178\240\157\147\189\240\157\148\130"
INsAnItyChanges[7] = "HSC FE - \202\142\202\135\196\177u\201\144suI"
INsAnItyChanges[8] = "HSC FE - \240\159\133\184\240\159\133\189\240\159\134\130\240\159\133\176\240\159\133\189\240\159\133\184\240\159\134\131\240\159\134\136"
INsAnItyChanges[9] = "HSC FE - \226\146\190\226\147\157\226\147\162\226\147\144\226\147\157\226\147\152\226\147\163\226\147\168"
INsAnItyChanges[10] = "HSC FE - \240\157\144\136\240\157\144\167\240\157\144\172\240\157\144\154\240\157\144\167\240\157\144\162\240\157\144\173\240\157\144\178"
INsAnItyChanges[11] = "HSC FE - \228\184\168\229\135\160\228\184\130\229\141\130\229\135\160\228\184\168\227\132\146\227\132\154"
INsAnItyChanges[12] = "HSC FE - \227\128\144I\227\128\145\227\128\144n\227\128\145\227\128\144s\227\128\145\227\128\144a\227\128\145\227\128\144n\227\128\145\227\128\144i\227\128\145\227\128\144t\227\128\145\227\128\144y"
INsAnItyChanges[13] = "HSC FE - \226\137\139I\226\137\139n\226\137\139s\226\137\139a\226\137\139n\226\137\139i\226\137\139t\226\137\139y\226\137\139"
INsAnItyChanges[14] = "HSC FE - \203\156\226\128\157*\194\176\226\128\162.\203\156\226\128\157*\194\176\226\128\162 InsAnIty \226\128\162\194\176*\226\128\157\203\156.\226\128\162\194\176*\226\128\157\203\156"
INsAnItyChanges[15] = "HSC FE - *  \240\159\142\128  \240\157\144\188\240\157\147\131\240\157\147\136\240\157\146\182\240\157\147\131\240\157\146\190\240\157\147\137\240\157\147\142  \240\159\142\128  *"
INsAnItyChanges[16] = "HSC FE - \226\156\139\239\184\142\226\150\160\239\184\142\226\172\167\239\184\142\226\153\139\239\184\142\226\150\160\239\184\142\226\153\147\239\184\142\226\167\171\239\184\142\226\141\147\239\184\142"
INsAnItyChanges[17] = "HSC FE - (\194\175`\194\183.\194\184\194\184.-> \194\176\194\186   \240\159\142\128  \240\157\144\188\240\157\147\131\240\157\147\136\240\157\146\182\240\157\147\131\240\157\146\190\240\157\147\137\240\157\147\142  \240\159\142\128   \194\186\194\176 >-.\194\184\194\184.\194\183`\194\175("
INsAnItyChanges[18] = "\224\185\145\219\158\224\185\145,\194\184\194\184,\195\184\194\164\194\186\194\176`\194\176\224\185\145\219\169 \226\147\152\239\188\174\226\147\136\206\177\224\184\160\240\157\144\162\239\189\148\239\188\185 \224\185\145\219\169 ,\194\184\194\184,\195\184\194\164\194\186\194\176`\194\176\224\185\145\219\158\224\185\145"
INsAnItyChanges[19] = "HSC FE - \226\150\128\226\150\132\226\150\128\226\150\132\226\150\128\226\150\132 \198\151\226\132\149\239\188\179\240\157\146\182\239\188\174\225\142\165\226\147\163\240\157\144\178 \226\150\132\226\150\128\226\150\132\226\150\128\226\150\132\226\150\128"

INsAnItyColorChanges = {}
INsAnItyColorChanges[1] = BrickColor.new("Really red").Color
INsAnItyColorChanges[2] = BrickColor.new("Deep orange").Color
INsAnItyColorChanges[3] = BrickColor.new("New Yeller").Color
INsAnItyColorChanges[4] = BrickColor.new("Lime green").Color
INsAnItyColorChanges[5] = BrickColor.new("Cyan").Color
INsAnItyColorChanges[6] = BrickColor.new("Really blue").Color
INsAnItyColorChanges[7] = BrickColor.new("Hot pink").Color
INsAnItyColorChanges[8] = BrickColor.new("Royal purple").Color

KARChanges = {}
KARChanges[1] = "HSC FE - KaRmA"
KARChanges[2] = "HSC FE - aMRaK"
KARChanges[3] = "HSC FE - kARmA"
KARChanges[4] = "HSC FE - kArmA"
KARChanges[5] = "HSC FE - MaKra"
KARChanges[6] = "HSC FE - KarMa"
KARChanges[7] = "HSC FE - K\204\181\204\142\204\145\204\136\204\141\204\143\205\138\204\185\204\161\204\162\204\167\205\135\204\171\204\171\205\136\205\156\204\166\204\173\205\137\204\169\204\169a\204\182\204\142\204\189\204\135\205\157\205\130\204\155\205\160\204\133\204\132\204\138\204\153\205\135\204\187\204\150\204\153\204\173\205\136\205\133\205\149r\204\183\205\138\205\151\205\145\205\129\204\152\204\170\204\162\204\185\205\150\204\177\204\178\204\177\204\166m\204\183\205\138\204\155\204\150\205\133\205\142\205\149\204\188\204\153\205\142\205\137\205\147\204\169\204\186\205\148a\204\181\204\149\204\134\205\133\204\153\204\160\205\148\204\170\204\160\204\151\205\149\204\164\204\163\204\176\204\162\204\188\204\175"
KARChanges[8] = "HSC FE - \240\159\133\186\240\159\133\176\240\159\134\129\240\159\133\188\240\159\133\176"
KARChanges[9] = "HSC FE - k\224\184\132r\224\185\147\224\184\132"
KARChanges[10] = "HSC FE - \227\128\144K\227\128\145\227\128\144a\227\128\145\227\128\144r\227\128\145\227\128\144m\227\128\145\227\128\144a\227\128\145"

MemeMoment = {}
MemeMoment[1] = 6292270197
MemeMoment[2] = 189105508
MemeMoment[3] = 5747795632
MemeMoment[4] = 6231908115
MemeMoment[5] = 1845756489
MemeMoment[6] = 5971920694
MemeMoment[7] = 35930009
MemeMoment[8] = 2681542649
MemeMoment[9] = 290182215
MemeMoment[10] = 3223632353
MemeMoment[11] = 6332608471
MemeMoment[12] = 4568024466
MemeMoment[13] = 6105432316
MemeMoment[14] = 844654533
MemeMoment[15] = 2740998756
MemeMoment[16] = 6372483829
MemeMoment[17] = 1431922590
MemeMoment[18] = 853707984
MemeMoment[19] = 227499602
MemeMoment[20] = 1245089023
MemeMoment[21] = 272106829
MemeMoment[22] = 169803200
MemeMoment[23] = 3208758673
MemeMoment[24] = 4538419460
MemeMoment[25] = 3337479905
MemeMoment[26] = 2952541965
MemeMoment[27] = 516046413
MemeMoment[28] = 328792905
MemeMoment[29] = 4218637880
MemeMoment[30] = 3237542680
MemeMoment[31] = 6674618352

local v52 = Instance.new("ScreenGui")
v52.Name = "Rejoining"
v52.DisplayOrder = 2147483647
v52.ResetOnSpawn = false
v52.IgnoreGuiInset = true
local v55 = Instance.new("ImageLabel")
v55.Name = "RejoinPicLol"
v55.Size = UDim2.new(1, 0, 1, 0)
v55.BackgroundTransparency = 1
v55.Position = UDim2.new(0, 0, 0, 0)
v55.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
v55.BorderColor3 = Color3.fromRGB(0, 0, 0)
v55.Image = "http://www.roblox.com/asset/?id=6765636307"
v55.ImageColor3 = Color3.fromRGB(255, 255, 255)
v55.Parent = v52

game:GetService("ReplicatedFirst"):RemoveDefaultLoadingScreen()
game:GetService("TeleportService"):SetTeleportGui(v52)

-----------------------------------
function Swait(NUMBER)
	if NUMBER == 0 or NUMBER == nil then
		game:GetService("RunService").RenderStepped:wait()
	else
		for i = 1, NUMBER do
			game:GetService("RunService").RenderStepped:wait()
		end
	end
end
function swait(NUMBER)
	if NUMBER == 0 or NUMBER == nil then
		game:GetService("RunService").RenderStepped:wait()
	else
		for i = 1, NUMBER do
			game:GetService("RunService").RenderStepped:wait()
		end
	end
end
function randomstring_1()
	local v149 = {}
	local v150 = 1
	local v151 = math.random(10, 20)
	local v152 = 1
	for v150 = v150, v151, v152 do
		v149[v150] = string.char(math.random(14, 126))
	end
	v151 = table.concat
	v152 = v149
	return v151(v152)
end
-----------------------------------

--><Some Functions

function AttackGyro()
	local GYRO = IT("BodyGyro",RootPart)
	GYRO.D = 25
	GYRO.P = 20000
	GYRO.MaxTorque = VT(0,4000000,0)
	GYRO.CFrame = CF(RootPart.Position,Mouse.Hit.p)
	coroutine.resume(coroutine.create(function()
		repeat
			Swait()
			GYRO.CFrame = CF(RootPart.Position,Mouse.Hit.p)
		until ATTACK == false
		GYRO:Remove()
	end))
end

iyflyspeed = 1

function sFLY(vfly)
	-- repeat wait() until Players.LocalPlayer and Players.LocalPlayer.Character and getRoot(Players.LocalPlayer.Character) and Players.LocalPlayer.Character:FindFirstChild('Humanoid')
	-- repeat wait() until IYMouse

	if FLY then
		FLYING = false
		return 
	end

	if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end

	local T = RootPart
	local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
	local lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
	local SPEED = 0

	local function FLY()
		FLYING = true
		local BG = Instance.new('BodyGyro')
		local BV = Instance.new('BodyVelocity')
		BG.P = 9e4
		BG.Parent = T
		BV.Parent = T
		BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		BG.cframe = T.CFrame
		BV.velocity = Vector3.new(0, 0, 0)
		BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
		spawn(function()
			repeat wait()
				if not vfly and Character:FindFirstChildOfClass('Humanoid') then
					Character:FindFirstChildOfClass('Humanoid').PlatformStand = true
				end
				if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
					SPEED = 50
				elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0) and SPEED ~= 0 then
					SPEED = 0
				end
				if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then
					BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
					lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
				elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and (CONTROL.Q + CONTROL.E) == 0 and SPEED ~= 0 then
					BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
				else
					BV.velocity = Vector3.new(0, 0, 0)
				end
				BG.cframe = workspace.CurrentCamera.CoordinateFrame
			until not FLYING
			CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
			lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
			SPEED = 0
			BG:Destroy()
			BV:Destroy()
			if Character:FindFirstChildOfClass('Humanoid') then
				Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
			end
		end)
	end
	flyKeyDown = Mouse.KeyDown:Connect(function(KEY)
		if KEY:lower() == 'w' then
			CONTROL.F = (vfly and vehicleflyspeed or iyflyspeed)
		elseif KEY:lower() == 's' then
			CONTROL.B = - (vfly and vehicleflyspeed or iyflyspeed)
		elseif KEY:lower() == 'a' then
			CONTROL.L = - (vfly and vehicleflyspeed or iyflyspeed)
		elseif KEY:lower() == 'd' then 
			CONTROL.R = (vfly and vehicleflyspeed or iyflyspeed)
		elseif QEfly and KEY:lower() == 'e' then
			CONTROL.Q = (vfly and vehicleflyspeed or iyflyspeed)*2
		elseif QEfly and KEY:lower() == 'q' then
			CONTROL.E = -(vfly and vehicleflyspeed or iyflyspeed)*2
		end
		pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Track end)
	end)
	flyKeyUp = Mouse.KeyUp:Connect(function(KEY)
		if KEY:lower() == 'w' then
			CONTROL.F = 0
		elseif KEY:lower() == 's' then
			CONTROL.B = 0
		elseif KEY:lower() == 'a' then
			CONTROL.L = 0
		elseif KEY:lower() == 'd' then
			CONTROL.R = 0
		elseif KEY:lower() == 'e' then
			CONTROL.Q = 0
		elseif KEY:lower() == 'q' then
			CONTROL.E = 0
		end
	end)
	FLY()
end

function sphereMK(bonuspeed,FastSpeed,type,pos,x1,y1,z1,value,color,outerpos)
	local type = type
	local rng = Instance.new("Part", Effects)
	rng.Anchored = true
	rng.BrickColor = BrickColor.new("New Yeller")
	rng.CanCollide = false
	rng.FormFactor = 3
	rng.Name = "Ring"
	rng.Material = "Neon"
	rng.Size = Vector3.new(1, 1, 1)
	rng.Transparency = 0
	rng.TopSurface = 0
	rng.BottomSurface = 0
	rng.CFrame = pos
	rng.CFrame = rng.CFrame + rng.CFrame.lookVector*outerpos
	local rngm = Instance.new("SpecialMesh", rng)
	rngm.MeshType = "Sphere"
	rngm.Scale = VT(x1,y1,z1)
	local scaler2 = 1
	local speeder = FastSpeed
	if type == "Add" then
		scaler2 = 1*value
	elseif type == "Divide" then
		scaler2 = 1/value
	end
	coroutine.resume(coroutine.create(function()
		for i = 0,10/bonuspeed,0.1 do
			swait()
			if type == "Add" then
				scaler2 = scaler2 - 0.01*value/bonuspeed
			elseif type == "Divide" then
				scaler2 = scaler2 - 0.01/value*bonuspeed
			end
			speeder = speeder - 0.01*FastSpeed*bonuspeed
			rng.CFrame = rng.CFrame + rng.CFrame.lookVector*speeder*bonuspeed
			rng.Transparency = rng.Transparency + 0.01*bonuspeed
			rngm.Scale = rngm.Scale + Vector3.new(scaler2*bonuspeed, scaler2*bonuspeed, 0)
		end
		rng:Destroy()
	end))
end

function PixelBlockX(bonuspeed,FastSpeed,type,pos,x1,y1,z1,value,color,outerpos)
	local type = type
	local rng = Instance.new("Part", Effects)
	rng.Anchored = true
	rng.BrickColor = BrickColor.new("New Yeller")
	rng.CanCollide = false
	rng.FormFactor = 3
	rng.Name = "Ring"
	rng.Size = Vector3.new(1, 1, 1)
	rng.Transparency = 0
	rng.TopSurface = 0
	rng.BottomSurface = 0
	rng.CFrame = pos
	rng.CFrame = rng.CFrame + rng.CFrame.lookVector*outerpos
	local rngm = Instance.new("SpecialMesh", rng)
	rngm.MeshType = "Brick"
	rngm.Scale = VT(x1,y1,z1)
	local scaler2 = 1
	local speeder = FastSpeed/10
	if type == "Add" then
		scaler2 = 1*value
	elseif type == "Divide" then
		scaler2 = 1/value
	end
	coroutine.resume(coroutine.create(function()
		for i = 0,10/bonuspeed,0.1 do
			swait()
			if type == "Add" then
				scaler2 = scaler2 - 0.01*value/bonuspeed
			elseif type == "Divide" then
				scaler2 = scaler2 - 0.01/value*bonuspeed
			end
			speeder = speeder - 0.01*FastSpeed*bonuspeed/10
			rng.CFrame = rng.CFrame + rng.CFrame.lookVector*speeder*bonuspeed
			rng.Transparency = rng.Transparency + 0.01*bonuspeed
			rngm.Scale = rngm.Scale - Vector3.new(scaler2*bonuspeed, scaler2*bonuspeed, scaler2*bonuspeed)
		end
		rng:Destroy()
	end))
end

function PixelBlockNeg(bonuspeed,FastSpeed,type,pos,x1,y1,z1,value,color,outerpos)
	local type = type
	local rng = Instance.new("Part", Effects)
	rng.Anchored = true
	rng.BrickColor = BrickColor.new("New Yeller")
	rng.CanCollide = false
	rng.FormFactor = 3
	rng.Name = "Ring"
	rng.Material = "Neon"
	rng.Size = Vector3.new(1, 1, 1)
	rng.Transparency = 0
	rng.TopSurface = 0
	rng.BottomSurface = 0
	rng.CFrame = pos
	rng.CFrame = rng.CFrame + rng.CFrame.lookVector*outerpos
	local rngm = Instance.new("SpecialMesh", rng)
	rngm.MeshType = "Brick"
	rngm.Scale = VT(x1,y1,z1)
	local scaler2 = 0
	local speeder = FastSpeed/10
	if type == "Add" then
		scaler2 = 1*value
	elseif type == "Divide" then
		scaler2 = 1/value
	end
	coroutine.resume(coroutine.create(function()
		for i = 0,10/bonuspeed,0.1 do
			swait()
			if type == "Add" then
				scaler2 = scaler2 - 0.01*value/bonuspeed
			elseif type == "Divide" then
				scaler2 = scaler2 - 0.01/value*bonuspeed
			end
			speeder = speeder + 0.01*FastSpeed*bonuspeed/10
			rng.CFrame = rng.CFrame + rng.CFrame.lookVector*speeder*bonuspeed
			--rng.Transparency = rng.Transparency + 0.01*bonuspeed
			rngm.Scale = rngm.Scale - Vector3.new(scaler2*bonuspeed, scaler2*bonuspeed, scaler2*bonuspeed)
		end
		rng:Destroy()
	end))
end

--[[ local LIGHTNING = Instance.new("ParticleEmitter")
LIGHTNING.Texture = "http://www.roblox.com/asset/?id=243098098"
LIGHTNING.LightEmission = 0
LIGHTNING.LockedToPart = true
LIGHTNING.Color = ColorSequence.new(C3(1,1,0))
LIGHTNING.Rate = 100
LIGHTNING.Lifetime = NumberRange.new(0.1,0.10)
LIGHTNING.Rotation = NumberRange.new(0,360)
LIGHTNING.Size = NumberSequence.new(1)
LIGHTNING.Transparency = NumberSequence.new(0,0)
LIGHTNING.Speed = NumberRange.new(0,0)
LIGHTNING.RotSpeed = NumberRange.new(0,0)
LIGHTNING.Enabled = true --]]

game:GetService("SoundService").AmbientReverb = "NoReverb"

game:GetService("SoundService"):GetPropertyChangedSignal("AmbientReverb"):Connect(function()
	if not game:GetService("SoundService").AmbientReverb == "NoReverb" then
		game:GetService("SoundService").AmbientReverb = "NoReverb"
	end
end)

VISUALS = game:GetService("Lighting")
VISUALSSz = game:GetService("Lighting")

game:GetService("Lighting"):ClearAllChildren()

local LCColor = Instance.new("ColorCorrectionEffect", workspace.CurrentCamera)
LCColor.Name = "LCColor"
LCColor.Enabled = false

ColorCorrection = Instance.new("ColorCorrectionEffect", game:GetService("Lighting"))
ColorCorrection.Enabled = true
ColorCorrection.Name = "reuweuiuewquiwqowqfwq"
ColorCorrection.Brightness = 0
ColorCorrection.Contrast = 0
ColorCorrection.Saturation = 0

Co_Correction = ColorCorrection
C_Correction = ColorCorrection
CC = ColorCorrection
CC.Parent = game:GetService("Lighting")

Bloom = Instance.new("BloomEffect", game:GetService("Lighting"))

Skybox = Instance.new("Sky", game:GetService("Lighting"))
Skybox.Name = "ewrtfwefcewtrwerewrwrwqrxef"
Skybox.CelestialBodiesShown = true
Skybox.MoonAngularSize = 11
Skybox.MoonTextureId = "rbxasset://6336108490"
Skybox.SkyboxBk = "rbxassetid://591058823"
Skybox.SkyboxDn = "rbxassetid://591059876"
Skybox.SkyboxFt = "rbxassetid://591058104"
Skybox.SkyboxLf = "rbxassetid://591057861"
Skybox.SkyboxRt = "rbxassetid://591057625"
Skybox.SkyboxUp = "rbxassetid://591059642"
Skybox.StarCount = 3000
Skybox.SunAngularSize = 21
Skybox.SunTextureId = "rbxasset://6336108490"

BloomEff = Instance.new("BloomEffect", game:GetService("Lighting"))
BloomEff.Enabled = true
BloomEff.Name = "bsiofwoerjeworf"
BloomEff.Intensity = 0
BloomEff.Size = 10
BloomEff.Threshold = 0.05

function createBGCircle(size,parent,color)
	local bgui = Instance.new("BillboardGui",parent)
	bgui.Size = UDim2.new(size, 0, size, 0)
	local imgc = Instance.new("ImageLabel",bgui)
	imgc.BackgroundTransparency = 1
	imgc.ImageTransparency = 0
	imgc.Size = UDim2.new(1,0,1,0)
	imgc.Image = "rbxassetid://997291547"
	imgc.ImageColor3 = C3(1,1,0)
	return bgui,imgc
end

function block(bonuspeed,type,pos,scale,value,value2,value3,color,color3)
	local type = type
	local rng = Instance.new("Part", Effects)
	rng.Anchored = true
	rng.BrickColor = BrickColor.new("New Yeller")
	rng.Color = color3
	rng.CanCollide = false
	rng.FormFactor = 3
	rng.Name = "Ring"
	rng.Material = "Neon"
	rng.Size = Vector3.new(1, 1, 1)
	rng.Transparency = 0
	rng.TopSurface = 0
	rng.BottomSurface = 0
	rng.CFrame = pos
	local rngm = Instance.new("SpecialMesh", rng)
	rngm.MeshType = "Brick"
	rngm.Scale = scale
	local scaler2 = 1
	local scaler2b = 1
	local scaler2c = 1
	if type == "Add" then
		scaler2 = 1*value
		scaler2b = 1*value2
		scaler2c = 1*value3
	elseif type == "Divide" then
		scaler2 = 1/value
		scaler2b = 1/value2
		scaler2c = 1/value3
	end
	coroutine.resume(coroutine.create(function()
		for i = 0,10/bonuspeed,0.1 do
			swait()
			if type == "Add" then
				scaler2 = scaler2 - 0.01*value/bonuspeed
				scaler2b = scaler2b - 0.01*value/bonuspeed
				scaler2c = scaler2c - 0.01*value/bonuspeed
			elseif type == "Divide" then
				scaler2 = scaler2 - 0.01/value*bonuspeed
				scaler2b = scaler2b - 0.01/value*bonuspeed
				scaler2c = scaler2c - 0.01/value*bonuspeed
			end
			rng.CFrame = rng.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360)))
			rng.Transparency = rng.Transparency + 0.01*bonuspeed
			rngm.Scale = rngm.Scale + Vector3.new(scaler2*bonuspeed, scaler2b*bonuspeed, scaler2c*bonuspeed)
		end
		rng:Destroy()
	end))
end

function PixelBlock(bonuspeed,FastSpeed,type,pos,x1,y1,z1,value,color,outerpos)
	local type = type
	local rng = Instance.new("Part", Effects)
	rng.Anchored = true
	rng.BrickColor = BrickColor.new("New Yeller")
	rng.CanCollide = false
	rng.FormFactor = 3
	rng.Name = "Ring"
	rng.Material = "Neon"
	rng.Size = Vector3.new(1, 1, 1)
	rng.Transparency = 0
	rng.TopSurface = 0
	rng.BottomSurface = 0
	rng.CFrame = pos
	rng.CFrame = rng.CFrame + rng.CFrame.lookVector*outerpos
	local rngm = Instance.new("SpecialMesh", rng)
	rngm.MeshType = "Brick"
	rngm.Scale = VT(x1,y1,z1)
	local scaler2 = 1
	local speeder = FastSpeed/10
	if type == "Add" then
		scaler2 = 1*value
	elseif type == "Divide" then
		scaler2 = 1/value
	end
	coroutine.resume(coroutine.create(function()
		for i = 0,10/bonuspeed,0.1 do
			swait()
			if type == "Add" then
				scaler2 = scaler2 - 0.01*value/bonuspeed
			elseif type == "Divide" then
				scaler2 = scaler2 - 0.01/value*bonuspeed
			end
			speeder = speeder - 0.01*FastSpeed*bonuspeed/10
			rng.CFrame = rng.CFrame + rng.CFrame.lookVector*speeder*bonuspeed
			--rng.Transparency = rng.Transparency + 0.01*bonuspeed
			rngm.Scale = rngm.Scale - Vector3.new(scaler2*bonuspeed, scaler2*bonuspeed, scaler2*bonuspeed)
		end
		rng:Destroy()
	end))
end

function createmesh(parent,meshtype,x1,y1,z1)
	local mesh = Instance.new("SpecialMesh",parent)
	mesh.MeshType = meshtype
	mesh.Scale = Vector3.new(x1*10,y1*10,z1*10)
	return mesh
end

function waveEff(bonuspeed,type,typeoftrans,pos,scale,value,value2,color)
	local type = type
	local rng = Instance.new("Part", Effects)
	rng.Anchored = true
	rng.BrickColor = BrickColor.new("New Yeller")
	rng.CanCollide = false
	rng.FormFactor = 3
	rng.Name = "Ring"
	rng.Color = C3(1,1,0)
	rng.Material = "Neon"
	rng.Size = Vector3.new(1, 1, 1)
	rng.Transparency = 0
	if typeoftrans == "In" then
		rng.Transparency = 1
	end
	rng.TopSurface = 0
	rng.BottomSurface = 0
	rng.CFrame = pos
	local rngm = Instance.new("SpecialMesh", rng)
	rngm.MeshType = "FileMesh"
	rngm.MeshId = "rbxassetid://20329976"
	rngm.Scale = scale
	local scaler2 = 1
	local scaler2b = 1
	if type == "Add" then
		scaler2 = 1*value
		scaler2b = 1*value2
	elseif type == "Divide" then
		scaler2 = 1/value
		scaler2b = 1/value2
	end
	local randomrot = math.random(1,2)
	coroutine.resume(coroutine.create(function()
		for i = 0,10/bonuspeed,0.1 do
			swait()
			if type == "Add" then
				scaler2 = scaler2 - 0.01*value/bonuspeed
				scaler2b = scaler2b - 0.01*value/bonuspeed
			elseif type == "Divide" then
				scaler2 = scaler2 - 0.01/value*bonuspeed
				scaler2b = scaler2b - 0.01/value*bonuspeed
			end
			if randomrot == 1 then
				rng.CFrame = rng.CFrame*CFrame.Angles(0,math.rad(5*bonuspeed/2),0)
			elseif randomrot == 2 then
				rng.CFrame = rng.CFrame*CFrame.Angles(0,math.rad(-5*bonuspeed/2),0)
			end
			if typeoftrans == "Out" then
				rng.Transparency = rng.Transparency + 0.01*bonuspeed
			elseif typeoftrans == "In" then
				rng.Transparency = rng.Transparency - 0.01*bonuspeed
			end
			rngm.Scale = rngm.Scale + Vector3.new(scaler2*bonuspeed, scaler2b*bonuspeed, scaler2*bonuspeed)
		end
		rng:Destroy()
	end))
end

function slash(bonuspeed,rotspeed,rotatingop,typeofshape,type,typeoftrans,pos,scale,value,color)
	local type = type
	local rotenable = rotatingop
	local rng = Instance.new("Part", Effects)
	rng.Anchored = true
	rng.Color = C3(1,1,0)
	rng.CanCollide = false
	rng.FormFactor = 3
	rng.Name = "Ring"
	rng.Material = "Neon"
	rng.Size = Vector3.new(1, 1, 1)
	rng.Transparency = 0
	if typeoftrans == "In" then
		rng.Transparency = 1
	end
	rng.TopSurface = 0
	rng.BottomSurface = 0
	rng.CFrame = pos
	local rngm = Instance.new("SpecialMesh", rng)
	rngm.MeshType = "FileMesh"
	if typeofshape == "Normal" then
		rngm.MeshId = "rbxassetid://662586858"
	elseif typeofshape == "Round" then
		rngm.MeshId = "rbxassetid://662585058"
	end
	rngm.Scale = scale
	local scaler2 = 1/10
	if type == "Add" then
		scaler2 = 1*value/10
	elseif type == "Divide" then
		scaler2 = 1/value/10
	end
	local randomrot = math.random(1,2)
	coroutine.resume(coroutine.create(function()
		for i = 0,10/bonuspeed,0.1 do
			swait()
			if type == "Add" then
				scaler2 = scaler2 - 0.01*value/bonuspeed/10
			elseif type == "Divide" then
				scaler2 = scaler2 - 0.01/value*bonuspeed/10
			end
			if rotenable == true then
				if randomrot == 1 then
					rng.CFrame = rng.CFrame*CFrame.Angles(0,math.rad(rotspeed*bonuspeed/2),0)
				elseif randomrot == 2 then
					rng.CFrame = rng.CFrame*CFrame.Angles(0,math.rad(-rotspeed*bonuspeed/2),0)
				end
			end
			if typeoftrans == "Out" then
				rng.Transparency = rng.Transparency + 0.01*bonuspeed
			elseif typeoftrans == "In" then
				rng.Transparency = rng.Transparency - 0.01*bonuspeed
			end
			rngm.Scale = rngm.Scale + Vector3.new(scaler2*bonuspeed/10, 0, scaler2*bonuspeed/10)
		end
		rng:Destroy()
	end))
end

function sphere(bonuspeed,type,pos,scale,value,color)
	local type = type
	local rng = Instance.new("Part", Effects)
	rng.Anchored = true
	rng.Color = C3(1,1,0)
	rng.CanCollide = false
	rng.FormFactor = 3
	rng.Name = "Ring"
	rng.Material = "Neon"
	rng.Size = Vector3.new(1, 1, 1)
	rng.Transparency = 0
	rng.TopSurface = 0
	rng.BottomSurface = 0
	rng.CFrame = pos
	local rngm = Instance.new("SpecialMesh", rng)
	rngm.MeshType = "Sphere"
	rngm.Scale = scale
	local scaler2 = 1
	if type == "Add" then
		scaler2 = 1*value
	elseif type == "Divide" then
		scaler2 = 1/value
	end
	coroutine.resume(coroutine.create(function()
		for i = 0,10/bonuspeed,0.1 do
			swait()
			if type == "Add" then
				scaler2 = scaler2 - 0.01*value/bonuspeed
			elseif type == "Divide" then
				scaler2 = scaler2 - 0.01/value*bonuspeed
			end
			rng.Transparency = rng.Transparency + 0.01*bonuspeed
			rngm.Scale = rngm.Scale + Vector3.new(scaler2*bonuspeed, scaler2*bonuspeed, scaler2*bonuspeed)
		end
		rng:Destroy()
	end))
end

function sphere2(bonuspeed,type,pos,scale,value,value2,value3,color,color3)
	local type = type
	local rng = Instance.new("Part", Effects)
	rng.Anchored = true
	rng.BrickColor = color
	rng.Color = C3(1,1,0)
	rng.CanCollide = false
	rng.FormFactor = 3
	rng.Name = "Ring"
	rng.Material = "Neon"
	rng.Size = Vector3.new(1, 1, 1)
	rng.Transparency = 0
	rng.TopSurface = 0
	rng.BottomSurface = 0
	rng.CFrame = pos
	local rngm = Instance.new("SpecialMesh", rng)
	rngm.MeshType = "Sphere"
	rngm.Scale = scale
	local scaler2 = 1
	local scaler2b = 1
	local scaler2c = 1
	if type == "Add" then
		scaler2 = 1*value
		scaler2b = 1*value2
		scaler2c = 1*value3
	elseif type == "Divide" then
		scaler2 = 1/value
		scaler2b = 1/value2
		scaler2c = 1/value3
	end
	coroutine.resume(coroutine.create(function()
		for i = 0,10/bonuspeed,0.1 do
			swait()
			if type == "Add" then
				scaler2 = scaler2 - 0.01*value/bonuspeed
				scaler2b = scaler2b - 0.01*value/bonuspeed
				scaler2c = scaler2c - 0.01*value/bonuspeed
			elseif type == "Divide" then
				scaler2 = scaler2 - 0.01/value*bonuspeed
				scaler2b = scaler2b - 0.01/value*bonuspeed
				scaler2c = scaler2c - 0.01/value*bonuspeed
			end
			rng.Transparency = rng.Transparency + 0.01*bonuspeed
			rngm.Scale = rngm.Scale + Vector3.new(scaler2*bonuspeed, scaler2b*bonuspeed, scaler2c*bonuspeed)
		end
		rng:Destroy()
	end))
end

function CreateParta(parent,transparency,reflectance,material,brickcolor)
	local p = Instance.new("Part")
	p.TopSurface = 0
	p.BottomSurface = 0
	p.Parent = Effects
	p.Size = Vector3.new(0.05,0.05,0.05)
	p.Transparency = transparency
	p.Reflectance = reflectance
	p.CanCollide = false
	p.Locked = true
	p.BrickColor = brickcolor
	p.Material = material
	return p
end

function sphere(bonuspeed,type,pos,scale,value,color)
	local type = type
	local rng = Instance.new("Part", Effects)
	rng.Anchored = true
	rng.Color = C3(1,1,0)
	rng.CanCollide = false
	rng.FormFactor = 3
	rng.Name = "Ring"
	rng.Material = "Neon"
	rng.Size = Vector3.new(1, 1, 1)
	rng.Transparency = 0
	rng.TopSurface = 0
	rng.BottomSurface = 0
	rng.CFrame = pos
	local rngm = Instance.new("SpecialMesh", rng)
	rngm.MeshType = "Sphere"
	rngm.Scale = scale
	local scaler2 = 1
	if type == "Add" then
		scaler2 = 1*value
	elseif type == "Divide" then
		scaler2 = 1/value
	end
	coroutine.resume(coroutine.create(function()
		for i = 0,10/bonuspeed,0.1 do
			swait()
			if type == "Add" then
				scaler2 = scaler2 - 0.01*value/bonuspeed
			elseif type == "Divide" then
				scaler2 = scaler2 - 0.01/value*bonuspeed
			end
			rng.Transparency = rng.Transparency + 0.01*bonuspeed
			rngm.Scale = rngm.Scale + Vector3.new(scaler2*bonuspeed, scaler2*bonuspeed, scaler2*bonuspeed)
		end
		rng:Destroy()
	end))
end

function turnto(position)
	RootPart.CFrame=CFrame.new(RootPart.CFrame.p,VT(position.X,RootPart.Position.Y,position.Z)) * CFrame.new(0, 0, 0)
end

function Raycast(POSITION, DIRECTION, RANGE, IGNOREDECENDANTS)
	return workspace:FindPartOnRay(Ray.new(POSITION, DIRECTION.unit * RANGE), IGNOREDECENDANTS)
end
function PositiveAngle(NUMBER)
	if NUMBER >= 0 then
		NUMBER = 0
	end
	return NUMBER
end
function NegativeAngle(NUMBER)
	if NUMBER <= 0 then
		NUMBER = 0
	end
	return NUMBER
end
function CreateMesh(MESH, PARENT, MESHTYPE, MESHID, TEXTUREID, SCALE, OFFSET)
	local NEWMESH = IT(MESH)
	if MESH == "SpecialMesh" then
		NEWMESH.MeshType = MESHTYPE
		if MESHID ~= "nil" and MESHID ~= "" then
			NEWMESH.MeshId = "http://www.roblox.com/asset/?id=" .. MESHID
		end
		if TEXTUREID ~= "nil" and TEXTUREID ~= "" then
			NEWMESH.TextureId = "http://www.roblox.com/asset/?id=" .. TEXTUREID
		end
	end
	NEWMESH.Offset = OFFSET or VT(0, 0, 0)
	NEWMESH.Scale = SCALE
	NEWMESH.Parent = PARENT
	return NEWMESH
end
function CreatePart(FORMFACTOR, PARENT, MATERIAL, REFLECTANCE, TRANSPARENCY, BRICKCOLOR, NAME, SIZE, ANCHOR)
	local NEWPART = IT("Part")
	NEWPART.formFactor = FORMFACTOR
	NEWPART.Reflectance = REFLECTANCE
	NEWPART.Transparency = TRANSPARENCY
	NEWPART.CanCollide = false
	NEWPART.Locked = true
	NEWPART.Anchored = true
	if ANCHOR == false then
		NEWPART.Anchored = false
	end
	NEWPART.BrickColor = BRICKC(tostring(BRICKCOLOR))
	NEWPART.Name = NAME
	NEWPART.Size = SIZE
	NEWPART.Position = Torso.Position
	NEWPART.Material = MATERIAL
	NEWPART:BreakJoints()
	NEWPART.Parent = PARENT
	return NEWPART
end
local weldBetween = function(a, b)
	local weldd = Instance.new("ManualWeld")
	weldd.Part0 = a
	weldd.Part1 = b
	weldd.C0 = CFrame.new()
	weldd.C1 = b.CFrame:inverse() * a.CFrame
	weldd.Parent = a
	return weldd
end
function weldSomethings(a, b, acf)
	local we = Instance.new("Weld", a)
	we.Part0 = a
	we.Part1 = b
	if acf ~= nil then
		we.C0 = acf
	end
end
function QuaternionFromCFrame(CF)
	local mx, my, mz, m00, m01, m02, m10, m11, m12, m20, m21, m22 = CF:components()
	local trace = m00 + m11 + m22
	if trace > 0 then
		local s = math.sqrt(1 + trace)
		local recip = 0.5 / s
		return (m21 - m12) * recip, (m02 - m20) * recip, (m10 - m01) * recip, s * 0.5
	else
		local i = 0
		if m00 < m11 then
			i = 1
		end
		if m22 > (i == 0 and m00 or m11) then
			i = 2
		end
		if i == 0 then
			local s = math.sqrt(m00 - m11 - m22 + 1)
			local recip = 0.5 / s
			return 0.5 * s, (m10 + m01) * recip, (m20 + m02) * recip, (m21 - m12) * recip
		elseif i == 1 then
			local s = math.sqrt(m11 - m22 - m00 + 1)
			local recip = 0.5 / s
			return (m01 + m10) * recip, 0.5 * s, (m21 + m12) * recip, (m02 - m20) * recip
		elseif i == 2 then
			local s = math.sqrt(m22 - m00 - m11 + 1)
			local recip = 0.5 / s
			return (m02 + m20) * recip, (m12 + m21) * recip, 0.5 * s, (m10 - m01) * recip
		end
	end
end
function QuaternionToCFrame(px, py, pz, x, y, z, w)
	local xs, ys, zs = x + x, y + y, z + z
	local wx, wy, wz = w * xs, w * ys, w * zs
	local xx = x * xs
	local xy = x * ys
	local xz = x * zs
	local yy = y * ys
	local yz = y * zs
	local zz = z * zs
	return CFrame.new(px, py, pz, 1 - (yy + zz), xy - wz, xz + wy, xy + wz, 1 - (xx + zz), yz - wx, xz - wy, yz + wx, 1 - (xx + yy))
end
function QuaternionSlerp(a, b, t)
	local cosTheta = a[1] * b[1] + a[2] * b[2] + a[3] * b[3] + a[4] * b[4]
	local startInterp, finishInterp
	if cosTheta >= 1.0E-4 then
		if 1 - cosTheta > 1.0E-4 then
			local theta = ACOS(cosTheta)
			local invSinTheta = 1 / SIN(theta)
			startInterp = SIN((1 - t) * theta) * invSinTheta
			finishInterp = SIN(t * theta) * invSinTheta
		else
			startInterp = 1 - t
			finishInterp = t
		end
	elseif 1 + cosTheta > 1.0E-4 then
		local theta = ACOS(-cosTheta)
		local invSinTheta = 1 / SIN(theta)
		startInterp = SIN((t - 1) * theta) * invSinTheta
		finishInterp = SIN(t * theta) * invSinTheta
	else
		startInterp = t - 1
		finishInterp = t
	end
	return a[1] * startInterp + b[1] * finishInterp, a[2] * startInterp + b[2] * finishInterp, a[3] * startInterp + b[3] * finishInterp, a[4] * startInterp + b[4] * finishInterp
end
function Clerp(a, b, t)
	local qa = {
		QuaternionFromCFrame(a)
	}
	local qb = {
		QuaternionFromCFrame(b)
	}
	local ax, ay, az = a.x, a.y, a.z
	local bx, by, bz = b.x, b.y, b.z
	local _t = 1 - t
	return QuaternionToCFrame(_t * ax + t * bx, _t * ay + t * by, _t * az + t * bz, QuaternionSlerp(qa, qb, t))
end
QuaternionFromCFrameCR = function(p157)
	local v3930, v3931, v3932, v3933, v3934, v3935, v3936, v3937, v3938, v3939, v3940, v3941 = p157:components()
	local v3943 = v3933 + v3937 + v3941
	local v3971 = 0
	if v3943 > v3971 then
		v3971 = math.sqrt
		local v3946 = v3971(1 + v3943)
		local v3947 = 0.5 / v3946
		return v3940 - v3938 * v3947, v3935 - v3939 * v3947, v3936 - v3934 * v3947, v3946 * 0.5
	end
	v3946 = 0
	if v3937 > v3933 then
		v3946 = 1
	end
	if v3946 == 0 then
		v3947 = v3933
		if v3947 then
			v3947 = v3937
		end
		if v3941 > v3947 then
			v3946 = 2
		end
		if v3946 == 0 then
			v3947 = math.sqrt
			local v3954 = v3947(v3933 - v3937 - v3941 + 1)
			local v3955 = 0.5 / v3954
			return {0.5 * v3954, v3936 + v3934 * v3955, v3939 + v3935 * v3955, v3940 - v3938 * v3955}
		end
		if v3946 == 1 then
			v3955 = v3937 - v3941 - v3933 + 1
			v3954 = math.sqrt
			local v3961 = v3954(v3955)
			local v3962 = 0.5 / v3961
			v3958 = v3935 - v3939
			return {v3934 + v3936 * v3962, 0.5 * v3961, v3940 + v3938 * v3962, v3958 * v3962}
		end
		if v3946 == 2 then
			v3962 = v3941 - v3933 - v3937 + 1
			v3961 = math.sqrt
			local v3967 = v3961(v3962)
			local v3968 = 0.5 / v3967
			v3958 = v3936 - v3934
			return {v3935 + v3939 * v3968, v3938 + v3940 * v3968, 0.5 * v3967, v3958 * v3968}
		end
		return
	end
end
local function ClerpCR(p167, p168, p169)
	local v4038 = {}
	v4038 = QuaternionFromCFrame(p167)
	v4042 = QuaternionFromCFrame
	v4043 = p168
	v4041 = QuaternionFromCFrame(p168)
	v4045 = p167.x
	v4046 = p167.y
	v4044 = p167.z
	v4047 = p168.x
	v4048 = p168.y
	local v4051 = 1 - p169
	return QuaternionToCFrame(v4051 * v4045 + p169 * v4047, v4051 * v4046 + p169 * v4048, v4051 * v4044 + p169 * p168.z, QuaternionSlerp(v4038, v4041, p169))
end
function ClerpHSC(p170, p171, p172)
	local v4067 = 1
	if 5 > p172 then
		v4067 = p172 * HyperThrot
		local v4071 = math.clamp(v4067, 0, 1)
		if v4071 then
			v4071 = 1
		end
		return p170:lerp(p171, v4071)
	end
end
function CreateFrame(PARENT, TRANSPARENCY, BORDERSIZEPIXEL, POSITION, SIZE, COLOR, BORDERCOLOR, NAME)
	local frame = IT("Frame")
	frame.BackgroundTransparency = TRANSPARENCY
	frame.BorderSizePixel = BORDERSIZEPIXEL
	frame.Position = POSITION
	frame.Size = SIZE
	frame.BackgroundColor3 = COLOR
	frame.BorderColor3 = BORDERCOLOR
	frame.Name = NAME
	frame.Parent = PARENT
	return frame
end
function CreateLabel(PARENT, TEXT, TEXTCOLOR, TEXTFONTSIZE, TEXTFONT, TRANSPARENCY, BORDERSIZEPIXEL, STROKETRANSPARENCY, NAME)
	local label = IT("TextLabel")
	label.BackgroundTransparency = 1
	label.Size = UD2(1, 0, 1, 0)
	label.Position = UD2(0, 0, 0, 0)
	label.TextColor3 = TEXTCOLOR
	label.TextStrokeTransparency = STROKETRANSPARENCY
	label.TextTransparency = TRANSPARENCY
	label.FontSize = TEXTFONTSIZE
	label.Font = TEXTFONT
	label.BorderSizePixel = BORDERSIZEPIXEL
	label.TextScaled = false
	label.Text = TEXT
	label.Name = NAME
	label.Parent = PARENT
	return label
end
function NoOutlines(PART)
	PART.TopSurface, PART.BottomSurface, PART.LeftSurface, PART.RightSurface, PART.FrontSurface, PART.BackSurface = 10, 10, 10, 10, 10, 10
end
function CreateWeldOrSnapOrMotor(TYPE, PARENT, PART0, PART1, C0, C1)
	local NEWWELD = IT(TYPE)
	NEWWELD.Part0 = PART0
	NEWWELD.Part1 = PART1
	NEWWELD.C0 = C0
	NEWWELD.C1 = C1
	NEWWELD.Parent = PARENT
	return NEWWELD
end
--[[ local S = IT("Sound")
function CreateSound(ID, PARENT, VOLUME, PITCH, DOESLOOP)
	local NEWSOUND
	coroutine.resume(coroutine.create(function()
		NEWSOUND = S:Clone()
		NEWSOUND.Parent = PARENT
		NEWSOUND.Volume = 2
		NEWSOUND.Pitch = .8
		NEWSOUND.EmitterSize = VOLUME * 3
		NEWSOUND.SoundId = "http://www.roblox.com/asset/?id=" .. ID
		NEWSOUND:play()
		if DOESLOOP == true then
			NEWSOUND.Looped = true
		else
			repeat
				wait(1)
			until NEWSOUND.Playing == false
			NEWSOUND:remove()
		end
	end))
	return NEWSOUND
end --]]
function NewSound(TABLE)
	local ID = "rbxassetid://"..(TABLE.ID or 0)
	local PARENT = (TABLE.PARENT or ROOT)
	local VOLUME = (TABLE.VOLUME or 0.5)
	local PITCH = (TABLE.PITCH or 1)
	local LOOP = (TABLE.LOOP or false)
	local MAXDISTANCE = (TABLE.MAXDISTANCE or 100)
	local EMITTERSIZE = (TABLE.EMITTERSIZE or 10)
	local PLAYING = (TABLE.PLAYING or true)
	local PLAYONREMOVE = (TABLE.PLAYONREMOVE or false)
	local DOESDEBRIS = (TABLE.DOESDEBRIS or true)
	if ID ~= "rbxassetid://0" then
		local SOUND = IT("Sound",PARENT)
		SOUND.SoundId = ID
		SOUND.Volume = VOLUME
		SOUND.Pitch = PITCH
		SOUND.Looped = LOOP
		SOUND.MaxDistance = MAXDISTANCE
		SOUND.EmitterSize = EMITTERSIZE
		SOUND.PlayOnRemove = PLAYONREMOVE
		if DOESDEBRIS == true and PLAYING == true and LOOP == false then
			Debris:AddItem(SOUND,SOUND.TimeLength+5)
		end
		if PLAYING == true then
			SOUND:Play()
		end
		return SOUND
	end
end 
function Wyvern(Size,DoesBurn)
	local WYVERN = IT("Model")
	local BASEPART = CreatePart(3, WYVERN, "Neon", 0, 0.5, "Deep orange", "Wyvern Base",(VT(1, 7.2, 1)*1.5)*Size,false)
	local BASEWELD = CreateWeldOrSnapOrMotor("Weld", Torso, Torso, BASEPART, CF(0,0,0), CF(0, 0, 0))
	CreateMesh("SpecialMesh", BASEPART, "FileMesh", "90615474", "", VT(1.5,1.5,1.5)*Size, VT(0,0,0))
	local RWING = CreatePart(3, WYVERN, "Neon", 0, 0.5, "Deep orange", "Right Wing", (VT(2, 3, 2)*1.5)*Size,false)
	local RWELD = CreateWeldOrSnapOrMotor("Weld", Torso, Torso, RWING, CF(2*Size , 2*Size, 0.75*Size), CF(-2*Size, 0, 0))
	local LWING = CreatePart(3, WYVERN, "Neon", 0, 0.5, "Deep orange", "Left Wing", (VT(2, 3, 2)*1.5)*Size,false)
	local LWELD = CreateWeldOrSnapOrMotor("Weld", Torso, Torso, LWING, CF(-2*Size , 2*Size, 0.75*Size), CF(2*Size, 0, 0))
	CreateMesh("SpecialMesh", RWING, "FileMesh", "90615661", "", VT(1.5,1.5,1.5)*Size, VT(0,0,0))
	CreateMesh("SpecialMesh", LWING, "FileMesh", "90615581", "", VT(1.5,1.5,1.5)*Size, VT(0,0,0))
	for _, c in pairs(WYVERN:GetChildren()) do
		if c.ClassName == "Part" then
			c.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
			c.Color = FIRECOLOR
		end
	end
	WYVERN.Parent = Effects
	if DoesBurn == false then
		return WYVERN,BASEPART,RWING,LWING,BASEWELD,RWELD,LWELD
	elseif DoesBurn == true then
		local BodyFire = BurningLimb(BASEPART)
		BodyFire.Size = NumberSequence.new(Size,0)
		BodyFire.Acceleration = VT(0,2*Size,0)
		local RightWingFire = BurningLimb(RWING)
		RightWingFire.Size = NumberSequence.new(Size,0)
		RightWingFire.Acceleration = VT(0,6*Size,0)
		local LeftWingFire = BurningLimb(LWING)
		LeftWingFire.Size = NumberSequence.new(Size,0)
		LeftWingFire.Acceleration = VT(0,6*Size,0)
		BodyFire.Color = ColorSequence.new(FIRECOLOR,C3(1,1,1))
		RightWingFire.Color = ColorSequence.new(FIRECOLOR,C3(1,1,1))
		LeftWingFire.Color = ColorSequence.new(FIRECOLOR,C3(1,1,1))
		return WYVERN,BASEPART,RWING,LWING,BASEWELD,RWELD,LWELD,BodyFire,RightWingFire,LeftWingFire
	end
end
function CFrameFromTopBack(at, top, back)
	local right = top:Cross(back)
	return CF(at.x, at.y, at.z, right.x, top.x, back.x, right.y, top.y, back.y, right.z, top.z, back.z)
end
function MagicRing()
	local O1 = CreatePart(3, Effects, "Neon", 0, 1, "Really black", "Warphole", VT(0, 0, 0))
	O1.CFrame = RootPart.CFrame * CF(0, 0, -3) * ANGLES(RAD(90), RAD(0), RAD(0))
	local decal = Decal:Clone()
	decal.Parent = O1
	decal.Face = "Top"
	decal.Texture = "http://www.roblox.com/asset/?id=0"
	local decal2 = Decal:Clone()
	decal2.Parent = O1
	decal2.Face = "Bottom"
	decal2.Texture = "http://www.roblox.com/asset/?id=0"
	return O1
end
function MagicRing2(PART,CFRAME)
	local RING = CreatePart(3, Effects, "Neon", 0, 1, "New Yeller", "MagicRing", VT(0,0,0),false)
	local WELD = CreateWeldOrSnapOrMotor("Weld", PART, PART, RING, CFRAME, CF(0, 0, 0))
	local MESH = IT("BlockMesh",RING)
	local BOTTOMTEXTURE = Decal:Clone()
	BOTTOMTEXTURE.Parent = RING
	BOTTOMTEXTURE.Face = "Bottom"
	BOTTOMTEXTURE.Name = "BottomTexture"
	local TOPTEXTURE = Decal:Clone()
	TOPTEXTURE.Parent = RING
	TOPTEXTURE.Face = "Top"
	TOPTEXTURE.Name = "TopTexture"
	local LIGHT = IT("PointLight",RING)
	BOTTOMTEXTURE.Texture = "http://www.roblox.com/asset/?id=2829906887"
	TOPTEXTURE.Texture = "http://www.roblox.com/asset/?id=2829906887"
	return RING,WELD,MESH
end
local DECAL = IT("Decal")
function MagicRing3()
	local RING = CreatePart(3, Effects, "Neon", 0, 1, BRICKC("Pearl"), "MagicRing", VT(0, 0, 0), true)
	local MSH = IT("BlockMesh", RING)
	local TOP = DECAL:Clone()
	local BOTTOM = DECAL:Clone()
	TOP.Parent = RING
	BOTTOM.Parent = RING
	TOP.Face = "Top"
	BOTTOM.Face = "Bottom"
	TOP.Texture = "http://www.roblox.com/asset/?id=0"
	BOTTOM.Texture = "http://www.roblox.com/asset/?id=0"
	local function REMOVE()
		coroutine.resume(coroutine.create(function()
			local SIZE = MSH.Scale.X
			for i = 1, 35 do
				Swait()
				MSH.Scale = MSH.Scale - VT(SIZE, 0, SIZE) / 60
				TOP.Transparency = TOP.Transparency + 0.02857142857142857
				BOTTOM.Transparency = BOTTOM.Transparency + 0.02857142857142857
				RING.CFrame = RING.CFrame * ANGLES(RAD(0), RAD(-5), RAD(0))
			end
			RING:remove()
		end))
	end
	return RING, MSH, REMOVE
end
function CreateWave(SIZE, WAIT, CFRAME, DOESROT, ROT, COLOR, GROW)
	local wave = CreatePart(3, Effects, "Neon", 0, 0.5, BRICKC(COLOR), "Effect", VT(0, 0, 0))
	local mesh = CreateMesh("SpecialMesh", wave, "FileMesh", "20329976", "", SIZE, VT(0, 0, -SIZE.X / 8))
	wave.CFrame = CFRAME
	coroutine.resume(coroutine.create(function(PART)
		for i = 1, WAIT do
			Swait()
			mesh.Scale = mesh.Scale + GROW
			mesh.Offset = VT(0, 0, -(mesh.Scale.X / 8))
			if DOESROT == true then
				wave.CFrame = wave.CFrame * CFrame.fromEulerAnglesXYZ(0, ROT, 0)
			end
			wave.Transparency = wave.Transparency + 0.5 / WAIT
			if wave.Transparency > 0.99 then
				wave:remove()
			end
		end
	end))
end
function SpecialSphere(SIZE,WAIT,CFRAME,COLOR,GROW)
	local wave = CreatePart(3, Effects, "Neon", 0, 0, BRICKC(COLOR), "Eye", VT(1,1,1), true)
	wave.Color = COLOR
	local mesh = CreateMesh("SpecialMesh", wave, "Sphere", "", "", SIZE, VT(0,0,0))
	wave.CFrame = CFRAME
	coroutine.resume(coroutine.create(function(PART)
		for i = 1, WAIT do
			Swait()
			mesh.Scale = mesh.Scale + GROW
			wave.Transparency = wave.Transparency + (1/WAIT)
			if wave.Transparency > 0.99 then
				wave:remove()
			end
		end
	end))
end
function MagicSphere(SIZE,WAIT,CFRAME,COLOR,GROW)
	local wave = CreatePart(3, Effects, "Neon", 0, 0, BRICKC(COLOR), "Effect", VT(1,1,1), true)
	local mesh = IT("SpecialMesh",wave)
	mesh.MeshType = "Sphere"
	mesh.Scale = SIZE
	mesh.Offset = VT(0,0,0)
	wave.CFrame = CFRAME
	coroutine.resume(coroutine.create(function(PART)
		for i = 1, WAIT do
			Swait()
			mesh.Scale = mesh.Scale + GROW
			wave.Transparency = wave.Transparency + (1/WAIT)
			if wave.Transparency > 0.99 then
				wave:remove()
			end
		end
	end))
end

Effect = function(p291)
	local v8005 = p291.EffectType or "Sphere"
	local v8301 = p291.Size
	if v8301 then
		v8301 = Vector3.new
		local v8009 = v8301(1, 1, 1)
	end
	local v8010 = p291.Size2
	if v8010 then
		v8010 = Vector3.new
		local v8011 = v8010()
	end
	local v8012 = p291.Transparency
	local v8013 = v8012 or 0
	local v8014 = p291.Transparency2
	v8012 = v8014 or 1
	v8014 = p291.CFrame
	if v8014 then
		v8014 = v733.CFrame
	end
	local v8016 = p291.MoveToPos
	v8015 = v8016 or nil
	local v8017 = p291.RotationX
	v8016 = v8017 or 0
	local v8018 = p291.RotationY
	v8017 = v8018 or 0
	local v8019 = p291.RotationZ
	v8018 = v8019 or 0
	local v8020 = p291.Material
	v8019 = v8020 or "Neon"
	v8020 = p291.Color
	if v8020 then
		v8020 = v798
	end
	local v8023, v8024, v8025 = Color3.toHSV(v8020)
	local v8026 = false
	local v8027 = 0.1
	if v8024 > v8027 then
		v8026 = true
	end
	local v8028 = p291.Time
	v8027 = v8028 or 45
	local v8029 = p291.SoundID
	v8028 = v8029 or nil
	local v8030 = p291.SoundPitch
	v8029 = v8030 or nil
	local v8031 = p291.SoundVolume
	v8030 = v8031 or nil
	local v8032 = p291.UseBoomerangMath
	v8031 = v8032 or false
	local v8033 = p291.Boomerang
	v8032 = v8033 or 0
	v8033 = p291.SizeBoomerang or 0
	coroutine.resume(coroutine.create(function()
		local v8037 = false
		local v8038
		local v8053 = CreatePart(3, v741, v8019, 0, v8013, v798, "Effect", Vector3.new(1, 1, 1), true)
		local v8054 = v8026
		if not v8054 then
			v8054 = coroutine.resume
			v8054(coroutine.create(function()
				while true do
					local v8059 = v8053:IsDescendantOf(game)
					if not v8059 then
						break
					end
					v8059 = v8053
					v8059.Color = v788.NeonParts.Color
					swait()
				end
			end))
		end
		local v8064 = v8028
		if v8064 == nil then
			v8064 = v8029
			if v8064 == nil then
				v8064 = v8030
				if v8064 == nil then
					v8037 = true
					v8064 = CreateSound
					v8038 = v8064(v8028, v8053, v8030, v8029, false)
				end
			end
		end
		v8070 = v8020
		v8053.Color = v8070
		v8070 = nil
		local v8071 = v8005
		if v8071 == "Sphere" then
			v8071 = CreateMesh
			v8070 = v8071("SpecialMesh", v8053, "Sphere", "", "", v8009, Vector3.new())
			local v8267 = v8005
			if v8267 == "Block" then
				v8267 = v8005
				if v8267 == "Box" then
					v8267 = Instance.new
					v8070 = v8267("BlockMesh", v8053)
					v8070.Scale = v8009
				else
					v8082 = v8005
					if v8082 == "Wave" then
						v8082 = CreateMesh
						v8070 = v8082("SpecialMesh", v8053, "FileMesh", "20329976", "", v8009, Vector3.new(0, 0, -v8009.X / 8))
					else
						v8096 = v8005
						if v8096 == "Ring" then
							v8096 = CreateMesh
							v8070 = v8096("SpecialMesh", v8053, "FileMesh", "559831844", "", Vector3.new(v8009.X, v8009.X, 0.1), Vector3.new())
						else
							v8108 = v8005
							if v8108 == "Slash" then
								v8108 = CreateMesh
								v8094 = v8009
								v8070 = v8108("SpecialMesh", v8053, "FileMesh", "662586858", "", Vector3.new(v8009.X / 10, 0, v8094.X / 10), Vector3.new())
							else
								v8121 = v8005
								if v8121 == "Round Slash" then
									v8121 = CreateMesh
									v8094 = v8009
									v8118 = v8094.X
									v8070 = v8121("SpecialMesh", v8053, "FileMesh", "662585058", "", Vector3.new(v8009.X / 10, 0, v8118 / 10), Vector3.new())
								else
									v8133 = v8005
									if v8133 == "Swirl" then
										v8133 = CreateMesh
										v8070 = v8133("SpecialMesh", v8053, "FileMesh", "168892432", "", v8009, Vector3.new())
									else
										v8141 = v8005
										if v8141 == "Skull" then
											v8141 = CreateMesh
											v8070 = v8141("SpecialMesh", v8053, "FileMesh", "4770583", "", v8009, Vector3.new())
										else
											v8149 = v8005
											if v8149 == "Crystal" then
												v8149 = CreateMesh
												v8070 = v8149("SpecialMesh", v8053, "FileMesh", "9756362", "", v8009, Vector3.new())
											end
										end
									end
								end
							end
						end
					end
				end
				if v8070 == nil then
					local v8158 = 1
					local v8159 = v8032
					local v8160 = v8159 / 50
					v8157 = v8158 + v8160
					local v8161 = v8033
					local v8278
					local v8279 = v8015
					if v8279 == nil then
						v8279 = v8031
						if v8279 == true then
							v8161 = v8014.p - v8015.Magnitude
							v8279 = v8161 / v8027
							v8278 = v8279 * v8157
						else
							v8163 = v8014
							v8164 = v8163.p
							v8163 = v8015
							v8161 = v8164 - v8163
							v8279 = v8161.Magnitude
							v8161 = v8027
							v8278 = v8279 / v8161
						end
					end
					local v8282
					local v8283 = v8031
					if v8283 == true then
						v8164 = v8009
						v8163 = v8011
						v8283 = v8164 - v8163
						v8164 = 1 + v8161 / 50 + 1
						v8282 = v8283 * v8164
					else
						v8283 = v8009
						v8164 = v8011
						v8282 = v8283 - v8164
					end
					v8164 = v8013
					v8163 = v8012
					local v8284 = v8164 - v8163
					v8164 = v8005
					if v8164 == "Block" then
						v8163 = v8014
						v8162 = CFrame.Angles
						v8118 = 0
						v8094 = 360
						v8093 = 360
						v8092 = 360
						v8164 = v8163 * v8162(math.rad(math.random(v8118, v8094)), math.rad(math.random(0, v8093)), math.rad(math.random(0, v8092)))
						v8053.CFrame = v8164
					else
						v8164 = v8014
						v8053.CFrame = v8164
					end
					v8164 = v8031
					if v8164 == true then
						v8175 = 1
						local v8176 = v8027
						v8164 = v8176 + 1
						v8163 = 1
						for v8175 = v8175, v8164, v8163 do
							v8176 = swait
							v8176()
							local v8177 = v8070.Scale
							local v8291 = v8159.Z
							local v8292 = 1
							local v8293 = v8175 / v8027
							local v8294 = v8293 * v8158
							local v8295 = v8292 - v8294
							local v8189 = Vector3.new(v8159.X * 1 - v8175 / v8027 * v8158, v8159.Y * 1 - v8175 / v8027 * v8158, v8291 * v8295) * v8158
							local v8297 = v8027
							local v8190 = v8189 / v8297
							v8070.Scale = v8177 - v8190
							local v8298 = v8005
							if v8298 == "Wave" then
								v8298 = Vector3.new
								v8177 = 0
								v8190 = 0
								v8297 = -v8070.Scale.Z
								v8189 = v8297 / 8
								v8070.Offset = v8298(v8177, v8190, v8189)
							end
							local v8195 = v8053.Transparency
							local v8196 = v8027
							local v8197 = v8161 / v8196
							v8194 = v8195 - v8197
							v8053.Transparency = v8194
							v8194 = v8005
							if v8194 == "Block" then
								v8195 = v8014
								v8197 = CFrame.Angles
								v8297 = math.random
								v8193 = 0
								v8192 = 360
								v8196 = math.rad
								v8291 = 360
								v8194 = v8195 * v8197(v8196(v8297(v8193, v8192)), math.rad(math.random(0, 360)), math.rad(math.random(0, v8291)))
								v8053.CFrame = v8194
							else
								v8195 = v8053.CFrame
								v8207 = CFrame.Angles
								v8194 = v8195 * v8207(math.rad(v8016), math.rad(v8017), math.rad(v8018))
								v8053.CFrame = v8194
							end
							v8194 = v8015
							if v8194 == nil then
								v8194 = v8053.Orientation
								v8216 = CFrame.new
								v8295 = 1
								v8293 = v8027
								v8294 = v8175 / v8293
								v8292 = v8294 * v8157
								v8195 = v8216(v8053.Position, v8015) * CFrame.new(0, 0, -v8160 * v8295 - v8292)
								v8053.CFrame = v8195
								v8053.Orientation = v8194
							end
						end
					else
						v8175 = 1
						v8194 = v8027
						v8164 = v8194 + 1
						v8163 = 1
						for v8175 = v8175, v8164, v8163 do
							v8194 = swait
							v8194()
							v8195 = v8070.Scale
							v8226 = v8027
							v8219 = v8159 / v8226
							v8070.Scale = v8195 - v8219
							local v8300 = v8005
							if v8300 == "Wave" then
								v8300 = Vector3.new
								v8195 = 0
								v8219 = 0
								v8226 = -v8070.Scale.Z / 8
								v8070.Offset = v8300(v8195, v8219, v8226)
							end
							local v8232 = v8053.Transparency
							local v8233 = v8027
							local v8234 = v8161 / v8233
							v8231 = v8232 - v8234
							v8053.Transparency = v8231
							v8231 = v8005
							if v8231 == "Block" then
								v8232 = v8014
								v8234 = CFrame.Angles
								v8230 = math.random
								v8229 = 0
								v8228 = 360
								v8233 = math.rad
								v8224 = 360
								v8223 = 360
								v8231 = v8232 * v8234(v8233(v8230(v8229, v8228)), math.rad(math.random(0, v8224)), math.rad(math.random(0, v8223)))
								v8053.CFrame = v8231
							else
								v8232 = v8053.CFrame
								v8243 = CFrame.Angles
								v8231 = v8232 * v8243(math.rad(v8016), math.rad(v8017), math.rad(v8018))
								v8053.CFrame = v8231
							end
							v8231 = v8015
							if v8231 == nil then
								v8231 = v8053.Orientation
								v8252 = CFrame.new
								v8232 = v8252(v8053.Position, v8015) * CFrame.new(0, 0, -v8160)
								v8053.CFrame = v8232
								v8053.Orientation = v8231
							end
						end
					end
					v8164 = 1
					v8053.Transparency = v8164
					if v8037 == false then
						v8053:Destroy()
						return 
					end
					while true do
						swait()
						v8175 = "Sound"
						if v8053:FindFirstChildOfClass(v8175) == nil then
							break
						end
					end
					v8053:Destroy()
					return 
				end
				if v8037 == false then
					v8053:Destroy()
					return 
				end
				while true do
					swait()
					v8160 = "Sound"
					if v8053:FindFirstChildOfClass(v8160) == nil then
						break
					end
				end
				v8053:Destroy()
				return 
			end
		end
	end))
end

function WACKYEFFECT(Table)
	local TYPE = Table.EffectType or "Sphere"
	local SIZE = Table.Size or VT(1, 1, 1)
	local ENDSIZE = Table.Size2 or VT(0, 0, 0)
	local TRANSPARENCY = Table.Transparency or 0
	local ENDTRANSPARENCY = Table.Transparency2 or 1
	local CFRAME = Table.CFrame or Torso.CFrame
	local MOVEDIRECTION = Table.MoveToPos or nil
	local ROTATION1 = Table.RotationX or 0
	local ROTATION2 = Table.RotationY or 0
	local ROTATION3 = Table.RotationZ or 0
	local MATERIAL = "Neon"
	local COLOR = Table.Color or C3(1, 1, 1)
	local TIME = Table.Time or 45
	local SOUNDID = Table.SoundID or nil
	local SOUNDPITCH = Table.SoundPitch or nil
	local SOUNDVOLUME = Table.SoundVolume or nil
	local USEBOOMERANGMATH = Table.UseBoomerangMath or false
	local BOOMERANG = Table.Boomerang or 0
	local SIZEBOOMERANG = Table.SizeBoomerang or 0
	coroutine.resume(coroutine.create(function()
		local PLAYSSOUND = false
		local SOUND
		local EFFECT = CreatePart(3, Effects, MATERIAL, 0, TRANSPARENCY, BRICKC("Pearl"), "Effect", VT(1, 1, 1), true)
		EFFECT.Color = COLOR
		if SOUNDID ~= nil and SOUNDPITCH ~= nil and SOUNDVOLUME ~= nil then
			PLAYSSOUND = true
			SOUND = CreateSound(SOUNDID, EFFECT, SOUNDVOLUME, SOUNDPITCH, false)
		end
		local MSH
		if TYPE == "Sphere" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "Sphere", "", "", SIZE, VT(0, 0, 0))
		elseif TYPE == "Block" or TYPE == "Box" then
			MSH = IT("BlockMesh", EFFECT)
			MSH.Scale = SIZE
		elseif TYPE == "Wave" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "20329976", "", SIZE, VT(0, 0, -SIZE.X / 8))
		elseif TYPE == "Ring" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "559831844", "", VT(SIZE.X, SIZE.X, 0.1), VT(0, 0, 0))
		elseif TYPE == "Slash" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "662586858", "", VT(SIZE.X / 10, 0, SIZE.X / 10), VT(0, 0, 0))
		elseif TYPE == "Round Slash" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "662585058", "", VT(SIZE.X / 10, 0, SIZE.X / 10), VT(0, 0, 0))
		elseif TYPE == "Swirl" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "168892432", "", SIZE, VT(0, 0, 0))
		elseif TYPE == "Skull" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "4770583", "", SIZE, VT(0, 0, 0))
		elseif TYPE == "Star" then 
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "2760116123", "", SIZE, VT(0,0,0))   	
		elseif TYPE == "Crystal" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "450656451", "", SIZE, VT(0, 0, 0))
		end
		coroutine.resume(coroutine.create(function()
			if MSH ~= nil then
				local BOOMR1 = 1 + BOOMERANG / 50
				local BOOMR2 = 1 + SIZEBOOMERANG / 50
				local MOVESPEED = nil
				if MOVEDIRECTION ~= nil then
					MOVESPEED = (CFRAME.p - MOVEDIRECTION).Magnitude/TIME
				end
				local GROWTH
				if USEBOOMERANGMATH == true then
					GROWTH = (SIZE - ENDSIZE) * (BOOMR2 + 1)
				else
					GROWTH = SIZE - ENDSIZE
				end
				local TRANS = TRANSPARENCY - ENDTRANSPARENCY
				if TYPE == "Block" then
					EFFECT.CFrame = CFRAME * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)))
				else
					EFFECT.CFrame = CFRAME
				end
				if USEBOOMERANGMATH == true then
					for LOOP = 1, TIME + 1 do
						Swait()
						MSH.Scale = MSH.Scale - VT(GROWTH.X * (1 - LOOP / TIME * BOOMR2), GROWTH.Y * (1 - LOOP / TIME * BOOMR2), GROWTH.Z * (1 - LOOP / TIME * BOOMR2)) * BOOMR2 / TIME
						if TYPE == "Wave" then
							MSH.Offset = VT(0, 0, -MSH.Scale.Z / 8)
						end
						EFFECT.Transparency = EFFECT.Transparency - TRANS / TIME
						if TYPE == "Block" then
							EFFECT.CFrame = CFRAME * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)))
						else
							EFFECT.CFrame = EFFECT.CFrame * ANGLES(RAD(ROTATION1), RAD(ROTATION2), RAD(ROTATION3))
						end
						if MOVEDIRECTION ~= nil then
							local ORI = EFFECT.Orientation
							EFFECT.CFrame = CF(EFFECT.Position, MOVEDIRECTION) * CF(0, 0, -MOVESPEED * (1 - LOOP / TIME * BOOMR1))
							EFFECT.Orientation = ORI
						end
					end
				else
					for LOOP = 1, TIME + 1 do
						Swait()
						MSH.Scale = MSH.Scale - GROWTH / TIME
						if TYPE == "Wave" then
							MSH.Offset = VT(0, 0, -MSH.Scale.Z / 8)
						end
						EFFECT.Transparency = EFFECT.Transparency - TRANS / TIME
						if TYPE == "Block" then
							EFFECT.CFrame = CFRAME * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)))
						else
							EFFECT.CFrame = EFFECT.CFrame * ANGLES(RAD(ROTATION1), RAD(ROTATION2), RAD(ROTATION3))
						end
						if MOVEDIRECTION ~= nil then
							local ORI = EFFECT.Orientation
							EFFECT.CFrame = CF(EFFECT.Position,MOVEDIRECTION)*CF(0,0,-MOVESPEED)
							EFFECT.Orientation = ORI
						end
					end
				end
				EFFECT.Transparency = 1
				if PLAYSSOUND == false then
					EFFECT:remove()
				else
					repeat
						Swait()
					until EFFECT:FindFirstChildOfClass("Sound") == nil
					EFFECT:remove()
				end
			elseif PLAYSSOUND == false then
				EFFECT:remove()
			else
				repeat
					Swait()
				until EFFECT:FindFirstChildOfClass("Sound") == nil
				EFFECT:remove()
			end
		end))
		return EFFECT
	end))
end

function EXCEPTWACKYEFFECT(Table)
	local TYPE = Table.EffectType or "Sphere"
	local SIZE = Table.Size or VT(1, 1, 1)
	local ENDSIZE = Table.Size2 or VT(0, 0, 0)
	local TRANSPARENCY = Table.Transparency or 0
	local ENDTRANSPARENCY = Table.Transparency2 or 1
	local CFRAME = Table.CFrame or Torso.CFrame
	local MOVEDIRECTION = Table.MoveToPos or nil
	local ROTATION1 = Table.RotationX or 0
	local ROTATION2 = Table.RotationY or 0
	local ROTATION3 = Table.RotationZ or 0
	local MATERIAL = "Neon"
	local COLOR = Table.Color or C3(1, 1, 1)
	local TIME = Table.Time or 45
	local SOUNDID = Table.SoundID or nil
	local SOUNDPITCH = Table.SoundPitch or nil
	local SOUNDVOLUME = Table.SoundVolume or nil
	local USEBOOMERANGMATH = Table.UseBoomerangMath or false
	local BOOMERANG = Table.Boomerang or 0
	local SIZEBOOMERANG = Table.SizeBoomerang or 0
	coroutine.resume(coroutine.create(function()
		local PLAYSSOUND = false
		local SOUND
		local EFFECT = CreatePart(3, ExceptEffects, MATERIAL, 0, TRANSPARENCY, BRICKC("Pearl"), "Effect", VT(1, 1, 1), true)
		EFFECT.Color = COLOR
		if SOUNDID ~= nil and SOUNDPITCH ~= nil and SOUNDVOLUME ~= nil then
			PLAYSSOUND = true
			SOUND = CreateSound(SOUNDID, EFFECT, SOUNDVOLUME, SOUNDPITCH, false)
		end
		local MSH
		if TYPE == "Sphere" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "Sphere", "", "", SIZE, VT(0, 0, 0))
		elseif TYPE == "Block" or TYPE == "Box" then
			MSH = IT("BlockMesh", EFFECT)
			MSH.Scale = SIZE
		elseif TYPE == "Wave" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "20329976", "", SIZE, VT(0, 0, -SIZE.X / 8))
		elseif TYPE == "Ring" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "559831844", "", VT(SIZE.X, SIZE.X, 0.1), VT(0, 0, 0))
		elseif TYPE == "Slash" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "662586858", "", VT(SIZE.X / 10, 0, SIZE.X / 10), VT(0, 0, 0))
		elseif TYPE == "Round Slash" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "662585058", "", VT(SIZE.X / 10, 0, SIZE.X / 10), VT(0, 0, 0))
		elseif TYPE == "Swirl" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "168892432", "", SIZE, VT(0, 0, 0))
		elseif TYPE == "Skull" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "4770583", "", SIZE, VT(0, 0, 0))
		elseif TYPE == "Star" then 
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "2760116123", "", SIZE, VT(0,0,0))   	
		elseif TYPE == "Crystal" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "450656451", "", SIZE, VT(0, 0, 0))
		end
		coroutine.resume(coroutine.create(function()
			if MSH ~= nil then
				local BOOMR1 = 1 + BOOMERANG / 50
				local BOOMR2 = 1 + SIZEBOOMERANG / 50
				local MOVESPEED = nil
				if MOVEDIRECTION ~= nil then
					MOVESPEED = (CFRAME.p - MOVEDIRECTION).Magnitude/TIME
				end
				local GROWTH
				if USEBOOMERANGMATH == true then
					GROWTH = (SIZE - ENDSIZE) * (BOOMR2 + 1)
				else
					GROWTH = SIZE - ENDSIZE
				end
				local TRANS = TRANSPARENCY - ENDTRANSPARENCY
				if TYPE == "Block" then
					EFFECT.CFrame = CFRAME * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)))
				else
					EFFECT.CFrame = CFRAME
				end
				if USEBOOMERANGMATH == true then
					for LOOP = 1, TIME + 1 do
						Swait()
						MSH.Scale = MSH.Scale - VT(GROWTH.X * (1 - LOOP / TIME * BOOMR2), GROWTH.Y * (1 - LOOP / TIME * BOOMR2), GROWTH.Z * (1 - LOOP / TIME * BOOMR2)) * BOOMR2 / TIME
						if TYPE == "Wave" then
							MSH.Offset = VT(0, 0, -MSH.Scale.Z / 8)
						end
						EFFECT.Transparency = EFFECT.Transparency - TRANS / TIME
						if TYPE == "Block" then
							EFFECT.CFrame = CFRAME * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)))
						else
							EFFECT.CFrame = EFFECT.CFrame * ANGLES(RAD(ROTATION1), RAD(ROTATION2), RAD(ROTATION3))
						end
						if MOVEDIRECTION ~= nil then
							local ORI = EFFECT.Orientation
							EFFECT.CFrame = CF(EFFECT.Position, MOVEDIRECTION) * CF(0, 0, -MOVESPEED * (1 - LOOP / TIME * BOOMR1))
							EFFECT.Orientation = ORI
						end
					end
				else
					for LOOP = 1, TIME + 1 do
						Swait()
						MSH.Scale = MSH.Scale - GROWTH / TIME
						if TYPE == "Wave" then
							MSH.Offset = VT(0, 0, -MSH.Scale.Z / 8)
						end
						EFFECT.Transparency = EFFECT.Transparency - TRANS / TIME
						if TYPE == "Block" then
							EFFECT.CFrame = CFRAME * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)))
						else
							EFFECT.CFrame = EFFECT.CFrame * ANGLES(RAD(ROTATION1), RAD(ROTATION2), RAD(ROTATION3))
						end
						if MOVEDIRECTION ~= nil then
							local ORI = EFFECT.Orientation
							EFFECT.CFrame = CF(EFFECT.Position,MOVEDIRECTION)*CF(0,0,-MOVESPEED)
							EFFECT.Orientation = ORI
						end
					end
				end
				EFFECT.Transparency = 1
				if PLAYSSOUND == false then
					EFFECT:remove()
				else
					repeat
						Swait()
					until EFFECT:FindFirstChildOfClass("Sound") == nil
					EFFECT:remove()
				end
			elseif PLAYSSOUND == false then
				EFFECT:remove()
			else
				repeat
					Swait()
				until EFFECT:FindFirstChildOfClass("Sound") == nil
				EFFECT:remove()
			end
		end))
		return EFFECT
	end))
end

function Lightning(Part0, Part1, Times, Offset, Color, Timer, sSize, eSize, Trans, Boomer, sBoomer, slow, stime)
	local magz = (Part0 - Part1).magnitude
	local curpos = Part0
	local trz = {
		-Offset,
		Offset
	}
	for i = 1, Times do
		local li = Instance.new("Part", Effects)
		li.Name = "Lightning"
		li.TopSurface = 0
		li.Material = "Neon"
		li.BottomSurface = 0
		li.Anchored = true
		li.Locked = true
		li.Transparency = 0
		li.BrickColor = Color
		li.formFactor = "Custom"
		li.CanCollide = false
		li.Size = Vector3.new(0.1, 0.1, magz / Times)
		local Offzet = Vector3.new(trz[math.random(1, 2)], trz[math.random(1, 2)], trz[math.random(1, 2)])
		local trolpos = CFrame.new(curpos, Part1) * CFrame.new(0, 0, magz / Times).p + Offzet
		if Times == i then
			local magz2 = (curpos - Part1).magnitude
			li.Size = Vector3.new(0.1, 0.1, magz2)
			li.CFrame = CFrame.new(curpos, Part1) * CFrame.new(0, 0, -magz2 / 2)
		else
			li.CFrame = CFrame.new(curpos, trolpos) * CFrame.new(0, 0, magz / Times / 2)
		end
		curpos = li.CFrame * CFrame.new(0, 0, magz / Times / 2).p
		li:Destroy()
		WACKYEFFECT({Time = Timer, EffectType = "Box", Size = Vector3.new(sSize,sSize,li.Size.Z), Size2 = Vector3.new(eSize,eSize,li.Size.Z), Transparency = Trans, Transparency2 = 1, CFrame = li.CFrame, MoveToPos = nil, RotationX = nil, RotationY = nil, RotationZ = nil, Material = "Neon", Color = li.Color, SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = Boomer, Boomerang = 0, SizeBoomerang = sBoomer})
		if slow == true then
			swait(stime)
		end
	end
end
function GetRoot(MODEL, ROOT)
	if ROOT == true then
		return MODEL:FindFirstChild("HumanoidRootPart") or MODEL:FindFirstChild("Torso") or MODEL:FindFirstChild("UpperTorso")
	else
		return MODEL:FindFirstChild("Torso") or MODEL:FindFirstChild("UpperTorso")
	end
end
function MakeForm(PART, TYPE)
	if TYPE == "Cyl" then
		local MSH = IT("CylinderMesh", PART)
	elseif TYPE == "Ball" then
		local MSH = IT("SpecialMesh", PART)
		MSH.MeshType = "Sphere"
	elseif TYPE == "Wedge" then
		local MSH = IT("SpecialMesh", PART)
		MSH.MeshType = "Wedge"
	end
end
Debris = game:GetService("Debris")
function CastProperRay(StartPos, EndPos, Distance, Ignore)
	local DIRECTION = CF(StartPos, EndPos).lookVector
	local Ignore = type(Ignore) == "table" and Ignore or {Ignore}
	return game:GetService("Workspace"):FindPartOnRayWithIgnoreList(Ray.new(StartPos, DIRECTION * Distance), Ignore)
end
function SpawnTrail(FROM,TO,BIG)
	local TRAIL = CreatePart(3, Effects, "Neon", 0, 0, "Really black", "Trail", VT(45,45,45))           
	MakeForm(TRAIL,"Cyl")
	local DIST = (FROM - TO).Magnitude
	if BIG == true then
		TRAIL.Size = VT(2,DIST,5)
	else
		TRAIL.Size = VT(2,DIST,5)
	end
	TRAIL.CFrame = CF(FROM, TO) * CF(0, 0, -DIST/2) * ANGLES(RAD(90),RAD(0),RAD(0))
	coroutine.resume(coroutine.create(function()
		for i = 1, 55 do
			Swait()
			TRAIL.Transparency = TRAIL.Transparency + 0.03
		end
		TRAIL:remove()
	end))
end

function Debree(Table)
	local KindOf = Table.Variant or "Ring"
	local Position = Table.Location or Torso.Position
	local Coloration = Table.Color or C3(1, 1, 1)
	local Texture = Table.Material or "Slate"
	local Fling = Table.Scatter or 1
	local Number = Table.Amount or 1
	local Rocks = Table.DebreeCount or 1
	local Range = Table.Distance or 1
	local Scale = Table.Size or 1
	local Timer = Table.Delay or 1.5
	coroutine.resume(coroutine.create(function()
		local ScaleVector = VT(Scale, Scale, Scale)
		local Boulders = {}
		Position = CF(Position)
		if KindOf == "Ring" or KindOf == "Both" then
			for RockValue = 1, Number do
				local LOCATION = Position * ANGLES(RAD(0), RAD(360 / Number * RockValue), RAD(0)) * CF(0, MRANDOM(-math.ceil(Scale / 2), math.ceil(Scale / 2)), Range)
				local BOULDER = CreatePart(3, workspace, Texture, 0, 0, BRICKC("Pearl"), "Debree", ScaleVector, true)
				BOULDER.CanCollide = true
				BOULDER.CFrame = LOCATION * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)))
				BOULDER.Color = Coloration
				table.insert(Boulders, BOULDER)
			end
		end
		if KindOf == "Loose" or KindOf == "Both" then
			for RockValue = 1, Rocks do
				local LOCATION = Position * ANGLES(RAD(0), RAD(360 / Number * RockValue), RAD(0)) * CF(0, MRANDOM(-math.ceil(Scale - Scale / 2), math.ceil(Scale - Scale / 2)), 0.7)
				local BOULDER = CreatePart(3, workspace, Texture, 0, 0, BRICKC("Pearl"), "Debree", ScaleVector, false)
				BOULDER.CanCollide = true
				BOULDER.CFrame = LOCATION * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)))
				BOULDER.Velocity = CF(BOULDER.Position - VT(0, 4, 0), BOULDER.CFrame * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360))) * CF(0, 5, 0).p).lookVector * MRANDOM(Fling - Fling / 1.5, Fling + Fling / 1.5)
				BOULDER.Color = Coloration
				table.insert(Boulders, BOULDER)
			end
		end
		if KindOf == "Random" then
			for RockValue = 1, Number do
				local LOCATION = Position * ANGLES(RAD(0), RAD(360 / Number * RockValue), RAD(0)) * CF(0, MRANDOM(-math.ceil(Scale / 2), math.ceil(Scale / 2)), MRANDOM(0, Range))
				local BOULDER = CreatePart(3, workspace, Texture, 0, 0, BRICKC("Pearl"), "Debree", ScaleVector, true)
				BOULDER.CanCollide = true
				BOULDER.CFrame = LOCATION * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)))
				BOULDER.Color = Coloration
				table.insert(Boulders, BOULDER)
			end
		end
		wait(Timer)
		for E = 1, 45 do
			Swait()
			for A = 1, #Boulders do
				Boulders[A].Transparency = Boulders[A].Transparency + 0.022222222222222223
			end
		end
		for A = 1, #Boulders do
			Boulders[A]:Destroy()
		end
	end))
end

function CameraShake(AREA,RANGE,SHAKE,TIMER)
	if true then return end
end

function Raycast(POSITION, DIRECTION, RANGE, IGNOREDECENDANTS)
	return workspace:FindPartOnRay(Ray.new(POSITION, DIRECTION.unit * RANGE), IGNOREDECENDANTS)
end
function PositiveAngle(NUMBER)
	if NUMBER >= 0 then
		NUMBER = 0
	end
	return NUMBER
end
function NegativeAngle(NUMBER)
	if NUMBER <= 0 then
		NUMBER = 0
	end
	return NUMBER
end
function CreateMesh(MESH, PARENT, MESHTYPE, MESHID, TEXTUREID, SCALE, OFFSET)
	local NEWMESH = IT(MESH)
	if MESH == "SpecialMesh" then
		NEWMESH.MeshType = MESHTYPE
		if MESHID ~= "nil" and MESHID ~= "" then
			NEWMESH.MeshId = "http://www.roblox.com/asset/?id=" .. MESHID
		end
		if TEXTUREID ~= "nil" and TEXTUREID ~= "" then
			NEWMESH.TextureId = "http://www.roblox.com/asset/?id=" .. TEXTUREID
		end
	end
	NEWMESH.Offset = OFFSET or VT(0, 0, 0)
	NEWMESH.Scale = SCALE
	NEWMESH.Parent = PARENT
	return NEWMESH
end
function CreatePart(FORMFACTOR, PARENT, MATERIAL, REFLECTANCE, TRANSPARENCY, BRICKCOLOR, NAME, SIZE, ANCHOR)
	local NEWPART = IT("Part")
	NEWPART.formFactor = FORMFACTOR
	NEWPART.Reflectance = REFLECTANCE
	NEWPART.Transparency = TRANSPARENCY
	NEWPART.CanCollide = false
	NEWPART.Locked = true
	NEWPART.Anchored = true
	if ANCHOR == false then
		NEWPART.Anchored = false
	end
	NEWPART.BrickColor = BRICKC(tostring(BRICKCOLOR))
	NEWPART.Name = NAME
	NEWPART.Size = SIZE
	NEWPART.Position = Torso.Position
	NEWPART.Material = MATERIAL
	NEWPART:BreakJoints()
	NEWPART.Parent = PARENT
	return NEWPART
end
local weldBetween = function(a, b)
	local weldd = Instance.new("ManualWeld")
	weldd.Part0 = a
	weldd.Part1 = b
	weldd.C0 = CFrame.new()
	weldd.C1 = b.CFrame:inverse() * a.CFrame
	weldd.Parent = a
	return weldd
end
function weldSomethings(a, b, acf)
	local we = Instance.new("Weld", a)
	we.Part0 = a
	we.Part1 = b
	if acf ~= nil then
		we.C0 = acf
	end
end
CameraEnshaking = function(p399, p400)
	coroutine.resume(coroutine.create(function()
		local v20221 = 1 * p400

		for v20223 = 0, p399, 0.1 do
			Swait()
			v20221 = v20221 - 0.05 * p400 / p399
			v20219 = 1 - 0.0005 * p400 / p399
			Humanoid.CameraOffset = Vector3.new(math.rad(math.random(-v20221, v20221)), math.rad(math.random(-v20221, v20221)), math.rad(math.random(-v20221, v20221)))
			game:GetService("Workspace").CurrentCamera.CFrame = game:GetService("Workspace").CurrentCamera.CFrame * CFrame.new(math.rad(math.random(-v20221, v20221)), math.rad(math.random(-v20221, v20221)), math.rad(math.random(-v20221, v20221))) * CFrame.fromEulerAnglesXYZ(math.rad(math.random(-v20221, v20221)) * 1, math.rad(math.random(-v20221, v20221)) * 1, math.rad(math.random(-v20221, v20221)) * 1)
		end
		Humanoid.CameraOffset = Vector3.new(0, 0, 0)
	end))
end
function QuaternionFromCFrame(CF)
	local mx, my, mz, m00, m01, m02, m10, m11, m12, m20, m21, m22 = CF:components()
	local trace = m00 + m11 + m22
	if trace > 0 then
		local s = math.sqrt(1 + trace)
		local recip = 0.5 / s
		return (m21 - m12) * recip, (m02 - m20) * recip, (m10 - m01) * recip, s * 0.5
	else
		local i = 0
		if m00 < m11 then
			i = 1
		end
		if m22 > (i == 0 and m00 or m11) then
			i = 2
		end
		if i == 0 then
			local s = math.sqrt(m00 - m11 - m22 + 1)
			local recip = 0.5 / s
			return 0.5 * s, (m10 + m01) * recip, (m20 + m02) * recip, (m21 - m12) * recip
		elseif i == 1 then
			local s = math.sqrt(m11 - m22 - m00 + 1)
			local recip = 0.5 / s
			return (m01 + m10) * recip, 0.5 * s, (m21 + m12) * recip, (m02 - m20) * recip
		elseif i == 2 then
			local s = math.sqrt(m22 - m00 - m11 + 1)
			local recip = 0.5 / s
			return (m02 + m20) * recip, (m12 + m21) * recip, 0.5 * s, (m10 - m01) * recip
		end
	end
end
function QuaternionToCFrame(px, py, pz, x, y, z, w)
	local xs, ys, zs = x + x, y + y, z + z
	local wx, wy, wz = w * xs, w * ys, w * zs
	local xx = x * xs
	local xy = x * ys
	local xz = x * zs
	local yy = y * ys
	local yz = y * zs
	local zz = z * zs
	return CFrame.new(px, py, pz, 1 - (yy + zz), xy - wz, xz + wy, xy + wz, 1 - (xx + zz), yz - wx, xz - wy, yz + wx, 1 - (xx + yy))
end
function QuaternionSlerp(a, b, t)
	local cosTheta = a[1] * b[1] + a[2] * b[2] + a[3] * b[3] + a[4] * b[4]
	local startInterp, finishInterp
	if cosTheta >= 1.0E-4 then
		if 1 - cosTheta > 1.0E-4 then
			local theta = ACOS(cosTheta)
			local invSinTheta = 1 / SIN(theta)
			startInterp = SIN((1 - t) * theta) * invSinTheta
			finishInterp = SIN(t * theta) * invSinTheta
		else
			startInterp = 1 - t
			finishInterp = t
		end
	elseif 1 + cosTheta > 1.0E-4 then
		local theta = ACOS(-cosTheta)
		local invSinTheta = 1 / SIN(theta)
		startInterp = SIN((t - 1) * theta) * invSinTheta
		finishInterp = SIN(t * theta) * invSinTheta
	else
		startInterp = t - 1
		finishInterp = t
	end
	return a[1] * startInterp + b[1] * finishInterp, a[2] * startInterp + b[2] * finishInterp, a[3] * startInterp + b[3] * finishInterp, a[4] * startInterp + b[4] * finishInterp
end
function Clerp(a, b, t)
	local qa = {
		QuaternionFromCFrame(a)
	}
	local qb = {
		QuaternionFromCFrame(b)
	}
	local ax, ay, az = a.x, a.y, a.z
	local bx, by, bz = b.x, b.y, b.z
	local _t = 1 - t
	return QuaternionToCFrame(_t * ax + t * bx, _t * ay + t * by, _t * az + t * bz, QuaternionSlerp(qa, qb, t))
end
function CreateFrame(PARENT, TRANSPARENCY, BORDERSIZEPIXEL, POSITION, SIZE, COLOR, BORDERCOLOR, NAME)
	local frame = IT("Frame")
	frame.BackgroundTransparency = TRANSPARENCY
	frame.BorderSizePixel = BORDERSIZEPIXEL
	frame.Position = POSITION
	frame.Size = SIZE
	frame.BackgroundColor3 = COLOR
	frame.BorderColor3 = BORDERCOLOR
	frame.Name = NAME
	frame.Parent = PARENT
	return frame
end
function CreateLabel(PARENT, TEXT, TEXTCOLOR, TEXTFONTSIZE, TEXTFONT, TRANSPARENCY, BORDERSIZEPIXEL, STROKETRANSPARENCY, NAME)
	local label = IT("TextLabel")
	label.BackgroundTransparency = 1
	label.Size = UD2(1, 0, 1, 0)
	label.Position = UD2(0, 0, 0, 0)
	label.TextColor3 = TEXTCOLOR
	label.TextStrokeTransparency = STROKETRANSPARENCY
	label.TextTransparency = TRANSPARENCY
	label.FontSize = TEXTFONTSIZE
	label.Font = TEXTFONT
	label.BorderSizePixel = BORDERSIZEPIXEL
	label.TextScaled = false
	label.Text = TEXT
	label.Name = NAME
	label.Parent = PARENT
	return label
end
function NoOutlines(PART)
	PART.TopSurface, PART.BottomSurface, PART.LeftSurface, PART.RightSurface, PART.FrontSurface, PART.BackSurface = 10, 10, 10, 10, 10, 10
end
function CreateWeldOrSnapOrMotor(TYPE, PARENT, PART0, PART1, C0, C1)
	local NEWWELD = IT(TYPE)
	NEWWELD.Part0 = PART0
	NEWWELD.Part1 = PART1
	NEWWELD.C0 = C0
	NEWWELD.C1 = C1
	NEWWELD.Parent = PARENT
	return NEWWELD
end
function spawnwave(p492)
	local v26121 = VT(0, -1, 0)
	local v26125, v26126 = Raycast(p492 + VT(0, 1, 0), CF(p492, p492 + v26121).lookVector, 100, Character)
	local v26127 = v26126
	if v26125 == nil then
		local v26130 = v26125.Parent:FindFirstChildOfClass("Humanoid")
		if not v26130 then
			v26130 = Raycast
			v26121 = 0
			local v26146, v26147 = v26130(p492 + VT(v26121, 1, 0), CF(p492, p492 + VT(0, -1, 0)).lookVector, 100, v26125.Parent)
			v26125 = v26146
			v26126 = v26147
			v26127 = v26126
		else
			v26147 = v26125.Parent
			v26146 = v26147.Parent
			local v26149 = v26146:FindFirstChildOfClass("Humanoid")
			if not v26149 then
				v26149 = Raycast
				v26147 = p492 + VT(0, 1, 0)
				v26142 = VT
				local v26165, v26166 = v26149(v26147, CF(p492, p492 + v26142(0, -1, 0)).lookVector, 100, v26125.Parent.Parent)
				v26125 = v26165
				v26126 = v26166
				v26127 = v26126
			end
		end
	end
	v26166 = v26127
	ApplyAoE(v26166, 55)
	local v26169 = {}
	v26169.EffectType = "Sphere"
	v26163 = 55
	v26169.Size = VT(55, 100000, v26163)
	v26169.Size2 = VT(0, 100000, 0)
	v26169.Transparency = 0
	v26169.Transparency2 = 1
	v26160 = MATHR
	v26169.CFrame = CF(v26127) * ANGLES(RAD(v26160(-15, 15)), RAD(0), RAD(MATHR(-15, 15)))
	v26169.MoveToPos = nil
	v26169.RotationX = 0
	v26169.RotationY = 0
	v26169.RotationZ = 0
	v26169.Material = "Neon"
	v26169.Color = AUDIOBASEDCOLOR
	v26169.SoundID = nil
	v26169.SoundPitch = 1
	v26169.SoundVolume = 5
	WACKYEFFECT(v26169)
	local v26195 = {}
	v26195.TIME = MATHR(0, 44)
	v26195.EffectType = "Wave"
	v26195.Size = VT(0, 0, 0)
	local v26202 = 7
	local v26206 = COS(v350 / 4)
	local v26211 = COS(v350 / 4)
	local v26213 = v350
	local v26214 = COS(v26213 / 4)
	v26195.Size2 = VT(77 + v26202 * v26206, 2 + 6 * v26211, 77 + 4 * v26214)
	v26195.Transparency = 0
	v26195.Transparency2 = 1
	v26195.CFrame = CF(v26127)
	v26195.MoveToPos = nil
	v26195.RotationX = 0
	v26195.RotationY = MATHR(-22, 22)
	v26195.RotationZ = 0
	v26195.Material = "ForceField"
	v26195.Color = AUDIOBASEDCOLOR
	v26195.SoundID = nil
	v26195.SoundPitch = nil
	v26195.SoundVolume = nil
	WACKYEFFECT(v26195)
	for v26220 = 1, 5, 1 do
		v26202 = v26127
		v26206 = RAD
		v26211 = MATHR
		v26214 = 0
		v26213 = 360
		local v26241 = CF(v26202) * ANGLES(v26206(v26211(v26214, 360)), RAD(MATHR(0, v26213)), RAD(MATHR(0, 360))) * CF(0, 0, 12)
		local v26323 = {}
		v26323.TIME = MATHR(0, 44)
		v26323.EffectType = "Wave"
		v26323.Size = VT(0, 0, 0)
		v26323.Size2 = VT(77 + 7 * COS(v350 / 4), 2 + 6 * COS(v350 / 4), 77 + 4 * COS(v350 / 4))
		v26323.Transparency = 0
		v26323.Transparency2 = 1
		v26323.CFrame = CF(v26127, v26241.p)
		v26323.MoveToPos = v26241.p
		v26323.RotationX = 0
		v26323.RotationY = MATHR(-22, 22)
		v26323.RotationZ = 0
		v26323.Material = "ForceField"
		v26323.Color = AUDIOBASEDCOLOR
		v26323.SoundID = nil
		v26323.SoundPitch = nil
		v26323.SoundVolume = nil
		WACKYEFFECT(v26323)
	end
end
local S = IT("Sound")
function CreateSound(ID, PARENT, VOLUME, PITCH, DOESLOOP)
	local NEWSOUND
	coroutine.resume(coroutine.create(function()
		NEWSOUND = S:Clone()
		NEWSOUND.Parent = PARENT
		NEWSOUND.Volume = VOLUME
		NEWSOUND.Pitch = PITCH
		NEWSOUND.EmitterSize = VOLUME * 3
		NEWSOUND.SoundId = "http://www.roblox.com/asset/?id=" .. ID
		NEWSOUND:play()
		if DOESLOOP == true then
			NEWSOUND.Looped = true
		else
			repeat
				wait(1)
			until NEWSOUND.Playing == false
			NEWSOUND:remove()
		end
	end))
	return NEWSOUND
end
function NewSound(TABLE)
	local ID = "rbxassetid://"..(TABLE.ID or 0)
	local PARENT = (TABLE.PARENT or ROOT)
	local VOLUME = (TABLE.VOLUME or 0.5)
	local PITCH = (TABLE.PITCH or 1)
	local LOOP = (TABLE.LOOP or false)
	local MAXDISTANCE = (TABLE.MAXDISTANCE or 100)
	local EMITTERSIZE = (TABLE.EMITTERSIZE or 10)
	local PLAYING = (TABLE.PLAYING or true)
	local PLAYONREMOVE = (TABLE.PLAYONREMOVE or false)
	local DOESDEBRIS = (TABLE.DOESDEBRIS or true)
	if ID ~= "rbxassetid://0" then
		local SOUND = IT("Sound",PARENT)
		SOUND.SoundId = ID
		SOUND.Volume = VOLUME
		SOUND.Pitch = PITCH
		SOUND.Looped = LOOP
		SOUND.MaxDistance = MAXDISTANCE
		SOUND.EmitterSize = EMITTERSIZE
		SOUND.PlayOnRemove = PLAYONREMOVE
		if DOESDEBRIS == true and PLAYING == true and LOOP == false then
			Debris:AddItem(SOUND,SOUND.TimeLength+5)
		end
		if PLAYING == true then
			SOUND:Play()
		end
		return SOUND
	end
end 
function CFrameFromTopBack(at, top, back)
	local right = top:Cross(back)
	return CF(at.x, at.y, at.z, right.x, top.x, back.x, right.y, top.y, back.y, right.z, top.z, back.z)
end
function MagicRing()
	local O1 = CreatePart(3, Effects, "Neon", 0, 1, "Really black", "Warphole", VT(0, 0, 0))
	O1.CFrame = RootPart.CFrame * CF(0, 0, -3) * ANGLES(RAD(90), RAD(0), RAD(0))
	local decal = Decal:Clone()
	decal.Parent = O1
	decal.Face = "Top"
	decal.Texture = "http://www.roblox.com/asset/?id=0"
	local decal2 = Decal:Clone()
	decal2.Parent = O1
	decal2.Face = "Bottom"
	decal2.Texture = "http://www.roblox.com/asset/?id=0"
	return O1
end
function MagicRing2(PART,CFRAME)
	local RING = CreatePart(3, Effects, "Neon", 0, 1, "New Yeller", "MagicRing", VT(0,0,0),false)
	local WELD = CreateWeldOrSnapOrMotor("Weld", PART, PART, RING, CFRAME, CF(0, 0, 0))
	local MESH = IT("BlockMesh",RING)
	local BOTTOMTEXTURE = Decal:Clone()
	BOTTOMTEXTURE.Parent = RING
	BOTTOMTEXTURE.Face = "Bottom"
	BOTTOMTEXTURE.Name = "BottomTexture"
	local TOPTEXTURE = Decal:Clone()
	TOPTEXTURE.Parent = RING
	TOPTEXTURE.Face = "Top"
	TOPTEXTURE.Name = "TopTexture"
	local LIGHT = IT("PointLight",RING)
	BOTTOMTEXTURE.Texture = "http://www.roblox.com/asset/?id=2829906887"
	TOPTEXTURE.Texture = "http://www.roblox.com/asset/?id=2829906887"
	return RING,WELD,MESH
end
local DECAL = IT("Decal")
function MagicRing3()
	local RING = CreatePart(3, Effects, "Neon", 0, 1, BRICKC("Pearl"), "MagicRing", VT(0, 0, 0), true)
	local MSH = IT("BlockMesh", RING)
	local TOP = DECAL:Clone()
	local BOTTOM = DECAL:Clone()
	TOP.Parent = RING
	BOTTOM.Parent = RING
	TOP.Face = "Top"
	BOTTOM.Face = "Bottom"
	TOP.Texture = "http://www.roblox.com/asset/?id=0"
	BOTTOM.Texture = "http://www.roblox.com/asset/?id=0"
	local function REMOVE()
		coroutine.resume(coroutine.create(function()
			local SIZE = MSH.Scale.X
			for i = 1, 35 do
				Swait()
				MSH.Scale = MSH.Scale - VT(SIZE, 0, SIZE) / 60
				TOP.Transparency = TOP.Transparency + 0.02857142857142857
				BOTTOM.Transparency = BOTTOM.Transparency + 0.02857142857142857
				RING.CFrame = RING.CFrame * ANGLES(RAD(0), RAD(-5), RAD(0))
			end
			RING:remove()
		end))
	end
	return RING, MSH, REMOVE
end
function CreateWave(SIZE, WAIT, CFRAME, DOESROT, ROT, COLOR, GROW)
	local wave = CreatePart(3, Effects, "Neon", 0, 0.5, BRICKC(COLOR), "Effect", VT(0, 0, 0))
	local mesh = CreateMesh("SpecialMesh", wave, "FileMesh", "20329976", "", SIZE, VT(0, 0, -SIZE.X / 8))
	wave.CFrame = CFRAME
	coroutine.resume(coroutine.create(function(PART)
		for i = 1, WAIT do
			Swait()
			mesh.Scale = mesh.Scale + GROW
			mesh.Offset = VT(0, 0, -(mesh.Scale.X / 8))
			if DOESROT == true then
				wave.CFrame = wave.CFrame * CFrame.fromEulerAnglesXYZ(0, ROT, 0)
			end
			wave.Transparency = wave.Transparency + 0.5 / WAIT
			if wave.Transparency > 0.99 then
				wave:remove()
			end
		end
	end))
end
function SpecialSphere(SIZE,WAIT,CFRAME,COLOR,GROW)
	local wave = CreatePart(3, Effects, "Neon", 0, 0, BRICKC(COLOR), "Eye", VT(1,1,1), true)
	wave.Color = COLOR
	local mesh = CreateMesh("SpecialMesh", wave, "Sphere", "", "", SIZE, VT(0,0,0))
	wave.CFrame = CFRAME
	coroutine.resume(coroutine.create(function(PART)
		for i = 1, WAIT do
			Swait()
			mesh.Scale = mesh.Scale + GROW
			wave.Transparency = wave.Transparency + (1/WAIT)
			if wave.Transparency > 0.99 then
				wave:remove()
			end
		end
	end))
end
function MagicSphere(SIZE,WAIT,CFRAME,COLOR,GROW)
	local wave = CreatePart(3, Effects, "Neon", 0, 0, BRICKC(COLOR), "Effect", VT(1,1,1), true)
	local mesh = IT("SpecialMesh",wave)
	mesh.MeshType = "Sphere"
	mesh.Scale = SIZE
	mesh.Offset = VT(0,0,0)
	wave.CFrame = CFRAME
	coroutine.resume(coroutine.create(function(PART)
		for i = 1, WAIT do
			Swait()
			mesh.Scale = mesh.Scale + GROW
			wave.Transparency = wave.Transparency + (1/WAIT)
			if wave.Transparency > 0.99 then
				wave:remove()
			end
		end
	end))
end
function WACKYEFFECT(Table)
	local TYPE = Table.EffectType or "Sphere"
	local SIZE = Table.Size or VT(1, 1, 1)
	local ENDSIZE = Table.Size2 or VT(0, 0, 0)
	local TRANSPARENCY = Table.Transparency or 0
	local ENDTRANSPARENCY = Table.Transparency2 or 1
	local CFRAME = Table.CFrame or Torso.CFrame
	local MOVEDIRECTION = Table.MoveToPos or nil
	local ROTATION1 = Table.RotationX or 0
	local ROTATION2 = Table.RotationY or 0
	local ROTATION3 = Table.RotationZ or 0
	local MATERIAL = Table.Material --or "Neon"
	local COLOR = Table.Color or C3(1, 1, 1)
	local TIME = Table.Time or 45
	local SOUNDID = Table.SoundID or nil
	local SOUNDPITCH = Table.SoundPitch or nil
	local SOUNDVOLUME = Table.SoundVolume or nil
	local USEBOOMERANGMATH = Table.UseBoomerangMath or false
	local BOOMERANG = Table.Boomerang or 0
	local SIZEBOOMERANG = Table.SizeBoomerang or 0
	coroutine.resume(coroutine.create(function()
		local PLAYSSOUND = false
		local SOUND
		local EFFECT = CreatePart(3, Effects, MATERIAL, 0, TRANSPARENCY, BRICKC("Pearl"), "Effect", VT(1, 1, 1), true)
		EFFECT.Color = COLOR
		if SOUNDID ~= nil and SOUNDPITCH ~= nil and SOUNDVOLUME ~= nil then
			PLAYSSOUND = true
			SOUND = CreateSound(SOUNDID, EFFECT, SOUNDVOLUME, SOUNDPITCH, false)
		end
		local MSH
		if TYPE == "Sphere" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "Sphere", "", "", SIZE, VT(0, 0, 0))
		elseif TYPE == "Block" or TYPE == "Box" then
			MSH = IT("BlockMesh", EFFECT)
			MSH.Scale = SIZE
		elseif TYPE == "Wave" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "20329976", "", SIZE, VT(0, 0, -SIZE.X / 8))
		elseif TYPE == "Ring" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "559831844", "", VT(SIZE.X, SIZE.X, 0.1), VT(0, 0, 0))
		elseif TYPE == "Slash" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "662586858", "", VT(SIZE.X / 10, 0, SIZE.X / 10), VT(0, 0, 0))
		elseif TYPE == "Round Slash" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "662585058", "", VT(SIZE.X / 10, 0, SIZE.X / 10), VT(0, 0, 0))
		elseif TYPE == "Swirl" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "168892432", "", SIZE, VT(0, 0, 0))
		elseif TYPE == "Skull" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "4770583", "", SIZE, VT(0, 0, 0))
		elseif TYPE == "Star" then 
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "2760116123", "", SIZE, VT(0,0,0))   	
		elseif TYPE == "Crystal" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "450656451", "", SIZE, VT(0, 0, 0))
		end
		coroutine.resume(coroutine.create(function()
			if MSH ~= nil then
				local BOOMR1 = 1 + BOOMERANG / 50
				local BOOMR2 = 1 + SIZEBOOMERANG / 50
				local MOVESPEED = nil
				if MOVEDIRECTION ~= nil then
					MOVESPEED = (CFRAME.p - MOVEDIRECTION).Magnitude/TIME
				end
				local GROWTH
				if USEBOOMERANGMATH == true then
					GROWTH = (SIZE - ENDSIZE) * (BOOMR2 + 1)
				else
					GROWTH = SIZE - ENDSIZE
				end
				local TRANS = TRANSPARENCY - ENDTRANSPARENCY
				if TYPE == "Block" then
					EFFECT.CFrame = CFRAME * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)))
				else
					EFFECT.CFrame = CFRAME
				end
				if USEBOOMERANGMATH == true then
					for LOOP = 1, TIME + 1 do
						Swait()
						MSH.Scale = MSH.Scale - VT(GROWTH.X * (1 - LOOP / TIME * BOOMR2), GROWTH.Y * (1 - LOOP / TIME * BOOMR2), GROWTH.Z * (1 - LOOP / TIME * BOOMR2)) * BOOMR2 / TIME
						if TYPE == "Wave" then
							MSH.Offset = VT(0, 0, -MSH.Scale.Z / 8)
						end
						EFFECT.Transparency = EFFECT.Transparency - TRANS / TIME
						if TYPE == "Block" then
							EFFECT.CFrame = CFRAME * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)))
						else
							EFFECT.CFrame = EFFECT.CFrame * ANGLES(RAD(ROTATION1), RAD(ROTATION2), RAD(ROTATION3))
						end
						if MOVEDIRECTION ~= nil then
							local ORI = EFFECT.Orientation
							EFFECT.CFrame = CF(EFFECT.Position, MOVEDIRECTION) * CF(0, 0, -MOVESPEED * (1 - LOOP / TIME * BOOMR1))
							EFFECT.Orientation = ORI
						end
					end
				else
					for LOOP = 1, TIME + 1 do
						Swait()
						MSH.Scale = MSH.Scale - GROWTH / TIME
						if TYPE == "Wave" then
							MSH.Offset = VT(0, 0, -MSH.Scale.Z / 8)
						end
						EFFECT.Transparency = EFFECT.Transparency - TRANS / TIME
						if TYPE == "Block" then
							EFFECT.CFrame = CFRAME * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)))
						else
							EFFECT.CFrame = EFFECT.CFrame * ANGLES(RAD(ROTATION1), RAD(ROTATION2), RAD(ROTATION3))
						end
						if MOVEDIRECTION ~= nil then
							local ORI = EFFECT.Orientation
							EFFECT.CFrame = CF(EFFECT.Position,MOVEDIRECTION)*CF(0,0,-MOVESPEED)
							EFFECT.Orientation = ORI
						end
					end
				end
				EFFECT.Transparency = 1
				if PLAYSSOUND == false then
					EFFECT:remove()
				else
					repeat
						Swait()
					until EFFECT:FindFirstChildOfClass("Sound") == nil
					EFFECT:remove()
				end
			elseif PLAYSSOUND == false then
				EFFECT:remove()
			else
				repeat
					Swait()
				until EFFECT:FindFirstChildOfClass("Sound") == nil
				EFFECT:remove()
			end
		end))
		return EFFECT
	end))
end
Lightning = function(p292, p293, p294, p295, p296, p297, p298, p299, p300, p301, p302, p303)
	local v8305 = (p292 - p293).Magnitude
	local v8310 = math.floor(math.clamp(v8305 / 10, 1, 20))
	local v8311 = p292
	local v8312 = {}
	v8312[1] = -p295
	v8312[2] = p295
	local v8315 = 1
	for v8315 = v8315, v8310, 1 do
		local v8319 = Instance.new("Part", ExceptEffects)
		v8319.Name = randomstring_1()
		v8319.TopSurface = 0
		v8319.Material = "Neon"
		v8319.BottomSurface = 0
		v8319.Anchored = true
		v8319.Locked = true
		v8319.Transparency = 0
		v8319.Color = p296
		v8319.formFactor = "Custom"
		v8319.CanCollide = false
		v8319.Size = Vector3.new(0.1, 0.1, v8305 / v8310)
		local v8342 = CFrame.new(v8311, p293)
		local v8347 = CFrame.new(0, 0, v8305 / v8310)
		local v8348 = v8347.p
		local v8349 = v8342 * v8348
		if v8310 == v8315 then
			v8342 = v8311 - p293
			v8349 = v8342.Magnitude
			v8342 = Vector3.new
			v8348 = 0.1
			v8347 = 0.1
			v8319.Size = v8342(v8348, v8347, v8349)
			v8319.CFrame = CFrame.new(v8311, p293) * CFrame.new(0, 0, -v8349 / 2)
		else
			v8352 = CFrame.new
			v8356 = v8311
			v8362 = v8349 + Vector3.new(v8312[math.random(1, 2)], v8312[math.random(1, 2)], v8312[math.random(1, 2)])
			v8349 = v8352(v8356, v8362) * CFrame.new(0, 0, v8305 / v8310 / 2)
			v8319.CFrame = v8349
		end
		v8369 = CFrame.new
		v8367 = v8305 / v8310
		v8363 = v8369(0, 0, v8367 / 2).p
		v8311 = v8319.CFrame * v8363
		v8319:Destroy()
		v8363 = {}
		v8363.Time = p297
		v8363.EffectType = "Box"
		v8367 = v8319.Size
		v8363.Size = Vector3.new(p298, p298, v8367.Z)
		v8367 = v8319.Size
		v8363.Size2 = Vector3.new(p299, p299, v8367.Z)
		v8363.Transparency = p300
		v8363.Transparency2 = p303 or 1
		v8363.CFrame = v8319.CFrame
		v8363.MoveToPos = nil
		v8363.RotationX = nil
		v8363.RotationY = nil
		v8363.RotationZ = nil
		v8363.Material = "Neon"
		v8363.Color = v8319.Color
		v8363.SoundID = nil
		v8363.SoundPitch = nil
		v8363.SoundVolume = nil
		v8363.UseBoomerangMath = p301
		v8363.Boomerang = 0
		v8363.SizeBoomerang = p302
		EXCEPTWACKYEFFECT(v8363)
	end
end
function GetRoot(MODEL, ROOT)
	if ROOT == true then
		return MODEL:FindFirstChild("HumanoidRootPart") or MODEL:FindFirstChild("Torso") or MODEL:FindFirstChild("UpperTorso")
	else
		return MODEL:FindFirstChild("Torso") or MODEL:FindFirstChild("UpperTorso")
	end
end
function MakeForm(PART, TYPE)
	if TYPE == "Cyl" then
		local MSH = IT("CylinderMesh", PART)
	elseif TYPE == "Ball" then
		local MSH = IT("SpecialMesh", PART)
		MSH.MeshType = "Sphere"
	elseif TYPE == "Wedge" then
		local MSH = IT("SpecialMesh", PART)
		MSH.MeshType = "Wedge"
	end
end
Debris = game:GetService("Debris")
function CastProperRay(StartPos, EndPos, Distance, Ignore)
	local DIRECTION = CF(StartPos, EndPos).lookVector
	local Ignore = type(Ignore) == "table" and Ignore or {Ignore}
	return game:GetService("Workspace"):FindPartOnRayWithIgnoreList(Ray.new(StartPos, DIRECTION * Distance), Ignore)
end
function SpawnTrail(FROM,TO,BIG)
	local TRAIL = CreatePart(3, Effects, "Neon", 0, 0, "Really black", "Trail", VT(45,45,45))           
	MakeForm(TRAIL,"Cyl")
	local DIST = (FROM - TO).Magnitude
	if BIG == true then
		TRAIL.Size = VT(2,DIST,5)
	else
		TRAIL.Size = VT(2,DIST,5)
	end
	TRAIL.CFrame = CF(FROM, TO) * CF(0, 0, -DIST/2) * ANGLES(RAD(90),RAD(0),RAD(0))
	coroutine.resume(coroutine.create(function()
		for i = 1, 55 do
			Swait()
			TRAIL.Transparency = TRAIL.Transparency + 0.03
		end
		TRAIL:remove()
	end))
end

function Debree(Table)
	local KindOf = Table.Variant or "Ring"
	local Position = Table.Location or Torso.Position
	local Coloration = Table.Color or C3(1, 1, 1)
	local Texture = Table.Material or "Slate"
	local Fling = Table.Scatter or 1
	local Number = Table.Amount or 1
	local Rocks = Table.DebreeCount or 1
	local Range = Table.Distance or 1
	local Scale = Table.Size or 1
	local Timer = Table.Delay or 1.5
	coroutine.resume(coroutine.create(function()
		local ScaleVector = VT(Scale, Scale, Scale)
		local Boulders = {}
		Position = CF(Position)
		if KindOf == "Ring" or KindOf == "Both" then
			for RockValue = 1, Number do
				local LOCATION = Position * ANGLES(RAD(0), RAD(360 / Number * RockValue), RAD(0)) * CF(0, MRANDOM(-math.ceil(Scale / 2), math.ceil(Scale / 2)), Range)
				local BOULDER = CreatePart(3, workspace, Texture, 0, 0, BRICKC("Pearl"), "Debree", ScaleVector, true)
				BOULDER.CanCollide = true
				BOULDER.CFrame = LOCATION * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)))
				BOULDER.Color = Coloration
				table.insert(Boulders, BOULDER)
			end
		end
		if KindOf == "Loose" or KindOf == "Both" then
			for RockValue = 1, Rocks do
				local LOCATION = Position * ANGLES(RAD(0), RAD(360 / Number * RockValue), RAD(0)) * CF(0, MRANDOM(-math.ceil(Scale - Scale / 2), math.ceil(Scale - Scale / 2)), 0.7)
				local BOULDER = CreatePart(3, workspace, Texture, 0, 0, BRICKC("Pearl"), "Debree", ScaleVector, false)
				BOULDER.CanCollide = true
				BOULDER.CFrame = LOCATION * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)))
				BOULDER.Velocity = CF(BOULDER.Position - VT(0, 4, 0), BOULDER.CFrame * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360))) * CF(0, 5, 0).p).lookVector * MRANDOM(Fling - Fling / 1.5, Fling + Fling / 1.5)
				BOULDER.Color = Coloration
				table.insert(Boulders, BOULDER)
			end
		end
		if KindOf == "Random" then
			for RockValue = 1, Number do
				local LOCATION = Position * ANGLES(RAD(0), RAD(360 / Number * RockValue), RAD(0)) * CF(0, MRANDOM(-math.ceil(Scale / 2), math.ceil(Scale / 2)), MRANDOM(0, Range))
				local BOULDER = CreatePart(3, workspace, Texture, 0, 0, BRICKC("Pearl"), "Debree", ScaleVector, true)
				BOULDER.CanCollide = true
				BOULDER.CFrame = LOCATION * ANGLES(RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)), RAD(MRANDOM(0, 360)))
				BOULDER.Color = Coloration
				table.insert(Boulders, BOULDER)
			end
		end
		wait(Timer)
		for E = 1, 45 do
			Swait()
			for A = 1, #Boulders do
				Boulders[A].Transparency = Boulders[A].Transparency + 0.022222222222222223
			end
		end
		for A = 1, #Boulders do
			Boulders[A]:Destroy()
		end
	end))
end

function CameraShake(AREA,RANGE,SHAKE,TIMER)
	if true then return end
end

function AdvancedChatfunc(Text, Timer, Delay, ChatterSound)
	local chat = coroutine.wrap(function()
		if Character:FindFirstChild("SpeechBoard") ~= nil then
			Character:FindFirstChild("SpeechBoard"):destroy()
		end
		local naeeym2 = IT("BillboardGui", Character)
		naeeym2.Size = UD2(80, 35, 3, 15)
		naeeym2.StudsOffset = VT(0, 5, 0)
		naeeym2.Adornee = Head
		naeeym2.Name = "SpeechBoard"
		naeeym2.AlwaysOnTop = true
		local tecks2 = IT("TextLabel", naeeym2)
		tecks2.BackgroundTransparency = 1
		tecks2.BorderSizePixel = 0
		tecks2.Text = ""
		tecks2.Font = FONTS_ENUM[MRANDOM(1,#FONTS_ENUM)]
		tecks2.TextSize = 35
		tecks2.TextStrokeTransparency = 0.3
		tecks2.TextColor3 = C3(0,0,0)
		tecks2.TextStrokeColor3 = C3(0,0,0)
		tecks2.Size = UDim2.new(1, 0, 0.5, 0)
		local FINISHED = false
		local DONE = false
		coroutine.wrap(function()
			while wait() do
				tecks2.Font = FONTS_ENUM[MRANDOM(1,#FONTS_ENUM)]
				tecks2.TextColor3 = C3(0,0,0)
				tecks2.TextStrokeColor3 = C3(0,0,0)
				if DONE == true then
					break
				end
			end
		end)()
		coroutine.resume(coroutine.create(function()
			for i = 1, string.len(Text) do
				if naeeym2.Parent ~= Character then
					FINISHED = true
				end
				if ChatterSound ~= false and naeeym2.Parent == Character then
					CreateSound(1296056458, Head, 7, MRANDOM(-6,12)/4, false) -- 265970978
				end
				tecks2.Text = string.sub(Text, 1, i)
				Swait(Timer)
			end
			FINISHED = true
		end))
		repeat
			wait()
		until FINISHED == true
		wait(Delay)
		naeeym2.Name = "FadingDialogue"
		if Character:FindFirstChild("SpeechBoard") == nil then
			coroutine.resume(coroutine.create(function()
				for i = 1, 35 do
					Swait()
				end
			end))
		end
		for i = 1, 45 do
			Swait()
			naeeym2.StudsOffset = naeeym2.StudsOffset + VT(0, (2 - 0.044444444444444446 * i) / 45, 0)
			tecks2.TextTransparency = tecks2.TextTransparency + 0.022222222222222223
			tecks2.TextStrokeTransparency = tecks2.TextTransparency
		end
		naeeym2:Destroy()
		DONE = true
	end)
	chat()
end

function CheckTableForString(Table, String)
	for i, v in pairs(Table) do
		if string.find(string.lower(String), string.lower(v)) then
			return true
		end
	end
	return false
end

function CreateFlyingDebree(FLOOR,POSITION,AMOUNT,BLOCKSIZE,SWAIT,STRENGTH)
	if FLOOR ~= nil then
		for i = 1, AMOUNT do
			local DEBREE = CreatePart(3, Effects, "Neon", 0, 0, "Peal", "Debree", BLOCKSIZE, false)
			DEBREE.Material = FLOOR.Material
			DEBREE.Color = FLOOR.Color
			DEBREE.CFrame = POSITION * ANGLES(RAD(MRANDOM(-360,360)),RAD(MRANDOM(-360,360)),RAD(MRANDOM(-360,360)))
			DEBREE.Velocity = VT(MRANDOM(-STRENGTH,STRENGTH),STRENGTH,MRANDOM(-STRENGTH,STRENGTH))
			coroutine.resume(coroutine.create(function()
				Swait(15)
				DEBREE.Parent = workspace
				DEBREE.CanCollide = true
				Debris:AddItem(DEBREE,SWAIT)
			end))
		end
	end
end

function AdvancedChatfunc(Text, Timer, Delay, ChatterSound)
	local chat = coroutine.wrap(function()
		if Character:FindFirstChild("SpeechBoard") ~= nil then
			Character:FindFirstChild("SpeechBoard"):destroy()
		end
		local naeeym2 = IT("BillboardGui", Character)
		naeeym2.Size = UD2(80, 35, 3, 15)
		naeeym2.StudsOffset = VT(0, 5, 0)
		naeeym2.Adornee = Head
		naeeym2.Name = "SpeechBoard"
		naeeym2.AlwaysOnTop = true
		local tecks2 = IT("TextLabel", naeeym2)
		tecks2.BackgroundTransparency = 1
		tecks2.BorderSizePixel = 0
		tecks2.Text = ""
		tecks2.Font = FONTS_ENUM[MRANDOM(1,#FONTS_ENUM)]
		tecks2.TextSize = 35
		tecks2.TextStrokeTransparency = 0.3
		tecks2.TextColor3 = C3(0,0,0)
		tecks2.TextStrokeColor3 = C3(0,0,0)
		tecks2.Size = UDim2.new(1, 0, 0.5, 0)
		local FINISHED = false
		local DONE = false
		coroutine.wrap(function()
			while wait() do
				tecks2.Font = FONTS_ENUM[MRANDOM(1,#FONTS_ENUM)]
				tecks2.TextColor3 = C3(0,0,0)
				tecks2.TextStrokeColor3 = C3(0,0,0)
				if DONE == true then
					break
				end
			end
		end)()
		coroutine.resume(coroutine.create(function()
			for i = 1, string.len(Text) do
				if naeeym2.Parent ~= Character then
					FINISHED = true
				end
				if ChatterSound ~= false and naeeym2.Parent == Character then
					CreateSound(265970978, Head, 7, MRANDOM(-6,12)/4, false)
				end
				tecks2.Text = string.sub(Text, 1, i)
				Swait(Timer)
			end
			FINISHED = true
		end))
		repeat
			wait()
		until FINISHED == true
		wait(Delay)
		naeeym2.Name = "FadingDialogue"
		if Character:FindFirstChild("SpeechBoard") == nil then
			coroutine.resume(coroutine.create(function()
				for i = 1, 35 do
					Swait()
				end
			end))
		end
		for i = 1, 45 do
			Swait()
			naeeym2.StudsOffset = naeeym2.StudsOffset + VT(0, (2 - 0.044444444444444446 * i) / 45, 0)
			tecks2.TextTransparency = tecks2.TextTransparency + 0.022222222222222223
			tecks2.TextStrokeTransparency = tecks2.TextTransparency
		end
		naeeym2:Destroy()
		DONE = true
	end)
	chat()
end

function CheckIntangible(Hit)
	local ProjectileNames = {"Water", "Arrow", "Projectile", "Effect", "Rail", "Lightning", "Bullet"}
	if Hit and Hit.Parent then
		if ((not Hit.CanCollide or CheckTableForString(ProjectileNames, Hit.Name)) and not Hit.Parent:FindFirstChild("Humanoid")) then
			return true
		end
	end
	return false
end

function CastZapRay(StartPos, Vec, Length, Ignore, DelayIfHit)
	local Direction = CFrame.new(StartPos, Vec).lookVector
	local Ignore = ((type(Ignore) == "table" and Ignore) or {Ignore})
	local RayHit, RayPos, RayNormal = game:GetService("Workspace"):FindPartOnRayWithIgnoreList(Ray.new(StartPos, Direction * Length), Ignore)
	if RayHit and CheckIntangible(RayHit) then
		if DelayIfHit then
			wait()
		end
		RayHit, RayPos, RayNormal = CastZapRay((RayPos + (Vec * 0.01)), Vec, (Length - ((StartPos - RayPos).magnitude)), Ignore, DelayIfHit)
	end
	return RayHit, RayPos, RayNormal
end

function MagicSphere2(size,waitt,cframe,color)
	local wave = CreatePart(3, Effects, "Neon", 0, 1, BRICKC(color), "Effect", VT(1,1,1))
	local mesh = IT("SpecialMesh",wave)
	mesh.MeshType = "Sphere"
	mesh.Scale = VT(size,size,size)
	mesh.Offset = VT(0,0,0)
	wave.CFrame = cframe
	coroutine.resume(coroutine.create(function(PART)
		for i = 1, waitt do
			Swait()
			mesh.Scale = mesh.Scale - VT(size/waitt,size/waitt,size/waitt)
			wave.Transparency = wave.Transparency - (1/waitt)
		end
		wave:remove()
	end))
end

function VELOC(Part,Resistance,Position)
	local GRAV = IT("BodyPosition",Part)
	GRAV.D = Resistance
	GRAV.P = 20000
	GRAV.MaxForce = VT(math.huge,math.huge,math.huge)
	GRAV.Position = Position
	return GRAV
end

function MakeForm(PART,TYPE)
	if TYPE == "Cyl" then
		local MSH = IT("CylinderMesh",PART)
	elseif TYPE == "Ball" then
		local MSH = IT("SpecialMesh",PART)
		MSH.MeshType = "Sphere"
	elseif TYPE == "Wedge" then
		local MSH = IT("SpecialMesh",PART)
		MSH.MeshType = "Wedge"
	end
end

function MakeWings(DoesBurn)
	local RWING = CreatePart(3, Effects, "Neon", 0, 0.5, "Deep orange", "Right Wing", (VT(2, 3, 2)*1.5),false)
	local LWING = CreatePart(3, Effects, "Neon", 0, 0.5, "Deep orange", "Left Wing", (VT(2, 3, 2)*1.5),false)
	CreateMesh("SpecialMesh", RWING, "FileMesh", "90615661", "", VT(1.5,1.5,1.5), VT(0,0,0))
	CreateMesh("SpecialMesh", LWING, "FileMesh", "90615581", "", VT(1.5,1.5,1.5), VT(0,0,0))
	local RWELD = CreateWeldOrSnapOrMotor("Weld", Torso, Torso, RWING, CF(2 , 2, 0.75), CF(-3.5, 0, 0))
	local LWELD = CreateWeldOrSnapOrMotor("Weld", Torso, Torso, LWING, CF(-2 , 2, 0.75), CF(3.5, 0, 0))
	RWING.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
	LWING.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
	RWING.Color = FIRECOLOR
	LWING.Color = FIRECOLOR
	if DoesBurn == true then
		local RightWingFire = BurningLimb(RWING)
		local LeftWingFire = BurningLimb(LWING)
		return RWING,LWING,RWELD,LWELD,RightWingFire,LeftWingFire
	else
		return RWING,LWING,RWELD,LWELD
	end
end

function BurningLimb(Limb)
	local PRTCL = ParticleEmitter({Speed = 2, Drag = 4, Size1 = 1, Size2 = 0, Lifetime1 = 0.6, Lifetime2 = 1.5, Parent = Limb, Emit = 100, Offset = 360, Enabled = true})
	PRTCL.Acceleration = VT(0,5,0)
	PRTCL.ZOffset = 1
	return PRTCL
end

local Particle = IT("ParticleEmitter",nil)
Particle.Enabled = false
Particle.LightEmission = 0.5
Particle.Rate = 150
Particle.ZOffset = 1
Particle.Rotation = NumberRange.new(-180, 180)
Particle.RotSpeed = NumberRange.new(-180, 180)
Particle.Texture = "http://www.roblox.com/asset/?id=284205403"
Particle.Color = ColorSequence.new(Color3.new(0,0,0),Color3.new(0,0,0))

function ParticleEmitter(Table)
	local PRTCL = Particle:Clone()
	local Speed = Table.Speed or 5
	local Drag = Table.Drag or 0
	local Size1 = Table.Size1 or 1
	local Size2 = Table.Size2 or 5
	local Lifetime1 = Table.Lifetime1 or 1
	local Lifetime2 = Table.Lifetime2 or 1.5
	local Parent = Table.Parent or Torso
	local Emit = Table.Emit or 100
	local Offset = Table.Offset or 360
	local Acel = Table.Acel or Vector3.new(0,-50,0)
	local Enabled = Table.Enabled or false
	PRTCL.Parent = Parent
	PRTCL.Size = NumberSequence.new(Size1,Size2)
	PRTCL.Lifetime = NumberRange.new(Lifetime1,Lifetime2)
	PRTCL.Speed = NumberRange.new(Speed)
	PRTCL.VelocitySpread = Offset
	PRTCL.Drag = Drag
	PRTCL.Acceleration = Acel
	if Enabled == false then
		PRTCL:Emit(Emit)
		game:GetService("Debris"):AddItem(PRTCL,Lifetime2)
	else
		PRTCL.Enabled = true
	end
	return PRTCL
end

function ShakeCam(Length,Intensity)
	coroutine.resume(coroutine.create(function()
		local intensity = 1 * Intensity
		local rotM = 0.01 * Intensity
		for i = 0, Length, 0.1 do
			Swait()
			intensity = intensity - 0.05 * Intensity / Length
			rotM = rotM - 5.0E-4 * Intensity / Length
			Humanoid.CameraOffset = Vector3.new(RAD(MRANDOM(-intensity, intensity)), RAD(MRANDOM(-intensity, intensity)), RAD(MRANDOM(-intensity, intensity)))
			Cam.CFrame = Cam.CFrame * CF(RAD(MRANDOM(-intensity, intensity)), RAD(MRANDOM(-intensity, intensity)), RAD(MRANDOM(-intensity, intensity))) * EULER(RAD(MRANDOM(-intensity, intensity)) * rotM, RAD(MRANDOM(-intensity, intensity)) * rotM, RAD(MRANDOM(-intensity, intensity)) * rotM)
		end
		Humanoid.CameraOffset = Vector3.new(0, 0, 0)
	end))
end

TeleportPlate = Instance.new("Part")
TeleportPlate.Name = "PleaseStopFall"
TeleportPlate.Parent = workspace
TeleportPlate.Anchored = true
TeleportPlate.Size = Vector3.new(2048, 1, 2048)
TeleportPlate.Color = Color3.new(255, 255, 255)
TeleportPlate.Material = Enum.Material.ForceField

TeleportPlate.Touched:Connect(function(Part) 
	if Part == playerss["Left Leg"] then
		g1 = Instance.new("BodyGyro", playerss.HumanoidRootPart)
		g1.D = 175
		g1.P = 20000
		g1.MaxTorque = Vector3.new(0,9000,0)
		g1.CFrame = CFrame.new(playerss:FindFirstChild("HumanoidRootPart"),Position, (ORIGIN_POS * CFrame.new(0, 50, 0)).p)

		game:GetService("Debris"):AddItem(g1, .05)
		playerss:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new((ORIGIN_POS * CFrame.new(0, 50, 0)).p)
	elseif Part == playerss["Right Leg"] then
		g1 = Instance.new("BodyGyro", playerss.HumanoidRootPart)
		g1.D = 175
		g1.P = 20000
		g1.MaxTorque = Vector3.new(0,9000,0)
		g1.CFrame = CFrame.new(playerss:FindFirstChild("HumanoidRootPart"),Position, (ORIGIN_POS * CFrame.new(0, 50, 0)).p)

		game:GetService("Debris"):AddItem(g1, .05)
		playerss:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new((ORIGIN_POS * CFrame.new(0, 50, 0)).p)
	elseif Part == playerss["Left Arm"] then
		g1 = Instance.new("BodyGyro", playerss.HumanoidRootPart)
		g1.D = 175
		g1.P = 20000
		g1.MaxTorque = Vector3.new(0,9000,0)
		g1.CFrame = CFrame.new(playerss:FindFirstChild("HumanoidRootPart"),Position, (ORIGIN_POS * CFrame.new(0, 50, 0)).p)

		game:GetService("Debris"):AddItem(g1, .05)
		playerss:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new((ORIGIN_POS * CFrame.new(0, 50, 0)).p)
	elseif Part == playerss["Right Arm"] then
		g1 = Instance.new("BodyGyro", playerss.HumanoidRootPart)
		g1.D = 175
		g1.P = 20000
		g1.MaxTorque = Vector3.new(0,9000,0)
		g1.CFrame = CFrame.new(playerss:FindFirstChild("HumanoidRootPart"),Position, (ORIGIN_POS * CFrame.new(0, 50, 0)).p)

		game:GetService("Debris"):AddItem(g1, .05)
		playerss:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new((ORIGIN_POS * CFrame.new(0, 50, 0)).p)
	elseif Part == playerss["Torso"] then
		g1 = Instance.new("BodyGyro", playerss.HumanoidRootPart)
		g1.D = 175
		g1.P = 20000
		g1.MaxTorque = Vector3.new(0,9000,0)
		g1.CFrame = CFrame.new(playerss:FindFirstChild("HumanoidRootPart"),Position, (ORIGIN_POS * CFrame.new(0, 50, 0)).p)

		game:GetService("Debris"):AddItem(g1, .05)
		playerss:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new((ORIGIN_POS * CFrame.new(0, 50, 0)).p)
	elseif Part == playerss["Head"] then
		g1 = Instance.new("BodyGyro", playerss.HumanoidRootPart)
		g1.D = 175
		g1.P = 20000
		g1.MaxTorque = Vector3.new(0,9000,0)
		g1.CFrame = CFrame.new(playerss:FindFirstChild("HumanoidRootPart"),Position, (ORIGIN_POS * CFrame.new(0, 50, 0)).p)

		game:GetService("Debris"):AddItem(g1, .05)
		playerss:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new((ORIGIN_POS * CFrame.new(0, 50, 0)).p)
	elseif Part == playerss["HumanoidRootPart"] then
		g1 = Instance.new("BodyGyro", playerss.HumanoidRootPart)
		g1.D = 175
		g1.P = 20000
		g1.MaxTorque = Vector3.new(0,9000,0)
		g1.CFrame = CFrame.new(playerss:FindFirstChild("HumanoidRootPart"),Position, (ORIGIN_POS * CFrame.new(0, 50, 0)).p)

		game:GetService("Debris"):AddItem(g1, .05)
		playerss:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new((ORIGIN_POS * CFrame.new(0, 50, 0)).p)
	end
end)

coroutine.resume(coroutine.create(function() 
	while true do
		pcall(function()
			Swait()

			TeleportPlate.Color = AUDIOBASEDCOLOR
			TeleportPlate.CFrame = CFrame.new(RootPart.CFrame.Position.X, -495, RootPart.CFrame.Position.Z)
		end)
	end
end))

--//=================================\\
--||	     WEAPON CREATION
--\\=================================//

function GenerateStuffs()
	m = Instance.new("Model",Character)

	cors = {}
	mas = Instance.new("Folder",Character)
	Gun = Instance.new("Part")
	GunAdditions = Instance.new("Model")
	Part2 = Instance.new("Part")
	Part3 = Instance.new("Part")
	Part4 = Instance.new("Part")
	Part5 = Instance.new("Part")
	Part6 = Instance.new("Part")
	Part7 = Instance.new("Part")
	Part8 = Instance.new("Part")
	Part9 = Instance.new("Part")
	Part10 = Instance.new("Part")
	Part11 = Instance.new("Part")
	Part12 = Instance.new("Part")
	Part13 = Instance.new("Part")
	Part14 = Instance.new("Part")
	Part15 = Instance.new("Part")
	Part16 = Instance.new("Part")
	Part17 = Instance.new("Part")
	Part18 = Instance.new("Part")
	Part19 = Instance.new("Part")
	Part20 = Instance.new("Part")
	Part21 = Instance.new("Part")
	Part22 = Instance.new("Part")
	Part23 = Instance.new("Part")
	Part24 = Instance.new("Part")
	Part25 = Instance.new("Part")
	Part26 = Instance.new("Part")
	Part27 = Instance.new("Part")
	Part28 = Instance.new("Part")
	Part29 = Instance.new("Part")
	Part30 = Instance.new("Part")
	Part31 = Instance.new("Part")
	Part32 = Instance.new("Part")
	NeonParts = Instance.new("Model")
	Part34 = Instance.new("Part")
	Part35 = Instance.new("Part")
	Part36 = Instance.new("Part")
	Part37 = Instance.new("Part")
	Part38 = Instance.new("Part")
	Part39 = Instance.new("Part")
	Part40 = Instance.new("Part")
	Part41 = Instance.new("Part")
	Part42 = Instance.new("Part")
	Part43 = Instance.new("Part")
	Part44 = Instance.new("Part")
	Part45 = Instance.new("Part")
	Part46 = Instance.new("Part")
	Part47 = Instance.new("Part")
	Part48 = Instance.new("Part")
	Part49 = Instance.new("Part")
	Part50 = Instance.new("Part")
	Part51 = Instance.new("Part")
	Part52 = Instance.new("Part")
	Part53 = Instance.new("Part")
	Part54 = Instance.new("Part")
	Part55 = Instance.new("Part")
	Part56 = Instance.new("Part")
	Part57 = Instance.new("Part")
	Part58 = Instance.new("Part")
	WedgePart59 = Instance.new("WedgePart")
	WedgePart60 = Instance.new("WedgePart")
	WedgePart61 = Instance.new("WedgePart")
	WedgePart62 = Instance.new("WedgePart")
	WedgePart63 = Instance.new("WedgePart")
	WedgePart64 = Instance.new("WedgePart")
	WedgePart65 = Instance.new("WedgePart")
	WedgePart66 = Instance.new("WedgePart")
	WedgePart67 = Instance.new("WedgePart")
	WedgePart68 = Instance.new("WedgePart")
	WedgePart69 = Instance.new("WedgePart")
	WedgePart70 = Instance.new("WedgePart")
	WedgePart71 = Instance.new("WedgePart")
	WedgePart72 = Instance.new("WedgePart")
	WedgePart73 = Instance.new("WedgePart")
	WedgePart74 = Instance.new("WedgePart")
	WedgePart75 = Instance.new("WedgePart")
	WedgePart76 = Instance.new("WedgePart")
	WedgePart77 = Instance.new("WedgePart")
	WedgePart78 = Instance.new("WedgePart")
	WedgePart79 = Instance.new("WedgePart")
	WedgePart80 = Instance.new("WedgePart")
	WedgePart81 = Instance.new("WedgePart")
	WedgePart82 = Instance.new("WedgePart")
	WedgePart83 = Instance.new("WedgePart")
	WedgePart84 = Instance.new("WedgePart")
	WedgePart85 = Instance.new("WedgePart")
	WedgePart86 = Instance.new("WedgePart")
	WedgePart87 = Instance.new("WedgePart")
	WedgePart88 = Instance.new("WedgePart")
	WedgePart89 = Instance.new("WedgePart")
	WedgePart90 = Instance.new("WedgePart")
	WedgePart91 = Instance.new("WedgePart")
	WedgePart92 = Instance.new("WedgePart")
	Gun.Parent = mas
	Gun.CFrame = CFrame.new(19.5114193, 17.4151173, 29.1267776, 0.0766888559, -0.0419792645, 0.996165454, -0.772843122, -0.633737981, 0.0327864662, 0.629938841, -0.772393823, -0.0810419023)
	Gun.Orientation = Vector3.new(-1.8799999952316, 94.650001525879, -129.35000610352)
	Gun.Position = Vector3.new(19.501419296265, 17.385117263794, 29.076777648926)
	Gun.Rotation = Vector3.new(-157.9700012207, 84.980003356934, 28.700000762939)
	Gun.Color = Color3.new(0, 0, 0)
	Gun.Size = Vector3.new(9.3359508514404 / 10, 8.5937814712524 / 10, 1.4496214389801)
	Gun.Anchored = true
	Gun.BrickColor = BrickColor.new("Black")
	Gun.CanCollide = false
	Gun.Locked = false
	Gun.Material = Enum.Material.Neon
	GunMesh = IT("SpecialMesh",Gun)
	GunMesh.MeshId = "rbxassetid://4615369575"
	GunMesh.Scale = VT(2.01,2.01,2.01)
	GunAdditions.Parent = Gun
	GunAdditions.Name = "GunAdditions"
	Part2.Parent = GunAdditions
	Part2.CFrame = CFrame.new(19.2145634, 16.6421738, 27.6565914, -0.0637066588, -0.0594783835, -0.996194661, 0.908383965, -0.416817188, -0.0332048088, -0.413256198, -0.907042325, 0.0805832073)
	Part2.Orientation = Vector3.new(1.8999999761581, -85.379997253418, 114.65000152588)
	Part2.Position = Vector3.new(19.214563369751, 16.64217376709, 27.656591415405)
	Part2.Rotation = Vector3.new(22.389999389648, -85, 136.9700012207)
	Part2.Color = Color3.new(0.498039, 0.498039, 0.498039)
	Part2.Size = Vector3.new(0.15661776065826, 0.090356394648552, 0.27307713031769)
	Part2.Anchored = true
	Part2.BottomSurface = Enum.SurfaceType.Smooth
	Part2.BrickColor = BrickColor.new("Sand green")
	Part2.CanCollide = false
	Part2.Locked = false
	Part2.Material = Enum.Material.Metal
	Part2.TopSurface = Enum.SurfaceType.Smooth
	Part2.brickColor = BrickColor.new("Sand green")
	Part3.Parent = GunAdditions
	Part3.CFrame = CFrame.new(19.3688221, 18.9064026, 23.968647, -0.0833633617, 0.722394645, -0.686437607, 0.09322685, -0.680160761, -0.727110922, -0.992148995, -0.124608696, -0.0106459931)
	Part3.Orientation = Vector3.new(46.639999389648, -90.889999389648, 172.19999694824)
	Part3.Position = Vector3.new(19.368822097778, 18.906402587891, 23.968647003174)
	Part3.Rotation = Vector3.new(90.839996337891, -43.349998474121, -96.580001831055)
	Part3.Color = Color3.new(1, 1, 1)
	Part3.Size = Vector3.new(0.20079199969769, 0.28110834956169, 0.14055448770523)
	Part3.Anchored = true
	Part3.BottomSurface = Enum.SurfaceType.Smooth
	Part3.BrickColor = BrickColor.new("Institutional white")
	Part3.CanCollide = false
	Part3.Locked = false
	Part3.Material = Enum.Material.Metal
	Part3.TopSurface = Enum.SurfaceType.Smooth
	Part3.brickColor = BrickColor.new("Institutional white")
	Part4.Parent = GunAdditions
	Part4.CFrame = CFrame.new(19.761692, 17.2902184, 26.7139797, -0.0833633617, 0.0254316237, -0.996194661, 0.09322685, -0.995091259, -0.0332048088, -0.992148995, -0.0956399739, 0.0805832073)
	Part4.Orientation = Vector3.new(1.8999999761581, -85.379997253418, 174.64999389648)
	Part4.Position = Vector3.new(19.761692047119, 17.290218353271, 26.713979721069)
	Part4.Rotation = Vector3.new(22.389999389648, -85, -163.0299987793)
	Part4.Color = Color3.new(0.498039, 0.498039, 0.498039)
	Part4.Size = Vector3.new(0.20079199969769, 0.20079199969769, 0.20079199969769)
	Part4.Anchored = true
	Part4.BottomSurface = Enum.SurfaceType.Smooth
	Part4.BrickColor = BrickColor.new("Sand green")
	Part4.CanCollide = false
	Part4.Locked = false
	Part4.Material = Enum.Material.Metal
	Part4.TopSurface = Enum.SurfaceType.Smooth
	Part4.brickColor = BrickColor.new("Sand green")
	Part4.Shape = Enum.PartType.Ball
	Part5.Parent = GunAdditions
	Part5.CFrame = CFrame.new(19.834959, 17.6540585, 27.1467686, -0.0833633617, 0.0254316237, -0.996194661, 0.09322685, -0.995091259, -0.0332048088, -0.992148995, -0.0956399739, 0.0805832073)
	Part5.Orientation = Vector3.new(1.8999999761581, -85.379997253418, 174.64999389648)
	Part5.Position = Vector3.new(19.834959030151, 17.654058456421, 27.146768569946)
	Part5.Rotation = Vector3.new(22.389999389648, -85, -163.0299987793)
	Part5.Color = Color3.new(0.498039, 0.498039, 0.498039)
	Part5.Size = Vector3.new(0.20079199969769, 0.20079199969769, 0.20079199969769)
	Part5.Anchored = true
	Part5.BottomSurface = Enum.SurfaceType.Smooth
	Part5.BrickColor = BrickColor.new("Sand green")
	Part5.CanCollide = false
	Part5.Locked = false
	Part5.Material = Enum.Material.Metal
	Part5.TopSurface = Enum.SurfaceType.Smooth
	Part5.brickColor = BrickColor.new("Sand green")
	Part5.Shape = Enum.PartType.Ball
	Part6.Parent = GunAdditions
	Part6.CFrame = CFrame.new(18.708746, 18.8844032, 24.0220394, -0.0833633617, -0.686433196, -0.722398877, 0.09322685, -0.727115035, 0.68015635, -0.992148995, -0.0106467605, 0.124608606)
	Part6.Orientation = Vector3.new(-42.860000610352, -80.209999084473, 172.69000244141)
	Part6.Position = Vector3.new(18.708745956421, 18.88440322876, 24.022039413452)
	Part6.Rotation = Vector3.new(-79.620002746582, -46.25, 96.919998168945)
	Part6.Color = Color3.new(1, 1, 1)
	Part6.Size = Vector3.new(0.20079199969769, 0.28110834956169, 0.14055448770523)
	Part6.Anchored = true
	Part6.BottomSurface = Enum.SurfaceType.Smooth
	Part6.BrickColor = BrickColor.new("Institutional white")
	Part6.CanCollide = false
	Part6.Locked = false
	Part6.Material = Enum.Material.Metal
	Part6.TopSurface = Enum.SurfaceType.Smooth
	Part6.brickColor = BrickColor.new("Institutional white")
	Part7.Parent = GunAdditions
	Part7.CFrame = CFrame.new(19.7784271, 17.2714996, 26.9131985, -0.0833633617, 0.0254316237, -0.996194661, 0.09322685, -0.995091259, -0.0332048088, -0.992148995, -0.0956399739, 0.0805832073)
	Part7.Orientation = Vector3.new(1.8999999761581, -85.379997253418, 174.64999389648)
	Part7.Position = Vector3.new(19.778427124023, 17.271499633789, 26.913198471069)
	Part7.Rotation = Vector3.new(22.389999389648, -85, -163.0299987793)
	Part7.Color = Color3.new(0.498039, 0.498039, 0.498039)
	Part7.Size = Vector3.new(0.40158399939537, 0.20079199969769, 0.20079199969769)
	Part7.Anchored = true
	Part7.BottomSurface = Enum.SurfaceType.Smooth
	Part7.BrickColor = BrickColor.new("Sand green")
	Part7.CanCollide = false
	Part7.Locked = false
	Part7.Material = Enum.Material.Metal
	Part7.TopSurface = Enum.SurfaceType.Smooth
	Part7.brickColor = BrickColor.new("Sand green")
	Part7.Shape = Enum.PartType.Cylinder
	Part8.Parent = GunAdditions
	Part8.CFrame = CFrame.new(19.2145634, 16.6421738, 27.6565914, -0.0833633617, 0.0254316237, -0.996194661, 0.09322685, -0.995091259, -0.0332048088, -0.992148995, -0.0956399739, 0.0805832073)
	Part8.Orientation = Vector3.new(1.8999999761581, -85.379997253418, 174.64999389648)
	Part8.Position = Vector3.new(19.214563369751, 16.64217376709, 27.656591415405)
	Part8.Rotation = Vector3.new(22.389999389648, -85, -163.0299987793)
	Part8.Color = Color3.new(0.498039, 0.498039, 0.498039)
	Part8.Size = Vector3.new(0.15661776065826, 0.090356394648552, 0.27307713031769)
	Part8.Anchored = true
	Part8.BottomSurface = Enum.SurfaceType.Smooth
	Part8.BrickColor = BrickColor.new("Sand green")
	Part8.CanCollide = false
	Part8.Locked = false
	Part8.Material = Enum.Material.Metal
	Part8.TopSurface = Enum.SurfaceType.Smooth
	Part8.brickColor = BrickColor.new("Sand green")
	Part9.Parent = GunAdditions
	Part9.CFrame = CFrame.new(18.8783092, 17.2415066, 26.986002, -0.0833633617, 0.0254316237, -0.996194661, 0.09322685, -0.995091259, -0.0332048088, -0.992148995, -0.0956399739, 0.0805832073)
	Part9.Orientation = Vector3.new(1.8999999761581, -85.379997253418, 174.64999389648)
	Part9.Position = Vector3.new(18.878309249878, 17.241506576538, 26.986001968384)
	Part9.Rotation = Vector3.new(22.389999389648, -85, -163.0299987793)
	Part9.Color = Color3.new(0.498039, 0.498039, 0.498039)
	Part9.Size = Vector3.new(0.40158399939537, 0.20079199969769, 0.20079199969769)
	Part9.Anchored = true
	Part9.BottomSurface = Enum.SurfaceType.Smooth
	Part9.BrickColor = BrickColor.new("Sand green")
	Part9.CanCollide = false
	Part9.Locked = false
	Part9.Material = Enum.Material.Metal
	Part9.TopSurface = Enum.SurfaceType.Smooth
	Part9.brickColor = BrickColor.new("Sand green")
	Part9.Shape = Enum.PartType.Cylinder
	Part10.Parent = GunAdditions
	Part10.CFrame = CFrame.new(19.4071236, 17.4078674, 23.8246422, -0.0833633617, -0.686433196, -0.722398877, 0.09322685, -0.727115035, 0.68015635, -0.992148995, -0.0106467605, 0.124608606)
	Part10.Orientation = Vector3.new(-42.860000610352, -80.209999084473, 172.69000244141)
	Part10.Position = Vector3.new(19.407123565674, 17.407867431641, 23.824642181396)
	Part10.Rotation = Vector3.new(-79.620002746582, -46.25, 96.919998168945)
	Part10.Color = Color3.new(1, 1, 1)
	Part10.Size = Vector3.new(0.20079199969769, 0.28110834956169, 0.14055448770523)
	Part10.Anchored = true
	Part10.BottomSurface = Enum.SurfaceType.Smooth
	Part10.BrickColor = BrickColor.new("Institutional white")
	Part10.CanCollide = false
	Part10.Locked = false
	Part10.Material = Enum.Material.Metal
	Part10.TopSurface = Enum.SurfaceType.Smooth
	Part10.brickColor = BrickColor.new("Institutional white")
	Part11.Parent = GunAdditions
	Part11.CFrame = CFrame.new(19.8014832, 17.691494, 26.7483444, -0.0833633617, 0.0254316237, -0.996194661, 0.09322685, -0.995091259, -0.0332048088, -0.992148995, -0.0956399739, 0.0805832073)
	Part11.Orientation = Vector3.new(1.8999999761581, -85.379997253418, 174.64999389648)
	Part11.Position = Vector3.new(19.801483154297, 17.691493988037, 26.748344421387)
	Part11.Rotation = Vector3.new(22.389999389648, -85, -163.0299987793)
	Part11.Color = Color3.new(0.498039, 0.498039, 0.498039)
	Part11.Size = Vector3.new(0.20079199969769, 0.20079199969769, 0.20079199969769)
	Part11.Anchored = true
	Part11.BottomSurface = Enum.SurfaceType.Smooth
	Part11.BrickColor = BrickColor.new("Sand green")
	Part11.CanCollide = false
	Part11.Locked = false
	Part11.Material = Enum.Material.Metal
	Part11.TopSurface = Enum.SurfaceType.Smooth
	Part11.brickColor = BrickColor.new("Sand green")
	Part11.Shape = Enum.PartType.Ball
	Part12.Parent = GunAdditions
	Part12.CFrame = CFrame.new(19.7747402, 18.0520058, 27.1892185, -0.0833633617, 0.0254316237, -0.996194661, 0.09322685, -0.995091259, -0.0332048088, -0.992148995, -0.0956399739, 0.0805832073)
	Part12.Orientation = Vector3.new(1.8999999761581, -85.379997253418, 174.64999389648)
	Part12.Position = Vector3.new(19.774740219116, 18.052005767822, 27.189218521118)
	Part12.Rotation = Vector3.new(22.389999389648, -85, -163.0299987793)
	Part12.Color = Color3.new(0.498039, 0.498039, 0.498039)
	Part12.Size = Vector3.new(0.20079199969769, 0.20079199969769, 0.20079199969769)
	Part12.Anchored = true
	Part12.BottomSurface = Enum.SurfaceType.Smooth
	Part12.BrickColor = BrickColor.new("Sand green")
	Part12.CanCollide = false
	Part12.Locked = false
	Part12.Material = Enum.Material.Metal
	Part12.TopSurface = Enum.SurfaceType.Smooth
	Part12.brickColor = BrickColor.new("Sand green")
	Part12.Shape = Enum.PartType.Ball
	Part13.Parent = GunAdditions
	Part13.CFrame = CFrame.new(19.795166, 17.2527809, 27.1124058, -0.0833633617, 0.0254316237, -0.996194661, 0.09322685, -0.995091259, -0.0332048088, -0.992148995, -0.0956399739, 0.0805832073)
	Part13.Orientation = Vector3.new(1.8999999761581, -85.379997253418, 174.64999389648)
	Part13.Position = Vector3.new(19.795166015625, 17.252780914307, 27.112405776978)
	Part13.Rotation = Vector3.new(22.389999389648, -85, -163.0299987793)
	Part13.Color = Color3.new(0.498039, 0.498039, 0.498039)
	Part13.Size = Vector3.new(0.20079199969769, 0.20079199969769, 0.20079199969769)
	Part13.Anchored = true
	Part13.BottomSurface = Enum.SurfaceType.Smooth
	Part13.BrickColor = BrickColor.new("Sand green")
	Part13.CanCollide = false
	Part13.Locked = false
	Part13.Material = Enum.Material.Metal
	Part13.TopSurface = Enum.SurfaceType.Smooth
	Part13.brickColor = BrickColor.new("Sand green")
	Part13.Shape = Enum.PartType.Ball
	Part14.Parent = GunAdditions
	Part14.CFrame = CFrame.new(18.8578854, 18.0407276, 27.062809, -0.0833633617, 0.0254316237, -0.996194661, 0.09322685, -0.995091259, -0.0332048088, -0.992148995, -0.0956399739, 0.0805832073)
	Part14.Orientation = Vector3.new(1.8999999761581, -85.379997253418, 174.64999389648)
	Part14.Position = Vector3.new(18.857885360718, 18.040727615356, 27.062808990479)
	Part14.Rotation = Vector3.new(22.389999389648, -85, -163.0299987793)
	Part14.Color = Color3.new(0.498039, 0.498039, 0.498039)
	Part14.Size = Vector3.new(0.40158399939537, 0.20079199969769, 0.20079199969769)
	Part14.Anchored = true
	Part14.BottomSurface = Enum.SurfaceType.Smooth
	Part14.BrickColor = BrickColor.new("Sand green")
	Part14.CanCollide = false
	Part14.Locked = false
	Part14.Material = Enum.Material.Metal
	Part14.TopSurface = Enum.SurfaceType.Smooth
	Part14.brickColor = BrickColor.new("Sand green")
	Part14.Shape = Enum.PartType.Cylinder
	Part15.Parent = GunAdditions
	Part15.CFrame = CFrame.new(19.818224, 17.6727772, 26.9475517, -0.0833633617, 0.0254316237, -0.996194661, 0.09322685, -0.995091259, -0.0332048088, -0.992148995, -0.0956399739, 0.0805832073)
	Part15.Orientation = Vector3.new(1.8999999761581, -85.379997253418, 174.64999389648)
	Part15.Position = Vector3.new(19.818223953247, 17.672777175903, 26.947551727295)
	Part15.Rotation = Vector3.new(22.389999389648, -85, -163.0299987793)
	Part15.Color = Color3.new(0.498039, 0.498039, 0.498039)
	Part15.Size = Vector3.new(0.40158399939537, 0.20079199969769, 0.20079199969769)
	Part15.Anchored = true
	Part15.BottomSurface = Enum.SurfaceType.Smooth
	Part15.BrickColor = BrickColor.new("Sand green")
	Part15.CanCollide = false
	Part15.Locked = false
	Part15.Material = Enum.Material.Metal
	Part15.TopSurface = Enum.SurfaceType.Smooth
	Part15.brickColor = BrickColor.new("Sand green")
	Part15.Shape = Enum.PartType.Cylinder
	Part16.Parent = GunAdditions
	Part16.CFrame = CFrame.new(19.7412624, 18.0894432, 26.7907867, -0.0833633617, 0.0254316237, -0.996194661, 0.09322685, -0.995091259, -0.0332048088, -0.992148995, -0.0956399739, 0.0805832073)
	Part16.Orientation = Vector3.new(1.8999999761581, -85.379997253418, 174.64999389648)
	Part16.Position = Vector3.new(19.741262435913, 18.089443206787, 26.790786743164)
	Part16.Rotation = Vector3.new(22.389999389648, -85, -163.0299987793)
	Part16.Color = Color3.new(0.498039, 0.498039, 0.498039)
	Part16.Size = Vector3.new(0.20079199969769, 0.20079199969769, 0.20079199969769)
	Part16.Anchored = true
	Part16.BottomSurface = Enum.SurfaceType.Smooth
	Part16.BrickColor = BrickColor.new("Sand green")
	Part16.CanCollide = false
	Part16.Locked = false
	Part16.Material = Enum.Material.Metal
	Part16.TopSurface = Enum.SurfaceType.Smooth
	Part16.brickColor = BrickColor.new("Sand green")
	Part16.Shape = Enum.PartType.Ball
	Part17.Parent = GunAdditions
	Part17.CFrame = CFrame.new(18.8411465, 18.0594501, 26.8635921, -0.0833633617, 0.0254316237, -0.996194661, 0.09322685, -0.995091259, -0.0332048088, -0.992148995, -0.0956399739, 0.0805832073)
	Part17.Orientation = Vector3.new(1.8999999761581, -85.379997253418, 174.64999389648)
	Part17.Position = Vector3.new(18.841146469116, 18.059450149536, 26.863592147827)
	Part17.Rotation = Vector3.new(22.389999389648, -85, -163.0299987793)
	Part17.Color = Color3.new(0.498039, 0.498039, 0.498039)
	Part17.Size = Vector3.new(0.20079199969769, 0.20079199969769, 0.20079199969769)
	Part17.Anchored = true
	Part17.BottomSurface = Enum.SurfaceType.Smooth
	Part17.BrickColor = BrickColor.new("Sand green")
	Part17.CanCollide = false
	Part17.Locked = false
	Part17.Material = Enum.Material.Metal
	Part17.TopSurface = Enum.SurfaceType.Smooth
	Part17.brickColor = BrickColor.new("Sand green")
	Part17.Shape = Enum.PartType.Ball
	Part18.Parent = GunAdditions
	Part18.CFrame = CFrame.new(18.8950462, 17.2227859, 27.1852131, -0.0833633617, 0.0254316237, -0.996194661, 0.09322685, -0.995091259, -0.0332048088, -0.992148995, -0.0956399739, 0.0805832073)
	Part18.Orientation = Vector3.new(1.8999999761581, -85.379997253418, 174.64999389648)
	Part18.Position = Vector3.new(18.895046234131, 17.222785949707, 27.185213088989)
	Part18.Rotation = Vector3.new(22.389999389648, -85, -163.0299987793)
	Part18.Color = Color3.new(0.498039, 0.498039, 0.498039)
	Part18.Size = Vector3.new(0.20079199969769, 0.20079199969769, 0.20079199969769)
	Part18.Anchored = true
	Part18.BottomSurface = Enum.SurfaceType.Smooth
	Part18.BrickColor = BrickColor.new("Sand green")
	Part18.CanCollide = false
	Part18.Locked = false
	Part18.Material = Enum.Material.Metal
	Part18.TopSurface = Enum.SurfaceType.Smooth
	Part18.brickColor = BrickColor.new("Sand green")
	Part18.Shape = Enum.PartType.Ball
	Part19.Parent = GunAdditions
	Part19.CFrame = CFrame.new(18.861578, 17.2602215, 26.7867889, -0.0833633617, 0.0254316237, -0.996194661, 0.09322685, -0.995091259, -0.0332048088, -0.992148995, -0.0956399739, 0.0805832073)
	Part19.Orientation = Vector3.new(1.8999999761581, -85.379997253418, 174.64999389648)
	Part19.Position = Vector3.new(18.861577987671, 17.260221481323, 26.78678894043)
	Part19.Rotation = Vector3.new(22.389999389648, -85, -163.0299987793)
	Part19.Color = Color3.new(0.498039, 0.498039, 0.498039)
	Part19.Size = Vector3.new(0.20079199969769, 0.20079199969769, 0.20079199969769)
	Part19.Anchored = true
	Part19.BottomSurface = Enum.SurfaceType.Smooth
	Part19.BrickColor = BrickColor.new("Sand green")
	Part19.CanCollide = false
	Part19.Locked = false
	Part19.Material = Enum.Material.Metal
	Part19.TopSurface = Enum.SurfaceType.Smooth
	Part19.brickColor = BrickColor.new("Sand green")
	Part19.Shape = Enum.PartType.Ball
	Part20.Parent = GunAdditions
	Part20.CFrame = CFrame.new(18.8180923, 17.6394482, 27.0284519, -0.0833633617, 0.0254316237, -0.996194661, 0.09322685, -0.995091259, -0.0332048088, -0.992148995, -0.0956399739, 0.0805832073)
	Part20.Orientation = Vector3.new(1.8999999761581, -85.379997253418, 174.64999389648)
	Part20.Position = Vector3.new(18.818092346191, 17.639448165894, 27.028451919556)
	Part20.Rotation = Vector3.new(22.389999389648, -85, -163.0299987793)
	Part20.Color = Color3.new(0.498039, 0.498039, 0.498039)
	Part20.Size = Vector3.new(0.40158399939537, 0.20079199969769, 0.20079199969769)
	Part20.Anchored = true
	Part20.BottomSurface = Enum.SurfaceType.Smooth
	Part20.BrickColor = BrickColor.new("Sand green")
	Part20.CanCollide = false
	Part20.Locked = false
	Part20.Material = Enum.Material.Metal
	Part20.TopSurface = Enum.SurfaceType.Smooth
	Part20.brickColor = BrickColor.new("Sand green")
	Part20.Shape = Enum.PartType.Cylinder
	Part21.Parent = GunAdditions
	Part21.CFrame = CFrame.new(18.7470493, 17.38587, 23.8780289, -0.0833633617, 0.722394645, -0.686437607, 0.09322685, -0.680160761, -0.727110922, -0.992148995, -0.124608696, -0.0106459931)
	Part21.Orientation = Vector3.new(46.639999389648, -90.889999389648, 172.19999694824)
	Part21.Position = Vector3.new(18.747049331665, 17.385869979858, 23.878028869629)
	Part21.Rotation = Vector3.new(90.839996337891, -43.349998474121, -96.580001831055)
	Part21.Color = Color3.new(1, 1, 1)
	Part21.Size = Vector3.new(0.20079199969769, 0.28110834956169, 0.14055448770523)
	Part21.Anchored = true
	Part21.BottomSurface = Enum.SurfaceType.Smooth
	Part21.BrickColor = BrickColor.new("Institutional white")
	Part21.CanCollide = false
	Part21.Locked = false
	Part21.Material = Enum.Material.Metal
	Part21.TopSurface = Enum.SurfaceType.Smooth
	Part21.brickColor = BrickColor.new("Institutional white")
	Part22.Parent = GunAdditions
	Part22.CFrame = CFrame.new(19.6146202, 16.655508, 27.6242313, -0.0637066588, -0.0594783835, -0.996194661, 0.908383965, -0.416817188, -0.0332048088, -0.413256198, -0.907042325, 0.0805832073)
	Part22.Orientation = Vector3.new(1.8999999761581, -85.379997253418, 114.65000152588)
	Part22.Position = Vector3.new(19.61462020874, 16.655508041382, 27.624231338501)
	Part22.Rotation = Vector3.new(22.389999389648, -85, 136.9700012207)
	Part22.Color = Color3.new(0.498039, 0.498039, 0.498039)
	Part22.Size = Vector3.new(0.15661776065826, 0.090356394648552, 0.27307713031769)
	Part22.Anchored = true
	Part22.BottomSurface = Enum.SurfaceType.Smooth
	Part22.BrickColor = BrickColor.new("Sand green")
	Part22.CanCollide = false
	Part22.Locked = false
	Part22.Material = Enum.Material.Metal
	Part22.TopSurface = Enum.SurfaceType.Smooth
	Part22.brickColor = BrickColor.new("Sand green")
	Part23.Parent = GunAdditions
	Part23.CFrame = CFrame.new(18.8348274, 17.6207294, 27.2276669, -0.0833633617, 0.0254316237, -0.996194661, 0.09322685, -0.995091259, -0.0332048088, -0.992148995, -0.0956399739, 0.0805832073)
	Part23.Orientation = Vector3.new(1.8999999761581, -85.379997253418, 174.64999389648)
	Part23.Position = Vector3.new(18.834827423096, 17.620729446411, 27.227666854858)
	Part23.Rotation = Vector3.new(22.389999389648, -85, -163.0299987793)
	Part23.Color = Color3.new(0.498039, 0.498039, 0.498039)
	Part23.Size = Vector3.new(0.20079199969769, 0.20079199969769, 0.20079199969769)
	Part23.Anchored = true
	Part23.BottomSurface = Enum.SurfaceType.Smooth
	Part23.BrickColor = BrickColor.new("Sand green")
	Part23.CanCollide = false
	Part23.Locked = false
	Part23.Material = Enum.Material.Metal
	Part23.TopSurface = Enum.SurfaceType.Smooth
	Part23.brickColor = BrickColor.new("Sand green")
	Part23.Shape = Enum.PartType.Ball
	Part24.Parent = GunAdditions
	Part24.CFrame = CFrame.new(18.8013535, 17.6581669, 26.8292332, -0.0833633617, 0.0254316237, -0.996194661, 0.09322685, -0.995091259, -0.0332048088, -0.992148995, -0.0956399739, 0.0805832073)
	Part24.Orientation = Vector3.new(1.8999999761581, -85.379997253418, 174.64999389648)
	Part24.Position = Vector3.new(18.80135345459, 17.658166885376, 26.829233169556)
	Part24.Rotation = Vector3.new(22.389999389648, -85, -163.0299987793)
	Part24.Color = Color3.new(0.498039, 0.498039, 0.498039)
	Part24.Size = Vector3.new(0.20079199969769, 0.20079199969769, 0.20079199969769)
	Part24.Anchored = true
	Part24.BottomSurface = Enum.SurfaceType.Smooth
	Part24.BrickColor = BrickColor.new("Sand green")
	Part24.CanCollide = false
	Part24.Locked = false
	Part24.Material = Enum.Material.Metal
	Part24.TopSurface = Enum.SurfaceType.Smooth
	Part24.brickColor = BrickColor.new("Sand green")
	Part24.Shape = Enum.PartType.Ball
	Part25.Parent = GunAdditions
	Part25.CFrame = CFrame.new(19.057436, 18.1661129, 23.9252605, -0.0833633617, 0.0254316237, -0.996194661, 0.09322685, -0.995091259, -0.0332048088, -0.992148995, -0.0956399739, 0.0805832073)
	Part25.Orientation = Vector3.new(1.8999999761581, -85.379997253418, 174.64999389648)
	Part25.Position = Vector3.new(19.05743598938, 18.16611289978, 23.925260543823)
	Part25.Rotation = Vector3.new(22.389999389648, -85, -163.0299987793)
	Part25.Color = Color3.new(1, 1, 1)
	Part25.Size = Vector3.new(0.20079199969769, 1.8673658370972, 0.60237598419189)
	Part25.Anchored = true
	Part25.BottomSurface = Enum.SurfaceType.Smooth
	Part25.BrickColor = BrickColor.new("Institutional white")
	Part25.CanCollide = false
	Part25.Locked = false
	Part25.Material = Enum.Material.Metal
	Part25.TopSurface = Enum.SurfaceType.Smooth
	Part25.brickColor = BrickColor.new("Institutional white")
	Part26.Parent = GunAdditions
	Part26.CFrame = CFrame.new(18.8746281, 18.022007, 27.2620239, -0.0833633617, 0.0254316237, -0.996194661, 0.09322685, -0.995091259, -0.0332048088, -0.992148995, -0.0956399739, 0.0805832073)
	Part26.Orientation = Vector3.new(1.8999999761581, -85.379997253418, 174.64999389648)
	Part26.Position = Vector3.new(18.874628067017, 18.022006988525, 27.262023925781)
	Part26.Rotation = Vector3.new(22.389999389648, -85, -163.0299987793)
	Part26.Color = Color3.new(0.498039, 0.498039, 0.498039)
	Part26.Size = Vector3.new(0.20079199969769, 0.20079199969769, 0.20079199969769)
	Part26.Anchored = true
	Part26.BottomSurface = Enum.SurfaceType.Smooth
	Part26.BrickColor = BrickColor.new("Sand green")
	Part26.CanCollide = false
	Part26.Locked = false
	Part26.Material = Enum.Material.Metal
	Part26.TopSurface = Enum.SurfaceType.Smooth
	Part26.brickColor = BrickColor.new("Sand green")
	Part26.Shape = Enum.PartType.Ball
	Part27.Parent = GunAdditions
	Part27.CFrame = CFrame.new(19.0576954, 18.1561203, 23.9242973, -0.0833633617, 0.0254316237, -0.996194661, 0.09322685, -0.995091259, -0.0332048088, -0.992148995, -0.0956399739, 0.0805832073)
	Part27.Orientation = Vector3.new(1.8999999761581, -85.379997253418, 174.64999389648)
	Part27.Position = Vector3.new(19.057695388794, 18.156120300293, 23.924297332764)
	Part27.Rotation = Vector3.new(22.389999389648, -85, -163.0299987793)
	Part27.Color = Color3.new(1, 1, 1)
	Part27.Size = Vector3.new(0.20079199969769, 1.4055438041687, 0.96380162239075)
	Part27.Anchored = true
	Part27.BottomSurface = Enum.SurfaceType.Smooth
	Part27.BrickColor = BrickColor.new("Institutional white")
	Part27.CanCollide = false
	Part27.Locked = false
	Part27.Material = Enum.Material.Metal
	Part27.TopSurface = Enum.SurfaceType.Smooth
	Part27.brickColor = BrickColor.new("Institutional white")
	Part28.Parent = GunAdditions
	Part28.CFrame = CFrame.new(19.6146202, 16.655508, 27.6242313, 0.0196564719, -0.0849107802, -0.996194661, 0.815166116, 0.578275025, -0.0332048163, 0.57889384, -0.811411381, 0.0805832073)
	Part28.Orientation = Vector3.new(1.8999999761581, -85.379997253418, 54.650001525879)
	Part28.Position = Vector3.new(19.61462020874, 16.655508041382, 27.624231338501)
	Part28.Rotation = Vector3.new(22.389999389648, -85, 76.970001220703)
	Part28.Color = Color3.new(0.498039, 0.498039, 0.498039)
	Part28.Size = Vector3.new(0.15661776065826, 0.090356394648552, 0.27307713031769)
	Part28.Anchored = true
	Part28.BottomSurface = Enum.SurfaceType.Smooth
	Part28.BrickColor = BrickColor.new("Sand green")
	Part28.CanCollide = false
	Part28.Locked = false
	Part28.Material = Enum.Material.Metal
	Part28.TopSurface = Enum.SurfaceType.Smooth
	Part28.brickColor = BrickColor.new("Sand green")
	Part29.Parent = GunAdditions
	Part29.CFrame = CFrame.new(19.4945221, 17.2114773, 28.9352398, 0.996195376, 0.02542652, -0.0833566338, 0.0331981331, -0.995092571, 0.0932152644, -0.0805773959, -0.09562774, -0.992150605)
	Part29.Orientation = Vector3.new(-5.3499999046326, -175.19999694824, 178.08999633789)
	Part29.Position = Vector3.new(19.494522094727, 17.211477279663, 28.93523979187)
	Part29.Rotation = Vector3.new(-174.63000488281, -4.7800002098083, -1.460000038147)
	Part29.Color = Color3.new(0.498039, 0.498039, 0.498039)
	Part29.Size = Vector3.new(1.1083718538284, 0.60237598419189, 0.60237598419189)
	Part29.Anchored = true
	Part29.BottomSurface = Enum.SurfaceType.Smooth
	Part29.BrickColor = BrickColor.new("Sand green")
	Part29.CanCollide = false
	Part29.Locked = false
	Part29.Material = Enum.Material.Metal
	Part29.TopSurface = Enum.SurfaceType.Smooth
	Part29.brickColor = BrickColor.new("Sand green")
	Part29.Shape = Enum.PartType.Cylinder
	Part30.Parent = GunAdditions
	Part30.CFrame = CFrame.new(19.7580051, 18.0707226, 26.9900036, -0.0833633617, 0.0254316237, -0.996194661, 0.09322685, -0.995091259, -0.0332048088, -0.992148995, -0.0956399739, 0.0805832073)
	Part30.Orientation = Vector3.new(1.8999999761581, -85.379997253418, 174.64999389648)
	Part30.Position = Vector3.new(19.758005142212, 18.070722579956, 26.990003585815)
	Part30.Rotation = Vector3.new(22.389999389648, -85, -163.0299987793)
	Part30.Color = Color3.new(0.498039, 0.498039, 0.498039)
	Part30.Size = Vector3.new(0.40158399939537, 0.20079199969769, 0.20079199969769)
	Part30.Anchored = true
	Part30.BottomSurface = Enum.SurfaceType.Smooth
	Part30.BrickColor = BrickColor.new("Sand green")
	Part30.CanCollide = false
	Part30.Locked = false
	Part30.Material = Enum.Material.Metal
	Part30.TopSurface = Enum.SurfaceType.Smooth
	Part30.brickColor = BrickColor.new("Sand green")
	Part30.Shape = Enum.PartType.Cylinder
	Part31.Parent = GunAdditions
	Part31.CFrame = CFrame.new(19.2145634, 16.6421738, 27.6565914, 0.0196564719, -0.0849107802, -0.996194661, 0.815166116, 0.578275025, -0.0332048163, 0.57889384, -0.811411381, 0.0805832073)
	Part31.Orientation = Vector3.new(1.8999999761581, -85.379997253418, 54.650001525879)
	Part31.Position = Vector3.new(19.214563369751, 16.64217376709, 27.656591415405)
	Part31.Rotation = Vector3.new(22.389999389648, -85, 76.970001220703)
	Part31.Color = Color3.new(0.498039, 0.498039, 0.498039)
	Part31.Size = Vector3.new(0.15661776065826, 0.090356394648552, 0.27307713031769)
	Part31.Anchored = true
	Part31.BottomSurface = Enum.SurfaceType.Smooth
	Part31.BrickColor = BrickColor.new("Sand green")
	Part31.CanCollide = false
	Part31.Locked = false
	Part31.Material = Enum.Material.Metal
	Part31.TopSurface = Enum.SurfaceType.Smooth
	Part31.brickColor = BrickColor.new("Sand green")
	Part32.Parent = GunAdditions
	Part32.CFrame = CFrame.new(19.6146202, 16.655508, 27.6242313, -0.0833633617, 0.0254316237, -0.996194661, 0.09322685, -0.995091259, -0.0332048088, -0.992148995, -0.0956399739, 0.0805832073)
	Part32.Orientation = Vector3.new(1.8999999761581, -85.379997253418, 174.64999389648)
	Part32.Position = Vector3.new(19.61462020874, 16.655508041382, 27.624231338501)
	Part32.Rotation = Vector3.new(22.389999389648, -85, -163.0299987793)
	Part32.Color = Color3.new(0.498039, 0.498039, 0.498039)
	Part32.Size = Vector3.new(0.15661776065826, 0.090356394648552, 0.27307713031769)
	Part32.Anchored = true
	Part32.BottomSurface = Enum.SurfaceType.Smooth
	Part32.BrickColor = BrickColor.new("Sand green")
	Part32.CanCollide = false
	Part32.Locked = false
	Part32.Material = Enum.Material.Metal
	Part32.TopSurface = Enum.SurfaceType.Smooth
	Part32.brickColor = BrickColor.new("Sand green")
	NeonParts.Parent = Gun
	NeonParts.Name = "NeonParts"
	Part34.Parent = NeonParts
	Part34.CFrame = CFrame.new(19.1845016, 16.2371864, 27.305172, -0.78582567, 0.612805307, -0.0833531395, 0.606101692, 0.789907157, 0.0932063311, 0.122958563, 0.0227234457, -0.992151737)
	Part34.Orientation = Vector3.new(-5.3499999046326, -175.19999694824, 37.5)
	Part34.Position = Vector3.new(19.184501647949, 16.237186431885, 27.305171966553)
	Part34.Rotation = Vector3.new(-174.63000488281, -4.7800002098083, -142.05000305176)
	Part34.Color = Color3.new(1, 1, 1)
	Part34.Size = Vector3.new(0.071473032236099, 0.010039600543678, 0.45377200841904)
	Part34.Anchored = true
	Part34.BottomSurface = Enum.SurfaceType.Smooth
	Part34.BrickColor = BrickColor.new("Institutional white")
	Part34.CanCollide = false
	Part34.Locked = false
	Part34.Material = Enum.Material.Neon
	Part34.TopSurface = Enum.SurfaceType.Smooth
	Part34.brickColor = BrickColor.new("Institutional white")
	Part35.Parent = NeonParts
	Part35.CFrame = CFrame.new(19.6012039, 16.2511044, 27.271471, -0.753437757, -0.652214646, -0.0833531469, -0.657517552, 0.747651935, 0.0932063162, 0.00152861222, 0.125031307, -0.992151737)
	Part35.Orientation = Vector3.new(-5.3499999046326, -175.19999694824, -41.330001831055)
	Part35.Position = Vector3.new(19.601203918457, 16.251104354858, 27.27147102356)
	Part35.Rotation = Vector3.new(-174.63000488281, -4.7800002098083, 139.11999511719)
	Part35.Color = Color3.new(1, 1, 1)
	Part35.Size = Vector3.new(0.071473032236099, 0.010039600543678, 0.45376893877983)
	Part35.Anchored = true
	Part35.BottomSurface = Enum.SurfaceType.Smooth
	Part35.BrickColor = BrickColor.new("Institutional white")
	Part35.CanCollide = false
	Part35.Locked = false
	Part35.Material = Enum.Material.Neon
	Part35.TopSurface = Enum.SurfaceType.Smooth
	Part35.brickColor = BrickColor.new("Institutional white")
	Part36.Parent = NeonParts
	Part36.CFrame = CFrame.new(19.1344414, 17.1291294, 29.692173, -0.0833598748, 0.0255075265, -0.996193051, 0.0932182819, -0.995089412, -0.0332796313, -0.992150009, -0.0956375897, 0.0805727541)
	Part36.Orientation = Vector3.new(1.9099999666214, -85.379997253418, 174.64999389648)
	Part36.Position = Vector3.new(19.134441375732, 17.12912940979, 29.69217300415)
	Part36.Rotation = Vector3.new(22.440000534058, -85, -162.99000549316)
	Part36.Color = Color3.new(1, 1, 1)
	Part36.Size = Vector3.new(0.80316805839539, 0.40158408880234, 0.010039600543678)
	Part36.Anchored = true
	Part36.BottomSurface = Enum.SurfaceType.Smooth
	Part36.BrickColor = BrickColor.new("Institutional white")
	Part36.CanCollide = false
	Part36.Locked = false
	Part36.Material = Enum.Material.Neon
	Part36.TopSurface = Enum.SurfaceType.Smooth
	Part36.brickColor = BrickColor.new("Institutional white")
	Part37.Parent = NeonParts
	Part37.CFrame = CFrame.new(19.5650501, 17.1119556, 29.7758217, -0.0833598748, 0.0255075265, -0.996193051, 0.0932182819, -0.995089412, -0.0332796313, -0.992150009, -0.0956375897, 0.0805727541)
	Part37.Orientation = Vector3.new(1.9099999666214, -85.379997253418, 174.64999389648)
	Part37.Position = Vector3.new(19.565050125122, 17.1119556427, 29.775821685791)
	Part37.Rotation = Vector3.new(22.440000534058, -85, -162.99000549316)
	Part37.Color = Color3.new(1, 1, 1)
	Part37.Size = Vector3.new(0.20079201459885, 0.46182161569595, 0.46182161569595)
	Part37.Anchored = true
	Part37.BottomSurface = Enum.SurfaceType.Smooth
	Part37.BrickColor = BrickColor.new("Institutional white")
	Part37.CanCollide = false
	Part37.Locked = false
	Part37.Material = Enum.Material.Neon
	Part37.TopSurface = Enum.SurfaceType.Smooth
	Part37.brickColor = BrickColor.new("Institutional white")
	Part37.Shape = Enum.PartType.Cylinder
	Part38.Parent = NeonParts
	Part38.CFrame = CFrame.new(19.9745464, 17.157198, 29.6242294, -0.0833598748, 0.0255075265, -0.996193051, 0.0932182819, -0.995089412, -0.0332796313, -0.992150009, -0.0956375897, 0.0805727541)
	Part38.Orientation = Vector3.new(1.9099999666214, -85.379997253418, 174.64999389648)
	Part38.Position = Vector3.new(19.974546432495, 17.157197952271, 29.624229431152)
	Part38.Rotation = Vector3.new(22.440000534058, -85, -162.99000549316)
	Part38.Color = Color3.new(1, 1, 1)
	Part38.Size = Vector3.new(0.80316805839539, 0.40158408880234, 0.010039600543678)
	Part38.Anchored = true
	Part38.BottomSurface = Enum.SurfaceType.Smooth
	Part38.BrickColor = BrickColor.new("Institutional white")
	Part38.CanCollide = false
	Part38.Locked = false
	Part38.Material = Enum.Material.Neon
	Part38.TopSurface = Enum.SurfaceType.Smooth
	Part38.brickColor = BrickColor.new("Institutional white")
	Part39.Parent = NeonParts
	Part39.CFrame = CFrame.new(18.8696117, 18.0262566, 27.2120361, -0.0833598748, 0.0255075265, -0.996193051, 0.0932182819, -0.995089412, -0.0332796313, -0.992150009, -0.0956375897, 0.0805727541)
	Part39.Orientation = Vector3.new(1.9099999666214, -85.379997253418, 174.64999389648)
	Part39.Position = Vector3.new(18.869611740112, 18.026256561279, 27.212036132813)
	Part39.Rotation = Vector3.new(22.440000534058, -85, -162.99000549316)
	Part39.Color = Color3.new(1, 1, 1)
	Part39.Size = Vector3.new(0.040158402174711, 0.22087122499943, 0.22087122499943)
	Part39.Anchored = true
	Part39.BottomSurface = Enum.SurfaceType.Smooth
	Part39.BrickColor = BrickColor.new("Institutional white")
	Part39.CanCollide = false
	Part39.Locked = false
	Part39.Material = Enum.Material.Neon
	Part39.TopSurface = Enum.SurfaceType.Smooth
	Part39.brickColor = BrickColor.new("Institutional white")
	Part39.Shape = Enum.PartType.Cylinder
	Part40.Parent = NeonParts
	Part40.CFrame = CFrame.new(19.7651043, 17.285183, 26.7636166, -0.0833598748, 0.0255075265, -0.996193051, 0.0932182819, -0.995089412, -0.0332796313, -0.992150009, -0.0956375897, 0.0805727541)
	Part40.Orientation = Vector3.new(1.9099999666214, -85.379997253418, 174.64999389648)
	Part40.Position = Vector3.new(19.765104293823, 17.285182952881, 26.76361656189)
	Part40.Rotation = Vector3.new(22.440000534058, -85, -162.99000549316)
	Part40.Color = Color3.new(1, 1, 1)
	Part40.Size = Vector3.new(0.040158402174711, 0.22087122499943, 0.22087122499943)
	Part40.Anchored = true
	Part40.BottomSurface = Enum.SurfaceType.Smooth
	Part40.BrickColor = BrickColor.new("Institutional white")
	Part40.CanCollide = false
	Part40.Locked = false
	Part40.Material = Enum.Material.Neon
	Part40.TopSurface = Enum.SurfaceType.Smooth
	Part40.brickColor = BrickColor.new("Institutional white")
	Part40.Shape = Enum.PartType.Cylinder
	Part41.Parent = NeonParts
	Part41.CFrame = CFrame.new(19.8048687, 17.6864586, 26.7979736, -0.0833598748, 0.0255075265, -0.996193051, 0.0932182819, -0.995089412, -0.0332796313, -0.992150009, -0.0956375897, 0.0805727541)
	Part41.Orientation = Vector3.new(1.9099999666214, -85.379997253418, 174.64999389648)
	Part41.Position = Vector3.new(19.80486869812, 17.686458587646, 26.797973632813)
	Part41.Rotation = Vector3.new(22.440000534058, -85, -162.99000549316)
	Part41.Color = Color3.new(1, 1, 1)
	Part41.Size = Vector3.new(0.040158402174711, 0.22087122499943, 0.22087122499943)
	Part41.Anchored = true
	Part41.BottomSurface = Enum.SurfaceType.Smooth
	Part41.BrickColor = BrickColor.new("Institutional white")
	Part41.CanCollide = false
	Part41.Locked = false
	Part41.Material = Enum.Material.Neon
	Part41.TopSurface = Enum.SurfaceType.Smooth
	Part41.brickColor = BrickColor.new("Institutional white")
	Part41.Shape = Enum.PartType.Cylinder
	Part42.Parent = NeonParts
	Part42.CFrame = CFrame.new(19.7446194, 18.0844002, 26.8404179, -0.0833598748, 0.0255075265, -0.996193051, 0.0932182819, -0.995089412, -0.0332796313, -0.992150009, -0.0956375897, 0.0805727541)
	Part42.Orientation = Vector3.new(1.9099999666214, -85.379997253418, 174.64999389648)
	Part42.Position = Vector3.new(19.744619369507, 18.084400177002, 26.840417861938)
	Part42.Rotation = Vector3.new(22.440000534058, -85, -162.99000549316)
	Part42.Color = Color3.new(1, 1, 1)
	Part42.Size = Vector3.new(0.040158402174711, 0.22087122499943, 0.22087122499943)
	Part42.Anchored = true
	Part42.BottomSurface = Enum.SurfaceType.Smooth
	Part42.BrickColor = BrickColor.new("Institutional white")
	Part42.CanCollide = false
	Part42.Locked = false
	Part42.Material = Enum.Material.Neon
	Part42.TopSurface = Enum.SurfaceType.Smooth
	Part42.brickColor = BrickColor.new("Institutional white")
	Part42.Shape = Enum.PartType.Cylinder
	Part43.Parent = NeonParts
	Part43.CFrame = CFrame.new(18.8445072, 18.0543365, 26.9132156, -0.0833598748, 0.0255075265, -0.996193051, 0.0932182819, -0.995089412, -0.0332796313, -0.992150009, -0.0956375897, 0.0805727541)
	Part43.Orientation = Vector3.new(1.9099999666214, -85.379997253418, 174.64999389648)
	Part43.Position = Vector3.new(18.844507217407, 18.054336547852, 26.913215637207)
	Part43.Rotation = Vector3.new(22.440000534058, -85, -162.99000549316)
	Part43.Color = Color3.new(1, 1, 1)
	Part43.Size = Vector3.new(0.040158402174711, 0.22087122499943, 0.22087122499943)
	Part43.Anchored = true
	Part43.BottomSurface = Enum.SurfaceType.Smooth
	Part43.BrickColor = BrickColor.new("Institutional white")
	Part43.CanCollide = false
	Part43.Locked = false
	Part43.Material = Enum.Material.Neon
	Part43.TopSurface = Enum.SurfaceType.Smooth
	Part43.brickColor = BrickColor.new("Institutional white")
	Part43.Shape = Enum.PartType.Cylinder
	Part44.Parent = NeonParts
	Part44.CFrame = CFrame.new(19.8299732, 17.6583843, 27.0967941, -0.0833598748, 0.0255075265, -0.996193051, 0.0932182819, -0.995089412, -0.0332796313, -0.992150009, -0.0956375897, 0.0805727541)
	Part44.Orientation = Vector3.new(1.9099999666214, -85.379997253418, 174.64999389648)
	Part44.Position = Vector3.new(19.829973220825, 17.65838432312, 27.096794128418)
	Part44.Rotation = Vector3.new(22.440000534058, -85, -162.99000549316)
	Part44.Color = Color3.new(1, 1, 1)
	Part44.Size = Vector3.new(0.040158402174711, 0.22087122499943, 0.22087122499943)
	Part44.Anchored = true
	Part44.BottomSurface = Enum.SurfaceType.Smooth
	Part44.BrickColor = BrickColor.new("Institutional white")
	Part44.CanCollide = false
	Part44.Locked = false
	Part44.Material = Enum.Material.Neon
	Part44.TopSurface = Enum.SurfaceType.Smooth
	Part44.brickColor = BrickColor.new("Institutional white")
	Part44.Shape = Enum.PartType.Cylinder
	Part45.Parent = NeonParts
	Part45.CFrame = CFrame.new(19.0610809, 18.1510201, 23.973938, -0.0833598748, 0.0255075265, -0.996193051, 0.0932182819, -0.995089412, -0.0332796313, -0.992150009, -0.0956375897, 0.0805727541)
	Part45.Orientation = Vector3.new(1.9099999666214, -85.379997253418, 174.64999389648)
	Part45.Position = Vector3.new(19.061080932617, 18.151020050049, 23.973937988281)
	Part45.Rotation = Vector3.new(22.440000534058, -85, -162.99000549316)
	Part45.Color = Color3.new(1, 1, 1)
	Part45.Size = Vector3.new(0.20079201459885, 1.405543923378, 0.96380168199539)
	Part45.Anchored = true
	Part45.BottomSurface = Enum.SurfaceType.Smooth
	Part45.BrickColor = BrickColor.new("Institutional white")
	Part45.CanCollide = false
	Part45.Locked = false
	Part45.Material = Enum.Material.Neon
	Part45.TopSurface = Enum.SurfaceType.Smooth
	Part45.brickColor = BrickColor.new("Institutional white")
	Part46.Parent = NeonParts
	Part46.CFrame = CFrame.new(18.8298492, 17.6249809, 27.1776791, -0.0833598748, 0.0255075265, -0.996193051, 0.0932182819, -0.995089412, -0.0332796313, -0.992150009, -0.0956375897, 0.0805727541)
	Part46.Orientation = Vector3.new(1.9099999666214, -85.379997253418, 174.64999389648)
	Part46.Position = Vector3.new(18.829849243164, 17.624980926514, 27.17767906189)
	Part46.Rotation = Vector3.new(22.440000534058, -85, -162.99000549316)
	Part46.Color = Color3.new(1, 1, 1)
	Part46.Size = Vector3.new(0.040158402174711, 0.22087122499943, 0.22087122499943)
	Part46.Anchored = true
	Part46.BottomSurface = Enum.SurfaceType.Smooth
	Part46.BrickColor = BrickColor.new("Institutional white")
	Part46.CanCollide = false
	Part46.Locked = false
	Part46.Material = Enum.Material.Neon
	Part46.TopSurface = Enum.SurfaceType.Smooth
	Part46.brickColor = BrickColor.new("Institutional white")
	Part46.Shape = Enum.PartType.Cylinder
	Part47.Parent = NeonParts
	Part47.CFrame = CFrame.new(19.7697277, 18.0563259, 27.1392403, -0.0833598748, 0.0255075265, -0.996193051, 0.0932182819, -0.995089412, -0.0332796313, -0.992150009, -0.0956375897, 0.0805727541)
	Part47.Orientation = Vector3.new(1.9099999666214, -85.379997253418, 174.64999389648)
	Part47.Position = Vector3.new(19.769727706909, 18.056325912476, 27.139240264893)
	Part47.Rotation = Vector3.new(22.440000534058, -85, -162.99000549316)
	Part47.Color = Color3.new(1, 1, 1)
	Part47.Size = Vector3.new(0.040158402174711, 0.22087122499943, 0.22087122499943)
	Part47.Anchored = true
	Part47.BottomSurface = Enum.SurfaceType.Smooth
	Part47.BrickColor = BrickColor.new("Institutional white")
	Part47.CanCollide = false
	Part47.Locked = false
	Part47.Material = Enum.Material.Neon
	Part47.TopSurface = Enum.SurfaceType.Smooth
	Part47.brickColor = BrickColor.new("Institutional white")
	Part47.Shape = Enum.PartType.Cylinder
	Part48.Parent = NeonParts
	Part48.CFrame = CFrame.new(19.7902126, 17.2571049, 27.0624371, -0.0833598748, 0.0255075265, -0.996193051, 0.0932182819, -0.995089412, -0.0332796313, -0.992150009, -0.0956375897, 0.0805727541)
	Part48.Orientation = Vector3.new(1.9099999666214, -85.379997253418, 174.64999389648)
	Part48.Position = Vector3.new(19.790212631226, 17.257104873657, 27.062437057495)
	Part48.Rotation = Vector3.new(22.440000534058, -85, -162.99000549316)
	Part48.Color = Color3.new(1, 1, 1)
	Part48.Size = Vector3.new(0.040158402174711, 0.22087122499943, 0.22087122499943)
	Part48.Anchored = true
	Part48.BottomSurface = Enum.SurfaceType.Smooth
	Part48.BrickColor = BrickColor.new("Institutional white")
	Part48.CanCollide = false
	Part48.Locked = false
	Part48.Material = Enum.Material.Neon
	Part48.TopSurface = Enum.SurfaceType.Smooth
	Part48.brickColor = BrickColor.new("Institutional white")
	Part48.Shape = Enum.PartType.Cylinder
	Part49.Parent = NeonParts
	Part49.CFrame = CFrame.new(19.618351, 16.4038925, 27.2266922, -0.0833598748, 0.0255074725, -0.996193051, 0.0932182893, -0.995089412, -0.0332795754, -0.992150009, -0.0956375897, 0.0805727616)
	Part49.Orientation = Vector3.new(1.9099999666214, -85.379997253418, 174.64999389648)
	Part49.Position = Vector3.new(19.618350982666, 16.40389251709, 27.226692199707)
	Part49.Rotation = Vector3.new(22.440000534058, -85, -162.99000549316)
	Part49.Color = Color3.new(1, 1, 1)
	Part49.Size = Vector3.new(0.56824111938477, 0.25701373815536, 0.010039600543678)
	Part49.Anchored = true
	Part49.BottomSurface = Enum.SurfaceType.Smooth
	Part49.BrickColor = BrickColor.new("Institutional white")
	Part49.CanCollide = false
	Part49.Locked = false
	Part49.Material = Enum.Material.Neon
	Part49.TopSurface = Enum.SurfaceType.Smooth
	Part49.brickColor = BrickColor.new("Institutional white")
	Part50.Parent = NeonParts
	Part50.CFrame = CFrame.new(19.9453259, 17.4299049, 31.817749, -0.0833598748, 0.563956439, -0.82158649, 0.0932182819, -0.816428006, -0.569873512, -0.992150009, -0.124091469, 0.0154862851)
	Part50.Orientation = Vector3.new(34.740001678467, -88.919998168945, 173.49000549316)
	Part50.Position = Vector3.new(19.94532585144, 17.429904937744, 31.817749023438)
	Part50.Rotation = Vector3.new(88.440002441406, -55.240001678467, -98.410003662109)
	Part50.Color = Color3.new(1, 1, 1)
	Part50.Size = Vector3.new(1.8071283102036, 0.40158402919769, 0.20079201459885)
	Part50.Anchored = true
	Part50.BottomSurface = Enum.SurfaceType.Smooth
	Part50.BrickColor = BrickColor.new("Institutional white")
	Part50.CanCollide = false
	Part50.Locked = false
	Part50.Material = Enum.Material.Neon
	Part50.TopSurface = Enum.SurfaceType.Smooth
	Part50.brickColor = BrickColor.new("Institutional white")
	Part51.Parent = NeonParts
	Part51.CFrame = CFrame.new(18.8649902, 17.2551155, 26.8364124, -0.0833598748, 0.0255075265, -0.996193051, 0.0932182819, -0.995089412, -0.0332796313, -0.992150009, -0.0956375897, 0.0805727541)
	Part51.Orientation = Vector3.new(1.9099999666214, -85.379997253418, 174.64999389648)
	Part51.Position = Vector3.new(18.864990234375, 17.255115509033, 26.83641242981)
	Part51.Rotation = Vector3.new(22.440000534058, -85, -162.99000549316)
	Part51.Color = Color3.new(1, 1, 1)
	Part51.Size = Vector3.new(0.040158402174711, 0.22087122499943, 0.22087122499943)
	Part51.Anchored = true
	Part51.BottomSurface = Enum.SurfaceType.Smooth
	Part51.BrickColor = BrickColor.new("Institutional white")
	Part51.CanCollide = false
	Part51.Locked = false
	Part51.Material = Enum.Material.Neon
	Part51.TopSurface = Enum.SurfaceType.Smooth
	Part51.brickColor = BrickColor.new("Institutional white")
	Part51.Shape = Enum.PartType.Cylinder
	Part52.Parent = NeonParts
	Part52.CFrame = CFrame.new(18.8901005, 17.2270412, 27.135231, -0.0833598748, 0.0255075265, -0.996193051, 0.0932182819, -0.995089412, -0.0332796313, -0.992150009, -0.0956375897, 0.0805727541)
	Part52.Orientation = Vector3.new(1.9099999666214, -85.379997253418, 174.64999389648)
	Part52.Position = Vector3.new(18.890100479126, 17.227041244507, 27.135231018066)
	Part52.Rotation = Vector3.new(22.440000534058, -85, -162.99000549316)
	Part52.Color = Color3.new(1, 1, 1)
	Part52.Size = Vector3.new(0.040158402174711, 0.22087122499943, 0.22087122499943)
	Part52.Anchored = true
	Part52.BottomSurface = Enum.SurfaceType.Smooth
	Part52.BrickColor = BrickColor.new("Institutional white")
	Part52.CanCollide = false
	Part52.Locked = false
	Part52.Material = Enum.Material.Neon
	Part52.TopSurface = Enum.SurfaceType.Smooth
	Part52.brickColor = BrickColor.new("Institutional white")
	Part52.Shape = Enum.PartType.Cylinder
	Part53.Parent = NeonParts
	Part53.CFrame = CFrame.new(19.3939915, 16.2220516, 27.2932415, -0.0833598748, 0.0255074725, -0.996193051, 0.0932182893, -0.995089412, -0.0332795754, -0.992150009, -0.0956375897, 0.0805727616)
	Part53.Orientation = Vector3.new(1.9099999666214, -85.379997253418, 174.64999389648)
	Part53.Position = Vector3.new(19.393991470337, 16.222051620483, 27.293241500854)
	Part53.Rotation = Vector3.new(22.440000534058, -85, -162.99000549316)
	Part53.Color = Color3.new(1, 1, 1)
	Part53.Size = Vector3.new(0.46784520149231, 0.010039600543678, 0.36945730447769)
	Part53.Anchored = true
	Part53.BottomSurface = Enum.SurfaceType.Smooth
	Part53.BrickColor = BrickColor.new("Institutional white")
	Part53.CanCollide = false
	Part53.Locked = false
	Part53.Material = Enum.Material.Neon
	Part53.TopSurface = Enum.SurfaceType.Smooth
	Part53.brickColor = BrickColor.new("Institutional white")
	Part54.Parent = NeonParts
	Part54.CFrame = CFrame.new(18.8047428, 17.6530552, 26.8788586, -0.0833598748, 0.0255075265, -0.996193051, 0.0932182819, -0.995089412, -0.0332796313, -0.992150009, -0.0956375897, 0.0805727541)
	Part54.Orientation = Vector3.new(1.9099999666214, -85.379997253418, 174.64999389648)
	Part54.Position = Vector3.new(18.80474281311, 17.65305519104, 26.878858566284)
	Part54.Rotation = Vector3.new(22.440000534058, -85, -162.99000549316)
	Part54.Color = Color3.new(1, 1, 1)
	Part54.Size = Vector3.new(0.040158402174711, 0.22087122499943, 0.22087122499943)
	Part54.Anchored = true
	Part54.BottomSurface = Enum.SurfaceType.Smooth
	Part54.BrickColor = BrickColor.new("Institutional white")
	Part54.CanCollide = false
	Part54.Locked = false
	Part54.Material = Enum.Material.Neon
	Part54.TopSurface = Enum.SurfaceType.Smooth
	Part54.brickColor = BrickColor.new("Institutional white")
	Part54.Shape = Enum.PartType.Cylinder
	Part55.Parent = NeonParts
	Part55.CFrame = CFrame.new(19.4972687, 17.414938, 31.8539886, -0.0833598748, -0.521174014, -0.849369764, 0.0932182819, -0.852677166, 0.514054656, -0.992150009, -0.0363252498, 0.119661994)
	Part55.Orientation = Vector3.new(-30.930000305176, -81.980003356934, 173.75999450684)
	Part55.Position = Vector3.new(19.497268676758, 17.414937973022, 31.853988647461)
	Part55.Rotation = Vector3.new(-76.900001525879, -58.139999389648, 99.089996337891)
	Part55.Color = Color3.new(1, 1, 1)
	Part55.Size = Vector3.new(1.8071283102036, 0.40158402919769, 0.20079201459885)
	Part55.Anchored = true
	Part55.BottomSurface = Enum.SurfaceType.Smooth
	Part55.BrickColor = BrickColor.new("Institutional white")
	Part55.CanCollide = false
	Part55.Locked = false
	Part55.Material = Enum.Material.Neon
	Part55.TopSurface = Enum.SurfaceType.Smooth
	Part55.brickColor = BrickColor.new("Institutional white")
	Part56.Name = "thingy"
	Part56.Parent = NeonParts
	Part56.CFrame = CFrame.new(19.5951786, 17.0782642, 30.1344013, -0.0833598748, 0.0255075265, -0.996193051, 0.0932182819, -0.995089412, -0.0332796313, -0.992150009, -0.0956375897, 0.0805727541)
	Part56.Orientation = Vector3.new(1.9099999666214, -85.379997253418, 174.64999389648)
	Part56.Position = Vector3.new(19.595178604126, 17.07826423645, 30.134401321411)
	Part56.Rotation = Vector3.new(22.440000534058, -85, -162.99000549316)
	Part56.Color = Color3.new(1, 1, 1)
	Part56.Size = Vector3.new(0.20079201459885, 0.20079201459885, 0.20079201459885)
	Part56.Anchored = true
	Part56.BottomSurface = Enum.SurfaceType.Smooth
	Part56.BrickColor = BrickColor.new("Institutional white")
	Part56.CanCollide = false
	Part56.Locked = false
	Part56.Material = Enum.Material.Neon
	Part56.TopSurface = Enum.SurfaceType.Smooth
	Part56.brickColor = BrickColor.new("Institutional white")
	Part57.Parent = NeonParts
	Part57.CFrame = CFrame.new(19.4937401, 17.2111092, 28.9350548, 0.996193707, 0.0255029462, -0.0833531469, 0.0332734324, -0.995090723, 0.0932063311, -0.0805669054, -0.0956249982, -0.992151678)
	Part57.Orientation = Vector3.new(-5.3499999046326, -175.19999694824, 178.08000183105)
	Part57.Position = Vector3.new(19.493740081787, 17.211109161377, 28.935054779053)
	Part57.Rotation = Vector3.new(-174.63000488281, -4.7800002098083, -1.4700000286102)
	Part57.Color = Color3.new(1, 1, 1)
	Part57.Size = Vector3.new(1.114395737648, 0.20079201459885, 0.20079201459885)
	Part57.Anchored = true
	Part57.BottomSurface = Enum.SurfaceType.Smooth
	Part57.BrickColor = BrickColor.new("Institutional white")
	Part57.CanCollide = false
	Part57.Locked = false
	Part57.Material = Enum.Material.Neon
	Part57.TopSurface = Enum.SurfaceType.Smooth
	Part57.brickColor = BrickColor.new("Institutional white")
	Part57.Shape = Enum.PartType.Cylinder
	Part58.Parent = NeonParts
	Part58.CFrame = CFrame.new(19.1502972, 16.388258, 27.2645493, -0.0833598748, 0.0255074725, -0.996193051, 0.0932182893, -0.995089412, -0.0332795754, -0.992150009, -0.0956375897, 0.0805727616)
	Part58.Orientation = Vector3.new(1.9099999666214, -85.379997253418, 174.64999389648)
	Part58.Position = Vector3.new(19.150297164917, 16.388257980347, 27.264549255371)
	Part58.Rotation = Vector3.new(22.440000534058, -85, -162.99000549316)
	Part58.Color = Color3.new(1, 1, 1)
	Part58.Size = Vector3.new(0.56824111938477, 0.25701373815536, 0.010039600543678)
	Part58.Anchored = true
	Part58.BottomSurface = Enum.SurfaceType.Smooth
	Part58.BrickColor = BrickColor.new("Institutional white")
	Part58.CanCollide = false
	Part58.Locked = false
	Part58.Material = Enum.Material.Neon
	Part58.TopSurface = Enum.SurfaceType.Smooth
	Part58.brickColor = BrickColor.new("Institutional white")
	WedgePart59.Parent = NeonParts
	WedgePart59.CFrame = CFrame.new(18.7870598, 16.9896164, 28.7612, -0.0796469674, 0.0354378037, 0.996193051, 0.723186314, 0.689850807, 0.0332794897, -0.686045229, 0.723083735, -0.0805726573)
	WedgePart59.Orientation = Vector3.new(-1.9099999666214, 94.620002746582, 46.349998474121)
	WedgePart59.Position = Vector3.new(18.787059783936, 16.989616394043, 28.761199951172)
	WedgePart59.Rotation = Vector3.new(-157.55999755859, 85, -156.00999450684)
	WedgePart59.Color = Color3.new(1, 1, 1)
	WedgePart59.Size = Vector3.new(0.19276034832001, 0.0863406509161, 0.078309148550034)
	WedgePart59.Anchored = true
	WedgePart59.BottomSurface = Enum.SurfaceType.Smooth
	WedgePart59.BrickColor = BrickColor.new("Institutional white")
	WedgePart59.CanCollide = false
	WedgePart59.Locked = false
	WedgePart59.Material = Enum.Material.Neon
	WedgePart59.brickColor = BrickColor.new("Institutional white")
	WedgePart60.Parent = NeonParts
	WedgePart60.CFrame = CFrame.new(18.8191109, 16.8925972, 29.0732765, 0.739508092, -0.334927619, -0.583910346, -0.670585632, -0.290936232, -0.682400942, 0.0586742349, 0.896202981, -0.439747304)
	WedgePart60.Orientation = Vector3.new(43.029998779297, -126.98000335693, -113.44999694824)
	WedgePart60.Position = Vector3.new(18.819110870361, 16.892597198486, 29.073276519775)
	WedgePart60.Rotation = Vector3.new(122.80000305176, -35.729999542236, 24.370000839233)
	WedgePart60.Color = Color3.new(1, 1, 1)
	WedgePart60.Size = Vector3.new(0.010039600543678, 0.093913570046425, 0.069044947624207)
	WedgePart60.Anchored = true
	WedgePart60.BottomSurface = Enum.SurfaceType.Smooth
	WedgePart60.BrickColor = BrickColor.new("Institutional white")
	WedgePart60.CanCollide = false
	WedgePart60.Locked = false
	WedgePart60.Material = Enum.Material.Neon
	WedgePart60.brickColor = BrickColor.new("Institutional white")
	WedgePart61.Parent = NeonParts
	WedgePart61.CFrame = CFrame.new(18.8532982, 16.9259586, 29.0237331, -0.739519358, 0.334903151, -0.583910227, 0.670575857, 0.290958315, -0.68240118, -0.05864482, -0.896204889, -0.439747244)
	WedgePart61.Orientation = Vector3.new(43.029998779297, -126.98000335693, 66.540000915527)
	WedgePart61.Position = Vector3.new(18.853298187256, 16.925958633423, 29.023733139038)
	WedgePart61.Rotation = Vector3.new(122.80000305176, -35.729999542236, -155.63999938965)
	WedgePart61.Color = Color3.new(1, 1, 1)
	WedgePart61.Size = Vector3.new(0.010039600543678, 0.037194218486547, 0.0271573420614)
	WedgePart61.Anchored = true
	WedgePart61.BottomSurface = Enum.SurfaceType.Smooth
	WedgePart61.BrickColor = BrickColor.new("Institutional white")
	WedgePart61.CanCollide = false
	WedgePart61.Locked = false
	WedgePart61.Material = Enum.Material.Neon
	WedgePart61.brickColor = BrickColor.new("Institutional white")
	WedgePart62.Parent = NeonParts
	WedgePart62.CFrame = CFrame.new(18.7789307, 16.8456383, 29.0430145, -0.739508092, -0.334927619, 0.583910406, 0.670585632, -0.290936232, 0.682400942, -0.0586742349, 0.896202922, 0.439747334)
	WedgePart62.Orientation = Vector3.new(-43.029998779297, 53.020000457764, 113.44999694824)
	WedgePart62.Position = Vector3.new(18.778930664063, 16.845638275146, 29.043014526367)
	WedgePart62.Rotation = Vector3.new(-57.200000762939, 35.729999542236, 155.63000488281)
	WedgePart62.Color = Color3.new(1, 1, 1)
	WedgePart62.Size = Vector3.new(0.010039600543678, 0.093913570046425, 0.068583011627197)
	WedgePart62.Anchored = true
	WedgePart62.BottomSurface = Enum.SurfaceType.Smooth
	WedgePart62.BrickColor = BrickColor.new("Institutional white")
	WedgePart62.CanCollide = false
	WedgePart62.Locked = false
	WedgePart62.Material = Enum.Material.Neon
	WedgePart62.brickColor = BrickColor.new("Institutional white")
	WedgePart63.Parent = NeonParts
	WedgePart63.CFrame = CFrame.new(18.8131142, 16.8790035, 28.9934731, 0.739519358, 0.334903061, 0.583910227, -0.670575857, 0.290958196, 0.68240124, 0.05864482, -0.896204948, 0.439747125)
	WedgePart63.Orientation = Vector3.new(-43.029998779297, 53.020000457764, -66.540000915527)
	WedgePart63.Position = Vector3.new(18.81311416626, 16.87900352478, 28.993473052979)
	WedgePart63.Rotation = Vector3.new(-57.200000762939, 35.729999542236, -24.360000610352)
	WedgePart63.Color = Color3.new(1, 1, 1)
	WedgePart63.Size = Vector3.new(0.010039600543678, 0.037194218486547, 0.11047061532736)
	WedgePart63.Anchored = true
	WedgePart63.BottomSurface = Enum.SurfaceType.Smooth
	WedgePart63.BrickColor = BrickColor.new("Institutional white")
	WedgePart63.CanCollide = false
	WedgePart63.Locked = false
	WedgePart63.Material = Enum.Material.Neon
	WedgePart63.brickColor = BrickColor.new("Institutional white")
	WedgePart64.Parent = NeonParts
	WedgePart64.CFrame = CFrame.new(18.8010826, 16.9062405, 28.900177, -0.0863238052, -0.0121530993, 0.996193051, 0.247736111, 0.968255818, 0.033279527, -0.964974105, 0.249665812, -0.080572769)
	WedgePart64.Orientation = Vector3.new(-1.9099999666214, 94.620002746582, 14.35000038147)
	WedgePart64.Position = Vector3.new(18.801082611084, 16.906240463257, 28.900177001953)
	WedgePart64.Rotation = Vector3.new(-157.55999755859, 85, 171.99000549316)
	WedgePart64.Color = Color3.new(1, 1, 1)
	WedgePart64.Size = Vector3.new(0.19276034832001, 0.0863406509161, 0.078309148550034)
	WedgePart64.Anchored = true
	WedgePart64.BottomSurface = Enum.SurfaceType.Smooth
	WedgePart64.BrickColor = BrickColor.new("Institutional white")
	WedgePart64.CanCollide = false
	WedgePart64.Locked = false
	WedgePart64.Material = Enum.Material.Neon
	WedgePart64.brickColor = BrickColor.new("Institutional white")
	WedgePart65.Parent = NeonParts
	WedgePart65.CFrame = CFrame.new(20.163414, 17.4725933, 28.6751709, -0.0381959155, 0.0783617795, -0.996193051, -0.664191544, -0.746821284, -0.0332795382, -0.746586025, 0.660391808, 0.0805727616)
	WedgePart65.Orientation = Vector3.new(1.9099999666214, -85.379997253418, -138.35000610352)
	WedgePart65.Position = Vector3.new(20.163414001465, 17.472593307495, 28.675170898438)
	WedgePart65.Rotation = Vector3.new(22.440000534058, -85, -115.98999786377)
	WedgePart65.Color = Color3.new(1, 1, 1)
	WedgePart65.Size = Vector3.new(0.19276034832001, 0.0863406509161, 0.078309148550034)
	WedgePart65.Anchored = true
	WedgePart65.BottomSurface = Enum.SurfaceType.Smooth
	WedgePart65.BrickColor = BrickColor.new("Institutional white")
	WedgePart65.CanCollide = false
	WedgePart65.Locked = false
	WedgePart65.Material = Enum.Material.Neon
	WedgePart65.brickColor = BrickColor.new("Institutional white")
	WedgePart66.Parent = NeonParts
	WedgePart66.CFrame = CFrame.new(20.2238159, 16.9109898, 28.7482929, 0.70479542, 0.344879448, -0.619936824, 0.683818281, -0.0976702347, 0.72308594, 0.188828081, -0.933551669, -0.30467242)
	WedgePart66.Orientation = Vector3.new(-46.310001373291, -116.16999816895, 98.129997253418)
	WedgePart66.Position = Vector3.new(20.223815917969, 16.910989761353, 28.748292922974)
	WedgePart66.Rotation = Vector3.new(-112.84999847412, -38.310001373291, -26.069999694824)
	WedgePart66.Color = Color3.new(1, 1, 1)
	WedgePart66.Size = Vector3.new(0.012047520838678, 0.093970663845539, 0.068670868873596)
	WedgePart66.Anchored = true
	WedgePart66.BottomSurface = Enum.SurfaceType.Smooth
	WedgePart66.BrickColor = BrickColor.new("Institutional white")
	WedgePart66.CanCollide = false
	WedgePart66.Locked = false
	WedgePart66.Material = Enum.Material.Neon
	WedgePart66.brickColor = BrickColor.new("Institutional white")
	WedgePart67.Parent = NeonParts
	WedgePart67.CFrame = CFrame.new(18.7761135, 17.1329746, 28.6850872, -0.0500194766, 0.0713970661, 0.996193051, 0.975189865, 0.218854606, 0.0332796015, -0.215645358, 0.973141968, -0.0805726871)
	WedgePart67.Orientation = Vector3.new(-1.9099999666214, 94.620002746582, 77.349998474121)
	WedgePart67.Position = Vector3.new(18.776113510132, 17.132974624634, 28.685087203979)
	WedgePart67.Rotation = Vector3.new(-157.55999755859, 85, -125.01000213623)
	WedgePart67.Color = Color3.new(1, 1, 1)
	WedgePart67.Size = Vector3.new(0.19276034832001, 0.0863406509161, 0.078309148550034)
	WedgePart67.Anchored = true
	WedgePart67.BottomSurface = Enum.SurfaceType.Smooth
	WedgePart67.BrickColor = BrickColor.new("Institutional white")
	WedgePart67.CanCollide = false
	WedgePart67.Locked = false
	WedgePart67.Material = Enum.Material.Neon
	WedgePart67.brickColor = BrickColor.new("Institutional white")
	WedgePart68.Parent = NeonParts
	WedgePart68.CFrame = CFrame.new(18.7713718, 17.295351, 28.6935921, -0.00610283948, 0.0869611427, 0.996193051, 0.948619366, -0.314664572, 0.0332795531, 0.316360652, 0.945211112, -0.0805726722)
	WedgePart68.Orientation = Vector3.new(-1.9099999666214, 94.620002746582, 108.34999847412)
	WedgePart68.Position = Vector3.new(18.771371841431, 17.295351028442, 28.693592071533)
	WedgePart68.Rotation = Vector3.new(-157.55999755859, 85, -94.01000213623)
	WedgePart68.Color = Color3.new(1, 1, 1)
	WedgePart68.Size = Vector3.new(0.19276034832001, 0.0863406509161, 0.078309148550034)
	WedgePart68.Anchored = true
	WedgePart68.BottomSurface = Enum.SurfaceType.Smooth
	WedgePart68.BrickColor = BrickColor.new("Institutional white")
	WedgePart68.CanCollide = false
	WedgePart68.Locked = false
	WedgePart68.Material = Enum.Material.Neon
	WedgePart68.brickColor = BrickColor.new("Institutional white")
	WedgePart69.Parent = NeonParts
	WedgePart69.CFrame = CFrame.new(18.8201008, 16.9493332, 29.1530933, -0.0487300679, -0.0722834095, 0.996193051, -0.553789735, 0.831991374, 0.0332796425, -0.831229508, -0.550059736, -0.0805727988)
	WedgePart69.Orientation = Vector3.new(-1.9099999666214, 94.620002746582, -33.650001525879)
	WedgePart69.Position = Vector3.new(18.820100784302, 16.949333190918, 29.153093338013)
	WedgePart69.Rotation = Vector3.new(-157.55999755859, 85, 123.98999786377)
	WedgePart69.Color = Color3.new(1, 1, 1)
	WedgePart69.Size = Vector3.new(0.19276034832001, 0.0863406509161, 0.078309148550034)
	WedgePart69.Anchored = true
	WedgePart69.BottomSurface = Enum.SurfaceType.Smooth
	WedgePart69.BrickColor = BrickColor.new("Institutional white")
	WedgePart69.CanCollide = false
	WedgePart69.Locked = false
	WedgePart69.Material = Enum.Material.Neon
	WedgePart69.brickColor = BrickColor.new("Institutional white")
	WedgePart70.Parent = NeonParts
	WedgePart70.CFrame = CFrame.new(19.5775242, 16.2775917, 26.9895821, -0.652214706, -0.753437638, 0.083353132, 0.747651875, -0.657517552, -0.0932064429, 0.125031397, 0.00152851187, 0.992151678)
	WedgePart70.Orientation = Vector3.new(5.3499999046326, 4.8000001907349, 131.33000183105)
	WedgePart70.Position = Vector3.new(19.577524185181, 16.277591705322, 26.989582061768)
	WedgePart70.Rotation = Vector3.new(5.3699998855591, 4.7800002098083, 130.88000488281)
	WedgePart70.Color = Color3.new(1, 1, 1)
	WedgePart70.Size = Vector3.new(0.010039600543678, 0.071473032236099, 0.11447283625603)
	WedgePart70.Anchored = true
	WedgePart70.BottomSurface = Enum.SurfaceType.Smooth
	WedgePart70.BrickColor = BrickColor.new("Institutional white")
	WedgePart70.CanCollide = false
	WedgePart70.Locked = false
	WedgePart70.Material = Enum.Material.Neon
	WedgePart70.brickColor = BrickColor.new("Institutional white")
	WedgePart71.Parent = NeonParts
	WedgePart71.CFrame = CFrame.new(18.7741966, 17.430378, 28.784277, 0.0395575687, 0.0776832923, 0.996193051, 0.651057243, -0.758298755, 0.0332796052, 0.757997274, 0.647262156, -0.0805727243)
	WedgePart71.Orientation = Vector3.new(-1.9099999666214, 94.620002746582, 139.35000610352)
	WedgePart71.Position = Vector3.new(18.774196624756, 17.430377960205, 28.78427696228)
	WedgePart71.Rotation = Vector3.new(-157.55999755859, 85, -63.009998321533)
	WedgePart71.Color = Color3.new(1, 1, 1)
	WedgePart71.Size = Vector3.new(0.19276034832001, 0.0863406509161, 0.078309148550034)
	WedgePart71.Anchored = true
	WedgePart71.BottomSurface = Enum.SurfaceType.Smooth
	WedgePart71.BrickColor = BrickColor.new("Institutional white")
	WedgePart71.CanCollide = false
	WedgePart71.Locked = false
	WedgePart71.Material = Enum.Material.Neon
	WedgePart71.brickColor = BrickColor.new("Institutional white")
	WedgePart72.Parent = NeonParts
	WedgePart72.CFrame = CFrame.new(19.2040005, 16.2153816, 27.5372543, 0.612803817, 0.0833631158, 0.785825789, 0.78990829, -0.0932139754, -0.606099069, 0.0227236301, 0.992150128, -0.122971095)
	WedgePart72.Orientation = Vector3.new(37.310001373291, 98.889999389648, 96.730003356934)
	WedgePart72.Position = Vector3.new(19.204000473022, 16.215381622314, 27.537254333496)
	WedgePart72.Rotation = Vector3.new(101.4700012207, 51.799999237061, -7.75)
	WedgePart72.Color = Color3.new(1, 1, 1)
	WedgePart72.Size = Vector3.new(0.010039600543678, 0.014073763042688, 0.071473032236099)
	WedgePart72.Anchored = true
	WedgePart72.BottomSurface = Enum.SurfaceType.Smooth
	WedgePart72.BrickColor = BrickColor.new("Institutional white")
	WedgePart72.CanCollide = false
	WedgePart72.Locked = false
	WedgePart72.Material = Enum.Material.Neon
	WedgePart72.brickColor = BrickColor.new("Institutional white")
	WedgePart73.Parent = NeonParts
	WedgePart73.CFrame = CFrame.new(20.1863289, 17.5304966, 28.982439, -0.0871212631, 0.00306334137, -0.996193051, 0.347589016, -0.937056243, -0.0332796164, -0.93359077, -0.349165142, 0.0805727467)
	WedgePart73.Orientation = Vector3.new(1.9099999666214, -85.379997253418, 159.64999389648)
	WedgePart73.Position = Vector3.new(20.186328887939, 17.53049659729, 28.982439041138)
	WedgePart73.Rotation = Vector3.new(22.440000534058, -85, -177.99000549316)
	WedgePart73.Color = Color3.new(1, 1, 1)
	WedgePart73.Size = Vector3.new(0.19276034832001, 0.0863406509161, 0.078309148550034)
	WedgePart73.Anchored = true
	WedgePart73.BottomSurface = Enum.SurfaceType.Smooth
	WedgePart73.BrickColor = BrickColor.new("Institutional white")
	WedgePart73.CanCollide = false
	WedgePart73.Locked = false
	WedgePart73.Material = Enum.Material.Neon
	WedgePart73.brickColor = BrickColor.new("Institutional white")
	WedgePart74.Parent = NeonParts
	WedgePart74.CFrame = CFrame.new(20.1728058, 17.5442448, 28.8209133, -0.0730998293, 0.0474964604, -0.996193051, -0.18467699, -0.98223573, -0.0332795531, -0.980076969, 0.18154119, 0.080572769)
	WedgePart74.Orientation = Vector3.new(1.9099999666214, -85.379997253418, -169.35000610352)
	WedgePart74.Position = Vector3.new(20.172805786133, 17.544244766235, 28.820913314819)
	WedgePart74.Rotation = Vector3.new(22.440000534058, -85, -146.99000549316)
	WedgePart74.Color = Color3.new(1, 1, 1)
	WedgePart74.Size = Vector3.new(0.19276034832001, 0.0863406509161, 0.078309148550034)
	WedgePart74.Anchored = true
	WedgePart74.BottomSurface = Enum.SurfaceType.Smooth
	WedgePart74.BrickColor = BrickColor.new("Institutional white")
	WedgePart74.CanCollide = false
	WedgePart74.Locked = false
	WedgePart74.Material = Enum.Material.Neon
	WedgePart74.brickColor = BrickColor.new("Institutional white")
	WedgePart75.Parent = NeonParts
	WedgePart75.CFrame = CFrame.new(18.7973747, 17.4828987, 29.0924892, 0.0871613696, 0.00154235598, 0.996193051, -0.363889873, -0.930847287, 0.0332795344, 0.927354813, -0.365405232, -0.0805726871)
	WedgePart75.Orientation = Vector3.new(-1.9099999666214, 94.620002746582, -158.64999389648)
	WedgePart75.Position = Vector3.new(18.797374725342, 17.482898712158, 29.092489242554)
	WedgePart75.Rotation = Vector3.new(-157.55999755859, 85, -1.0099999904633)
	WedgePart75.Color = Color3.new(1, 1, 1)
	WedgePart75.Size = Vector3.new(0.19276034832001, 0.0863406509161, 0.078309148550034)
	WedgePart75.Anchored = true
	WedgePart75.BottomSurface = Enum.SurfaceType.Smooth
	WedgePart75.BrickColor = BrickColor.new("Institutional white")
	WedgePart75.CanCollide = false
	WedgePart75.Locked = false
	WedgePart75.Material = Enum.Material.Neon
	WedgePart75.brickColor = BrickColor.new("Institutional white")
	WedgePart76.Parent = NeonParts
	WedgePart76.CFrame = CFrame.new(20.2001209, 17.4352722, 29.1136055, -0.0762555003, -0.0422445945, -0.996193051, 0.780558407, -0.62419641, -0.0332796462, -0.620414138, -0.780124605, 0.0805727765)
	WedgePart76.Orientation = Vector3.new(1.9099999666214, -85.379997253418, 128.64999389648)
	WedgePart76.Position = Vector3.new(20.200120925903, 17.435272216797, 29.113605499268)
	WedgePart76.Rotation = Vector3.new(22.440000534058, -85, 151.00999450684)
	WedgePart76.Color = Color3.new(1, 1, 1)
	WedgePart76.Size = Vector3.new(0.19276034832001, 0.0863406509161, 0.078309148550034)
	WedgePart76.Anchored = true
	WedgePart76.BottomSurface = Enum.SurfaceType.Smooth
	WedgePart76.BrickColor = BrickColor.new("Institutional white")
	WedgePart76.CanCollide = false
	WedgePart76.Locked = false
	WedgePart76.Material = Enum.Material.Neon
	WedgePart76.brickColor = BrickColor.new("Institutional white")
	WedgePart77.Parent = NeonParts
	WedgePart77.CFrame = CFrame.new(18.7837753, 17.4994717, 28.9312344, 0.073917523, 0.0462134778, 0.996193051, 0.167506799, -0.985309064, 0.0332795717, 0.983096063, 0.164409131, -0.0805726722)
	WedgePart77.Orientation = Vector3.new(-1.9099999666214, 94.620002746582, 170.35000610352)
	WedgePart77.Position = Vector3.new(18.78377532959, 17.499471664429, 28.931234359741)
	WedgePart77.Rotation = Vector3.new(-157.55999755859, 85, -32.009998321533)
	WedgePart77.Color = Color3.new(1, 1, 1)
	WedgePart77.Size = Vector3.new(0.19276034832001, 0.0863406509161, 0.078309148550034)
	WedgePart77.Anchored = true
	WedgePart77.BottomSurface = Enum.SurfaceType.Smooth
	WedgePart77.BrickColor = BrickColor.new("Institutional white")
	WedgePart77.CanCollide = false
	WedgePart77.Locked = false
	WedgePart77.Material = Enum.Material.Neon
	WedgePart77.brickColor = BrickColor.new("Institutional white")
	WedgePart78.Parent = NeonParts
	WedgePart78.CFrame = CFrame.new(20.1608334, 17.3360119, 28.5868397, 0.0076195579, 0.0868414789, -0.996193051, -0.953966498, -0.298061103, -0.0332795642, -0.29981643, 0.950588346, 0.0805727765)
	WedgePart78.Orientation = Vector3.new(1.9099999666214, -85.379997253418, -107.34999847412)
	WedgePart78.Position = Vector3.new(20.160833358765, 17.336011886597, 28.586839675903)
	WedgePart78.Rotation = Vector3.new(22.440000534058, -85, -84.98999786377)
	WedgePart78.Color = Color3.new(1, 1, 1)
	WedgePart78.Size = Vector3.new(0.19276034832001, 0.0863406509161, 0.078309148550034)
	WedgePart78.Anchored = true
	WedgePart78.BottomSurface = Enum.SurfaceType.Smooth
	WedgePart78.BrickColor = BrickColor.new("Institutional white")
	WedgePart78.CanCollide = false
	WedgePart78.Locked = false
	WedgePart78.Material = Enum.Material.Neon
	WedgePart78.brickColor = BrickColor.new("Institutional white")
	WedgePart79.Parent = NeonParts
	WedgePart79.CFrame = CFrame.new(18.821043, 17.2347965, 29.2827072, 0.0422824882, -0.0762343556, 0.996193051, -0.992724121, -0.115721293, 0.0332796015, 0.112743683, -0.990352035, -0.0805726573)
	WedgePart79.Orientation = Vector3.new(-1.9099999666214, 94.620002746582, -96.650001525879)
	WedgePart79.Position = Vector3.new(18.821043014526, 17.234796524048, 29.282707214355)
	WedgePart79.Rotation = Vector3.new(-157.55999755859, 85, 60.990001678467)
	WedgePart79.Color = Color3.new(1, 1, 1)
	WedgePart79.Size = Vector3.new(0.19276034832001, 0.0863406509161, 0.078309148550034)
	WedgePart79.Anchored = true
	WedgePart79.BottomSurface = Enum.SurfaceType.Smooth
	WedgePart79.BrickColor = BrickColor.new("Institutional white")
	WedgePart79.CanCollide = false
	WedgePart79.Locked = false
	WedgePart79.Material = Enum.Material.Neon
	WedgePart79.brickColor = BrickColor.new("Institutional white")
	WedgePart80.Parent = NeonParts
	WedgePart80.CFrame = CFrame.new(18.8243561, 17.0741558, 29.2573299, -0.00302052894, -0.0871226564, 0.996193051, -0.910531104, 0.412099183, 0.0332795791, -0.413429737, -0.906964183, -0.0805726349)
	WedgePart80.Orientation = Vector3.new(-1.9099999666214, 94.620002746582, -65.650001525879)
	WedgePart80.Position = Vector3.new(18.824356079102, 17.074155807495, 29.257329940796)
	WedgePart80.Rotation = Vector3.new(-157.55999755859, 85, 91.98999786377)
	WedgePart80.Color = Color3.new(1, 1, 1)
	WedgePart80.Size = Vector3.new(0.19276034832001, 0.0863406509161, 0.078309148550034)
	WedgePart80.Anchored = true
	WedgePart80.BottomSurface = Enum.SurfaceType.Smooth
	WedgePart80.BrickColor = BrickColor.new("Institutional white")
	WedgePart80.CanCollide = false
	WedgePart80.Locked = false
	WedgePart80.Material = Enum.Material.Neon
	WedgePart80.brickColor = BrickColor.new("Institutional white")
	WedgePart81.Parent = NeonParts
	WedgePart81.CFrame = CFrame.new(19.6207047, 16.2293015, 27.5035496, 0.652214646, 0.0833511353, -0.753437936, -0.747651875, -0.0932081267, -0.657517314, -0.125031352, 0.992151678, 0.00152593176)
	WedgePart81.Orientation = Vector3.new(41.110000610352, -89.879997253418, -97.110000610352)
	WedgePart81.Position = Vector3.new(19.620704650879, 16.229301452637, 27.503549575806)
	WedgePart81.Rotation = Vector3.new(89.870002746582, -48.889999389648, -7.2800002098083)
	WedgePart81.Color = Color3.new(1, 1, 1)
	WedgePart81.Size = Vector3.new(0.010039600543678, 0.014076827093959, 0.071473032236099)
	WedgePart81.Anchored = true
	WedgePart81.BottomSurface = Enum.SurfaceType.Smooth
	WedgePart81.BrickColor = BrickColor.new("Institutional white")
	WedgePart81.CanCollide = false
	WedgePart81.Locked = false
	WedgePart81.Material = Enum.Material.Neon
	WedgePart81.brickColor = BrickColor.new("Institutional white")
	WedgePart82.Parent = NeonParts
	WedgePart82.CFrame = CFrame.new(18.8111, 17.3853874, 29.2219753, 0.0755064562, -0.0435689278, 0.996193051, -0.791332841, -0.610479176, 0.0332795084, 0.606705129, -0.790833175, -0.0805726424)
	WedgePart82.Orientation = Vector3.new(-1.9099999666214, 94.620002746582, -127.65000152588)
	WedgePart82.Position = Vector3.new(18.811100006104, 17.385387420654, 29.221975326538)
	WedgePart82.Rotation = Vector3.new(-157.55999755859, 85, 29.989999771118)
	WedgePart82.Color = Color3.new(1, 1, 1)
	WedgePart82.Size = Vector3.new(0.19276034832001, 0.0863406509161, 0.078309148550034)
	WedgePart82.Anchored = true
	WedgePart82.BottomSurface = Enum.SurfaceType.Smooth
	WedgePart82.BrickColor = BrickColor.new("Institutional white")
	WedgePart82.CanCollide = false
	WedgePart82.Locked = false
	WedgePart82.Material = Enum.Material.Neon
	WedgePart82.brickColor = BrickColor.new("Institutional white")
	WedgePart83.Parent = NeonParts
	WedgePart83.CFrame = CFrame.new(19.1608181, 16.2636719, 27.023283, -0.612803698, 0.785826981, 0.0833532587, -0.789908528, -0.606100082, -0.0932063013, -0.0227236077, -0.122958601, 0.992151678)
	WedgePart83.Orientation = Vector3.new(5.3499999046326, 4.8000001907349, -127.5)
	WedgePart83.Position = Vector3.new(19.160818099976, 16.263671875, 27.023283004761)
	WedgePart83.Rotation = Vector3.new(5.3699998855591, 4.7800002098083, -127.94999694824)
	WedgePart83.Color = Color3.new(1, 1, 1)
	WedgePart83.Size = Vector3.new(0.010039600543678, 0.071473032236099, 0.11446976661682)
	WedgePart83.Anchored = true
	WedgePart83.BottomSurface = Enum.SurfaceType.Smooth
	WedgePart83.BrickColor = BrickColor.new("Institutional white")
	WedgePart83.CanCollide = false
	WedgePart83.Locked = false
	WedgePart83.Material = Enum.Material.Neon
	WedgePart83.brickColor = BrickColor.new("Institutional white")
	WedgePart84.Parent = NeonParts
	WedgePart84.CFrame = CFrame.new(20.1882267, 16.9325409, 28.803112, -0.704806209, -0.344856858, -0.619937181, -0.6838153, 0.0976912081, 0.72308594, -0.188798696, 0.933557868, -0.304671764)
	WedgePart84.Orientation = Vector3.new(-46.310001373291, -116.16999816895, -81.870002746582)
	WedgePart84.Position = Vector3.new(20.188226699829, 16.932540893555, 28.803112030029)
	WedgePart84.Rotation = Vector3.new(-112.84999847412, -38.310001373291, 153.92999267578)
	WedgePart84.Color = Color3.new(1, 1, 1)
	WedgePart84.Size = Vector3.new(0.012047520838678, 0.037146523594856, 0.11043561249971)
	WedgePart84.Anchored = true
	WedgePart84.BottomSurface = Enum.SurfaceType.Smooth
	WedgePart84.BrickColor = BrickColor.new("Institutional white")
	WedgePart84.CanCollide = false
	WedgePart84.Locked = false
	WedgePart84.Material = Enum.Material.Neon
	WedgePart84.brickColor = BrickColor.new("Institutional white")
	WedgePart85.Parent = NeonParts
	WedgePart85.CFrame = CFrame.new(20.2137947, 17.1247158, 29.1543713, 0.00149967743, -0.0871622041, -0.996193051, 0.917584419, 0.396145493, -0.033279527, 0.397538096, -0.914041281, 0.0805727765)
	WedgePart85.Orientation = Vector3.new(1.9099999666214, -85.379997253418, 66.650001525879)
	WedgePart85.Position = Vector3.new(20.213794708252, 17.124715805054, 29.154371261597)
	WedgePart85.Rotation = Vector3.new(22.440000534058, -85, 89.01000213623)
	WedgePart85.Color = Color3.new(1, 1, 1)
	WedgePart85.Size = Vector3.new(0.19276034832001, 0.0863406509161, 0.078309148550034)
	WedgePart85.Anchored = true
	WedgePart85.BottomSurface = Enum.SurfaceType.Smooth
	WedgePart85.BrickColor = BrickColor.new("Institutional white")
	WedgePart85.CanCollide = false
	WedgePart85.Locked = false
	WedgePart85.Material = Enum.Material.Neon
	WedgePart85.brickColor = BrickColor.new("Institutional white")
	WedgePart86.Parent = NeonParts
	WedgePart86.CFrame = CFrame.new(20.2102375, 17.2857742, 29.1769524, -0.0436064638, -0.0754849315, -0.996193051, 0.990553379, -0.13302888, -0.0332795419, -0.130010352, -0.988233447, 0.0805727616)
	WedgePart86.Orientation = Vector3.new(1.9099999666214, -85.379997253418, 97.650001525879)
	WedgePart86.Position = Vector3.new(20.210237503052, 17.285774230957, 29.176952362061)
	WedgePart86.Rotation = Vector3.new(22.440000534058, -85, 120.01000213623)
	WedgePart86.Color = Color3.new(1, 1, 1)
	WedgePart86.Size = Vector3.new(0.19276034832001, 0.0863406509161, 0.078309148550034)
	WedgePart86.Anchored = true
	WedgePart86.BottomSurface = Enum.SurfaceType.Smooth
	WedgePart86.BrickColor = BrickColor.new("Institutional white")
	WedgePart86.CanCollide = false
	WedgePart86.Locked = false
	WedgePart86.Material = Enum.Material.Neon
	WedgePart86.brickColor = BrickColor.new("Institutional white")
	WedgePart87.Parent = NeonParts
	WedgePart87.CFrame = CFrame.new(20.2097721, 16.9980984, 29.0523167, 0.046177648, -0.0739400163, -0.996193051, 0.582488894, 0.812157094, -0.033279635, 0.811525881, -0.578734636, 0.0805727392)
	WedgePart87.Orientation = Vector3.new(1.9099999666214, -85.379997253418, 35.650001525879)
	WedgePart87.Position = Vector3.new(20.209772109985, 16.998098373413, 29.052316665649)
	WedgePart87.Rotation = Vector3.new(22.440000534058, -85, 58.009998321533)
	WedgePart87.Color = Color3.new(1, 1, 1)
	WedgePart87.Size = Vector3.new(0.19276034832001, 0.0863406509161, 0.078309148550034)
	WedgePart87.Anchored = true
	WedgePart87.BottomSurface = Enum.SurfaceType.Smooth
	WedgePart87.BrickColor = BrickColor.new("Institutional white")
	WedgePart87.CanCollide = false
	WedgePart87.Locked = false
	WedgePart87.Material = Enum.Material.Neon
	WedgePart87.brickColor = BrickColor.new("Institutional white")
	WedgePart88.Parent = NeonParts
	WedgePart88.CFrame = CFrame.new(20.1455669, 16.9822941, 28.7821445, 0.704806209, -0.344856858, 0.619937181, 0.6838153, 0.0976912081, -0.72308594, 0.188798696, 0.933557868, 0.304671764)
	WedgePart88.Orientation = Vector3.new(46.310001373291, 63.830001831055, 81.870002746582)
	WedgePart88.Position = Vector3.new(20.145566940308, 16.982294082642, 28.782144546509)
	WedgePart88.Rotation = Vector3.new(67.150001525879, 38.310001373291, 26.069999694824)
	WedgePart88.Color = Color3.new(1, 1, 1)
	WedgePart88.Size = Vector3.new(0.012047520838678, 0.037146523594856, 0.027106922119856)
	WedgePart88.Anchored = true
	WedgePart88.BottomSurface = Enum.SurfaceType.Smooth
	WedgePart88.BrickColor = BrickColor.new("Institutional white")
	WedgePart88.CanCollide = false
	WedgePart88.Locked = false
	WedgePart88.Material = Enum.Material.Neon
	WedgePart88.brickColor = BrickColor.new("Institutional white")
	WedgePart89.Parent = NeonParts
	WedgePart89.CFrame = CFrame.new(20.1658039, 17.1735134, 28.5811672, 0.0512577705, 0.0705134124, -0.996193051, -0.971222103, 0.235839382, -0.0332795307, 0.232594892, 0.969230473, 0.0805727839)
	WedgePart89.Orientation = Vector3.new(1.9099999666214, -85.379997253418, -76.349998474121)
	WedgePart89.Position = Vector3.new(20.165803909302, 17.173513412476, 28.581167221069)
	WedgePart89.Rotation = Vector3.new(22.440000534058, -85, -53.990001678467)
	WedgePart89.Color = Color3.new(1, 1, 1)
	WedgePart89.Size = Vector3.new(0.19276034832001, 0.0863406509161, 0.078309148550034)
	WedgePart89.Anchored = true
	WedgePart89.BottomSurface = Enum.SurfaceType.Smooth
	WedgePart89.BrickColor = BrickColor.new("Institutional white")
	WedgePart89.CanCollide = false
	WedgePart89.Locked = false
	WedgePart89.Material = Enum.Material.Neon
	WedgePart89.brickColor = BrickColor.new("Institutional white")
	WedgePart90.Parent = NeonParts
	WedgePart90.CFrame = CFrame.new(20.1993122, 16.9420948, 28.8999443, 0.0783433318, -0.0382337607, -0.996193051, 0.0635954812, 0.997420788, -0.0332795605, 0.994895995, -0.0607461371, 0.0805727467)
	WedgePart90.Orientation = Vector3.new(1.9099999666214, -85.379997253418, 3.6500000953674)
	WedgePart90.Position = Vector3.new(20.199312210083, 16.942094802856, 28.89994430542)
	WedgePart90.Rotation = Vector3.new(22.440000534058, -85, 26.010000228882)
	WedgePart90.Color = Color3.new(1, 1, 1)
	WedgePart90.Size = Vector3.new(0.19276034832001, 0.0863406509161, 0.078309148550034)
	WedgePart90.Anchored = true
	WedgePart90.BottomSurface = Enum.SurfaceType.Smooth
	WedgePart90.BrickColor = BrickColor.new("Institutional white")
	WedgePart90.CanCollide = false
	WedgePart90.Locked = false
	WedgePart90.Material = Enum.Material.Neon
	WedgePart90.brickColor = BrickColor.new("Institutional white")
	WedgePart91.Parent = NeonParts
	WedgePart91.CFrame = CFrame.new(20.1769066, 17.0315189, 28.6597652, 0.0808353573, 0.0326366425, -0.996193051, -0.698670328, 0.714669287, -0.0332795568, 0.710862458, 0.698700666, 0.0805728063)
	WedgePart91.Orientation = Vector3.new(1.9099999666214, -85.379997253418, -44.349998474121)
	WedgePart91.Position = Vector3.new(20.176906585693, 17.031518936157, 28.65976524353)
	WedgePart91.Rotation = Vector3.new(22.440000534058, -85, -21.989999771118)
	WedgePart91.Color = Color3.new(1, 1, 1)
	WedgePart91.Size = Vector3.new(0.19276034832001, 0.0863406509161, 0.078309148550034)
	WedgePart91.Anchored = true
	WedgePart91.BottomSurface = Enum.SurfaceType.Smooth
	WedgePart91.BrickColor = BrickColor.new("Institutional white")
	WedgePart91.CanCollide = false
	WedgePart91.Locked = false
	WedgePart91.Material = Enum.Material.Neon
	WedgePart91.brickColor = BrickColor.new("Institutional white")
	WedgePart92.Parent = NeonParts
	WedgePart92.CFrame = CFrame.new(20.1811619, 16.9607525, 28.7273254, -0.70479542, 0.344879448, 0.619936824, -0.683818281, -0.0976702347, -0.72308594, -0.188828081, -0.933551669, 0.30467242)
	WedgePart92.Orientation = Vector3.new(46.310001373291, 63.830001831055, -98.129997253418)
	WedgePart92.Position = Vector3.new(20.181161880493, 16.960752487183, 28.727325439453)
	WedgePart92.Rotation = Vector3.new(67.150001525879, 38.310001373291, -153.92999267578)
	WedgePart92.Color = Color3.new(1, 1, 1)
	WedgePart92.Size = Vector3.new(0.012047520838678, 0.093970663845539, 0.06907245516777)
	WedgePart92.Anchored = true
	WedgePart92.BottomSurface = Enum.SurfaceType.Smooth
	WedgePart92.BrickColor = BrickColor.new("Institutional white")
	WedgePart92.CanCollide = false
	WedgePart92.Locked = false
	WedgePart92.Material = Enum.Material.Neon
	WedgePart92.brickColor = BrickColor.new("Institutional white")

	for i, v in pairs(Gun:GetDescendants()) do
		if v:IsA("Part") or v:IsA("WedgePart") then
			local weld = Instance.new("Weld")
			weld.Parent = v
			weld.Part0 = v
			weld.Part1 = Gun
			weld.C0 = v.CFrame:Inverse()
			weld.C1 = Gun.CFrame:Inverse()

			v.Anchored = false
		end
	end

	Gun.Anchored = false

	Hole = IT("Part",Gun)
	Hole.Size = VT(0.05,0.05,0.05)
	Hole.Anchored = false
	Hole.CanCollide = false
	Hole.Transparency = 1

	CreateWeldOrSnapOrMotor("Weld", Hole, Hole, Gun, CF(-5, 5, 0.5)*ANGLES(RAD(0),RAD(0),RAD(0)), CF(0, 0, 0))

	GunGrip = CreateWeldOrSnapOrMotor("ManualWeld", Gun, RightArm, Gun, CF(0, -1.5, 0)*ANGLES(RAD(-90),RAD(0),RAD(0)), CF(-2, 0, 0)*ANGLES(RAD(90),RAD(225),RAD(90)))
	PlayerSize = 1
	FT,FRA,FLA,FRL,FLL = Instance.new("SpecialMesh"),Instance.new("SpecialMesh"),Instance.new("SpecialMesh"),Instance.new("SpecialMesh"),Instance.new("SpecialMesh")
	FT.MeshId,FT.Scale = "rbxasset://fonts/torso.mesh",Vector3.new(PlayerSize,PlayerSize,PlayerSize)
	FRA.MeshId,FRA.Scale = "rbxasset://fonts/rightarm.mesh",Vector3.new(PlayerSize,PlayerSize,PlayerSize)
	FLA.MeshId,FLA.Scale = "rbxasset://fonts/leftarm.mesh",Vector3.new(PlayerSize,PlayerSize,PlayerSize)
	FRL.MeshId,FRL.Scale = "rbxasset://fonts/rightleg.mesh",Vector3.new(PlayerSize,PlayerSize,PlayerSize)
	FLL.MeshId,FLL.Scale = "rbxasset://fonts/leftleg.mesh",Vector3.new(PlayerSize,PlayerSize,PlayerSize)

	-----------------------------------------------------------------------------------------------------------------------------

	if CannonAcc then
		local GunAthp = Instance.new("Attachment", Gun)
		local GunAtho = Instance.new("Attachment", Gun)

		GunAthp.Name = "Attachment1"
		GunAtho.Name = "Attachment2"

		GunAthp.Position = Vector3.new(-1.1, 0.3, 0)
		GunAtho.Rotation = Vector3.new(180, 180, 180)

		CannonAcc:FindFirstChildOfClass("AlignPosition").Attachment1 = GunAthp
		CannonAcc:FindFirstChildOfClass("AlignOrientation").Attachment1 = GunAtho

		Gun.Transparency = 1

		for _, v in pairs(GunAdditions:GetChildren()) do
			v.Transparency = 1
		end

		for _, v in pairs(NeonParts:GetChildren()) do
			v.Transparency = 1
		end
	end

	-----------------------------------------------------------------------------------------------------------------------------

	GroundMababjin = Instance.new("Part", m)
	GroundMababjin.Anchored = true
	GroundMababjin.Transparency = 1

	-----------------------------------------------------------------------------------------------------------------------------


	if MPAAuraAcc then
		local MPAAuraAccAthp = Instance.new("Attachment",GroundMababjin)
		local MPAAuraAccAtho = Instance.new("Attachment",GroundMababjin)

		MPAAuraAccAthp.Name = "Attachment1"
		MPAAuraAccAtho.Name = "Attachment2"

		MPAAuraAccAthp.Position = Vector3.new(0, 0, 0)
		MPAAuraAccAtho.Rotation = Vector3.new(0, 0, 0)

		MPAAuraAcc:FindFirstChildOfClass("AlignPosition").Attachment1 = MPAAuraAccAthp
		MPAAuraAcc:FindFirstChildOfClass("AlignOrientation").Attachment1 = MPAAuraAccAtho
	end

	-----------------------------------------------------------------------------------------------------------------------------

	WingFolder = Instance.new("Folder")
	WingFolder.Parent = game.Players.LocalPlayer.Character
	WingFolder.Name = "efEfeeEcFfEfeeEFeCstSfEefEfeeEcFfEfeeEFeCstSfEefEfeeEcFfEfeeEFeCstSfE"

	LWing = Instance.new("Part")
	LWing.Name = "LWing"
	LWing.Parent = WingFolder
	LWing.FrontParamA = -0.5
	LWing.FrontParamB = 0.5
	LWing.BackParamA = -0.5
	LWing.BackParamB = 0.5
	LWing.LeftParamA = -0.5
	LWing.LeftParamB = 0.5
	LWing.RightParamA = -0.5
	LWing.RightParamB = 0.5
	LWing.BrickColor = BrickColor.new("Really black")
	LWing.CanCollide = true
	LWing.Shape = Enum.PartType.Block
	LWing.Size = Vector3.new(4, 1, 2)
	LWing.Material = Enum.Material.Neon

	LWingMesh = Instance.new("SpecialMesh")
	LWingMesh.Parent = LWing
	LWingMesh.MeshId = "rbxassetid://1553468234"
	LWingMesh.MeshType = Enum.MeshType.FileMesh
	LWingMesh.Offset = Vector3.new(0, 0, 0)
	LWingMesh.Scale = Vector3.new(0.048, 0.048, 0.048)
	LWingMesh.VertexColor = Vector3.new("VertexColor")

	LWingWeld = CreateWeldOrSnapOrMotor("Weld", LWing, Torso, LWing, CF(0, 0, 0)*ANGLES(RAD(0),RAD(0),RAD(0)), CF(0, 0, 0))

	RWing = Instance.new("Part")
	RWing.Name = "RWing"
	RWing.Parent = WingFolder
	RWing.FrontParamA = -0.5
	RWing.FrontParamB = 0.5
	RWing.BackParamA = -0.5
	RWing.BackParamB = 0.5
	RWing.LeftParamA = -0.5
	RWing.LeftParamB = 0.5
	RWing.RightParamA = -0.5
	RWing.RightParamB = 0.5
	RWing.BrickColor = BrickColor.new("Really black")
	RWing.CanCollide = true
	RWing.Shape = Enum.PartType.Block
	RWing.Size = Vector3.new(4, 1, 2)
	RWing.Material = Enum.Material.Neon

	RWingMesh = Instance.new("SpecialMesh")
	RWingMesh.Parent = RWing
	RWingMesh.MeshId = "rbxassetid://1553468709"
	RWingMesh.MeshType = Enum.MeshType.FileMesh
	RWingMesh.Offset = Vector3.new(0, 0, 0)
	RWingMesh.Scale = Vector3.new(0.048, 0.048, 0.048)
	RWingMesh.VertexColor = Vector3.new("VertexColor")

	RWingWeld = CreateWeldOrSnapOrMotor("Weld", RWing, Torso, RWing, CF(0, 0, 0)*ANGLES(RAD(0),RAD(0),RAD(0)), CF(0, 0, 0))

	-----------------------------------------------------------------------------------------------------------------------------

	if MPAWingAcc1 then
		local MPAWingAccAthp1 = Instance.new("Attachment", LWing)
		local MPAWingAccAtho1 = Instance.new("Attachment", LWing)

		MPAWingAccAthp1.Name = "Attachment1"
		MPAWingAccAtho1.Name = "Attachment2"

		MPAWingAccAthp1.Position = Vector3.new(0.5, 1.5, -0.3)
		MPAWingAccAtho1.Rotation = Vector3.new(0, -70, 0)

		MPAWingAcc1:FindFirstChildOfClass("AlignPosition").Attachment1 = MPAWingAccAthp1
		MPAWingAcc1:FindFirstChildOfClass("AlignOrientation").Attachment1 = MPAWingAccAtho1

		LWing.Transparency = 1
	end

	if MPAWingAcc2 then
		local MPAWingAccAthp2 = Instance.new("Attachment", RWing)
		local MPAWingAccAtho2 = Instance.new("Attachment", RWing)

		MPAWingAccAthp2.Name = "Attachment1"
		MPAWingAccAtho2.Name = "Attachment2"

		MPAWingAccAthp2.Position = Vector3.new(0.5, 1.5, 0.3)
		MPAWingAccAtho2.Rotation = Vector3.new(0, -110, 0)

		MPAWingAcc2:FindFirstChildOfClass("AlignPosition").Attachment1 = MPAWingAccAthp2
		MPAWingAcc2:FindFirstChildOfClass("AlignOrientation").Attachment1 = MPAWingAccAtho2

		RWing.Transparency = 1
	end

	-----------------------------------------------------------------------------------------------------------------------------

	pcall(function()
		if workspace[Player.Name]["Right Arm"] and workspace[Player.Name]["Left Leg"] then
			workspace[Player.Name]["Right Arm"].Material = Enum.Material.ForceField
			workspace[Player.Name]["Left Leg"].Material = Enum.Material.ForceField

			workspace[Player.Name]["Right Arm"].BrickColor = BrickColor.new("White")
			workspace[Player.Name]["Left Leg"].BrickColor = BrickColor.new("White")
		end
	end)
	-----------------------------------------------------------------------------------------------------------------------------
end

GenerateStuffs()

local halocolor = BrickColor.new("White")
local halocolor2 = BrickColor.new("White")
local starcolor = BrickColor.new("White")
local lunacolor = BrickColor.new("White")
local lunacolor2 = BrickColor.new("White")
local wepcolor = BrickColor.new("White")
local maincolor = BrickColor.new("White")

function GenerateGlove()
	local function CreateParta(parent,transparency,reflectance,material,brickcolor)
		local p = Instance.new("Part")
		p.TopSurface = 0
		p.BottomSurface = 0
		p.Parent = parent
		p.Size = Vector3.new(0.1,0.1,0.1)
		p.Transparency = transparency
		p.Reflectance = reflectance
		p.CanCollide = false
		p.Locked = true
		p.BrickColor = brickcolor
		p.Material = material
		return p
	end

	local function CreateMesh(parent,meshtype,x1,y1,z1)
		local mesh = Instance.new("SpecialMesh",parent)
		mesh.MeshType = meshtype
		mesh.Scale = Vector3.new(x1*10,y1*10,z1*10)
		return mesh
	end

	local function CreateWeld(parent,part0,part1,C1X,C1Y,C1Z,C1Xa,C1Ya,C1Za,C0X,C0Y,C0Z,C0Xa,C0Ya,C0Za)
		local weld = Instance.new("Weld")
		weld.Parent = parent
		weld.Part0 = part0
		weld.Part1 = part1
		weld.C1 = CFrame.new(C1X,C1Y,C1Z)*CFrame.Angles(C1Xa,C1Ya,C1Za)
		weld.C0 = CFrame.new(C0X,C0Y,C0Z)*CFrame.Angles(C0Xa,C0Ya,C0Za)
		return weld
	end

	local function CreateSpecialMesh(parent,meshid,x1,y1,z1)
		local mesh = Instance.new("SpecialMesh",parent)
		mesh.MeshType = "FileMesh"
		mesh.MeshId = meshid
		mesh.Scale = Vector3.new(x1,y1,z1)
		return mesh
	end

	GloveFolder = Instance.new("Folder")
	GloveFolder.Parent = game.Players.LocalPlayer.Character
	GloveFolder.Name = "kgjkhbvKLJBJKYHVUILBklhvlukb"

	ran = CreateParta(GloveFolder,0,0,"Glass",wepcolor)
	CreateMesh(ran,"Wedge",1.02,1.02,1.02)
	CreateWeld(ran,LeftArm,ran,0,0.15,0,math.rad(0),math.rad(90),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))
	ran = CreateParta(GloveFolder,0,0,"Glass",wepcolor)
	CreateMesh(ran,"Wedge",0.9,0.9,1.025)
	CreateWeld(ran,LeftArm,ran,0,0.155,0,math.rad(0),math.rad(90),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))
	ran = CreateParta(GloveFolder,0,0,"Glass",wepcolor)
	CreateMesh(ran,"Wedge",1.025,0.9,0.9)
	CreateWeld(ran,LeftArm,ran,0,0.155,-0.025,math.rad(0),math.rad(90),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

	gan = CreateParta(GloveFolder,0,0,"Glass",wepcolor)
	CreateMesh(gan,"Brick",1.075,0.1,1.075)
	CreateWeld(gan,LeftArm,gan,0,0.5,0,math.rad(0),math.rad(0),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

	gan = CreateParta(GloveFolder,0,0,"Glass",wepcolor)
	CreateMesh(gan,"Brick",1.075,0.1,1.075)
	CreateWeld(gan,LeftArm,gan,0,0.75,0,math.rad(0),math.rad(0),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

	gan = CreateParta(GloveFolder,0,0,"Neon",halocolor2)
	CreateMesh(gan,"Brick",1.095,0.035,1.095)
	CreateWeld(gan,LeftArm,gan,0,0.5,0,math.rad(0),math.rad(0),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

	gan = CreateParta(GloveFolder,0,0,"Neon",halocolor2)
	CreateMesh(gan,"Brick",1.095,0.035,1.095)
	CreateWeld(gan,LeftArm,gan,0,0.75,0,math.rad(0),math.rad(0),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

	gane = CreateParta(GloveFolder,0,0,"Glass",lunacolor2)
	CreateMesh(gane,"Brick",1.0625,0.2,1.0625)
	CreateWeld(gane,LeftArm,gane,0,0.6,0,math.rad(0),math.rad(0),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

	star = CreateParta(GloveFolder,0,0,"Glass",wepcolor)
	CreateSpecialMesh(star,"http://www.roblox.com/asset/?id=45428961",2.5,2.5,2.5)
	CreateWeld(star,LeftArm,star,0,0.475,0.6,math.rad(90),math.rad(90),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))
	starl = CreateParta(GloveFolder,0,0,"SmoothPlastic",starcolor)
	CreateSpecialMesh(starl,"http://www.roblox.com/asset/?id=45428961",1.95,2.55,1.95)
	CreateWeld(starl,LeftArm,starl,0,0.475,0.6,math.rad(90),math.rad(90),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

	--- second ring

	ran = CreateParta(GloveFolder,0,0,"Glass",wepcolor)
	CreateMesh(ran,"Wedge",1.02,1.02,1.02)
	CreateWeld(ran,RightArm,ran,0,0.15,0,math.rad(0),math.rad(-90),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))
	ran = CreateParta(GloveFolder,0,0,"Glass",wepcolor)
	CreateMesh(ran,"Wedge",0.9,0.9,1.025)
	CreateWeld(ran,RightArm,ran,0,0.155,0,math.rad(0),math.rad(-90),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))
	ran = CreateParta(GloveFolder,0,0,"Glass",wepcolor)
	CreateMesh(ran,"Wedge",1.025,0.9,0.9)
	CreateWeld(ran,RightArm,ran,0,0.155,-0.025,math.rad(0),math.rad(-90),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

	gan = CreateParta(GloveFolder,0,0,"Glass",wepcolor)
	CreateMesh(gan,"Brick",1.075,0.1,1.075)
	CreateWeld(gan,RightArm,gan,0,0.5,0,math.rad(0),math.rad(0),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

	gan = CreateParta(GloveFolder,0,0,"Glass",wepcolor)
	CreateMesh(gan,"Brick",1.075,0.1,1.075)
	CreateWeld(gan,RightArm,gan,0,0.75,0,math.rad(0),math.rad(0),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

	gan = CreateParta(GloveFolder,0,0,"Neon",halocolor2)
	CreateMesh(gan,"Brick",1.095,0.035,1.095)
	CreateWeld(gan,RightArm,gan,0,0.5,0,math.rad(0),math.rad(0),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

	gan = CreateParta(GloveFolder,0,0,"Neon",halocolor2)
	CreateMesh(gan,"Brick",1.095,0.035,1.095)
	CreateWeld(gan,RightArm,gan,0,0.75,0,math.rad(0),math.rad(0),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

	gane = CreateParta(GloveFolder,0,0,"Glass",lunacolor2)
	CreateMesh(gane,"Brick",1.0625,0.2,1.0625)
	CreateWeld(gane,RightArm,gane,0,0.6,0,math.rad(0),math.rad(0),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))

	star = CreateParta(GloveFolder,0,0,"Glass",wepcolor)
	CreateSpecialMesh(star,"http://www.roblox.com/asset/?id=45428961",2.5,2.5,2.5)
	CreateWeld(star,RightArm,star,0,-0.475,0.6,math.rad(90),math.rad(90),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))
	starl = CreateParta(GloveFolder,0,0,"Glass",starcolor)
	CreateSpecialMesh(starl,"http://www.roblox.com/asset/?id=45428961",1.95,2.55,1.95)
	CreateWeld(starl,RightArm,starl,0,-0.475,0.6,math.rad(90),math.rad(90),math.rad(0),0,0,0,math.rad(0),math.rad(0),math.rad(0))
end

GenerateGlove()

-----------------------------------------------------------------------------------------------------------------------------

local OrbAccAthp = Instance.new("Attachment", RootPart)
local OrbAccAtho = Instance.new("Attachment", RootPart)

local MPASwordAthp1 = Instance.new("Attachment", RootPart)
local MPASwordAtho1 = Instance.new("Attachment", RootPart)

local MPASwordAthp2 = Instance.new("Attachment", RootPart)
local MPASwordAtho2 = Instance.new("Attachment", RootPart)

local MPASwordAthp3 = Instance.new("Attachment", RootPart)
local MPASwordAtho3 = Instance.new("Attachment", RootPart)

local MPASwordAthp4 = Instance.new("Attachment", RootPart)
local MPASwordAtho4 = Instance.new("Attachment", RootPart)

-----------------------------------------------------------------------------------------------------------------------------

MAINRUINCOLOR = BrickColor.new("Really red")
AUDIOBASEDCOLOR = Color3.new(255, 0, 0)
RAINBOWCOLOR = Color3.new(255, 0, 0)
LASTPART = playerss.Head

function GenerateGui()
	NameMode2 = Instance.new("BillboardGui", Head)
	NameMode2.AlwaysOnTop = true
	NameMode2.Size = UDim2.new(7, 35, 3, 15)
	NameMode2.StudsOffset = Vector3.new(0, 2, 0)
	NameMode2.MaxDistance = 10000
	NameMode2.Adornee = v727
	NameMode2.Name = "Name2"

	NameMode = Instance.new("TextLabel")
	NameMode.BackgroundTransparency = 1
	NameMode.TextScaled = true
	NameMode.BorderSizePixel = 0
	NameMode.Text = "HSC FE - InsAnIty"
	NameMode.Font = "Arial"
	NameMode.TextSize = 35
	NameMode.TextStrokeTransparency = 0
	NameMode.Size = UDim2.new(1, 0, 0.5, 0)
	NameMode.Parent = NameMode2
	NameMode.TextColor3 = Color3.fromRGB()
end

GenerateGui()

coroutine.resume(coroutine.create(function()
	while true do
		for i = 0, 1, 0.01 do
			RAINBOWCOLOR = Color3.fromHSV(i,1,1)
			Swait()
		end
	end
end))

-----------------------------------------------------------------------------------------------------------------------------

--//=================================\\
--||			DAMAGING
--\\=================================//

function Kill(dude)
	coroutine.resume(coroutine.create(function()
		if dude and dude.Name ~= Character.Name and dude.Name ~= Player.Name then
			local h = dude:FindFirstChildOfClass("Humanoid")
			local t = dude:FindFirstChild("Torso") or dude:FindFirstChild("UpperTorso") or dude:FindFirstChild("HumanoidRootPart")
			local deathp = Instance.new("Part",Effects) deathp.Anchored = true deathp.Size = Vector3.new() deathp.Transparency = 1 deathp.CanCollide = false deathp.CFrame = t.CFrame
			coroutine.wrap(function()
				deathp:Destroy()
			end)
			if h then
				if dude then
					CreateSound(206082273, deathp, 5, .75)
					ShakeCam(1,10)
					for i = 0, math.random(3,7) do
						WACKYEFFECT({Time = math.random(36.25,91.25), EffectType = "Sphere", Size = Vector3.new(2.5,2.5,2.5), Size2 = Vector3.new(1.25,20,1.25), Transparency = 0, Transparency2 = 1, CFrame = deathp.CFrame*CFrame.Angles(math.rad(math.random(0,360)),math.rad(math.random(0,360)),math.rad(math.random(0,360))), MoveToPos = nil, RotationX = nil, RotationY = nil, RotationZ = nil, Material = "Neon", Color = Color3.new(1,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 35})
					end
					WACKYEFFECT({Time = math.random(18,20.5), EffectType = "Sphere", Size = Vector3.new(2.5,2.5,2.5), Size2 = Vector3.new(10,10,10), Transparency = 0.6, Transparency2 = 1, CFrame = deathp.CFrame, MoveToPos = nil, RotationX = nil, RotationY = nil, RotationZ = nil, Material = "Neon", Color = Color3.new(1,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 35})
					for i = 0, math.random(5,9) do
						WACKYEFFECT({Time = math.random(9,10.25), EffectType = "Sphere", Size = Vector3.new(4.5,4.5,4.5), Size2 = Vector3.new(2,2,2), Transparency = 0, Transparency2 = 1, CFrame = deathp.CFrame, MoveToPos = deathp.CFrame*CFrame.new(math.random(-95,95),math.random(-95,95),math.random(-95,95)).p, RotationX = nil, RotationY = nil, RotationZ = nil, Material = "Neon", Color = Color3.new(1,0,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil, UseBoomerangMath = true, Boomerang = 45, SizeBoomerang = 40})
					end
				end
			end
		end
		DamageFling(dude)
	end))
end

function ApplyAoE(POSITION,RANGE)
	coroutine.resume(coroutine.create(function()
		for index, CHILD in pairs(workspace:GetDescendants()) do
			if CHILD.ClassName == "Model" and CHILD ~= Character then
				local HUM = CHILD:FindFirstChildOfClass("Humanoid")
				if HUM then
					local TORSO = CHILD:FindFirstChild("Torso") or CHILD:FindFirstChild("UpperTorso")
					if TORSO then
						if (TORSO.Position - POSITION).Magnitude <= RANGE then
							Kill(CHILD)
						end
					end
				end
			end
		end
	end))
end

function MDR(p289, p290)
	pcall(function()
		for v7859, v7860 in pairs(game:GetService("Workspace"):GetDescendants()) do
			local v7863 = v7860:IsDescendantOf(Character)
			local v7865 = v7860:IsA("Humanoid")
			v7865 = v7860.RootPart
			v7865 = v7860.RootPart.Position - p289.Magnitude
			local v7969 = p290 + v7860.RootPart.Size.Magnitude
			v7865 = Instance.new
			local v7871 = v7865("Part")
			v7871.Anchored = true
			v7871.Transparency = 1
			v7871.CanCollide = false
			v7871.CFrame = v7860.RootPart.CFrame
			CreateSound(206082273, Character, 5, 0.75).PlayOnRemove = true
			local v7875 = 1
			local v7980 = 10
			local v7876 = 1
			for v7875 = 1, 10, 1 do
				local v7879 = Instance.new("Part")
				v7879.Name = randomstring_1()
				v7879.Anchored = true
				v7879.Position = v7871.Position
				v7879.Shape = "Ball"
				v7879.Color = v798
				v7879.Material = "Neon"
				v7879.CastShadow = false
				v7879.Size = Vector3.new(v7875 * 2.5, v7875 * 2.5, v7875 * 2.5)
				v7879.CanCollide = false
				v7879.Transparency = 0.75
				v7879.Parent = game:GetService("Workspace")
				local v7891 = 1.5
				local v7892 = v7875 / 10
				game:GetService("Debris"):AddItem(v7879, v7891 - v7892)
				for v7894 = 1, 3, 1 do
					v7892 = script.ierofjqwoiuorewqjofjweor
					v7891 = v7892.rtoiufteuwkeworkowekoew
					local v7899 = v7891.ertfwetfretfretewtwtewrtret:Clone()
					v7891 = v798
					v7899.Color = v7891
					v7891 = v7899.Trail
					v7892 = ColorSequence.new
					v7891.Color = v7892(v798, Color3.new(1, 1, 1))
					v7891 = v7899.attachment.ParticleEmitter
					v7891.Color = ColorSequence.new(v798, Color3.new(1, 1, 1))
					v7891 = v7879.CFrame * CFrame.Angles(math.rad(math.random(0, 360)), math.rad(math.random(0, 360)), math.rad(math.random(0, 360))) * CFrame.new(0, 1, 0)
					v7899.CFrame = v7891
					v7891 = v741
					v7899.Parent = v7891
					v7891 = CFrame.new(v7899.Position, v7879.Position).LookVector * 250
					v7899.Velocity = v7891
					v7891 = game
					v7891:GetService("Debris"):AddItem(v7899, 1.33)
				end
			end
			v7980 = game
			v7871.Parent = v7980:GetService("Workspace")
			v7876 = function()
				v7871:Destroy()
			end
			pcall(v7876)
			local v7941 = v7860:IsDescendantOf(game)
			v7941 = v7860.Parent
			v7879 = "Workspace"
			local v7943 = game:GetService(v7879)
			v7941 = v7860.Parent
			v7895 = "Workspace"
			local v7945 = game:GetService(v7895)
			v7943 = v7945.Terrain
			if v7941 ~= v7943 then
				v7941 = v7860.RootPart
				v7941:Destroy()
				local v7946 = v7860
				while true do
					v7946 = v7946.Parent
					v7943 = v7946.Parent
					v7945 = game
					local v7948 = v7945:GetService("Workspace")
					if v7943 ~= v7948 then
						break
					end
					v7943 = v7946.Parent
					v7896 = "Workspace"
					v7948 = game:GetService(v7896).Terrain
					if v7943 ~= v7948 then
						break
					end
				end
				v7943 = coroutine.resume
				v7948 = coroutine.create
				v7950 = function()
					local v7951 = 0
					while true do
						v7951 = v7951 + game:GetService("RunService").RenderStepped:Wait()
						if 3 < v7951 then
							break
						end
					end
					v7956 = RayCast_1
					v7956:FireServer(v7946.Name)
				end
				v7943(v7948(v7950))
				v7946:Destroy()
			else
				local v7962 = v7860:IsDescendantOf(game)
				if not v7962 then
					v7962 = v7860.RootPart
					v7962:Destroy()
					v7860:Destroy()
				end
			end
		end
		return
	end)
end

--//=================================\\
--||	ATTACK FUNCTIONS AND STUFF
--\\=================================//

function SwitchModeEffect()
	ATTACK = true
	local v20306 = 0
	local v20662 = 4
	local v20307 = 0.1
	for v20306 = v20306, v20662, v20307 do
		Swait()
		RightHip.C0 = ClerpHSC(RightHip.C0, CF(1, -0.15, -0.5) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-3), RAD(-15), RAD(-20)), 0.1)
		LeftHip.C0 = ClerpHSC(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-3), RAD(1), RAD(20)), 0.1)
		RootJoint.C0 = ClerpHSC(RootJoint.C0, CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * CF(0, 0.25, -0.05) * ANGLES(RAD(-20), RAD(0), RAD(30)), 0.1)
		Neck.C0 = ClerpHSC(Neck.C0, CFrame.new(0, 1, 0) * ANGLES(RAD(20 - 120), RAD(0), RAD(-30 + 180)), 0.1)
		RightShoulder.C0 = ClerpHSC(RightShoulder.C0, CF(1.45, 0.8, -0.15) * ANGLES(RAD(35), RAD(-10), RAD(30)), 0.8)
		LeftShoulder.C0 = ClerpHSC(LeftShoulder.C0, CF(-1.4, 0.5, 0.1) * ANGLES(RAD(-5), RAD(10), RAD(-20)), 0.1)
	end
	CreateSound(824687369, Torso, 10, 0.9, false)
	local v20430 = {}
	v20430.Time = 50
	v20430.EffectType = "Wave"
	v20430.Size = VT(0, 0, 0)
	v20430.Size2 = VT(150, 5, 150)
	v20430.Transparency = 0.5
	v20430.Transparency2 = 1
	v20430.CFrame = RootPart.CFrame * CF(0, 0, 1)
	v20430.MoveToPos = nil
	v20430.RotationX = 0
	v20430.RotationY = 0
	v20430.RotationZ = 0
	v20430.Material = "Neon"
	v20430.Color = Color3.new(0.0235294, 0.152941, 1)
	v20430.SoundID = nil
	v20430.SoundPitch = 1.2
	v20430.SoundVolume = 4
	WACKYEFFECT(v20430)
	local v20449 = {}
	v20449.Time = 50
	v20449.EffectType = "Wave"
	v20449.Size = VT(0, 0, 0)
	v20449.Size2 = VT(160, 10, 160)
	v20449.Transparency = 0.5
	v20449.Transparency2 = 1
	v20449.CFrame = RootPart.CFrame * CF(0, 0, 1)
	v20449.MoveToPos = nil
	v20449.RotationX = 0
	v20449.RotationY = 1
	v20449.RotationZ = 0
	v20449.Material = "Neon"
	v20449.Color = Color3.new(0.0235294, 0.152941, 1)
	v20449.SoundID = nil
	v20449.SoundPitch = 1.2
	v20449.SoundVolume = 4
	WACKYEFFECT(v20449)
	local v20467 = {}
	v20467.Time = 50
	v20467.EffectType = "Wave"
	v20467.Size = VT(0, 0, 0)
	v20467.Size2 = VT(170, 5, 170)
	v20467.Transparency = 0.5
	v20467.Transparency2 = 1
	v20467.CFrame = RootPart.CFrame * CF(0, 0, 1)
	v20467.MoveToPos = nil
	v20467.RotationX = 0
	v20467.RotationY = 2
	v20467.RotationZ = 0
	v20467.Material = "Neon"
	v20467.Color = Color3.new(0.0235294, 0.152941, 1)
	v20467.SoundID = nil
	v20467.SoundPitch = 1.2
	v20467.SoundVolume = 4
	WACKYEFFECT(v20467)
	CameraEnshaking(5, 10 / 4.5)
	local v20487 = {}
	v20487.Time = 50
	v20487.EffectType = "Wave"
	v20487.Size = VT(0, 0, 0)
	v20487.Size2 = VT(180, 10, 180)
	v20487.Transparency = 0.5
	v20487.Transparency2 = 1
	v20487.CFrame = RootPart.CFrame * CF(0, 0, 1)
	v20487.MoveToPos = nil
	v20487.RotationX = 0
	v20487.RotationY = 3
	v20487.RotationZ = 0
	v20487.Material = "Neon"
	v20487.Color = Color3.new(0, 0, 0)
	v20487.SoundID = nil
	v20487.SoundPitch = 1.2
	v20487.SoundVolume = 4
	WACKYEFFECT(v20487)
	local v20506 = {}
	v20506.Time = 50
	v20506.EffectType = "Wave"
	v20506.Size = VT(0, 0, 0)
	v20506.Size2 = VT(190, 5, 190)
	v20506.Transparency = 0.5
	v20506.Transparency2 = 1
	v20506.CFrame = RootPart.CFrame * CF(0, 0, 1)
	v20506.MoveToPos = nil
	v20506.RotationX = 0
	v20506.RotationY = 4
	v20506.RotationZ = 0
	v20506.Material = "Neon"
	v20506.Color = Color3.new(0, 0, 0)
	v20506.SoundID = nil
	v20506.SoundPitch = 1.2
	v20506.SoundVolume = 4
	WACKYEFFECT(v20506)
	local v20524 = {}
	v20524.Time = 50
	v20524.EffectType = "Wave"
	v20524.Size = VT(0, 0, 0)
	v20524.Size2 = VT(200, 10, 200)
	v20524.Transparency = 0.5
	v20524.Transparency2 = 1
	v20524.CFrame = RootPart.CFrame * CF(0, 0, 1)
	v20524.MoveToPos = nil
	v20524.RotationX = 0
	v20524.RotationY = 5
	v20524.RotationZ = 0
	v20524.Material = "Neon"
	v20524.Color = Color3.new(0, 0, 0)
	v20524.SoundID = nil
	v20524.SoundPitch = 1.2
	v20524.SoundVolume = 4
	WACKYEFFECT(v20524)
	local v20541 = 2
	for v20540 = 0, v20541, 0.1 do
		Swait()
		RightHip.C0 = ClerpHSC(RightHip.C0, CF(1, -0.5, -0.5) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-3), RAD(-25), RAD(30)), 0.8)
		LeftHip.C0 = ClerpHSC(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-3), RAD(1), RAD(20)), 0.8)
		RootJoint.C0 = ClerpHSC(RootJoint.C0, CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * CF(0, -0.25, -0.5) * ANGLES(RAD(30), RAD(0), RAD(50)), 0.8)
		Neck.C0 = ClerpHSC(Neck.C0, CFrame.new(0, 1, 0) * ANGLES(RAD(20 - 120), RAD(0), RAD(-50 + 180)), 0.8)
		RightShoulder.C0 = ClerpHSC(RightShoulder.C0, CF(1.45, 0.6, -0.15) * ANGLES(RAD(35), RAD(-10), RAD(75)), 0.8)
		LeftShoulder.C0 = ClerpHSC(LeftShoulder.C0, CF(-1.4, 0.5, 0.1) * ANGLES(RAD(-35), RAD(10), RAD(-50)), 0.8)
	end
	ATTACK = false
	v519 = v20541
end

function SwitchMode(SModeCodeName, MusicId)
	LastestMusicId = MusicId

	if SModeCodeName == "Vaporwave" then
		ModeCodeName = "Vaporwave"
		ModeName = "HSC FE - Vaporwave"

		LCColor.Enabled = false
		LightingEffect = false

		sick:Stop()
		sick.Volume = 5
		sick.TimePosition = 0
		sick.PlaybackSpeed = 1
		sick.SoundId = "rbxassetid://" .. tostring(MusicId)
		sick:Play()
	elseif SModeCodeName == "Rage" then
		ModeCodeName = "Rage"
		ModeName = "HSC FE - Rage"

		LCColor.Enabled = true
		LightingEffect = true

		sick:Stop()
		sick.Volume = 4
		sick.TimePosition = 0
		sick.PlaybackSpeed = 1
		sick.SoundId = "rbxassetid://" .. tostring(MusicId)
		sick:Play()
	elseif SModeCodeName == "BadApple2" then
		ModeCodeName = "BadApple2"
		ModeName = "HSC FE - Bad Apple"

		LCColor.Enabled = true
		LightingEffect = true

		sick:Stop()
		sick.Volume = 7
		sick.TimePosition = 0
		sick.PlaybackSpeed = 1.1
		sick.SoundId = "rbxassetid://" .. tostring(MusicId)
		sick:Play()
	elseif SModeCodeName == "FNFB3" then
		ModeName = "HSC FE - Thorns"
		ModeCodeName = "FNFB3"

		LCColor.Enabled = true
		LightingEffect = true

		sick:Stop()
		sick.Volume = 3
		sick.TimePosition = 0
		sick.PlaybackSpeed = 1
		sick.SoundId = "rbxassetid://" .. tostring(MusicId)
		sick:Play()
	elseif SModeCodeName == "Relaxed" then
		ModeName = "HSC FE - Relaxed"
		ModeCodeName = "Relaxed"

		LCColor.Enabled = false
		LightingEffect = false

		sick:Stop()
		sick.Volume = 3
		sick.TimePosition = 0
		sick.PlaybackSpeed = 1
		sick.SoundId = "rbxassetid://" .. tostring(MusicId)
		sick:Play()
	elseif SModeCodeName == "InsAnitY" then
		ModeName = "HSC FE - InsAnitY"
		ModeCodeName = "InsAnitY"

		LCColor.Enabled = false
		LightingEffect = false

		sick:Stop()
		sick.Volume = 4
		sick.TimePosition = 0
		sick.PlaybackSpeed = 1
		sick.SoundId = "rbxassetid://" .. tostring(MusicId)
		sick:Play()
	elseif SModeCodeName == "KARMA" then
		ModeName = "HSC FE - KARMA"
		ModeCodeName = "KARMA"

		LCColor.Enabled = true
		LightingEffect = true

		sick:Stop()
		sick.Volume = 4
		sick.TimePosition = 0
		sick.PlaybackSpeed = 1
		sick.SoundId = "rbxassetid://" .. tostring(MusicId)
		sick:Play()
	elseif SModeCodeName == "NulledXD" then
		ModeName = "HSC FE - NulledXD"
		ModeCodeName = "NulledXD"

		LCColor.Enabled = false
		LightingEffect = true

		sick:Stop()
		sick.Volume = 4
		sick.TimePosition = 0
		sick.PlaybackSpeed = 1
		sick.SoundId = "rbxassetid://" .. tostring(MusicId)
		sick:Play()
	elseif SModeCodeName == "Rolling girl" then
		ModeName = "HSC FE - Rolling girl"
		ModeCodeName = "Rolling girl"

		LCColor.Enabled = false
		LightingEffect = false

		sick:Stop()
		sick.Volume = 4
		sick.TimePosition = 0
		sick.PlaybackSpeed = 1
		sick.SoundId = "rbxassetid://" .. tostring(MusicId)
		sick:Play()
	elseif SModeCodeName == "Fave" then
		ModeName = "HSC FE - Fave"
		ModeCodeName = "Fave"

		LCColor.Enabled = false
		LightingEffect = false

		sick:Stop()
		sick.Volume = 4
		sick.TimePosition = 0
		sick.PlaybackSpeed = 1
		sick.SoundId = "rbxassetid://" .. tostring(MusicId)
		sick:Play()
	elseif SModeCodeName == "MemeLol" then
		ModeName = "HSC FE - ???"
		ModeCodeName = "MemeLol"

		LCColor.Enabled = false
		LightingEffect = true

		sick:Stop()
		sick.Volume = 4
		sick.TimePosition = 0
		sick.PlaybackSpeed = 1
		sick.SoundId = "rbxassetid://" .. tostring(MusicId)
		sick:Play()
	elseif SModeCodeName == "Heck ya" then
		ModeName = "Hyperskidded Cannon FE"
		ModeCodeName = "Heck ya"

		LCColor.Enabled = false
		LightingEffect = false

		sick:Stop()
		sick.Volume = 3.5
		sick.TimePosition = 0
		sick.PlaybackSpeed = 1
		sick.SoundId = "rbxassetid://" .. tostring(MusicId)
		sick:Play()
	end
end

function attackone()
	ATTACK = true
	v665 = 16
	AttackGyro()
	local v11612 = 0
	local v11613 = 0.5
	local v11614 = 0.05
	for v11612 = 0, 0.5, 0.05 do
		Swait()
		RootJoint.C0 = ClerpHSC(RootJoint.C0, CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * CFrame.new(0 + 0.5 * math.cos(SINE / 50), 0, 0 - 0.5 * math.sin(SINE / 50)) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(30)), 0.23333333333333)
		Neck.C0 = ClerpHSC(Neck.C0, CFrame.new(0, 1, 0) * CFrame.new() * CFrame.Angles(math.rad(15 - 110), math.rad(0), math.rad(-30 + 180)), 0.33333333333333)
		-- RightShoulder.C0 = ClerpHSC(RightShoulder.C0, CFrame.new(1.5, 1.5, 0) * CFrame.Angles(math.rad(90 + 30 - 70), math.rad(0), math.rad(0)) * CFrame.new(0, 1, 0), 0.33333333333333)
		RightShoulder.C0 = ClerpHSC(RightShoulder.C0, CFrame.new(1.5, 1.5, 0) * CFrame.Angles(math.rad(90), math.rad(0), math.rad(30)) * CFrame.new(0, 1, 0), 0.33333333333333)
		LeftShoulder.C0 = ClerpHSC(LeftShoulder.C0, CFrame.new(-1, 0.5, 0) * CFrame.Angles(math.rad(30), math.rad(0), math.rad(0)) * CFrame.new(-0.5, 0, 0), 0.33333333333333)
		RightHip.C0 = ClerpHSC(RightHip.C0, CFrame.new(1, -0.5, -0.5) * CFrame.Angles(math.rad(-15 + 9 * math.cos(SINE / 74)), math.rad(80), math.rad(0)) * CFrame.Angles(math.rad(0 + 5 * math.cos(SINE / 37)), math.rad(0), math.rad(0)), 0.23333333333333)
		LeftHip.C0 = ClerpHSC(LeftHip.C0, CFrame.new(-1, -1, 0) * CFrame.Angles(math.rad(-15 - 9 * math.cos(SINE / 54)), math.rad(-80), math.rad(0)) * CFrame.Angles(math.rad(0 - 5 * math.cos(SINE / 41)), math.rad(0), math.rad(0)), 0.23333333333333)
		-- v794.C0 = ClerpHSC(v794.C0, CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)), 0.5)
	end
	v11613 = Effect
	v11614 = {}
	v11612 = 25
	v11614.Time = v11612
	v11614.EffectType = "Box"
	v11614.Size = Vector3.new()
	v11616 = 3
	v11769 = 3
	v11614.Size2 = Vector3.new(v11616, v11769, 3)
	v11614.Transparency = 0
	v11614.Transparency2 = 1
	v11614.CFrame = Hole.CFrame
	v11614.MoveToPos = nil
	v11614.RotationX = math.random(-1, 1)
	v11614.RotationY = math.random(-1, 1)
	v11614.RotationZ = math.random(-1, 1)
	v11614.Material = "Neon"
	v11614.Color = Color3.new(1, 1, 1)
	v11614.SoundID = 642890855
	v11614.SoundPitch = 1
	v11614.SoundVolume = 10000
	v11614.UseBoomerangMath = true
	v11614.Boomerang = 0
	v11614.SizeBoomerang = 50
	EXCEPTWACKYEFFECT(v11614)
	local v11787 = {}
	v11787.Time = 25
	v11787.EffectType = "Box"
	v11787.Size = Vector3.new()
	v11787.Size2 = Vector3.new(3, 3, 3)
	v11787.Transparency = 0
	v11787.Transparency2 = 1
	v11787.CFrame = Hole.CFrame
	v11787.MoveToPos = nil
	v11787.RotationX = math.random(-1, 1)
	v11787.RotationY = math.random(-1, 1)
	v11787.RotationZ = math.random(-1, 1)
	v11787.Material = "Neon"
	v11787.Color = Color3.new(0, 0, 0)
	v11787.SoundID = nil
	v11787.SoundPitch = nil
	v11787.SoundVolume = nil
	v11787.UseBoomerangMath = true
	v11787.Boomerang = 0
	v11787.SizeBoomerang = 50
	EXCEPTWACKYEFFECT(v11787)
	local v12951 = 0
	local v11802 = 2
	local v11803 = 1
	for v11801 = 0, 2, 1 do
		local v11805 = {}
		v11805.Time = math.random(25, 50)
		v11805.EffectType = "Round Slash"
		v11805.Size = Vector3.new()
		v11768 = 0.1
		v11805.Size2 = Vector3.new(0.1, 0, v11768)
		v11805.Transparency = 0
		v11805.Transparency2 = 1
		v11742 = 360
		v11805.CFrame = Hole.CFrame * CFrame.Angles(math.rad(math.random(0, 360)), math.rad(math.random(0, 360)), math.rad(math.random(0, v11742)))
		v11805.MoveToPos = nil
		v11805.RotationX = math.random(-1, 1)
		v11805.RotationY = math.random(-1, 1)
		v11805.RotationZ = math.random(-1, 1)
		v11805.Material = "Neon"
		v11805.Color = Color3.new(1, 1, 1)
		v11805.SoundID = nil
		v11805.SoundPitch = nil
		v11805.SoundVolume = nil
		v11805.UseBoomerangMath = true
		v11805.Boomerang = 0
		v11805.SizeBoomerang = 15
		EXCEPTWACKYEFFECT(v11805)
		local v11842 = {}
		v11842.Time = math.random(25, 50)
		v11842.EffectType = "Round Slash"
		v11842.Size = Vector3.new()
		v11842.Size2 = Vector3.new(0.1, 0, 0.1)
		v11842.Transparency = 0
		v11842.Transparency2 = 1
		v11842.CFrame = Hole.CFrame * CFrame.Angles(math.rad(math.random(0, 360)), math.rad(math.random(0, 360)), math.rad(math.random(0, 360)))
		v11842.MoveToPos = nil
		v11842.RotationX = math.random(-1, 1)
		v11842.RotationY = math.random(-1, 1)
		v11842.RotationZ = math.random(-1, 1)
		v11842.Material = "Neon"
		v11842.Color = Color3.new(0, 0, 0)
		v11842.SoundID = nil
		v11842.SoundPitch = nil
		v11842.SoundVolume = nil
		v11842.UseBoomerangMath = true
		v11842.Boomerang = 0
		v11842.SizeBoomerang = 15
		EXCEPTWACKYEFFECT(v11842)
	end
	v11802 = Mouse.Hit
	v12951 = Hole.Position - v11802.p
	local v12996 = v12951.Magnitude
	v11874 = "Neon"
	local v11885 = CreatePart(3, v741, v11874, 0, 0, AUDIOBASEDCOLOR, "Kill Beam", Vector3.new(1, v12996, 1))
	local v11893 = -v12996
	v11885.CFrame = CFrame.new(Hole.Position, v11802.p) * CFrame.new(0, 0, v11893 / 2) * CFrame.Angles(math.rad(90), math.rad(0), math.rad(0))
	MakeForm(v11885, "Cyl")
	coroutine.resume(coroutine.create(function()
		local v11909 = 1
		local v11910 = 25
		for v11909 = v11909, v11910, 1 do
			swait()
			v11885.Transparency = v11909 / 25
		end
		v11910 = v11885
		v11910:Destroy()
	end))
	local v11915 = 1
	local v11916 = 4
	local v11917 = 1
	for v11915 = v11915, v11916, v11917 do
		coroutine.resume(coroutine.create(function()
			Lightning(Hole.Position, v11802.p, 15, 3.5, Color3.new(1, 1, 1), 25, 0, 1, 0, true, 55)
		end))
	end
	coroutine.resume(coroutine.create(function()
		Lightning(Hole.Position, v11802.p, 15, 3.5, Color3.new(1, 1, 1), 25, 0, 1, 0, true, 55)
		local v11956 = {}
		v11956.Time = 20
		v11956.EffectType = "Box"
		v11956.Size = Vector3.new()
		v11956.Size2 = Vector3.new(3, 3, 3)
		v11956.Transparency = 0
		v11956.Transparency2 = 1
		v11956.CFrame = v11802
		v11956.MoveToPos = nil
		v11956.RotationX = math.random(-1, 1)
		v11956.RotationY = math.random(-1, 1)
		v11956.RotationZ = math.random(-1, 1)
		v11956.Material = "Neon"
		v11956.Color = AUDIOBASEDCOLOR
		v11956.SoundID = 1474367957
		v11956.SoundPitch = 1
		v11956.SoundVolume = 10000
		v11956.UseBoomerangMath = true
		v11956.Boomerang = 0
		v11956.SizeBoomerang = 50
		EXCEPTWACKYEFFECT(v11956)
		local v11977 = {}
		v11977.Time = 20
		v11977.EffectType = "Box"
		v11977.Size = Vector3.new()
		v11977.Size2 = Vector3.new(3, 3, 3)
		v11977.Transparency = 0
		v11977.Transparency2 = 1
		v11977.CFrame = v11802
		v11977.MoveToPos = nil
		v11977.RotationX = math.random(-1, 1)
		v11977.RotationY = math.random(-1, 1)
		v11977.RotationZ = math.random(-1, 1)
		v11977.Material = "Neon"
		v11977.Color = Color3.new(0, 0, 0)
		v11977.SoundID = nil
		v11977.SoundPitch = nil
		v11977.SoundVolume = nil
		v11977.UseBoomerangMath = true
		v11977.Boomerang = 0
		v11977.SizeBoomerang = 50
		EXCEPTWACKYEFFECT(v11977)
		local v12106 = 0
		local v11992 = 2
		local v11993 = 1
		for v11991 = v12106, v11992, v11993 do
			local v11995 = {}
			v11995.Time = math.random(25, 50)
			v11995.EffectType = "Round Slash"
			v11995.Size = Vector3.new()
			v11995.Size2 = Vector3.new(0.1, 0, 0.1)
			v11995.Transparency = 0
			v11995.Transparency2 = 1
			v11995.CFrame = v11802 * CFrame.Angles(math.rad(math.random(0, 360)), math.rad(math.random(0, 360)), math.rad(math.random(0, 360)))
			v11995.MoveToPos = nil
			v11995.RotationX = math.random(-1, 1)
			v11995.RotationY = math.random(-1, 1)
			v11995.RotationZ = math.random(-1, 1)
			v11995.Material = "Neon"
			v11995.Color = Color3.new(1, 1, 1)
			v11995.SoundID = nil
			v11995.SoundPitch = nil
			v11995.SoundVolume = nil
			v11995.UseBoomerangMath = true
			v11995.Boomerang = 0
			v11995.SizeBoomerang = 15
			EXCEPTWACKYEFFECT(v11995)
			local v12034 = {}
			v12034.Time = math.random(25, 50)
			v12034.EffectType = "Round Slash"
			v12034.Size = Vector3.new()
			v12034.Size2 = Vector3.new(0.1, 0, 0.1)
			v12034.Transparency = 0
			v12034.Transparency2 = 1
			v12034.CFrame = v11802 * CFrame.Angles(math.rad(math.random(0, 360)), math.rad(math.random(0, 360)), math.rad(math.random(0, 360)))
			v12034.MoveToPos = nil
			v12034.RotationX = math.random(-1, 1)
			v12034.RotationY = math.random(-1, 1)
			v12034.RotationZ = math.random(-1, 1)
			v12034.Material = "Neon"
			v12034.Color = Color3.new(0, 0, 0)
			v12034.SoundID = nil
			v12034.SoundPitch = nil
			v12034.SoundVolume = nil
			v12034.UseBoomerangMath = true
			v12034.Boomerang = 0
			v12034.SizeBoomerang = 15
			EXCEPTWACKYEFFECT(v12034)
		end
		--[[ v11992 = MDR
		v12106 = v11802
		v11993 = v12106.p
		v11992(v11993, 10) --]]
		ApplyAoE(v11802.p,10)
	end))
	local v12149 = 0
	local v12150 = 0.5
	local v12151 = 0.075
	for v12149 = v12149, v12150, v12151 do
		swait()
		v11744 = 0
		v11743 = 0.5
		v11631 = SINE / 50
		v11700 = math.cos
		v11744 = 0
		v11743 = 0
		v11893 = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * CFrame.new(v11744 + v11743 * v11700(v11631), v11744, v11743 - 0.5 * math.sin(SINE / 50))
		v11893 = 0.23333333333333
		RootJoint.C0 = ClerpHSC(RootJoint.C0, CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * CFrame.new(v11744 + v11743 * v11700(v11631), v11744, v11743 - 0.5 * math.sin(SINE / 50)) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(30)), v11893)
		Neck.C0 = ClerpHSC(Neck.C0, CFrame.new(0, 1, 0) * CFrame.new() * CFrame.Angles(math.rad(10 - 110), math.rad(0), math.rad(-60 + 180)), 0.33333333333333)
		v11743 = 60
		RightShoulder.C0 = ClerpHSC(RightShoulder.C0, CFrame.new(1.5, 1.5, 0) * CFrame.Angles(math.rad(90 + 30), math.rad(0 + 20), math.rad(30)) * CFrame.new(0, 1, 0), 0.33333333333333)
		LeftShoulder.C0 = ClerpHSC(LeftShoulder.C0, CFrame.new(-1, 0.5, 0) * CFrame.Angles(math.rad(40), math.rad(5), math.rad(5)) * CFrame.new(-0.5, 0, 0), 0.33333333333333)
		RightHip.C0 = ClerpHSC(RightHip.C0, CFrame.new(1, -0.5, -0.5) * CFrame.Angles(math.rad(-15 + 9 * math.cos(SINE / 74)), math.rad(80), math.rad(0)) * CFrame.Angles(math.rad(0 + 5 * math.cos(SINE / 37)), math.rad(0), math.rad(0)), 0.23333333333333)
		LeftHip.C0 = ClerpHSC(LeftHip.C0, CFrame.new(-1, -1, 0) * CFrame.Angles(math.rad(-15 - 9 * math.cos(SINE / 54)), math.rad(-80), math.rad(0)) * CFrame.Angles(math.rad(0 - 5 * math.cos(SINE / 41)), math.rad(0), math.rad(0)), 0.23333333333333)
		-- v794.C0 = ClerpHSC(v794.C0, CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)), 0.5)
	end
	while true do
		v12150 = Effect
		v12151 = {}
		v12149 = 25
		v12151.Time = v12149
		v12149 = "Box"
		v12151.EffectType = v12149
		v12149 = Vector3.new
		v12151.Size = v12149()
		v12153 = 3
		v12301 = 3
		v12151.Size2 = Vector3.new(v12153, v12301, 3)
		v12151.Transparency = 0
		v12151.Transparency2 = 1
		v12151.CFrame = Hole.CFrame
		v12151.MoveToPos = nil
		v12151.RotationX = math.random(-1, 1)
		v12151.RotationY = math.random(-1, 1)
		v12151.RotationZ = math.random(-1, 1)
		v12151.Material = "Neon"
		v12151.Color = Color3.new(1, 1, 1)
		v12151.SoundID = 642890855
		v12151.SoundPitch = 1
		v12151.SoundVolume = 10000
		v12151.UseBoomerangMath = true
		v12151.Boomerang = 0
		v12151.SizeBoomerang = 50
		EXCEPTWACKYEFFECT(v12151)
		local v12319 = {}
		v12319.Time = 25
		v12319.EffectType = "Box"
		v12319.Size = Vector3.new()
		v12319.Size2 = Vector3.new(3, 3, 3)
		v12319.Transparency = 0
		v12319.Transparency2 = 1
		v12319.CFrame = Hole.CFrame
		v12319.MoveToPos = nil
		v12319.RotationX = math.random(-1, 1)
		v12319.RotationY = math.random(-1, 1)
		v12319.RotationZ = math.random(-1, 1)
		v12319.Material = "Neon"
		v12319.Color = Color3.new(0, 0, 0)
		v12319.SoundID = nil
		v12319.SoundPitch = nil
		v12319.SoundVolume = nil
		v12319.UseBoomerangMath = true
		v12319.Boomerang = 0
		v12319.SizeBoomerang = 50
		EXCEPTWACKYEFFECT(v12319)
		local v13115 = 0
		local v12334 = 2
		local v12335 = 1
		for v12333 = v13115, v12334, v12335 do
			local v12337 = {}
			v12337.Time = math.random(25, 50)
			v12337.EffectType = "Round Slash"
			v12337.Size = Vector3.new()
			v12300 = 0.1
			v12337.Size2 = Vector3.new(0.1, 0, v12300)
			v12337.Transparency = 0
			v12337.Transparency2 = 1
			v12274 = 360
			v12337.CFrame = Hole.CFrame * CFrame.Angles(math.rad(math.random(0, 360)), math.rad(math.random(0, 360)), math.rad(math.random(0, v12274)))
			v12337.MoveToPos = nil
			v12337.RotationX = math.random(-1, 1)
			v12337.RotationY = math.random(-1, 1)
			v12337.RotationZ = math.random(-1, 1)
			v12337.Material = "Neon"
			v12337.Color = Color3.new(1, 1, 1)
			v12337.SoundID = nil
			v12337.SoundPitch = nil
			v12337.SoundVolume = nil
			v12337.UseBoomerangMath = true
			v12337.Boomerang = 0
			v12337.SizeBoomerang = 15
			EXCEPTWACKYEFFECT(v12337)
			local v12374 = {}
			v12374.Time = math.random(25, 50)
			v12374.EffectType = "Round Slash"
			v12374.Size = Vector3.new()
			v12374.Size2 = Vector3.new(0.1, 0, 0.1)
			v12374.Transparency = 0
			v12374.Transparency2 = 1
			v12374.CFrame = Hole.CFrame * CFrame.Angles(math.rad(math.random(0, 360)), math.rad(math.random(0, 360)), math.rad(math.random(0, 360)))
			v12374.MoveToPos = nil
			v12374.RotationX = math.random(-1, 1)
			v12374.RotationY = math.random(-1, 1)
			v12374.RotationZ = math.random(-1, 1)
			v12374.Material = "Neon"
			v12374.Color = Color3.new(0, 0, 0)
			v12374.SoundID = nil
			v12374.SoundPitch = nil
			v12374.SoundVolume = nil
			v12374.UseBoomerangMath = true
			v12374.Boomerang = 0
			v12374.SizeBoomerang = 15
			EXCEPTWACKYEFFECT(v12374)
		end
		v12335 = v7375
		v12334 = Mouse.Hit
		v13115 = Hole.Position - v12334.p
		local v13160 = v13115.Magnitude
		v12406 = "Neon"
		local v12417 = CreatePart(3, v741, v12406, 0, 0, AUDIOBASEDCOLOR, "Kill Beam", Vector3.new(1, v13160, 1))
		local v12425 = -v13160
		v12417.CFrame = CFrame.new(Hole.Position, v12334.p) * CFrame.new(0, 0, v12425 / 2) * CFrame.Angles(math.rad(90), math.rad(0), math.rad(0))
		MakeForm(v12417, "Cyl")
		coroutine.resume(coroutine.create(function()
			local v12441 = 1
			local v12442 = 25
			for v12441 = v12441, v12442, 1 do
				swait()
				v12417.Transparency = v12441 / 25
			end
			v12442 = v12417
			v12442:Destroy()
		end))
		local v12447 = 1
		local v12448 = 4
		local v12449 = 1
		for v12447 = v12447, v12448, v12449 do
			coroutine.resume(coroutine.create(function()
				Lightning(Hole.Position, v12334.p, 15, 3.5, Color3.new(1, 1, 1), 25, 0, 1, 0, true, 55)
			end))
		end
		v12448 = coroutine.resume
		v12449 = coroutine.create
		coroutine.resume(coroutine.create(function()
			Lightning(Hole.Position, v12334.p, 15, 3.5, Color3.new(1, 1, 1), 25, 0, 1, 0, true, 55)
			local v12488 = {}
			v12488.Time = 20
			v12488.EffectType = "Box"
			v12488.Size = Vector3.new()
			v12488.Size2 = Vector3.new(3, 3, 3)
			v12488.Transparency = 0
			v12488.Transparency2 = 1
			v12488.CFrame = v12334
			v12488.MoveToPos = nil
			v12488.RotationX = math.random(-1, 1)
			v12488.RotationY = math.random(-1, 1)
			v12488.RotationZ = math.random(-1, 1)
			v12488.Material = "Neon"
			v12488.Color = AUDIOBASEDCOLOR
			v12488.SoundID = 1474367957
			v12488.SoundPitch = 1
			v12488.SoundVolume = 10000
			v12488.UseBoomerangMath = true
			v12488.Boomerang = 0
			v12488.SizeBoomerang = 50
			EXCEPTWACKYEFFECT(v12488)
			local v12509 = {}
			v12509.Time = 20
			v12509.EffectType = "Box"
			v12509.Size = Vector3.new()
			v12509.Size2 = Vector3.new(3, 3, 3)
			v12509.Transparency = 0
			v12509.Transparency2 = 1
			v12509.CFrame = v12334
			v12509.MoveToPos = nil
			v12509.RotationX = math.random(-1, 1)
			v12509.RotationY = math.random(-1, 1)
			v12509.RotationZ = math.random(-1, 1)
			v12509.Material = "Neon"
			v12509.Color = Color3.new(0, 0, 0)
			v12509.SoundID = nil
			v12509.SoundPitch = nil
			v12509.SoundVolume = nil
			v12509.UseBoomerangMath = true
			v12509.Boomerang = 0
			v12509.SizeBoomerang = 50
			EXCEPTWACKYEFFECT(v12509)
			local v12638 = 0
			local v12524 = 2
			local v12525 = 1
			for v12523 = v12638, v12524, v12525 do
				local v12527 = {}
				v12527.Time = math.random(25, 50)
				v12527.EffectType = "Round Slash"
				v12527.Size = Vector3.new()
				v12527.Size2 = Vector3.new(0.1, 0, 0.1)
				v12527.Transparency = 0
				v12527.Transparency2 = 1
				v12527.CFrame = v12334 * CFrame.Angles(math.rad(math.random(0, 360)), math.rad(math.random(0, 360)), math.rad(math.random(0, 360)))
				v12527.MoveToPos = nil
				v12527.RotationX = math.random(-1, 1)
				v12527.RotationY = math.random(-1, 1)
				v12527.RotationZ = math.random(-1, 1)
				v12527.Material = "Neon"
				v12527.Color = Color3.new(1, 1, 1)
				v12527.SoundID = nil
				v12527.SoundPitch = nil
				v12527.SoundVolume = nil
				v12527.UseBoomerangMath = true
				v12527.Boomerang = 0
				v12527.SizeBoomerang = 15
				EXCEPTWACKYEFFECT(v12527)
				local v12566 = {}
				v12566.Time = math.random(25, 50)
				v12566.EffectType = "Round Slash"
				v12566.Size = Vector3.new()
				v12566.Size2 = Vector3.new(0.1, 0, 0.1)
				v12566.Transparency = 0
				v12566.Transparency2 = 1
				v12566.CFrame = v12334 * CFrame.Angles(math.rad(math.random(0, 360)), math.rad(math.random(0, 360)), math.rad(math.random(0, 360)))
				v12566.MoveToPos = nil
				v12566.RotationX = math.random(-1, 1)
				v12566.RotationY = math.random(-1, 1)
				v12566.RotationZ = math.random(-1, 1)
				v12566.Material = "Neon"
				v12566.Color = Color3.new(0, 0, 0)
				v12566.SoundID = nil
				v12566.SoundPitch = nil
				v12566.SoundVolume = nil
				v12566.UseBoomerangMath = true
				v12566.Boomerang = 0
				v12566.SizeBoomerang = 15
				EXCEPTWACKYEFFECT(v12566)
			end
			--[[ v12524 = MDR
			v12638 = v12334
			v12525 = v12638.p
			v12524(v12525, 10) --]]
			ApplyAoE(v12334.p,10)
		end))
		local v12682 = 0.5
		for v12681 = 0, v12682, 0.075 do
			swait()
			v12276 = 0
			v12275 = 0.5
			v12164 = SINE / 50
			v12232 = math.cos
			v12276 = 0
			v12275 = 0
			v12425 = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * CFrame.new(v12276 + v12275 * v12232(v12164), v12276, v12275 - 0.5 * math.sin(SINE / 50))
			v12425 = 0.23333333333333
			RootJoint.C0 = ClerpHSC(RootJoint.C0, CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * CFrame.new(v12276 + v12275 * v12232(v12164), v12276, v12275 - 0.5 * math.sin(SINE / 50)) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(30)), v12425)
			Neck.C0 = ClerpHSC(Neck.C0, CFrame.new(0, 1, 0) * CFrame.new() * CFrame.Angles(math.rad(10 - 110), math.rad(0), math.rad(-60 + 180)), 0.33333333333333)
			v12275 = 60
			RightShoulder.C0 = ClerpHSC(RightShoulder.C0, CFrame.new(1.5, 1.5, 0) * CFrame.Angles(math.rad(90 + 30), math.rad(0 + 20), math.rad(30)) * CFrame.new(0, 1, 0), 0.33333333333333)
			LeftShoulder.C0 = ClerpHSC(LeftShoulder.C0, CFrame.new(-1, 0.5, 0) * CFrame.Angles(math.rad(40), math.rad(5), math.rad(5)) * CFrame.new(-0.5, 0, 0), 0.33333333333333)
			RightHip.C0 = ClerpHSC(RightHip.C0, CFrame.new(1, -0.5, -0.5) * CFrame.Angles(math.rad(-15 + 9 * math.cos(SINE / 74)), math.rad(80), math.rad(0)) * CFrame.Angles(math.rad(0 + 5 * math.cos(SINE / 37)), math.rad(0), math.rad(0)), 0.23333333333333)
			LeftHip.C0 = ClerpHSC(LeftHip.C0, CFrame.new(-1, -1, 0) * CFrame.Angles(math.rad(-15 - 9 * math.cos(SINE / 54)), math.rad(-80), math.rad(0)) * CFrame.Angles(math.rad(0 - 5 * math.cos(SINE / 41)), math.rad(0), math.rad(0)), 0.23333333333333)
			-- v794.C0 = ClerpHSC(v794.C0, CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)), 0.5)
		end
		v12682 = HOLD
		if not HOLD then
			break
		end
	end
	v12334 = 50
	v665 = v12334
	v12334 = false
	ATTACK = v12334
end

function USLCannonRemover()
	chatfunc("Bugged/attempted to bug all running Lightning Cannon scripts.", false, true)
	warnedpeople("Bugged/attempted to bug all running Lightning Cannon scripts.")
end

function attacktwo()
	ATTACK = true
	local savespeed = Speed
	Speed = 3
	local keptcolor = BrickColor.new("New Yeller")
	CreateSound(847061203,Torso,10,1,false)
	sphere2(5,"Add",RightArm.CFrame*CFrame.new(0,-2,0)*CFrame.Angles(math.rad(90),0,0),VT(1,1,1),0.1,0.1,0.1,keptcolor,keptcolor.Color)
	sphere2(5,"Add",RightArm.CFrame*CFrame.new(0,-2,0)*CFrame.Angles(math.rad(90),0,0),VT(1,1,1),0.2,0.2,0.2,keptcolor,keptcolor.Color)
	for i = 0, 14 do
		PixelBlock(1,math.random(1,3),"Add",RightArm.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),1,1,1,0.02,keptcolor,0)
	end
	for i = 0,1,0.1 do
		swait()
		sphere2(8,"Add",LeftArm.CFrame*CFrame.new(0,-2,0)*CFrame.Angles(math.rad(90),0,0),VT(2.25,0.1,2.25),0.01,0.01,0.01,keptcolor,keptcolor.Color)
		RightHip.C0=Clerp(RightHip.C0,CF(1,-1,0)*ANGLES(math.rad(0),math.rad(90),math.rad(0))*ANGLES(math.rad(-2.5),math.rad(0),math.rad(-5)),.3)
		LeftHip.C0=Clerp(LeftHip.C0,CF(-1,-1,0)*ANGLES(math.rad(0),math.rad(-90),math.rad(0))*ANGLES(math.rad(-2.5),math.rad(30),math.rad(0)),.3)
		RootJoint.C0=Clerp(RootJoint.C0,ROOTC0*CF(0,0,0)*ANGLES(math.rad(0),math.rad(0),math.rad(60)),.3)
		Torso.Neck.C0=Clerp(Torso.Neck.C0,NECKC0*ANGLES(math.rad(20),math.rad(0),math.rad(-30)),.3)
		RightShoulder.C0=Clerp(RightShoulder.C0,CF(1.15,0.5,-0.5)*ANGLES(math.rad(90),math.rad(0),math.rad(-60)),.3)
		LeftShoulder.C0=Clerp(LeftShoulder.C0,CF(-1.15,0.5,0)*ANGLES(math.rad(-20),math.rad(0),math.rad(-10)),.3)
	end
	for i = 0, 1 do
		CreateSound(763755889,Torso,10,1,false)
		for i = 0,1,0.6 do
			swait()
			sphere2(8,"Add",RightArm.CFrame*CFrame.new(0,-2,0)*CFrame.Angles(math.rad(90),0,0),VT(2.25,0.1,2.25),0.01,0.01,0.01,keptcolor,keptcolor.Color)
			slash(math.random(15,30)/10,5,true,"Round","Add","Out",RootPart.CFrame*CFrame.Angles(math.rad(math.random(-5,5)),math.rad(math.random(-5,5)),math.rad(math.random(-5,5))),VT(0.05,0.01,0.05),math.random(25,75)/250,BrickColor.new("White"))
			RightHip.C0=Clerp(RightHip.C0,CF(1,-1,0)*ANGLES(math.rad(0),math.rad(90),math.rad(0))*ANGLES(math.rad(-2.5),math.rad(0),math.rad(-5)),.6)
			LeftHip.C0=Clerp(LeftHip.C0,CF(-1,-1,0)*ANGLES(math.rad(0),math.rad(-90),math.rad(0))*ANGLES(math.rad(-2.5),math.rad(30),math.rad(0)),.6)
			RootJoint.C0=Clerp(RootJoint.C0,ROOTC0*CF(0,0,0)*ANGLES(math.rad(0),math.rad(0),math.rad(0)),.6)
			Torso.Neck.C0=Clerp(Torso.Neck.C0,NECKC0*ANGLES(math.rad(20),math.rad(0),math.rad(-30)),.6)
			RightShoulder.C0=Clerp(RightShoulder.C0,CF(1.15,0.5,-0.5)*ANGLES(math.rad(90),math.rad(0),math.rad(-60)),.6)
			LeftShoulder.C0=Clerp(LeftShoulder.C0,CF(-1.15,0.5,0)*ANGLES(math.rad(-20),math.rad(0),math.rad(-10)),.6)
		end
		for i = 0,1,0.6 do
			swait()
			sphere2(8,"Add",RightArm.CFrame*CFrame.new(0,-2,0)*CFrame.Angles(math.rad(90),0,0),VT(2.25,0.1,2.25),0.01,0.01,0.01,keptcolor,keptcolor.Color)
			slash(math.random(15,30)/10,5,true,"Round","Add","Out",RootPart.CFrame*CFrame.Angles(math.rad(math.random(-5,5)),math.rad(math.random(-5,5)),math.rad(math.random(-5,5))),VT(0.05,0.01,0.05),math.random(25,75)/250,BrickColor.new("White"))
			RightHip.C0=Clerp(RightHip.C0,CF(1,-1,0)*ANGLES(math.rad(0),math.rad(90),math.rad(0))*ANGLES(math.rad(-2.5),math.rad(0),math.rad(-5)),.6)
			LeftHip.C0=Clerp(LeftHip.C0,CF(-1,-1,0)*ANGLES(math.rad(0),math.rad(-90),math.rad(0))*ANGLES(math.rad(-2.5),math.rad(30),math.rad(0)),.6)
			RootJoint.C0=Clerp(RootJoint.C0,ROOTC0*CF(0,0,0)*ANGLES(math.rad(0),math.rad(0),math.rad(-90)),.6)
			Torso.Neck.C0=Clerp(Torso.Neck.C0,NECKC0*ANGLES(math.rad(20),math.rad(0),math.rad(-30)),.6)
			RightShoulder.C0=Clerp(RightShoulder.C0,CF(1.15,0.5,-0.5)*ANGLES(math.rad(90),math.rad(0),math.rad(-60)),.6)
			LeftShoulder.C0=Clerp(LeftShoulder.C0,CF(-1.15,0.5,0)*ANGLES(math.rad(-20),math.rad(0),math.rad(-10)),.6)
		end
		for i = 0,1,0.6 do
			swait()
			sphere2(8,"Add",RightArm.CFrame*CFrame.new(0,-2,0)*CFrame.Angles(math.rad(90),0,0),VT(2.25,0.1,2.25),0.01,0.01,0.01,keptcolor,keptcolor.Color)
			slash(math.random(15,30)/10,5,true,"Round","Add","Out",RootPart.CFrame*CFrame.Angles(math.rad(math.random(-5,5)),math.rad(math.random(-5,5)),math.rad(math.random(-5,5))),VT(0.05,0.01,0.05),math.random(25,75)/250,BrickColor.new("White"))
			RightHip.C0=Clerp(RightHip.C0,CF(1,-1,0)*ANGLES(math.rad(0),math.rad(90),math.rad(0))*ANGLES(math.rad(-2.5),math.rad(0),math.rad(-5)),.6)
			LeftHip.C0=Clerp(LeftHip.C0,CF(-1,-1,0)*ANGLES(math.rad(0),math.rad(-90),math.rad(0))*ANGLES(math.rad(-2.5),math.rad(30),math.rad(0)),.6)
			RootJoint.C0=Clerp(RootJoint.C0,ROOTC0*CF(0,0,0)*ANGLES(math.rad(0),math.rad(0),math.rad(-180)),.6)
			Torso.Neck.C0=Clerp(Torso.Neck.C0,NECKC0*ANGLES(math.rad(20),math.rad(0),math.rad(-30)),.6)
			RightShoulder.C0=Clerp(RightShoulder.C0,CF(1.15,0.5,-0.5)*ANGLES(math.rad(90),math.rad(0),math.rad(-60)),.6)
			LeftShoulder.C0=Clerp(LeftShoulder.C0,CF(-1.15,0.5,0)*ANGLES(math.rad(-20),math.rad(0),math.rad(-10)),.6)
		end
		for i = 0,1,0.6 do
			swait()
			sphere2(8,"Add",RightArm.CFrame*CFrame.new(0,-2,0)*CFrame.Angles(math.rad(90),0,0),VT(2.25,0.1,2.25),0.01,0.01,0.01,keptcolor,keptcolor.Color)
			slash(math.random(15,30)/10,5,true,"Round","Add","Out",RootPart.CFrame*CFrame.Angles(math.rad(math.random(-5,5)),math.rad(math.random(-5,5)),math.rad(math.random(-5,5))),VT(0.05,0.01,0.05),math.random(25,75)/250,BrickColor.new("White"))
			RightHip.C0=Clerp(RightHip.C0,CF(1,-1,0)*ANGLES(math.rad(0),math.rad(90),math.rad(0))*ANGLES(math.rad(-2.5),math.rad(0),math.rad(-5)),.6)
			LeftHip.C0=Clerp(LeftHip.C0,CF(-1,-1,0)*ANGLES(math.rad(0),math.rad(-90),math.rad(0))*ANGLES(math.rad(-2.5),math.rad(30),math.rad(0)),.6)
			RootJoint.C0=Clerp(RootJoint.C0,ROOTC0*CF(0,0,0)*ANGLES(math.rad(0),math.rad(0),math.rad(-270)),.6)
			Torso.Neck.C0=Clerp(Torso.Neck.C0,NECKC0*ANGLES(math.rad(20),math.rad(0),math.rad(-30)),.6)
			RightShoulder.C0=Clerp(RightShoulder.C0,CF(1.15,0.5,-0.5)*ANGLES(math.rad(90),math.rad(0),math.rad(-60)),.6)
			LeftShoulder.C0=Clerp(LeftShoulder.C0,CF(-1.15,0.5,0)*ANGLES(math.rad(-20),math.rad(0),math.rad(-10)),.6)
		end
		local rot = 0
		local dis = CreateParta(Effects,0.5,1,"Neon",keptcolor)
		CreateSound(763718160,Torso,10,1,false)
		dis.CFrame = RootPart.CFrame*CFrame.new(0,2,-3)
		createmesh(dis,"Sphere",10,1,10)
		local at1 = Instance.new("Attachment",dis)
		at1.Position = VT(-5,0,0)
		local at2 = Instance.new("Attachment",dis)
		at2.Position = VT(5,0,0)
		local a = Instance.new("Part",workspace)
		a.Name = "Direction"	
		a.Anchored = true
		a.BrickColor = BRICKC("Bright red")
		a.Material = "Neon"
		a.Transparency = 1
		a.CanCollide = false
		local ray = Ray.new(
			dis.CFrame.p,                           -- origin
			(mouse.Hit.p - dis.CFrame.p).unit * 500 -- direction
		) 
		local ignore = dis
		local hit, position, normal = workspace:FindPartOnRay(ray, ignore)
		a.BottomSurface = 10
		a.TopSurface = 10
		local distance = (dis.CFrame.p - position).magnitude
		a.Size = Vector3.new(0.1, 0.1, 0.1)
		a.CFrame = CFrame.new(dis.CFrame.p, position) * CFrame.new(0, 0, 0)
		dis.CFrame = a.CFrame
		dis.CFrame = dis.CFrame*CFrame.Angles(0,math.rad(rot),0)
		a:Destroy()
		local bv = Instance.new("BodyVelocity")
		bv.maxForce = Vector3.new(1e9, 1e9, 1e9)
		bv.velocity = dis.CFrame.lookVector*250
		bv.Parent = dis
		game:GetService("Debris"):AddItem(dis, 5)
		local hitted = false
		coroutine.resume(coroutine.create(function()
			dis.Touched:connect(function(hit) 
				if hitted == false and hit.Parent ~= Effects then
					hitted = true
					CreateSound(782200047,Torso,10,1,false)
					ApplyAoE(dis.Position,25)
					sphere2(8,"Add",dis.CFrame,VT(10,1,10),1,0.1,1,keptcolor,keptcolor.Color)
					sphere2(4,"Add",dis.CFrame,VT(1,1,1),0.5,0.5,0.5,keptcolor,keptcolor.Color)
					sphere2(3,"Add",dis.CFrame,VT(1,1,1),0.5,0.5,0.5,keptcolor,keptcolor.Color)
					coroutine.resume(coroutine.create(function()
						local eff = Instance.new("ParticleEmitter",dis)
						eff.Texture = "rbxassetid://2344870656"
						eff.LightEmission = 1
						eff.Color = ColorSequence.new(dis.Color)
						eff.Rate = 10000000
						eff.Enabled = true
						eff.EmissionDirection = "Front"
						eff.Lifetime = NumberRange.new(1)
						eff.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,75,0),NumberSequenceKeypoint.new(0.1,20,0),NumberSequenceKeypoint.new(0.8,40,0),NumberSequenceKeypoint.new(1,60,0)})
						eff.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0.8,0),NumberSequenceKeypoint.new(0.5,0,0),NumberSequenceKeypoint.new(1,1,0)})
						eff.Speed = NumberRange.new(150)
						eff.Drag = 5
						eff.Rotation = NumberRange.new(-500,500)
						eff.SpreadAngle = Vector2.new(0,900)
						eff.RotSpeed = NumberRange.new(-500,500)
						wait(0.2)
						eff.Enabled = false
					end))
					coroutine.resume(coroutine.create(function()
						for i = 0, 9 do
							local disr = CreateParta(Effects,1,1,"Neon",keptcolor)
							disr.CFrame = dis.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360)))
							local at1 = Instance.new("Attachment",disr)
							at1.Position = VT(-5,0,0)
							local at2 = Instance.new("Attachment",disr)
							at2.Position = VT(5,0,0)
							local trl = Instance.new('Trail',disr)
							trl.Attachment0 = at1
							trl.FaceCamera = true
							trl.Attachment1 = at2
							trl.Texture = "rbxassetid://2342682798"
							trl.LightEmission = 1
							trl.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0),NumberSequenceKeypoint.new(1, 1)})
							trl.Color = ColorSequence.new(keptcolor.Color)
							trl.Lifetime = 0.5
							local bv = Instance.new("BodyVelocity")
							bv.maxForce = Vector3.new(1e9, 1e9, 1e9)
							bv.velocity = disr.CFrame.lookVector*math.random(50,200)
							bv.Parent = disr
							local val2 = 0
							coroutine.resume(coroutine.create(function()
								swait(30)
								for i = 0, 9 do
									swait()
									val = val2 + 0.1
									trl.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, val),NumberSequenceKeypoint.new(1, 1)})
									ApplyAoE(disr.Position,25)
								end
								game:GetService("Debris"):AddItem(disr, 3)
							end))
						end
						ApplyAoE(dis.Position,25)
						local eff = Instance.new("ParticleEmitter",dis)
						eff.Texture = "rbxassetid://2273224484"
						eff.LightEmission = 1
						eff.Color = ColorSequence.new(keptcolor.Color)
						eff.Rate = 500000
						eff.Lifetime = NumberRange.new(0.5,2)
						eff.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,20,0),NumberSequenceKeypoint.new(0.2,2,0),NumberSequenceKeypoint.new(0.8,2,0),NumberSequenceKeypoint.new(1,0,0)})
						eff.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,1,0),NumberSequenceKeypoint.new(0.1,0,0),NumberSequenceKeypoint.new(0.8,0,0),NumberSequenceKeypoint.new(1,1,0)})
						eff.Speed = NumberRange.new(20,250)
						eff.Drag = 5
						eff.Rotation = NumberRange.new(-500,500)
						eff.VelocitySpread = 9000
						eff.RotSpeed = NumberRange.new(-50,50)
						wait(0.25)
						eff.Enabled = false
					end))
					for i = 0, 9 do
						slash(math.random(10,20)/10,5,true,"Round","Add","Out",dis.CFrame*CFrame.Angles(math.rad(math.random(-5,5)),math.rad(math.random(-5,5)),math.rad(math.random(-5,5))),VT(0.01,0.01,0.01),math.random(100,200)/250,BrickColor.new("White"))
					end
					for i = 0, 19 do
						PixelBlock(1,math.random(5,20),"Add",dis.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),4,4,4,0.08,keptcolor,0)
					end
					coroutine.resume(coroutine.create(function()
						for i = 0, 19 do
							swait()
							ShakeCam(1,10)
						end
					end))
					dis.Anchored = true
					dis.Transparency = 1
					wait(8)
					dis:Destroy()
				end
			end)
		end))
		rot = rot - 15
	end
	for i = 0,2,0.1 do
		swait()
		RightHip.C0=Clerp(RightHip.C0,CF(1,-1,0)*ANGLES(math.rad(0),math.rad(90),math.rad(0))*ANGLES(math.rad(-2.5),math.rad(-30),math.rad(0)),.3)
		LeftHip.C0=Clerp(LeftHip.C0,CF(-1,-1,0)*ANGLES(math.rad(0),math.rad(-90),math.rad(0))*ANGLES(math.rad(-2.5),math.rad(0),math.rad(5)),.3)
		RootJoint.C0=Clerp(RootJoint.C0,ROOTC0*CF(0,0,0)*ANGLES(math.rad(0),math.rad(0),math.rad(-60)),.3)
		Torso.Neck.C0=Clerp(Torso.Neck.C0,NECKC0*ANGLES(math.rad(10),math.rad(0),math.rad(50)),.3)
		RightShoulder.C0=Clerp(RightShoulder.C0,CF(1.5,0.5,0)*ANGLES(math.rad(90),math.rad(0),math.rad(60)),.3)
		LeftShoulder.C0=Clerp(LeftShoulder.C0,CF(-1.5,0.5,0)*ANGLES(math.rad(-20),math.rad(0),math.rad(-10)),.3)
	end
	ATTACK = false
	Speed = 35
end

function attackthree()
	ATTACK = true
	local keptcolor = BrickColor.new("New Yeller")
	CreateSound(136007472,Torso,10,1,false)
	for i = 0,2,0.1 do
		swait()
		sphere2(5,"Add",LeftArm.CFrame*CFrame.new(0,-1.5,0),VT(1,1,1),0.025,0.025,0.025,BrickColor.new("New Yeller"),BrickColor.new("New Yeller").Color)
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0*CF(0,0,0)* ANGLES(math.rad(10),math.rad(0),math.rad(50)),0.3)
		Torso.Neck.C0 = Clerp(Torso.Neck.C0,NECKC0 *ANGLES(math.rad(5),math.rad(0),math.rad(-50)),.3)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CFrame.new(1.5, 0.5, 0) * ANGLES(math.rad(80), math.rad(10), math.rad(60)), 0.3)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CFrame.new(-1.5, 0.5, 0) * ANGLES(math.rad(140), math.rad(0), math.rad(-70)), 0.3)
		RightHip.C0=Clerp(RightHip.C0,CF(1,-1,0)*ANGLES(math.rad(0),math.rad(90),math.rad(0))*ANGLES(math.rad(-1.5),math.rad(-50),math.rad(-10)),.3)
		LeftHip.C0=Clerp(LeftHip.C0,CF(-1,-1,0)*ANGLES(math.rad(0),math.rad(-90),math.rad(0))*ANGLES(math.rad(-2.5),math.rad(0),math.rad(40)),.3)
	end
	CreateSound(763716870,Torso,10,1,false)
	CreateSound(782353443,Torso,10,1,false)
	CreateSound(782225570,Torso,10,1,false)
	CreateSound(763717569,Torso,10,1,false)
	sphere2(5,"Add",RootPart.CFrame,VT(1,1,1),1,1,1,BrickColor.new("New Yeller"))
	sphere2(5,"Add",RootPart.CFrame,VT(1,1,1),0.5,0.5,0.5,BrickColor.new("New Yeller"))
	for i = 0, 24 do
		slash(math.random(10,50)/10,5,true,"Round","Add","Out",RootPart.CFrame*CFrame.Angles(math.rad(90),math.rad(math.random(-360,360)),math.rad(0)),VT(0.01,0.01,0.01),math.random(50,200)/250,BrickColor.new("White"))
	end
	for i = 0,4,0.1 do
		swait()
		RootPart.CFrame = RootPart.CFrame + RootPart.CFrame.lookVector*5
		local dis = CreateParta(Effects,0.25,1,"Neon",BrickColor.new("New Yeller"))
		createmesh(dis,"Sphere",1,1,1)
		dis.Anchored = true
		dis.CFrame = LeftArm.CFrame*CFrame.new(0,-3,0)
		sphere2(5,"Add",dis.CFrame,VT(1,1,1),0.1,0.1,0.1,dis.BrickColor,dis.Color)
		coroutine.resume(coroutine.create(function()
			swait(30)
			dis.Transparency = 1
			coroutine.resume(coroutine.create(function()
				for i = 0, 19 do
					swait()
					ShakeCam(1,5)
				end
			end))
			coroutine.resume(coroutine.create(function()
				ApplyAoE(dis.Position,25)
				local eff = Instance.new("ParticleEmitter",dis)
				eff.Texture = "rbxassetid://2273224484"
				eff.LightEmission = 1
				eff.Color = ColorSequence.new(dis.Color)
				eff.Rate = 500000
				eff.Lifetime = NumberRange.new(0.5,2)
				eff.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,20,0),NumberSequenceKeypoint.new(0.2,2,0),NumberSequenceKeypoint.new(0.8,2,0),NumberSequenceKeypoint.new(1,0,0)})
				eff.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,1,0),NumberSequenceKeypoint.new(0.1,0,0),NumberSequenceKeypoint.new(0.8,0,0),NumberSequenceKeypoint.new(1,1,0)})
				eff.Speed = NumberRange.new(50,450)
				eff.Drag = 5
				eff.Rotation = NumberRange.new(-500,500)
				eff.VelocitySpread = 9000
				eff.RotSpeed = NumberRange.new(-50,50)
				wait(0.125)
				eff.Enabled = false
			end))
			ApplyAoE(dis.Position,25)
			for i = 0, 2 do
				slash(math.random(10,80)/10,5,true,"Round","Add","Out",dis.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),VT(0.01,0.01,0.01),math.random(50,150)/250,dis.BrickColor)
			end
			CreateSound(782353117,Torso,10,1,false)
			CreateSound(1666361078,Torso,10,1,false)
			CreateSound(782353443,Torso,10,1,false)
			sphere2(3,"Add",dis.CFrame,VT(1,1,1),0.4,0.4,0.4,dis.BrickColor,dis.Color)
		end))
		game:GetService("Debris"):AddItem(dis, 5)
		RootJoint.C0 = Clerp(RootJoint.C0,ROOTC0*CF(0,0,0)* ANGLES(math.rad(89),math.rad(-8),math.rad(-5)),0.5)
		Torso.Neck.C0 = Clerp(Torso.Neck.C0,NECKC0 *ANGLES(math.rad(-30),math.rad(0),math.rad(8)),.5)
		RightShoulder.C0 = Clerp(RightShoulder.C0, CFrame.new(1.5, 0.5, 0) * ANGLES(math.rad(-14), math.rad(1), math.rad(17)), 0.5)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CFrame.new(-1.5, 0.85, 0) * ANGLES(math.rad(180), math.rad(0), math.rad(-8)), 0.5)
		LeftShoulder.C0=Clerp(LeftShoulder.C0,CF(1,-0.5,-0.6)*ANGLES(math.rad(0),math.rad(90),math.rad(0))*ANGLES(math.rad(-8),math.rad(0),math.rad(-20)),.5)
		LeftShoulder.C0=Clerp(LeftShoulder.C0,CF(-1,-1,0)*ANGLES(math.rad(0),math.rad(-90),math.rad(0))*ANGLES(math.rad(9),math.rad(0),math.rad(20)),.5)
	end
	ATTACK = false
	Speed = 35
end

function ball()
	ATTACK = true
	Rooted = true
	local truescale = 0
	local rd = math.random(1,3)
	CreateSound(1368583274,Torso,10,1,false)
	for i = 0,49,0.1 do
		swait()
		truescale = truescale + 0.2
		ShakeCam(3,10)
		slash(5,5,true,"Round","Add","Out",RootPart.CFrame*CFrame.new(0,75,0)*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),VT(3,0.01,3),-3,BrickColor.new("New Yeller"))
		block(10,"Add",RootPart.CFrame*CFrame.new(0,75,0)*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),VT(truescale,truescale,truescale),0.01,0.01,0.01,BrickColor.new("New Yeller"),BrickColor.new("New Yeller").Color)
		RightHip.C0=Clerp(RightHip.C0,CF(1,-0.5,-0.5)*ANGLES(math.rad(0),math.rad(90),math.rad(0))*ANGLES(math.rad(-3),math.rad(5),math.rad(-10)),.5)
		LeftHip.C0=Clerp(LeftHip.C0,CF(-1,-1,0)*ANGLES(math.rad(0),math.rad(-90),math.rad(0))*ANGLES(math.rad(-3),math.rad(1),math.rad(5)),.5)
		RootJoint.C0=Clerp(RootJoint.C0,ROOTC0*CF(0,0,1)*ANGLES(math.rad(0),math.rad(0),math.rad(40)),.5)
		Torso.Neck.C0=Clerp(Torso.Neck.C0,NECKC0*ANGLES(math.rad(20),math.rad(0),math.rad(-40)),.5)
		RightShoulder.C0=Clerp(RightShoulder.C0,CF(1.45,1,0.1)*ANGLES(math.rad(180),math.rad(-30),math.rad(-5)),.5)
		LeftShoulder.C0=Clerp(LeftShoulder.C0,CF(-1.45,0.5,0.1)*ANGLES(math.rad(-5),math.rad(10),math.rad(-10)),.5)
	end
	CreateSound(260411131,Torso,10,1,false)
	for i = 0,2,0.1 do
		swait()
		block(10,"Add",RightArm.CFrame*CFrame.new(0,-1.5,0)*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),VT(1,1,1),0.01,0.01,0.01,BrickColor.new("New Yeller"),BrickColor.new("New Yeller").Color)
		RightHip.C0=Clerp(RightHip.C0,CF(1,-0.5,-0.5)*ANGLES(math.rad(0),math.rad(90),math.rad(0))*ANGLES(math.rad(-3),math.rad(5),math.rad(-10)),.5)
		LeftHip.C0=Clerp(LeftHip.C0,CF(-1,-1,0)*ANGLES(math.rad(0),math.rad(-90),math.rad(0))*ANGLES(math.rad(-3),math.rad(1),math.rad(5)),.5)
		RootJoint.C0=Clerp(RootJoint.C0,ROOTC0*CF(0,0,1)*ANGLES(math.rad(0),math.rad(0),math.rad(55)),.5)
		Torso.Neck.C0=Clerp(Torso.Neck.C0,NECKC0*ANGLES(math.rad(10),math.rad(0),math.rad(-55)),.5)
		RightShoulder.C0=Clerp(RightShoulder.C0,CF(1.15,0.5,-0.6)*ANGLES(math.rad(90),math.rad(0),math.rad(-50)),.5)
		LeftShoulder.C0=Clerp(LeftShoulder.C0,CF(-1.45,0.5,0.1)*ANGLES(math.rad(-5),math.rad(10),math.rad(-10)),.5)
	end
	local orb = Instance.new("Part", Effects)
	for i = 0, 4 do
		CreateSound(335657174,Torso,10,1,false)
	end
	local efec = Instance.new("ParticleEmitter",orb)
	efec.Texture = "rbxassetid://2109052855"
	efec.LightEmission = 1
	efec.Color = ColorSequence.new(BrickColor.new("New Yeller").Color)
	efec.Rate = 5
	efec.Lifetime = NumberRange.new(3)
	efec.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,100,0),NumberSequenceKeypoint.new(0.2,175,0),NumberSequenceKeypoint.new(0.6,110,0),NumberSequenceKeypoint.new(0.8,175,0),NumberSequenceKeypoint.new(1,200,0)})
	efec.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,1,0),NumberSequenceKeypoint.new(0.1,0.25,0),NumberSequenceKeypoint.new(0.6,0.25,0),NumberSequenceKeypoint.new(1,1,0)})
	efec.Drag = 5
	efec.LockedToPart = true
	efec.Rotation = NumberRange.new(-500,500)
	efec.VelocitySpread = 9000
	efec.RotSpeed = NumberRange.new(-500,500)
	orb.BrickColor = BrickColor.new("New Yeller")
	orb.CanCollide = false
	orb.FormFactor = 3
	orb.Name = "Ring"
	orb.Material = "Neon"
	orb.Size = Vector3.new(1, 1, 1)
	orb.Transparency = 0
	orb.TopSurface = 0
	orb.BottomSurface = 0
	local orbm = Instance.new("SpecialMesh", orb)
	orbm.MeshType = "Sphere"
	orbm.Name = "SizeMesh"
	orbm.Scale = VT(25,25,25)
	orb.CFrame = RootPart.CFrame + RootPart.CFrame.lookVector*3
	local a = Instance.new("Part",workspace)
	a.Name = "Direction"	
	a.Anchored = true
	a.BrickColor = BrickColor.new("New Yeller")
	a.Material = "Neon"
	a.Transparency = 1
	a.CanCollide = false
	local ray = Ray.new(
		orb.CFrame.p,                           -- origin
		(mouse.Hit.p - orb.CFrame.p).unit * 500 -- direction
	) 
	local ignore = orb
	local hit, position, normal = workspace:FindPartOnRay(ray, ignore)
	a.BottomSurface = 10
	a.TopSurface = 10
	local distance = (orb.CFrame.p - position).magnitude
	a.Size = Vector3.new(0.1, 0.1, 0.1)
	a.CFrame = CFrame.new(orb.CFrame.p, position) * CFrame.new(0, 0, 0)
	orb.CFrame = a.CFrame
	a:Destroy()
	local over = false
	local bgui,imgc = createBGCircle(250,orb,BrickColor.new("New Yeller").Color)
	bgui.AlwaysOnTop = true
	imgc.Image = "rbxassetid://2076519836"
	coroutine.resume(coroutine.create(function()
		while true do
			swait()
			if over == false then
				slash(10,2,true,"Round","Add","Out",orb.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),VT(0.01,0.01,0.01),1,BrickColor.new("New Yeller"))
				imgc.Rotation = imgc.Rotation + 5
				imgc.ImageTransparency = 0.75 + 0.25 * math.cos(SINE / 15)
				bgui.Size = UDim2.new(250 + 25 * math.cos(SINE / 15),0, 250 + 25 * math.cos(SINE / 15),0)
			elseif over == true then
				break
			end
		end
	end))
	local bv = Instance.new("BodyVelocity")
	bv.maxForce = Vector3.new(1e9, 1e9, 1e9)
	bv.velocity = orb.CFrame.lookVector*50
	bv.Parent = orb
	coroutine.resume(coroutine.create(function()
		wait(10)
		over = true
		efec.Enabled = false
		orb.Anchored = true
		for i = 0, 2 do
			CreateSound(1664711478,Torso,10,1,false)
			CreateSound(763717897,Torso,10,1,false)
			CreateSound(763718160,Torso,10,1,false)
			CreateSound(782353443,Torso,10,1,false)
			CreateSound(335657174,Torso,10,1,false)
			CreateSound(167115397,Torso,10,1,false)
		end
		for i = 0, 2 do
			block(3,"Add",orb.CFrame,VT(1,1,1),6.5,6.5,6.5,BrickColor.new("New Yeller"),BrickColor.new("New Yeller").Color)
			block(2,"Add",orb.CFrame,VT(1,1,1),6,6,6,BrickColor.new("New Yeller"),BrickColor.new("New Yeller").Color)
			block(1,"Add",orb.CFrame,VT(1,1,1),4.5,4.5,4.5,BrickColor.new("New Yeller"),BrickColor.new("New Yeller").Color)
		end
		for i = 0, 49 do
			slash(math.random(10,30)/10,5,true,"Round","Add","Out",orb.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),VT(0.01,0.01,0.01),math.random(150,2500)/250,BrickColor.new("New Yeller"))
		end
		imgc.ImageTransparency = 0
		ShakeCam(25,100)
		for i = 0, 199 do
			swait()
			coroutine.resume(coroutine.create(function()
				ApplyAoE(orb.Position,9e9)
			end))
			imgc.Rotation = imgc.Rotation + 10
			local dis = CreateParta(Effects,1,1,"Neon",BrickColor.new("New Yeller"))
			dis.CFrame = orb.CFrame*CFrame.new(math.random(-5,5),math.random(-5,5),math.random(-5,5))*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360)))
			local at1 = Instance.new("Attachment",dis)
			at1.Position = VT(-25000,0,0)
			local at2 = Instance.new("Attachment",dis)
			at2.Position = VT(25000,0,0)
			local trl = Instance.new('Trail',dis)
			trl.Attachment0 = at1
			trl.FaceCamera = true
			trl.Attachment1 = at2
			trl.Texture = "rbxassetid://1049219073"
			trl.LightEmission = 1
			trl.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0),NumberSequenceKeypoint.new(1, 1)})
			trl.Color = ColorSequence.new(BrickColor.new("New Yeller").Color)
			trl.Lifetime = 5
			local bv = Instance.new("BodyVelocity")
			bv.maxForce = Vector3.new(1e9, 1e9, 1e9)
			bv.velocity = dis.CFrame.lookVector*math.random(500,2500)
			bv.Parent = dis
			game:GetService("Debris"):AddItem(dis, 5)
			sphere2(15,"Add",orb.CFrame,VT(1.25,1.25,1.25),45,45,45,BrickColor.new("New Yeller"))
			for i = 0, 2 do
				slash(15,5,true,"Round","Add","Out",orb.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),VT(0.01,0.01,0.01),25,BrickColor.new("New Yeller"))
				slash(15,5,true,"Round","Add","Out",orb.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),VT(0.01,0.01,0.01),50,BrickColor.new("New Yeller"))
			end
			orbm.Scale = orbm.Scale + VT(10,10,10)
			orb.Transparency = orb.Transparency + 0.005
			imgc.ImageTransparency = imgc.ImageTransparency + 0.005
			bgui.Size = bgui.Size + UDim2.new(35,0,35,0)
		end
		game:GetService("Debris"):AddItem(orb, 10)
	end))
	for i = 0,2,0.1 do
		swait()
		RightHip.C0=Clerp(RightHip.C0,CF(1,-0.5,-0.5)*ANGLES(math.rad(0),math.rad(90),math.rad(0))*ANGLES(math.rad(-3),math.rad(5),math.rad(-10)),.5)
		LeftHip.C0=Clerp(LeftHip.C0,CF(-1,-1,0)*ANGLES(math.rad(0),math.rad(-90),math.rad(0))*ANGLES(math.rad(-3),math.rad(20),math.rad(10)),.5)
		RootJoint.C0=Clerp(RootJoint.C0,ROOTC0*CF(0,-0.3,1)*ANGLES(math.rad(5),math.rad(0),math.rad(-45)),.5)
		Torso.Neck.C0=Clerp(Torso.Neck.C0,NECKC0*ANGLES(math.rad(10),math.rad(0),math.rad(45)),.5)
		RightShoulder.C0=Clerp(RightShoulder.C0,CF(1.45,0.5,0)*ANGLES(math.rad(90),math.rad(0),math.rad(50)),.5)
		LeftShoulder.C0=Clerp(LeftShoulder.C0,CF(-1.45,0.5,0.1)*ANGLES(math.rad(20),math.rad(10),math.rad(-30)),.5)
	end
	ATTACK = false
	Rooted = false
end

function Spin()
	ATTACK = true
	Speed = 3
	CreateSound(1368583274,Torso,10,1,false)
	local bgui = Instance.new("BillboardGui",RootPart)
	bgui.Size = UDim2.new(25, 0, 25, 0)
	local imgc = Instance.new("ImageLabel",bgui)
	imgc.BackgroundTransparency = 1
	imgc.ImageTransparency = 1
	imgc.Size = UDim2.new(1,0,1,0)
	imgc.Image = "rbxassetid://997291547"
	imgc.ImageColor3 = Color3.new(1,1,0)
	local imgc2 = imgc:Clone()
	imgc2.Parent = bgui
	imgc2.Position = UDim2.new(-0.5,0,-0.5,0)
	imgc2.Size = UDim2.new(2,0,2,0)
	imgc2.ImageColor3 = Color3.new(1,1,0)
	for i = 0, 10, 0.1 do
		swait()
		imgc.ImageTransparency = imgc.ImageTransparency - 0.01
		imgc.Rotation = imgc.Rotation + 1
		imgc2.ImageTransparency = imgc2.ImageTransparency - 0.01
		imgc2.Rotation = imgc2.Rotation - 1
		bgui.Size = bgui.Size - UDim2.new(0.25, 0, 0.25, 0)
		slash(math.random(50,100)/10,5,true,"Round","Add","Out",RootPart.CFrame*CFrame.new(0,-3,0)*CFrame.Angles(math.rad(math.random(-10,10)),math.rad(math.random(-360,360)),math.rad(math.random(-10,10))),VT(0.1,0.01,0.1),math.random(25,50)/250,BrickColor.new("White"))
		sphere2(5,"Add",Sword.CFrame*CFrame.new(math.random(-8,-2),0,0)*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),VT(0.1,0.1,0.1),0,0.1,0,BrickColor.new("Cyan"),BrickColor.new("Cyan").Color)
		waveEff(5,"Add","In",RootPart.CFrame*CFrame.new(0,-3,0)*CFrame.Angles(0,math.rad(math.random(-360,360)),0),VT(15,0.25,15),-0.075,0.05,BrickColor.new("White"))
		RightHip.C0=Clerp(RightHip.C0,CF(1,-0.5,0)*ANGLES(math.rad(0),math.rad(90),math.rad(0))*ANGLES(math.rad(-3),math.rad(-40),math.rad(10)),.2)
		LeftHip.C0=Clerp(LeftHip.C0,CF(-1,-1,0)*ANGLES(math.rad(0),math.rad(-90),math.rad(0))*ANGLES(math.rad(-3),math.rad(1),math.rad(20)),.2)
		RootJoint.C0=Clerp(RootJoint.C0,ROOTC0*CF(0.1,0.2,-0.3)*ANGLES(math.rad(10),math.rad(0),math.rad(50)),.3)
		Torso.Neck.C0=Clerp(Torso.Neck.C0,NECKC0*ANGLES(math.rad(5),math.rad(0),math.rad(-50)),.3)
		RightShoulder.C0=Clerp(RightShoulder.C0,CF(1.25,0.5,-0.65)*ANGLES(math.rad(100),math.rad(0),math.rad(-23))*ANGLES(RAD(0),RAD(90),RAD(0)),.3)
		LeftShoulder.C0=Clerp(LeftShoulder.C0,CF(-1.45,0.5,0.1)*ANGLES(math.rad(110),math.rad(0),math.rad(-85))*ANGLES(RAD(0),RAD(-90),RAD(0)),.3)
	end
	imgc.ImageTransparency = 1
	waveEff(2,"Add","Out",RootPart.CFrame*CFrame.new(0,0,0)*CFrame.Angles(math.rad(90),math.rad(math.random(-360,360)),0),VT(6,10,6),0.5,0.8,BrickColor.new("White"))
	waveEff(3,"Add","Out",RootPart.CFrame*CFrame.new(0,0,0)*CFrame.Angles(math.rad(90),math.rad(math.random(-360,360)),0),VT(6,10,6),0.5,0.4,BrickColor.new("White"))
	waveEff(4,"Add","Out",RootPart.CFrame*CFrame.new(0,0,0)*CFrame.Angles(math.rad(90),math.rad(math.random(-360,360)),0),VT(6,10,6),0.5,0.2,BrickColor.new("White"))
	waveEff(5,"Add","Out",RootPart.CFrame*CFrame.new(0,0,0)*CFrame.Angles(math.rad(90),math.rad(math.random(-360,360)),0),VT(6,10,6),0.5,0.1,BrickColor.new("White"))
	waveEff(6,"Add","Out",RootPart.CFrame*CFrame.new(0,0,0)*CFrame.Angles(math.rad(90),math.rad(math.random(-360,360)),0),VT(6,10,6),0.5,0.05,BrickColor.new("White"))
	for i = 0, 9 do
		slash(math.random(10,25)/10,5,true,"Round","Add","Out",RootPart.CFrame*CFrame.new(0,0,math.random(-30,15))*CFrame.Angles(math.rad(90 + math.random(-10,10)),math.rad(math.random(-360,360)),math.rad(math.random(-10,10))),VT(0.1,0.01,0.1),math.random(75,250)/250,BrickColor.new("White"))
	end
	--CreateSound(430315987,Torso,10,1,false)
	CreateSound(1295446488,Torso,10,1,false)
	for x = 0, 14 do
		CreateSound(200633281,Torso,10,1,false)
		CreateSound(161006195,Torso,10,1,false)
		ApplyAoE(Torso.Position,10)
		CreateSound(200632992,Torso,10,1,false)
		slash(5,5,true,"Round","Add","Out",RootPart.CFrame*CFrame.new(0,3,0)*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),VT(0.05,0.01,0.05),math.random(1,10)/100,BrickColor.new("White"))
		for i = 0, 1, 0.6 do
			swait()
			RootPart.CFrame = RootPart.CFrame + RootPart.CFrame.lookVector*2
			RootPart.Velocity = VT(0,0,0)
			RightHip.C0=Clerp(RightHip.C0,CF(1,-1,0)*ANGLES(math.rad(0),math.rad(90),math.rad(0))*ANGLES(math.rad(-3),math.rad(0),math.rad(0)),.2)
			LeftHip.C0=Clerp(LeftHip.C0,CF(-1,-1,0)*ANGLES(math.rad(0),math.rad(-90),math.rad(0))*ANGLES(math.rad(-3),math.rad(0),math.rad(0)),.2)
			RootJoint.C0=Clerp(RootJoint.C0,ROOTC0*CF(0,0,3)*ANGLES(math.rad(0),math.rad(0),math.rad(90)),.3)
			Torso.Neck.C0=Clerp(Torso.Neck.C0,NECKC0*ANGLES(math.rad(4),math.rad(0),math.rad(-60)),.3)
			RightShoulder.C0=Clerp(RightShoulder.C0,CF(1.45,0.5,0.1)*ANGLES(math.rad(90),math.rad(0),math.rad(90)),.3)
			LeftShoulder.C0=Clerp(LeftShoulder.C0,CF(-1.45,0.5,0.1)*ANGLES(math.rad(90),math.rad(0),math.rad(-90)),.3)
		end
		slash(5,2.5,true,"Round","Add","Out",RootPart.CFrame*CFrame.new(0,3,0)*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),VT(0.05,0.01,0.05),math.random(1,10)/100,BrickColor.new("White"))
		CreateSound(200632992,Torso,10,1,false)
		ApplyAoE(Torso.Position,10)
		for i = 0, 1, 0.6 do
			swait()
			RootPart.CFrame = RootPart.CFrame + RootPart.CFrame.lookVector*3
			RootPart.Velocity = VT(0,0,0)
			RightHip.C0=Clerp(RightHip.C0,CF(1,-1,0)*ANGLES(math.rad(0),math.rad(90),math.rad(0))*ANGLES(math.rad(-3),math.rad(0),math.rad(0)),.2)
			LeftHip.C0=Clerp(LeftHip.C0,CF(-1,-1,0)*ANGLES(math.rad(0),math.rad(-90),math.rad(0))*ANGLES(math.rad(-3),math.rad(0),math.rad(0)),.2)
			RootJoint.C0=Clerp(RootJoint.C0,ROOTC0*CF(0,0,3)*ANGLES(math.rad(90),math.rad(0),math.rad(90)),.3)
			Torso.Neck.C0=Clerp(Torso.Neck.C0,NECKC0*ANGLES(math.rad(4),math.rad(0),math.rad(-60)),.3)
			RightShoulder.C0=Clerp(RightShoulder.C0,CF(1.45,0.5,0.1)*ANGLES(math.rad(90),math.rad(0),math.rad(90)),.3)
			LeftShoulder.C0=Clerp(LeftShoulder.C0,CF(-1.45,0.5,0.1)*ANGLES(math.rad(90),math.rad(0),math.rad(-90)),.3)
		end
		slash(5,2.5,true,"Round","Add","Out",RootPart.CFrame*CFrame.new(0,3,0)*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),VT(0.05,0.01,0.05),math.random(1,10)/100,BrickColor.new("White"))
		CreateSound(200632992,Torso,10,1,false)
		ApplyAoE(Torso.Position,10)
		for i = 0, 1, 0.6 do
			swait()
			RootPart.CFrame = RootPart.CFrame + RootPart.CFrame.lookVector*3
			RootPart.Velocity = VT(0,0,0)
			RightHip.C0=Clerp(RightHip.C0,CF(1,-1,0)*ANGLES(math.rad(0),math.rad(90),math.rad(0))*ANGLES(math.rad(-3),math.rad(0),math.rad(0)),.2)
			LeftHip.C0=Clerp(LeftHip.C0,CF(-1,-1,0)*ANGLES(math.rad(0),math.rad(-90),math.rad(0))*ANGLES(math.rad(-3),math.rad(0),math.rad(0)),.2)
			RootJoint.C0=Clerp(RootJoint.C0,ROOTC0*CF(0,0,3)*ANGLES(math.rad(180),math.rad(0),math.rad(90)),.3)
			Torso.Neck.C0=Clerp(Torso.Neck.C0,NECKC0*ANGLES(math.rad(4),math.rad(0),math.rad(-60)),.3)
			RightShoulder.C0=Clerp(RightShoulder.C0,CF(1.45,0.5,0.1)*ANGLES(math.rad(90),math.rad(0),math.rad(90)),.3)
			LeftShoulder.C0=Clerp(LeftShoulder.C0,CF(-1.45,0.5,0.1)*ANGLES(math.rad(90),math.rad(0),math.rad(-90)),.3)
		end
		slash(5,2.5,true,"Round","Add","Out",RootPart.CFrame*CFrame.new(0,3,0)*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),VT(0.05,0.01,0.05),math.random(1,10)/100,BrickColor.new("White"))
		CreateSound(200632992,Torso,10,1,false)
		ApplyAoE(Torso.Position,10)for i = 0, 1, 0.6 do
			swait()
			RootPart.CFrame = RootPart.CFrame + RootPart.CFrame.lookVector*3
			RootPart.Velocity = VT(0,0,0)
			RightHip.C0=Clerp(RightHip.C0,CF(1,-1,0)*ANGLES(math.rad(0),math.rad(90),math.rad(0))*ANGLES(math.rad(-3),math.rad(0),math.rad(0)),.2)
			LeftHip.C0=Clerp(LeftHip.C0,CF(-1,-1,0)*ANGLES(math.rad(0),math.rad(-90),math.rad(0))*ANGLES(math.rad(-3),math.rad(0),math.rad(0)),.2)
			RootJoint.C0=Clerp(RootJoint.C0,ROOTC0*CF(0,0,3)*ANGLES(math.rad(270),math.rad(0),math.rad(90)),.3)
			Torso.Neck.C0=Clerp(Torso.Neck.C0,NECKC0*ANGLES(math.rad(4),math.rad(0),math.rad(-60)),.3)
			RightShoulder.C0=Clerp(RightShoulder.C0,CF(1.45,0.5,0.1)*ANGLES(math.rad(90),math.rad(0),math.rad(90)),.3)
			LeftShoulder.C0=Clerp(LeftShoulder.C0,CF(-1.45,0.5,0.1)*ANGLES(math.rad(90),math.rad(0),math.rad(-90)),.3)
		end
	end
	for i = 0, 2.5, 0.1 do
		swait()
		RightHip.C0=Clerp(RightHip.C0,CF(1,-1,0)*ANGLES(math.rad(0),math.rad(90),math.rad(0))*ANGLES(math.rad(-3),math.rad(0),math.rad(-20)),.2)
		LeftHip.C0=Clerp(LeftHip.C0,CF(-1,-0.6,-0.5)*ANGLES(math.rad(0),math.rad(-90),math.rad(0))*ANGLES(math.rad(-3),math.rad(20),math.rad(-12)),.2)
		RootJoint.C0=Clerp(RootJoint.C0,ROOTC0*CF(0.1,0.2,-0.35)*ANGLES(math.rad(10),math.rad(0),math.rad(-40)),.2)
		Torso.Neck.C0=Clerp(Torso.Neck.C0,NECKC0*ANGLES(math.rad(5),math.rad(0),math.rad(40)),.2)
		RightShoulder.C0=Clerp(RightShoulder.C0,CF(1.45,0.5,0)*ANGLES(math.rad(90),math.rad(0),math.rad(110))*ANGLES(RAD(0),RAD(90),RAD(0)),.2)
		LeftShoulder.C0=Clerp(LeftShoulder.C0,CF(-1.45,0.5,0)*ANGLES(math.rad(45),math.rad(0),math.rad(-20))*ANGLES(RAD(0),RAD(-90),RAD(0)),.2)
	end
	bgui:Destroy()
	ATTACK = false
	Speed = 35
end

function violent()
	ATTACK = true
	Rooted = true
	local highuppos = Hole.Position+VT(0,1000,0)
	for i = 0, 2.5, 0.1 do
		swait()
		RightHip.C0=Clerp(RightHip.C0,CF(1,-1 + 0.05 * math.cos(SINE / 20)  - 0.02 * math.cos(SINE / 40),0)*ANGLES(math.rad(0),math.rad(90),math.rad(0))*ANGLES(math.rad(-3 + 2 * math.cos(SINE / 40)),math.rad(-15),math.rad(0 + 2 * math.cos(SINE / 20))),.1)
		LeftHip.C0=Clerp(LeftHip.C0,CF(-1,-1 + 0.05 * math.cos(SINE / 20) - 0.02 * math.cos(SINE / 40),0)*ANGLES(math.rad(0),math.rad(-90),math.rad(0))*ANGLES(math.rad(-3 - 2 * math.cos(SINE / 40)),math.rad(1),math.rad(0 - 2 * math.cos(SINE / 20))),.1)
		RootJoint.C0=Clerp(RootJoint.C0,ROOTC0*CF(0 + 0.02 * math.cos(SINE / 40),0 - 0.02 * math.cos(SINE / 40),-0.05 - 0.05 * math.cos(SINE / 20))*ANGLES(math.rad(0 + 2 * math.cos(SINE / 20)),math.rad(0 + 2 * math.cos(SINE / 40)),math.rad(30 + 3 * math.cos(SINE / 40))),.1)
		Torso.Neck.C0=Clerp(Torso.Neck.C0,NECKC0*ANGLES(math.rad(2),math.rad(0 - 7 * math.cos(SINE / 40)),math.rad(-30 - 3 * math.cos(SINE / 40))),.1)
		RightShoulder.C0=Clerp(RightShoulder.C0,CF(1,0.5 + 0.05 * math.cos(SINE / 28),0.1)*ANGLES(math.rad(-6 + 5 * math.cos(SINE / 26)),math.rad(-10 - 6 * math.cos(SINE / 24)),math.rad(13 - 5 * math.cos(SINE / 34)))*ANGLES(RAD(0),RAD(90),RAD(0)),.1)
		LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(180), RAD(180), RAD(0)) * RIGHTSHOULDERC0, 0.8 / 3)
	end
	WACKYEFFECT({Time = 25, EffectType = "Slash", Size = VT(0,0,0), Size2 = VT(0.1,0,0.1)*MRANDOM(1000/1000,1750/1000), Transparency = 0, Transparency2 = 1, CFrame = Hole.CFrame*ANGLES(RAD(MRANDOM(-360,360)),RAD(MRANDOM(-360,360)),RAD(MRANDOM(-360,360))), MoveToPos = nil, RotationX = 0, RotationY = MRANDOM(-100/100,100/100), RotationZ = 0, Material = "Neon", Color = C3(1,1,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil})
	WACKYEFFECT({Time = 25, EffectType = "Slash", Size = VT(0,0,0), Size2 = VT(0.1,0,0.1)*MRANDOM(1000/1000,1750/1000), Transparency = 0, Transparency2 = 1, CFrame = Hole.CFrame*ANGLES(RAD(MRANDOM(-360,360)),RAD(MRANDOM(-360,360)),RAD(MRANDOM(-360,360))), MoveToPos = nil, RotationX = 0, RotationY = MRANDOM(-100/100,100/100), RotationZ = 0, Material = "Neon", Color = C3(1,1,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil})
	WACKYEFFECT({Time = 25, EffectType = "Slash", Size = VT(0,0,0), Size2 = VT(0.1,0,0.1)*MRANDOM(1000/1000,1750/1000), Transparency = 0, Transparency2 = 1, CFrame = Hole.CFrame*ANGLES(RAD(MRANDOM(-360,360)),RAD(MRANDOM(-360,360)),RAD(MRANDOM(-360,360))), MoveToPos = nil, RotationX = 0, RotationY = MRANDOM(-100/100,100/100), RotationZ = 0, Material = "Neon", Color = C3(1,1,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil})
	WACKYEFFECT({Time = 25, EffectType = "Slash", Size = VT(0,0,0), Size2 = VT(0.1,0,0.1)*MRANDOM(1000/1000,1750/1000), Transparency = 0, Transparency2 = 1, CFrame = Hole.CFrame*ANGLES(RAD(MRANDOM(-360,360)),RAD(MRANDOM(-360,360)),RAD(MRANDOM(-360,360))), MoveToPos = nil, RotationX = 0, RotationY = MRANDOM(-100/100,100/100), RotationZ = 0, Material = "Neon", Color = C3(1,1,0), SoundID = nil, SoundPitch = nil, SoundVolume = nil})
	WACKYEFFECT({Time = 30, EffectType = "Sphere", Size = VT(0,0,0), Size2 = VT(2.5,2.5,2.5), Transparency = 0.3, Transparency2 = 1, CFrame = Hole.CFrame*ANGLES(RAD(MRANDOM(-15,15)), RAD(0), RAD(MRANDOM(-15,15))), MoveToPos = nil, RotationX = 0, RotationY = MRANDOM(-1,1)*5, RotationZ = 0, Material = "Neon", Color = C3(1,1,0), UseBoomerangMath = true, SizeBoomerang = 50, SoundID = nil, SoundPitch = nil, SoundVolume = nil})
	WACKYEFFECT({Time = 30, EffectType = "Sphere", Size = VT(0,0,0), Size2 = VT(2,2,2), Transparency = 0.3, Transparency2 = 1, CFrame = Hole.CFrame*ANGLES(RAD(MRANDOM(-15,15)), RAD(0), RAD(MRANDOM(-15,15))), MoveToPos = nil, RotationX = 0, RotationY = MRANDOM(-1,1)*5, RotationZ = 0, Material = "Neon", Color = C3(1,1,0), UseBoomerangMath = true, SizeBoomerang = 50, SoundID = nil, SoundPitch = nil, SoundVolume = nil})
	SpawnTrail(Hole.Position,highuppos)
	ATTACK = false
	Rooted = false
	CreateSound(136007472,Torso,10,1,false)
	local orb = Instance.new("Part", Effects)
	orb.BrickColor = BrickColor.new("New Yeller")
	orb.CanCollide = false
	orb.FormFactor = 3
	orb.Name = "Ring"
	orb.Material = "Neon"
	orb.Size = Vector3.new(1, 1, 1)
	orb.Transparency = 0
	orb.TopSurface = 0
	orb.BottomSurface = 0
	local orbm = Instance.new("SpecialMesh", orb)
	orbm.MeshType = "Sphere"
	orbm.Name = "SizeMesh"
	orbm.Scale = VT(2,2,2)
	orb.CFrame = mouse.Hit
	local bv = Instance.new("BodyVelocity")
	bv.maxForce = Vector3.new(1e9, 1e9, 1e9)
	bv.velocity = orb.CFrame.lookVector*100
	bv.Parent = orb
	local hitted = false
	coroutine.resume(coroutine.create(function()
		game:GetService("Debris"):AddItem(orb, 5)
		orb.Transparency = 1
		orb.Anchored = true
		local elocacenter = CreateParta(m,1,1,"SmoothPlastic",BrickColor.random())
		elocacenter.Anchored = true
		elocacenter.CFrame = orb.CFrame
		elocacenter.Orientation = VT(0,0,0)
		local eloca1 = CreateParta(m,1,1,"SmoothPlastic",BrickColor.random())
		eloca1.Anchored = true
		eloca1.CFrame = elocacenter.CFrame
		local eloca2 = CreateParta(m,1,1,"SmoothPlastic",BrickColor.random())
		eloca2.Anchored = true
		eloca2.CFrame = elocacenter.CFrame
		local eloca3 = CreateParta(m,1,1,"SmoothPlastic",BrickColor.random())
		eloca3.Anchored = true
		eloca3.CFrame = elocacenter.CFrame
		local eloca4 = CreateParta(m,1,1,"SmoothPlastic",BrickColor.random())
		eloca4.Anchored = true
		eloca4.CFrame = elocacenter.CFrame
		local lookavec = 0 
		local speeds = 0
		ShakeCam(1,25)
		coroutine.resume(coroutine.create(function()
			CreateSound(419447292,Torso,10,1,false)
			sphere(5,"Add",elocacenter.CFrame,VT(0,0,0),1,BrickColor.new("New Yeller"))
			sphere(6,"Add",elocacenter.CFrame,VT(0,0,0),1,BrickColor.new("New Yeller"))
			sphere(7,"Add",elocacenter.CFrame,VT(0,0,0),1,BrickColor.new("New Yeller"))
			sphere(8,"Add",elocacenter.CFrame,VT(0,0,0),1,BrickColor.new("New Yeller"))
			sphere(9,"Add",elocacenter.CFrame,VT(0,0,0),1,BrickColor.new("New Yeller"))
			for i = 0, 24 do
				swait()
				lookavec = lookavec + 2
				speeds = speeds + 1
				elocacenter.CFrame = elocacenter.CFrame*CFrame.Angles(0,math.rad(speeds),0)
				eloca1.CFrame = elocacenter.CFrame*CFrame.new(lookavec,0,0)
				PixelBlockNeg(2,math.random(1,2),"Add",eloca1.CFrame*CFrame.Angles(math.rad(90 + math.random(-10,10)),math.rad(math.random(-10,10)),math.rad(math.random(-10,10))),5,5,5,0.05,BrickColor.new("New Yeller"),-2)

				eloca2.CFrame = elocacenter.CFrame*CFrame.new(-lookavec,0,0)
				PixelBlockNeg(2,math.random(1,2),"Add",eloca2.CFrame*CFrame.Angles(math.rad(90 + math.random(-10,10)),math.rad(math.random(-10,10)),math.rad(math.random(-10,10))),5,5,5,0.05,BrickColor.new("New Yeller"),-2)

				eloca3.CFrame = elocacenter.CFrame*CFrame.new(0,0,lookavec)
				PixelBlockNeg(2,math.random(1,2),"Add",eloca3.CFrame*CFrame.Angles(math.rad(90 + math.random(-10,10)),math.rad(math.random(-10,10)),math.rad(math.random(-10,10))),5,5,5,0.05,BrickColor.new("New Yeller"),-2)

				eloca4.CFrame = elocacenter.CFrame*CFrame.new(0,0,-lookavec)
				PixelBlockNeg(2,math.random(1,2),"Add",eloca4.CFrame*CFrame.Angles(math.rad(90 + math.random(-10,10)),math.rad(math.random(-10,10)),math.rad(math.random(-10,10))),5,5,5,0.05,BrickColor.new("New Yeller"),-2)
			end

			local risen = 0
			for i = 0, 176 do
				swait()
				lookavec = lookavec + 0.25
				risen = risen + 0.05
				speeds = speeds + 0.1
				elocacenter.CFrame = elocacenter.CFrame*CFrame.Angles(0,math.rad(speeds),0)
				eloca1.CFrame = elocacenter.CFrame*CFrame.new(lookavec,0,0)
				PixelBlockNeg(2,math.random(1+risen,2+risen),"Add",eloca1.CFrame*CFrame.Angles(math.rad(90 + math.random(-10,10)),math.rad(math.random(-10,10)),math.rad(math.random(-10,10))),5,5,5,0.05,BrickColor.new("New Yeller"),-2)

				eloca2.CFrame = elocacenter.CFrame*CFrame.new(-lookavec,0,0)
				PixelBlockNeg(2,math.random(1+risen,2+risen),"Add",eloca2.CFrame*CFrame.Angles(math.rad(90 + math.random(-10,10)),math.rad(math.random(-10,10)),math.rad(math.random(-10,10))),5,5,5,0.05,BrickColor.new("New Yeller"),-2)

				eloca3.CFrame = elocacenter.CFrame*CFrame.new(0,0,lookavec)
				PixelBlockNeg(2,math.random(1+risen,2+risen),"Add",eloca3.CFrame*CFrame.Angles(math.rad(90 + math.random(-10,10)),math.rad(math.random(-10,10)),math.rad(math.random(-10,10))),5,5,5,0.05,BrickColor.new("New Yeller"),-2)

				eloca4.CFrame = elocacenter.CFrame*CFrame.new(0,0,-lookavec)
				PixelBlockNeg(2,math.random(1+risen,2+risen),"Add",eloca4.CFrame*CFrame.Angles(math.rad(90 + math.random(-10,10)),math.rad(math.random(-10,10)),math.rad(math.random(-10,10))),5,5,5,0.05,BrickColor.new("New Yeller"),-2)
			end

			for i = 0, 176 do
				swait()
				lookavec = lookavec + 0.5
				risen = risen + 0.05
				speeds = speeds + 0.1
				elocacenter.CFrame = elocacenter.CFrame*CFrame.Angles(0,math.rad(speeds),0)
				eloca1.CFrame = elocacenter.CFrame*CFrame.new(lookavec,0,0)
				PixelBlockNeg(2,math.random(1+risen,2+risen),"Add",eloca1.CFrame*CFrame.Angles(math.rad(90 + math.random(-15,15)),math.rad(math.random(-15,15)),math.rad(math.random(-15,15))),5,5,5,0.05,BrickColor.new("New Yeller"),-2)

				eloca2.CFrame = elocacenter.CFrame*CFrame.new(-lookavec,0,0)
				PixelBlockNeg(2,math.random(1+risen,2+risen),"Add",eloca2.CFrame*CFrame.Angles(math.rad(90 + math.random(-15,15)),math.rad(math.random(-15,15)),math.rad(math.random(-15,15))),5,5,5,0.05,BrickColor.new("New Yeller"),-2)

				eloca3.CFrame = elocacenter.CFrame*CFrame.new(0,0,lookavec)
				PixelBlockNeg(2,math.random(1+risen,2+risen),"Add",eloca3.CFrame*CFrame.Angles(math.rad(90 + math.random(-15,15)),math.rad(math.random(-15,15)),math.rad(math.random(-15,15))),5,5,5,0.05,BrickColor.new("New Yeller"),-2)

				eloca4.CFrame = elocacenter.CFrame*CFrame.new(0,0,-lookavec)
				PixelBlockNeg(2,math.random(1+risen,2+risen),"Add",eloca4.CFrame*CFrame.Angles(math.rad(90 + math.random(-15,15)),math.rad(math.random(-15,15)),math.rad(math.random(-15,15))),5,5,5,0.05,BrickColor.new("New Yeller"),-2)
			end
		end))
		coroutine.resume(coroutine.create(function()
			ShakeCam(1,25)
			ApplyAoE(elocacenter.Position,125)
			CreateSound(468991944,Torso,10,1,false)
			CreateSound(533636230,Torso,10,1,false)
			CreateSound(419447292,Torso,10,1,false)
			CreateSound(421328847,Torso,10,1,false)
			CreateSound(919941001,Torso,10,1,false)
			sphere(1,"Add",elocacenter.CFrame,VT(100,90000,100),-0.25,BrickColor.new("New Yeller"))
			sphere(1,"Add",elocacenter.CFrame,VT(100,90000,100),0.5,BrickColor.new("New Yeller"))
			sphere(1,"Add",elocacenter.CFrame,VT(0,0,0),5,BrickColor.new("New Yeller"))
			sphere(2,"Add",elocacenter.CFrame,VT(0,0,0),5,BrickColor.new("New Yeller"))
			sphere(3,"Add",elocacenter.CFrame,VT(0,0,0),5,BrickColor.new("New Yeller"))
			sphere(4,"Add",elocacenter.CFrame,VT(0,0,0),5,BrickColor.new("New Yeller"))
			sphere(5,"Add",elocacenter.CFrame,VT(0,0,0),5,BrickColor.new("New Yeller"))
			sphere(5,"Add",elocacenter.CFrame,VT(0,0,0),500,BrickColor.new("New Yeller"))
			for i = 0, 24 do
				sphereMK(2,2,"Add",elocacenter.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),25,25,100,-0.25,BrickColor.new("New Yeller"),0)
				sphereMK(4,4,"Add",elocacenter.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),25,25,75,-0.25,BrickColor.new("New Yeller"),0)
				sphereMK(6,6,"Add",elocacenter.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),25,25,50,-0.25,BrickColor.new("New Yeller"),0)
				sphereMK(8,8,"Add",elocacenter.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),25,25,25,-0.25,BrickColor.new("New Yeller"),0)
			end
			coroutine.resume(coroutine.create(function()
				local eff = Instance.new("ParticleEmitter",elocacenter)
				eff.Texture = "rbxassetid://2092248396"
				eff.LightEmission = 1
				eff.Color = ColorSequence.new(BrickColor.new("New Yeller").Color)
				eff.Rate = 50000
				eff.Lifetime = NumberRange.new(6,12)
				eff.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,60,0),NumberSequenceKeypoint.new(0.2,0.75,0),NumberSequenceKeypoint.new(1,0.1,0)})
				eff.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,1,0),NumberSequenceKeypoint.new(0.2,0,0),NumberSequenceKeypoint.new(1,1,0)})
				eff.Speed = NumberRange.new(100,1000)
				eff.Drag = 5
				eff.Rotation = NumberRange.new(-500,500)
				eff.VelocitySpread = 9000
				eff.RotSpeed = NumberRange.new(-100,100)
				wait(0.6)
				eff.Enabled = false
			end))
			wait(1.25)
			ShakeCam(1,25)
			ApplyAoE(elocacenter.Position,150)
			CreateSound(468991944,Torso,10,1,false)
			CreateSound(533636230,Torso,10,1,false)
			CreateSound(419447292,Torso,10,1,false)
			CreateSound(421328847,Torso,10,1,false)
			CreateSound(919941001,Torso,10,1,false)
			sphere(1,"Add",elocacenter.CFrame,VT(150,90000,150),-0.5,BrickColor.new("New Yeller"))
			sphere(1,"Add",elocacenter.CFrame,VT(150,90000,150),1,BrickColor.new("New Yeller"))
			sphere(1,"Add",elocacenter.CFrame,VT(0,0,0),5*2,BrickColor.new("New Yeller"))
			sphere(2,"Add",elocacenter.CFrame,VT(0,0,0),5*2,BrickColor.new("New Yeller"))
			sphere(3,"Add",elocacenter.CFrame,VT(0,0,0),5*2,BrickColor.new("New Yeller"))
			sphere(4,"Add",elocacenter.CFrame,VT(0,0,0),5*2,BrickColor.new("New Yeller"))
			sphere(5,"Add",elocacenter.CFrame,VT(0,0,0),5*2,BrickColor.new("New Yeller"))
			sphere(5,"Add",elocacenter.CFrame,VT(0,0,0),500*2,BrickColor.new("New Yeller"))
			for i = 0, 24 do
				sphereMK(2,2,"Add",elocacenter.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),25,25,100,-0.25*2,BrickColor.new("New Yeller"),0)
				sphereMK(4,4,"Add",elocacenter.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),25,25,75,-0.25*2,BrickColor.new("New Yeller"),0)
				sphereMK(6,6,"Add",elocacenter.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),25,25,50,-0.25*2,BrickColor.new("New Yeller"),0)
				sphereMK(8,8,"Add",elocacenter.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),25,25,25,-0.25*2,BrickColor.new("New Yeller"),0)
			end
			coroutine.resume(coroutine.create(function()
				local eff = Instance.new("ParticleEmitter",elocacenter)
				eff.Texture = "rbxassetid://2092248396"
				eff.LightEmission = 1
				eff.Color = ColorSequence.new(BrickColor.new("New Yeller").Color)
				eff.Rate = 50000
				eff.Lifetime = NumberRange.new(6,12)
				eff.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,90,0),NumberSequenceKeypoint.new(0.2,1.25,0),NumberSequenceKeypoint.new(1,0.1,0)})
				eff.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,1,0),NumberSequenceKeypoint.new(0.2,0,0),NumberSequenceKeypoint.new(1,1,0)})
				eff.Speed = NumberRange.new(125,1250)
				eff.Drag = 5
				eff.Rotation = NumberRange.new(-500,500)
				eff.VelocitySpread = 9000
				eff.RotSpeed = NumberRange.new(-100,100)
				wait(1.25)
				eff.Enabled = false
			end))
			wait(1.25)
			ShakeCam(1,25)
			ApplyAoE(elocacenter.Position,175)
			CreateSound(468991944,Torso,10,1,false)
			CreateSound(533636230,Torso,10,1,false)
			CreateSound(419447292,Torso,10,1,false)
			CreateSound(421328847,Torso,10,1,false)
			CreateSound(919941001,Torso,10,1,false)
			sphere(1,"Add",elocacenter.CFrame,VT(225,90000,225),-0.25*3,BrickColor.new("New Yeller"))
			sphere(1,"Add",elocacenter.CFrame,VT(225,90000,225),0.5*3,BrickColor.new("New Yeller"))
			sphere(1,"Add",elocacenter.CFrame,VT(0,0,0),5*3,BrickColor.new("New Yeller"))
			sphere(2,"Add",elocacenter.CFrame,VT(0,0,0),5*3,BrickColor.new("New Yeller"))
			sphere(3,"Add",elocacenter.CFrame,VT(0,0,0),5*3,BrickColor.new("New Yeller"))
			sphere(4,"Add",elocacenter.CFrame,VT(0,0,0),5*3,BrickColor.new("New Yeller"))
			sphere(5,"Add",elocacenter.CFrame,VT(0,0,0),5*3,BrickColor.new("New Yeller"))
			sphere(5,"Add",elocacenter.CFrame,VT(0,0,0),500*3,BrickColor.new("New Yeller"))
			for i = 0, 24 do
				sphereMK(2,2,"Add",elocacenter.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),25,25,100,-0.25*3,BrickColor.new("New Yeller"),0)
				sphereMK(4,4,"Add",elocacenter.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),25,25,75,-0.25*3,BrickColor.new("New Yeller"),0)
				sphereMK(6,6,"Add",elocacenter.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),25,25,50,-0.25*3,BrickColor.new("New Yeller"),0)
				sphereMK(8,8,"Add",elocacenter.CFrame*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),25,25,25,-0.25*3,BrickColor.new("New Yeller"),0)
			end
			coroutine.resume(coroutine.create(function()
				local eff = Instance.new("ParticleEmitter",elocacenter)
				eff.Texture = "rbxassetid://2092248396"
				eff.LightEmission = 1
				eff.Color = ColorSequence.new(BrickColor.new("New Yeller").Color)
				eff.Rate = 50000
				eff.Lifetime = NumberRange.new(6,12)
				eff.Size = NumberSequence.new({NumberSequenceKeypoint.new(0,120,0),NumberSequenceKeypoint.new(0.2,2.5,0),NumberSequenceKeypoint.new(1,0.1,0)})
				eff.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,1,0),NumberSequenceKeypoint.new(0.2,0,0),NumberSequenceKeypoint.new(1,1,0)})
				eff.Speed = NumberRange.new(150,1500)
				eff.Drag = 5
				eff.Rotation = NumberRange.new(-500,500)
				eff.VelocitySpread = 9000
				eff.RotSpeed = NumberRange.new(-100,100)
				wait(1.25)
				eff.Enabled = false
			end))
			wait(0.5)
			CreateSound(1535995263,Torso,10,1,false)
			CreateSound(1535995263,Torso,10,1,false)
		end))
		for i = 0, 4, 0.1 do
			swait()
			PixelBlockX(5,0.5,"Add",RightArm.CFrame*CFrame.new(0,-1,0)*CFrame.Angles(math.rad(90 + math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),1,1,1,0.01,BrickColor.new("New Yeller"),0)
			PixelBlockNeg(5,0.5,"Add",RightArm.CFrame*CFrame.new(0,-1,0)*CFrame.Angles(math.rad(90 + math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),1,1,1,0.01,BrickColor.new("New Yeller"),0)
			PixelBlockX(5,0.5,"Add",LeftArm.CFrame*CFrame.new(0,-1,0)*CFrame.Angles(math.rad(90 + math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),1,1,1,0.01,BrickColor.new("New Yeller"),0)
			PixelBlockNeg(5,0.5,"Add",LeftArm.CFrame*CFrame.new(0,-1,0)*CFrame.Angles(math.rad(90 + math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),1,1,1,0.01,BrickColor.new("New Yeller"),0)
		end
		coroutine.resume(coroutine.create(function()
			wait(10)
			elocacenter:Destroy()
			eloca1:Destroy()
			eloca2:Destroy()
			eloca3:Destroy()
			eloca4:Destroy()
		end))
	end))
end

--//=================================\\
--||	  ASSIGN THINGS TO KEYS
--\\=================================//

Speed = 40

function MouseDown(Mouse)
	HOLD = true
	if ATTACK == false and ModeCodeName ~= "Vaporwave" and ModeCodeName ~= "NulledXD" and ModeCodeName ~= "Rolling girl" and ModeCodeName ~= "Fave" and ModeCodeName ~= "MemeLol" then
		attackone()
	end
end

function MouseUp(Mouse)
	HOLD = false
end

function KeyDown(Key)
	KEYHOLD = true
	if Key == "1" and ATTACK == false then
		sick:Stop()
		SwitchModeEffect()

		if ModeCodeName ~= "Vaporwave" then
			SwitchMode("Vaporwave", 171230598)
			return
		end

		SwitchMode("Heck ya", 4736655124)
	elseif Key == "2" and ATTACK == false then
		sick:Stop()
		SwitchModeEffect()

		if ModeCodeName ~= "Rage" then
			SwitchMode("Rage", 597538672)
			return
		end

		SwitchMode("Heck ya", 4736655124)
	elseif Key == "3" and ATTACK == false then
		sick:Stop()
		SwitchModeEffect()

		if ModeCodeName ~= "BadApple2" then
			SwitchMode("BadApple2", 932923622)
			return
		end

		SwitchMode("Heck ya", 4736655124)
	elseif Key == "4" and ATTACK == false then
		sick:Stop()
		SwitchModeEffect()

		if ModeCodeName ~= "FNFB3" then
			SwitchMode("FNFB3", 6372483829)
			return
		end

		SwitchMode("Heck ya", 4736655124)
	elseif Key == "5" and ATTACK == false then
		sick:Stop()
		SwitchModeEffect()

		if ModeCodeName ~= "Relaxed" then
			warnedpeople("Ahh")
			SwitchMode("Relaxed", 4951120514)

			wait(1)
			warnedpeople("What a relaxing day!")
			return
		end

		SwitchMode("Heck ya", 4736655124)
	elseif Key == "6" and ATTACK == false then
		sick:Stop()
		SwitchModeEffect()

		if ModeCodeName ~= "InsAnitY" then
			SwitchMode("InsAnitY", 611191130)
			return
		end

		SwitchMode("Heck ya", 4736655124)
	elseif Key == "7" and ATTACK == false then
		sick:Stop()
		SwitchModeEffect()

		if ModeCodeName ~= "KARMA" then
			SwitchMode("KARMA", 733456981)
			return
		end

		SwitchMode("Heck ya", 4736655124)
	elseif Key == "=" and ATTACK == false then
		sick:Stop()
		SwitchModeEffect()

		if ModeCodeName ~= "NulledXD" then
			SwitchMode("NulledXD", 1496130120)
			return
		end

		SwitchMode("Heck ya", 4736655124)
	elseif Key == "t" and ATTACK == false then
		sick:Stop()
		SwitchModeEffect()

		if ModeCodeName ~= "Rolling girl" then
			SwitchMode("Rolling girl", 4532152563)
			return
		end

		SwitchMode("Heck ya", 4736655124)
	elseif Key == "y" and ATTACK == false then
		sick:Stop()
		SwitchModeEffect()

		if ModeCodeName ~= "Fave" then
			SwitchMode("Fave", 290182215)
			return
		end

		SwitchMode("Heck ya", 4736655124)
	elseif Key == "u" and ATTACK == false then
		sick:Stop()
		SwitchModeEffect()

		if ModeCodeName ~= "MemeLol" then
			SwitchMode("MemeLol", MemeMoment[MATHR(1, #MemeMoment)])
			return 
		end

	    --[[ SwitchMode("None", 0)
	    wait(0.3) --]]

		SwitchModeEffect("Heck ya", 4736655124)
	end

	if Key == "r" then
		for i = 0, 9 do
			slash(math.random(10,50)/10,3,true,"Round","Add","Out",RootPart.CFrame*CFrame.new(0,-3,0)*CFrame.Angles(math.rad(math.random(-10,10)),math.rad(math.random(-360,360)),math.rad(math.random(-10,10))),VT(0.05,0.01,0.05),math.random(25,50)/250,BrickColor.new("White"))
		end

		CreateSound(1368637781,Torso,10,1,false)
		CreateSound(200633077,Torso,10,1,false)
		CreateSound(169380495,Torso,10,1,false)

		sphere2(5,"Add",RootPart.CFrame,VT(5,5,5),0.25,0.25,0.25,BrickColor.new("New Yeller"),BrickColor.new("New Yeller").Color)
		sphere2(6,"Add",RootPart.CFrame,VT(5,5,5),0.25,0.25,0.25,BrickColor.new("New Yeller"),BrickColor.new("New Yeller").Color)

		for i = 0, 1, 0.1 do
			swait()
			ShakeCam(0.5,10)
			sphere2(5,"Add",Torso.CFrame*CFrame.new(math.random(-8,-2),0,0)*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),VT(0.1,0.1,0.1),0,0.1,0,BrickColor.new("New Yeller"),BrickColor.new("New Yeller").Color)
			waveEff(5,"Add","Out",RootPart.CFrame*CFrame.new(0,-3,0)*CFrame.Angles(0,math.rad(math.random(-360,360)),0),VT(5,0.25,5),0.05,0.015,BrickColor.new("New Yeller"))
			waveEff(5,"Add","Out",RootPart.CFrame*CFrame.new(0,-3,0)*CFrame.Angles(0,math.rad(math.random(-360,360)),0),VT(10,0.25,10),0.05,0.015,BrickColor.new("New Yeller"))
		end

		TeleportGyro = Instance.new("BodyGyro", playerss.HumanoidRootPart)
		TeleportGyro.D = 175
		TeleportGyro.P = 20000
		TeleportGyro.MaxTorque = Vector3.new(0,9000,0)
		TeleportGyro.CFrame = CFrame.new(playerss.HumanoidRootPart.Position, Mouse.Hit.p)

		game:GetService("Debris"):AddItem(TeleportGyro, 0.05)
		playerss.HumanoidRootPart.CFrame = CFrame.new(Mouse.Hit.p) * CFrame.new(0,3.3,0)

		for i = 0, 9 do
			slash(math.random(10,50)/10,3,true,"Round","Add","Out",RootPart.CFrame*CFrame.new(0,-3,0)*CFrame.Angles(math.rad(math.random(-10,10)),math.rad(math.random(-360,360)),math.rad(math.random(-10,10))),VT(0.05,0.01,0.05),math.random(25,50)/250,BrickColor.new("White"))
		end

		CreateSound(1368637781,Torso,10,1,false)
		CreateSound(200633077,Torso,10,1,false)
		CreateSound(169380495,Torso,10,1,false)

		sphere2(5,"Add",RootPart.CFrame,VT(5,5,5),0.25,0.25,0.25,BrickColor.new("New Yeller"),BrickColor.new("New Yeller").Color)
		sphere2(6,"Add",RootPart.CFrame,VT(5,5,5),0.25,0.25,0.25,BrickColor.new("New Yeller"),BrickColor.new("New Yeller").Color)

		for i = 0, 1, 0.1 do
			swait()
			ShakeCam(0.5,10)
			sphere2(5,"Add",Torso.CFrame*CFrame.new(math.random(-8,-2),0,0)*CFrame.Angles(math.rad(math.random(-360,360)),math.rad(math.random(-360,360)),math.rad(math.random(-360,360))),VT(0.1,0.1,0.1),0,0.1,0,BrickColor.new("New Yeller"),BrickColor.new("New Yeller").Color)
			waveEff(5,"Add","Out",RootPart.CFrame*CFrame.new(0,-3,0)*CFrame.Angles(0,math.rad(math.random(-360,360)),0),VT(5,0.25,5),0.05,0.015,BrickColor.new("New Yeller"))
			waveEff(5,"Add","Out",RootPart.CFrame*CFrame.new(0,-3,0)*CFrame.Angles(0,math.rad(math.random(-360,360)),0),VT(10,0.25,10),0.05,0.015,BrickColor.new("New Yeller"))
		end
	end

	if Key == "-" then
		FlingModeSky = not FlingModeSky
	end

	if Key == "f" then
		sFLY()
		FLY = not FLY
	end

	if Key == "j" then
		if LCColor.Enabled then
			LCColor.Enabled = false
			chatfunc("(TERRAIN) Color correction has been set to false", false, true)
		else
			LCColor.Enabled = true
			chatfunc("(TERRAIN) Color correction has been set to true", false, true)
		end
	end

	if Key == "l" then
		if LightingEffect then
			LightingEffect = false
			chatfunc("(TERRAIN) Color changes has been set to false", false, true)
		else
			LightingEffect = true
			chatfunc("(TERRAIN) Color changes has been set to true", false, true)
		end
	end

	--[[ if Key == "z" and ATTACK == false and RUNNING == false then
		violent()
	end
	if Key == "x" and ATTACK == false and RUNNING == false then
		attackone()
	end
	if Key == "c" and ATTACK == false and RUNNING == false then
		attacktwo()
	end
	if Key == "v" and ATTACK == false and RUNNING == false then
		attackthree()
	end
	if Key == "b" and ATTACK == false and RUNNING == false then
		ball()
	end --]]
end

--//=================================\\
--\\=================================//

local ActualVelocity = Vector3.new(0,0,0)

function KeyUp(Key)
	KEYHOLD = false
	if Key == "0" and RUNNING == true then
		Speed = 35
		RUNNING = false
	end
end

Mouse.Button1Down:connect(function(NEWKEY)
	MouseDown(NEWKEY)
end)
Mouse.Button1Up:connect(function(NEWKEY)
	MouseUp(NEWKEY)
end)
Mouse.KeyDown:connect(function(NEWKEY)
	KeyDown(NEWKEY)
end)
Mouse.KeyUp:connect(function(NEWKEY)
	KeyUp(NEWKEY)
end)

function unanchor()
	for _, c in pairs(Character:GetChildren()) do
		if c:IsA("BasePart") and c ~= RootPart then
			c.Anchored = false
		end
	end
	if UNANCHOR == true then
		RootPart.Anchored = false
	else
		RootPart.Anchored = true
	end
end

coroutine.resume(coroutine.create(function()
	while true do
		Swait()

		NameMode.TextColor3 = AUDIOBASEDCOLOR

		pcall(function()
			workspace[Player.Name]["Right Arm"].Color = AUDIOBASEDCOLOR
			workspace[Player.Name]["Left Leg"].Color = AUDIOBASEDCOLOR
		end)

		bullet.Color = AUDIOBASEDCOLOR

		LCColor.TintColor = AUDIOBASEDCOLOR

		for _, v in pairs(NeonParts:GetChildren()) do
			if v:IsA("Part") or v:IsA("MeshPart") or v:IsA("WedgePart") then
				v.Color = AUDIOBASEDCOLOR
			end
		end

		for _, v in pairs(GloveFolder:GetChildren()) do
			if v:IsA("Part") or v:IsA("MeshPart") or v:IsA("WedgePart") then
				v.Color = AUDIOBASEDCOLOR
			end
		end

		for _, v in pairs(Effects:GetDescendants()) do
			if v:IsA("Part") or v:IsA("MeshPart") then
				v.Color = AUDIOBASEDCOLOR
			elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
				v.Color = AUDIOBASEDCOLOR
			elseif v:IsA("ImageLabel") then
				v.ImageColor3 = AUDIOBASEDCOLOR
			end
		end

		if LightingEffect then
			VISUALS.FogColor = AUDIOBASEDCOLOR
			VISUALS.Ambient = AUDIOBASEDCOLOR
			VISUALS.OutdoorAmbient = AUDIOBASEDCOLOR
			VISUALS.ClockTime = 6
			Bloom.Intensity = 0 + sick.PlaybackLoudness / 500
			VISUALSSz.ExposureCompensation = math.clamp(0 + sick.PlaybackLoudness / 125, 0, 5)
			VISUALSSz.FogEnd = math.clamp(sick.PlaybackLoudness, 50, 1000)
			VISUALSSz.Brightness = 0
			VISUALS.EnvironmentDiffuseScale = 0 + sick.PlaybackLoudness / 100
			VISUALS.reuweuiuewquiwqowqfwq.Contrast = 0.1 + sick.PlaybackLoudness / 1000
			VISUALS.bsiofwoerjeworf.Enabled = true
			VISUALS.reuweuiuewquiwqowqfwq.Enabled = true
			Skybox.MoonAngularSize = 6 + sick.PlaybackLoudness / 60
			Skybox.SunAngularSize = 6 + sick.PlaybackLoudness / 35
		else
			VISUALS.Ambient = Color3.new(1, 1, 1)
			VISUALS.Brightness = 1
			VISUALS.ColorShift_Bottom = Color3.new()
			VISUALS.ColorShift_Top = Color3.new()
			VISUALS.EnvironmentDiffuseScale = 0
			VISUALS.EnvironmentSpecularScale = 0
			VISUALS.GlobalShadows = true
			VISUALS.OutdoorAmbient = Color3.new(0.5, 0.5, 0.5)
			VISUALS.ClockTime = 6
			VISUALS.GeographicLatitude = 41.733
			VISUALS.ExposureCompensation = 0
			VISUALS.FogColor = Color3.fromRGB(192, 192, 192)
			VISUALS.FogEnd = 100000
			VISUALS.reuweuiuewquiwqowqfwq.Enabled = false
			VISUALS.bsiofwoerjeworf.Enabled = false
			Skybox.MoonAngularSize = 6 + sick.PlaybackLoudness / 60
			Skybox.SunAngularSize = 6 + sick.PlaybackLoudness / 35
		end
	end
end))

function chatfunc6(p131)
	local v2466 = Player.PlayerGui
	coroutine.resume(coroutine.create(function()
		local v2471 = Instance.new("ScreenGui")
		v2471.DisplayOrder = 2147483647
		v2471.Name = randomstring_1()
		v2471.ResetOnSpawn = false
		v2471.Archivable = false
		local v2475 = Instance.new("TextLabel")
		v2475.BackgroundTransparency = 1
		v2475.Name = randomstring_1()
		v2475.Position = UDim2.new(0, 0, 1, 0)
		v2475.Size = UDim2.new(1, 0, 0.05, 0)
		v2475.Archivable = false
		v2475.Font = Enum.Font.SourceSans
		v2475.TextSize = 15
		v2475.TextScaled = true
		v2475.TextColor3 = AUDIOBASEDCOLOR
		v2475.TextStrokeTransparency = 0
		v2475.TextXAlignment = Enum.TextXAlignment.Left
		v2475.Parent = v2471
		v2471.Parent = Player.PlayerGui
		v2475:TweenPosition(UDim2.new(0, 0, 0.95, 0))
		local v2497 = tick()
		spawn(function()
			while true do
				game:GetService("RunService").RenderStepped:Wait()
				v2475.TextColor3 = AUDIOBASEDCOLOR
				if 0.5 < tick() - v2497 then
					break
				end
			end
		end)
		v2497 = tick()
		local v2573 = 0
		local CharIndex = 0
		while true do
			game:GetService("RunService").RenderStepped:Wait()
			v2475.TextColor3 = AUDIOBASEDCOLOR
			local v2521 = math.floor(tick() * 100)
			if v2521 > v2573 then
				v2573 = v2521 + 1
				CharIndex = CharIndex + 1
			end
			v2475.Text = HSCChanges2[MATHR(1, #HSCChanges2)] .. string.sub(p131, 0, CharIndex)
			if string.len(p131) / 30 < tick() - v2497 then
				break
			end
		end
		v2521 = tick
		local v2595 = v2521()
		while true do
			v2530 = game
			v2533 = "RunService"
			v2534 = v2530:GetService(v2533).RenderStepped
			v2534:Wait()
			v2475.TextColor3 = AUDIOBASEDCOLOR
			if 1 < tick() - v2595 then
				break
			end
		end
		v2536 = game
		v2531 = "TweenService"
		local v2544 = {}
		v2544.TextTransparency = 1
		v2544.TextStrokeTransparency = 1
		v2536:GetService(v2531):Create(v2475, TweenInfo.new(1, Enum.EasingStyle.Linear), v2544):Play()
		game:GetService("Debris"):AddItem(v2475, 1)
		game:GetService("Debris"):AddItem(v2471, 3)
	end))
end

function chatfunc(p132, p133, p134)
	local v2601 = string.sub(string.gsub(p132, "\226\128\139", ""), 1, 5)
	if v2601 == "" then
		coroutine.resume(coroutine.create(function()
			SwitchModeEffect()
			v490.Value = "rbxassetid://0"
			v516.Value = 0
			wait(0.1)
			while true do
				swait()
				if 0 < v516.Value then
					break
				end
			end
			v2612 = chatfunc
			v2611 = ""
			v2612(v2611, false, false)
			while true do
				swait()
				if 0 < v516.Value then
					break
				end
			end
			v2617 = chatfunc
			v2616 = ""
			v2617(v2616, true, false)
			while true do
				swait()
				if 0 < v516.Value then
					break
				end
			end
			v2622 = chatfunc
			v2621 = ""
			v2622(v2621, false, false)
			while true do
				swait()
				if 0 < v516.Value then
					break
				end
			end
			v2627 = chatfunc
			v2626 = ""
			v2627(v2626, true, false)
			while true do
				swait()
				if 0 < v516.Value then
					break
				end
			end
			v2632 = chatfunc
			v2631 = ""
			v2632(v2631, false, false)
			while true do
				swait()
				if 0 < v516.Value then
					break
				end
			end
			v2637 = chatfunc
			v2636 = ""
			v2637(v2636, true, false)
			while true do
				swait()
				if 0 < v516.Value then
					break
				end
			end
			v2642 = chatfunc
			v2641 = ""
			v2642(v2641, false, false)
			while true do
				swait()
				if 0 < v516.Value then
					break
				end
			end
			v2647 = chatfunc
			v2646 = ""
			v2647(v2646, true, false)
			while true do
				swait()
				local v2652 = v516.Value
				local v2747 = 0
				if v2747 < v2652 then
					break
				end
				v2747 = v490
				v2652 = v2747.Value
				if v2652 == "rbxassetid://0" then
					break
				end
			end
			v2651 = v490
			v2652 = v2651.Value
			if v2652 == "rbxassetid://0" then
				v2652 = chatfunc
				v2651 = " "
				v2652(v2651)
				local v2653 = 0
				local v2654 = 49
				local v2655 = 1
				for v2653 = v2653, v2654, v2655 do
					sphereMK(2.5, -1, "Add", v733.CFrame * CFrame.Angles(math.rad(math.random(-360, 360)), math.rad(math.random(-360, 360)), math.rad(math.random(-360, 360))), 2.5, 2.5, 25, -0.025, BrickColor.new("Really black"), 0)
					slash(math.random(10, 20) / 10, 5, true, "Round", "Add", "Out", v733.CFrame * CFrame.new(0, -3, 0) * CFrame.Angles(math.rad(math.random(-30, 30)), math.rad(math.random(-30, 30)), math.rad(math.random(-40, 40))), Vector3.new(0.05, 0.01, 0.05), math.random(50, 60) / 250, BrickColor.new("Really black"))
				end
				v2654 = CreateSound
				v2655 = 239000203
				v2653 = v706
				v2654(v2655, v2653, 10, false)
				CreateSound(1042716828, v706, 10, false)
				v630:FireServer("BloodWater", 4835535512)
			end
		end))
		return 
	end
	local v2766 = string.gsub(string.gsub(p132, "\226\128\139", ""), "%c", "")
	local v2771 = string.sub(v2766, 1, 3)
	if v2771 == "/e " then
		v2771 = string.sub
		local v2775 = v2771(v2766, 1, 3)
	elseif v2775 == "/w " then
		v2775 = string.sub
		local v2779 = v2775(v2766, 1, 3)
	elseif v2779 == "/c " then
		v2779 = string.sub
		local v2783 = v2779(v2766, 1, 8)
	elseif v2783 == "/console" then
		v2783 = string.sub
		local v2787 = v2783(v2766, 1, 6)
	elseif v2787 == "/clear" then
		return 
	end
	v2787 = string.sub
	local v2791 = v2787(v2766, 1, 4)
	if v2791 == "/me " then
		v2791 = string.sub
		v2766 = v2791(v2766, 5)
	end
	coroutine.wrap(function()
		local v2796 = p134
		if not v2796 then
			v2796 = coroutine.resume
			v2796(coroutine.create(function()
				chatfunc6(v2766)
			end))
		end
		local v2803 = Character:FindFirstChild("TalkingBillBoard")
		if v2803 then
			v2803:Destroy()
		end
		local v2808 = Instance.new("BillboardGui", Character)
		v2808.Size = UDim2.new(0, 9999, 2, 0)
		v2808.StudsOffset = Vector3.new(0, 5, 0)
		v2808.Adornee = Head
		v2808.Name = "TalkingBillBoard"
		local v2821 = Instance.new("TextLabel", v2808)
		coroutine.resume(coroutine.create(function()
			chatfunc6(v2766)
		end))
		v2821.BackgroundTransparency = 1
		v2821.BorderSizePixel = 0
		v2821.Text = ""
		v2821.Font = "Code"
		v2821.TextScaled = true
		v2821.TextStrokeTransparency = 0
		coroutine.resume(coroutine.create(function()
			while true do
				local v2827 = v2821:IsDescendantOf(game)
				if not v2827 then
					break
				end
				v2827 = Color3.toHSV
				local v2831, v2832, v2833 = v2827(AUDIOBASEDCOLOR)
				v2821.TextColor3 = Color3.fromHSV(v2831, v2832, v2833 / 2)
				game:GetService("RunService").RenderStepped:Wait()
			end
		end))
		v2821.TextStrokeColor3 = AUDIOBASEDCOLOR
		v2821.Size = UDim2.new(1, 0, 1, 0)
		local v2852 = Instance.new("TextLabel", v2808)
		v2852.BackgroundTransparency = 1
		v2852.BorderSizePixel = 0
		v2852.Text = ""
		v2852.Font = "Code"
		v2852.TextScaled = true
		v2852.TextStrokeTransparency = 0
		coroutine.resume(coroutine.create(function()
			while true do
				local v2858 = v2852:IsDescendantOf(game)
				if not v2858 then
					break
				end
				v2858 = v2852
				v2858.TextColor3 = AUDIOBASEDCOLOR
				game:GetService("RunService").RenderStepped:Wait()
			end
		end))
		v2852.TextStrokeColor3 = AUDIOBASEDCOLOR
		v2852.Size = UDim2.new(1, 0, 1, 0)
		coroutine.resume(coroutine.create(function()
			while true do
				local v2874 = v2808
				if v2874 == nil then
					break
				end
				v2874 = game:GetService("RunService").RenderStepped
				v2874:Wait()
				local v2878 = p133
				local v2902 = v517
				v2878 = ModeCodeName
				if v2878 == "iNsAnIty" then
					v2902 = FONTS
					v2878 = v2902[MATHR(1, #FONTS)]
					v2902 = v2821
					v2902.Font = v2878
					v2902 = v2852
					v2902.Font = v2878
				end
				v2883 = 0
				v2881 = 3
				v2821.Position = UDim2.new(v2883, MATHR(-3, v2881), 0, MATHR(-3, 3))
				v2852.Position = UDim2.new(0, MATHR(-3, 3), 0, MATHR(-3, 3))
			end
		end))
		local v2907 = 1
		local v2910 = string.len(v2766)
		local v2911 = v2910
		local v2912 = 1
		for v2907 = v2907, v2911, v2912 do
			v2910 = game:GetService("RunService").RenderStepped
			v2910:Wait()
			coroutine.resume(coroutine.create(function()
				local v2921 = Instance.new("Sound", Character)
				v2921.SoundId = "rbxassetid://615716445"
				v2921.Volume = 500
				v2921.Name = randomstring_1()
				v2921.PlayOnRemove = true
				v2921:Play()
				v2921:Destroy()
			end))
			v2821.Text = string.sub(v2766, 1, v2907)
			v2852.Text = string.sub(v2766, 1, v2907)
		end
		v2911 = swait
		v2912 = 120
		v2911(v2912)
		v2936 = 2
		CreateSound(169112309, Character, v2936, MATHR(5, 15) / 10, false)
		v684 = 9000000000
		v2821.Text = " "
		v2852.Text = " "
		swait()
		local v2945 = 1
		for v2945 = v2945, 50, 1 do
			game:GetService("RunService").RenderStepped:Wait()
			v2821.Position = v2821.Position - UDim2.new(0, MATHR(-3, 3), 0, MATHR(-3, 3))
			v2852.Position = v2821.Position - UDim2.new(0, MATHR(-3, 3), 0, MATHR(-3, 3))
			v2821.Rotation = v2821.Rotation + MATHR(-4, 4)
			v2852.Rotation = v2852.Rotation + MATHR(-4, 4)
			v2821.Text = v2821.Text .. otherrandomstring(1)
			v2852.Text = v2852.Text .. otherrandomstring(1)
			v2821.Font = FONTS[MATHR(1, #FONTS)]
			v2852.Font = FONTS[MATHR(1, #FONTS)]
			v2821.TextStrokeTransparency = v2945 / 50
			v2821.TextTransparency = v2821.TextStrokeTransparency
			v2852.TextStrokeTransparency = v2821.TextStrokeTransparency
			v2852.TextTransparency = v2821.TextStrokeTransparency
		end
		v2808:Destroy()
	end)()
end

warnedpeople = function(p129)
	coroutine.resume(coroutine.create(function()
		local v2061 = Player.PlayerGui:FindFirstChild("Spinny")
		if v2061 ~= nil then
			Player.PlayerGui:FindFirstChild("Spinny"):destroy()
		end
		local v2067 = Instance.new("ScreenGui", Player.PlayerGui)
		v2067.Name = "Spinny"
		local v2070 = Instance.new("Frame", v2067)
		v2070.Name = "Wobble"
		v2070.BackgroundTransparency = 0.5
		v2070.Size = UDim2.new(1.1, 0, 1.1, 0)
		v2070.Position = UDim2.new(-0.08, 0, 0.943, 0)
		local v2084 = Instance.new("Frame", v2067)
		v2084.Name = "wobble2"
		v2084.BackgroundTransparency = 0.5
		v2084.Size = UDim2.new(1.1, 0, 0.09, 0)
		v2084.Position = UDim2.new(-0.08, 0, 0.878, 0)
		local v2098 = Instance.new("Frame", v2067)
		v2098.Name = "Visuals"
		v2098.BackgroundTransparency = 0.3
		v2098.Size = UDim2.new(0, 100, 0, 100)
		v2098.Position = UDim2.new(0.462, 0, 0.826, 0)
		local v2112 = Instance.new("ImageLabel", v2067)
		v2112.Name = "glow"
		v2112.BackgroundTransparency = 1
		v2112.ImageTransparency = 0
		v2112.Image = "rbxassetid://2344870656"
		v2112.Size = UDim2.new(0, 0, 0, 0)
		v2112.Position = UDim2.new(0.026, 0, -0.235, 0)
		local v2126 = Instance.new("Frame", v2067)
		v2126.Name = "Visuals2"
		v2126.BackgroundTransparency = 0.3
		v2126.Size = UDim2.new(0, 50, 0, 50)
		v2126.Position = UDim2.new(0.48, 0, 0.867, 0)
		local v2140 = Instance.new("TextLabel", v2067)
		v2140.Name = "Farmer"
		v2140.Font = "Arcade"
		v2140.Text = p129
		v2140.TextScaled = true
		v2140.TextSize = 60
		v2140.BackgroundTransparency = 1
		v2140.Size = UDim2.new(0.8, 0, 0, 42)
		v2140.Position = UDim2.new(0.11, 0, 0.867, 0)
		coroutine.resume(coroutine.create(function()
			while true do
				Swait()
				v2140.TextColor3 = Color3.new(1, 0, 0)
				v2140.TextStrokeColor3 = Color3.new(0, 0, 0)
				v2140.TextStrokeTransparency = 0
				v2140.Rotation = 0 + MATHR(-3, 3)
				v2140.Position = UDim2.new(0.11, 0 + MATHR(-3, 3), 0.867, 0 + MATHR(-3, 3))
				v2140.Font = Enum.Font.Arcade
				v2112.ImageColor3 = Color3.new(0, 0, 0)
				v2070.Rotation = 0 - 2 * math.cos(SINE / 24)
				v2084.Rotation = 0 - 2 * math.cos(SINE / 30)
				v2084.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				v2084.BorderColor3 = Color3.new(1, 0, 0)
				v2084.BorderSizePixel = 2
				v2098.Rotation = v2098.Rotation + MATHR(-5, 5)
				v2126.Rotation = v2126.Rotation + MATHR(-10, 10)
				v2098.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				v2098.BorderColor3 = Color3.new(1, 0, 0)
				v2126.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				v2126.BorderColor3 = Color3.new(1, 0, 0)
				v2070.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				v2070.BorderColor3 = Color3.new(1, 0, 0)
				v2070.BorderSizePixel = 2
			end
		end))
		coroutine.resume(coroutine.create(function()
			local v2291 = 205
			for v2290 = 0, v2291, 1 do
				Swait()
			end
			v2291 = v2067
			v2291:Destroy()
		end))
	end))
end

warnedpeople3 = function(p130)
	coroutine.resume(coroutine.create(function()
		local v2340 = v2336
		local v2343 = game.Players.LocalPlayer.PlayerGui:FindFirstChild("ARRIVAL")
		if v2343 then
			v2340 = v2336
			v2343 = game.Players.LocalPlayer.PlayerGui
			v2343:FindFirstChild("ARRIVAL"):destroy()
		end
		local v2346 = false
		local v2350 = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
		v2350.Name = "ARRIVAL"
		local v2353 = Instance.new("Frame", v2350)
		v2353.Name = "MainFrame"
		v2353.BackgroundTransparency = 1
		v2353.BorderSizePixel = 0
		v2353.Size = UDim2.new(1, 0, -0.013, 100)
		v2353.Position = UDim2.new(0, 0, 0.365, 0)
		local v2367 = Instance.new("TextLabel", v2353)
		v2367.Name = "TextFrame"
		v2367.Font = "Arcade"
		v2367.Text = ""
		v2367.TextScaled = true
		v2367.TextSize = 9
		v2367.TextStrokeTransparency = 1
		v2367.BackgroundTransparency = 1
		v2367.TextColor3 = Color3.new(1, 1, 1)
		v2367.TextStrokeColor3 = Color3.new(1, 1, 1)
		v2367.Size = UDim2.new(1, 0, 0, 92)
		v2367.Position = UDim2.new(0, 0, 0, 0)
		coroutine.resume(coroutine.create(function()
			v350 = 0
			while true do
				game:GetService("RunService").RenderStepped:Wait()
				v2353.BackgroundColor3 = AUDIOBASEDCOLOR
				v2353.BorderColor3 = AUDIOBASEDCOLOR
				v2367.Font = FONTS[math.random(1, #FONTS)]
				local v2397 = v777
				v2367.TextColor3 = AUDIOBASEDCOLOR
				local v2413 = AUDIOBASEDCOLOR
				v2367.TextStrokeColor3 = BrickColor.new("Black").Color
				local v2414 = v2346
				if v2414 then
					v2353.Rotation = 0 - 2 * math.cos(v350 / 24)
				end
				v350 = v350 + 1
				v2367.TextStrokeTransparency = 0
			end
		end))
		local v2417 = 1
		local v2420 = string.len(p130)
		local v2421 = v2420
		local v2422 = 1
		for v2417 = v2417, v2421, v2422 do
			v2420 = string.sub
			v2367.Text = v2420(p130, 1, v2417)
			game:GetService("RunService").RenderStepped:Wait()
		end
		v2421 = wait
		v2422 = 2
		v2421(v2422)
		local v2459 = true
		local v2427 = 0
		v2353.Rotation = v2427
		local v2460 = 1
		for v2428 = 0, 99, 1 do
			game:GetService("RunService").RenderStepped:Wait()
			v2427 = v2427 + 0.25
			v2353.Position = v2353.Position + UDim2.new(0, 0, 0.0005 * v2427, 0)
		end
		v2350:Destroy()
	end))
end

function FixCharacter()
	game:GetService("StarterGui"):SetCore("ResetButtonCallback", true)
	if resetBindable ~= nil then resetBindable:Destroy() end

	pcall(function() workspace[Clone_Character_Name]:Destroy() end)

	for i, v in pairs(game:GetChildren()) do
		if v.Name ~= "Chat" and v.Name ~= "Teams" and v.Name ~= "CoreGui" then  
			for o, b in pairs(v:GetDescendants()) do
				if b:IsA("LocalScript") and b.Name ~= "Animate" and b.Name ~= "BubbleChat" and b.Name ~= "ChatScript" then
					DelLScript = DelLScript + 1
					b:Destroy()
				elseif b:IsA("RemoteEvent") then
					if b.Parent and b.Parent.Name == "DefaultChatSystemChatEvents" then
						continue
					end

					DelREvent = DelREvent + 1
					b:Destroy()
				elseif b:IsA("RemoteFunction") then
					if b.Parent and b.Parent.Name == "DefaultChatSystemChatEvents" then
						continue
					end

					DelRFunction = DelRFunction + 1
					b:Destroy()
				elseif b:IsA("Tool") then
					DelTool = DelTool + 1
					b:Destroy()
				end
			end
		end
	end

	local Plrs = game.Players
	local Plr = Plrs.LocalPlayer
	local Char = Plr.Character

	for i,v in next, game:GetService("Players").LocalPlayer.Character:GetDescendants() do
		if v:IsA("BasePart") then 
			game:GetService("RunService").Heartbeat:connect(function()
				v.Velocity = Vector3.new(30,0,0)
			end)
		end
	end

	local index = 1

	for _,v in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
		if v.Name == "MeshPartAccessory" and v.Handle.Size == Vector3.new(4, 4, 1) then
			v.Name = "MPASword" .. index
			index = index + 1
		elseif v.Name == "MeshPartAccessory" and v.Handle.Size == Vector3.new(2.5,2.5,2.5) then
			if v.Handle.SpecialMesh.MeshId == "rbxassetid://5507041951" then
				v.Name = "MPAWing1"
			elseif v.Handle.SpecialMesh.MeshId == "rbxassetid://5507042353" then
				v.Name = "MPAWing2"
			end
		elseif v.Name == "MeshPartAccessory" and v.Handle.Size == Vector3.new(3,3,3) then
			v.Name = "MPAAura"
		end
	end

	if Char:FindFirstChild("MeshPartAccessory") ~= nil then
		if Char:FindFirstChild("MeshPartAccessory").Handle:FindFirstChildOfClass("SpecialMesh") ~= nil then
			Char:FindFirstChild("MeshPartAccessory").Handle:FindFirstChildOfClass("SpecialMesh"):Destroy()
		end
	end

	local ANCHOR_PLAYER = game:GetService("Players").LocalPlayer
	local PLAYER_HRP = ANCHOR_PLAYER.Character.HumanoidRootPart

	local ORIGIN_POS = PLAYER_HRP.CFrame

	local RunService = game:GetService("RunService")

	_G.REANIMATE_DONE = false

	coroutine.resume(coroutine.create(function() 
		while not _G.REANIMATE_DONE do
			PLAYER_HRP.CFrame = CFrame.new(ORIGIN_POS.Position.X, 500, ORIGIN_POS.Position.Z)
			RunService.RenderStepped:Wait()
		end
	end))

	local S = Instance.new("Sound")

	function CreateSoundP(ID, PARENT, VOLUME, PITCH, DOESLOOP)
		local NEWSOUND
		coroutine.resume(coroutine.create(function()
			NEWSOUND = S:Clone()
			NEWSOUND.Parent = PARENT
			NEWSOUND.Volume = 2
			NEWSOUND.Pitch = PITCH
			NEWSOUND.EmitterSize = VOLUME * 3
			NEWSOUND.SoundId = "http://www.roblox.com/asset/?id=" .. ID
			NEWSOUND:play()
			if DOESLOOP == true then
				NEWSOUND.Looped = true
			else
				repeat
					wait(1)
				until NEWSOUND.Playing == false
				NEWSOUND:remove()
			end
		end))
		return NEWSOUND
	end

	print("(HSC FE) Please wait...")
	local v18 = Instance.new("Hint", game:GetService("Workspace"))
	v18.Text = "(Hyperskidded Cannon FE) Please wait..."

	CreateSoundP(5035412139, game.Players.LocalPlayer.Character.Head, 7, 1, false)

	wait(1.1)

	Bypass = "death"

	Reanimate()

	_G.REANIMATE_DONE = true

	wait(.1)

	playerss = workspace[Clone_Character_Name]

	IsDead = false
	StateMover = true

	g1 = Instance.new("BodyGyro", playerss.HumanoidRootPart)
	g1.D = 175
	g1.P = 20000
	g1.MaxTorque = Vector3.new(0,9000,0)
	g1.CFrame = CFrame.new(playerss:FindFirstChild("HumanoidRootPart"),Position, (ORIGIN_POS * CFrame.new(0, 50, 0)).p)

	game:GetService("Debris"):AddItem(g1, .05)
	playerss:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new((ORIGIN_POS * CFrame.new(0, 50, 0)).p)

	v18:Destroy()

	wait(.2)

	print("(HSC FE) Done!")
	local v20 = Instance.new("Hint", game:GetService("Workspace"))
	v20.Text = "(Hyperskidded Cannon FE) Done!"

	CreateSoundP(5035412139, game.Players.LocalPlayer.Character.Head, 7, 1, false)

	wait(.5)

	v20:Destroy()

	MATHR = math.random

	if playerss:FindFirstChild("Starslayer Railgun") then
		CannonAcc = playerss["Starslayer Railgun"].Handle
	end

	if playerss:FindFirstChild("MPAAura") then
		MPAAuraAcc = playerss["MPAAura"].Handle
	end

	if playerss:FindFirstChild("MPASword1") then
		MPASwordAcc1 = playerss["MPASword1"].Handle
	end

	if playerss:FindFirstChild("MPASword2") then
		MPASwordAcc2 = playerss["MPASword2"].Handle
	end

	if playerss:FindFirstChild("MPASword3") then
		MPASwordAcc3 = playerss["MPASword3"].Handle
	end

	if playerss:FindFirstChild("MPASword4") then
		MPASwordAcc4 = playerss["MPASword4"].Handle
	end

	if playerss:FindFirstChild("MPAWing1") then
		MPAWingAcc1 = playerss["MPAWing1"].Handle
	end

	if playerss:FindFirstChild("MPAWing2") then
		MPAWingAcc2 = playerss["MPAWing2"].Handle
	end

	if playerss:FindFirstChild("MeshPartAccessory") then
		OrbAcc = playerss["MeshPartAccessory"].Handle
	end

	bbv = nil
	bullet = nil

	if Bypass == "death" then
		bullet = game.Players.LocalPlayer.Character["HumanoidRootPart"]
		bullet.Transparency = 0.25
		bullet.Material = Enum.Material.Neon
		bullet.BrickColor = BrickColor.new("White")
		bullet.Massless = true

		if bullet:FindFirstChildOfClass("Attachment") then
			for _,v in pairs(bullet:GetChildren()) do
				if v:IsA("Attachment") then
					v:Destroy()
				end
			end
		end

		bbv = Instance.new("BodyPosition",bullet)
		bbv.Position = playerss.Torso.CFrame.p
	end

	if CannonAcc then
		CannonAcc:FindFirstChildOfClass("AlignPosition").Name = "AlignPosition2"
		CannonAcc:FindFirstChildOfClass("AlignOrientation").Name = "AlignOrientation2"
	end

	if MPAAuraAcc then
		MPAAuraAcc:FindFirstChildOfClass("AlignPosition").Name = "AlignPosition2"
		MPAAuraAcc:FindFirstChildOfClass("AlignOrientation").Name = "AlignOrientation2"
	end

	if MPASwordAcc1 then
		MPASwordAcc1:FindFirstChildOfClass("AlignPosition").Name = "AlignPosition2"
		MPASwordAcc1:FindFirstChildOfClass("AlignOrientation").Name = "AlignOrientation2"
	end

	if MPASwordAcc2 then
		MPASwordAcc2:FindFirstChildOfClass("AlignPosition").Name = "AlignPosition2"
		MPASwordAcc2:FindFirstChildOfClass("AlignOrientation").Name = "AlignOrientation2"
	end

	if MPASwordAcc3 then
		MPASwordAcc3:FindFirstChildOfClass("AlignPosition").Name = "AlignPosition2"
		MPASwordAcc3:FindFirstChildOfClass("AlignOrientation").Name = "AlignOrientation2"
	end

	if MPASwordAcc4 then
		MPASwordAcc4:FindFirstChildOfClass("AlignPosition").Name = "AlignPosition2"
		MPASwordAcc4:FindFirstChildOfClass("AlignOrientation").Name = "AlignOrientation2"
	end

	if MPAWingAcc1 then
		MPAWingAcc1:FindFirstChildOfClass("AlignPosition").Name = "AlignPosition2"
		MPAWingAcc1:FindFirstChildOfClass("AlignOrientation").Name = "AlignOrientation2"
	end

	if MPAWingAcc2 then
		MPAWingAcc2:FindFirstChildOfClass("AlignPosition").Name = "AlignPosition2"
		MPAWingAcc2:FindFirstChildOfClass("AlignOrientation").Name = "AlignOrientation2"
	end

	if OrbAcc then
		OrbAcc:FindFirstChildOfClass("AlignPosition").Name = "AlignPosition2"
		OrbAcc:FindFirstChildOfClass("AlignOrientation").Name = "AlignOrientation2"
	end

	playerss.Torso.WaistBackAttachment.Position = Vector3.new(-0, -0, 0.6)
	playerss.Torso.WaistBackAttachment.Orientation = Vector3.new(-0, -0, 0)

	if Bypass == "death" then
		coroutine.wrap(function()
			while true do
				if STOPEVERYTHING then return end
				game:GetService("RunService").RenderStepped:wait()

				if IsDead then
					break
				end

				pcall(function()
					if not playerss or not playerss:FindFirstChildOfClass("Humanoid") or playerss:FindFirstChildOfClass("Humanoid").Health <= 0 then 
						IsDead = true; 
						return 
					end

					if StateMover then
						if FlingModeSky then
							bbv.Position = (CFrame.new(playerss.Torso.CFrame.Position.X, 500, playerss.Torso.CFrame.Position.Z)).p -- playerss.Torso.CFrame.p
							bullet.Position = (CFrame.new(playerss.Torso.CFrame.Position.X, 500, playerss.Torso.CFrame.Position.Z)).p -- (playerss.Torso.CFrame * CFrame.new(0, 500, 0)).p
						else
							bbv.Position = playerss.Torso.CFrame.p
							bullet.Position = playerss.Torso.CFrame.p
						end
					end
				end)
			end
		end)()
	end

	game:GetService("RunService").RenderStepped:Connect(function() 
		if STOPEVERYTHING then return end
		pcall(function()
			bbav = Instance.new("BodyAngularVelocity",bullet)
			bbav.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)
			bbav.P = 9799999999999999999999999999999999999
			bbav.AngularVelocity = Vector3.new(9799999999999999999999999999999999999, 9799999999999999999999999999999999999, 9799999999999999999999999999999999999)

			game:GetService("Debris"):AddItem(bbav, 0.1)
		end)
	end)

	local CDDF = {}

	DamageFling = function(DmgPer)
		if STOPEVERYTHING then return end
		if IsDead or Bypass ~= "death" or (DmgPer.Name == playerss.Name and DmgPer.Name == Clone_Character_Name) or CDDF[DmgPer] or not DmgPer or not DmgPer:FindFirstChildOfClass("Humanoid") or DmgPer:FindFirstChildOfClass("Humanoid").Health <= 0 then return end

		CDDF[DmgPer] = true; StateMover = false
		local PosFling = (DmgPer:FindFirstChild("HumanoidRootPart") and DmgPer:FindFirstChild("HumanoidRootPart") .CFrame.p) or (DmgPer:FindFirstChildOfClass("Part") and DmgPer:FindFirstChildOfClass("Part").CFrame.p)

		bullet.Rotation = playerss.Torso.Rotation

		for _=1,15 do
			bbv.Position = PosFling
			bullet.Position = PosFling

			game:GetService("RunService").RenderStepped:wait()
		end

		StateMover = true

		bbv.Position = playerss.Torso.CFrame.p
		bullet.Position = playerss.Torso.CFrame.p

		CDDF[DmgPer] = false
	end

	workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character:FindFirstChildWhichIsA('Humanoid')
	workspace.CurrentCamera.CameraType = "Custom"

	game.Players.LocalPlayer.CameraMinZoomDistance = math.huge - math.huge
	game.Players.LocalPlayer.CameraMaxZoomDistance = math.huge - math.huge
	game.Players.LocalPlayer.CameraMode = "Classic"
	game.Players.LocalPlayer.Character.Head.Anchored = false

	Player = game.Players.LocalPlayer
	Character = playerss
	Mouse = Player:GetMouse()

	speaker = game:GetService("Players").LocalPlayer

	workspace.CurrentCamera:remove()

	wait(.1)

	repeat wait() until speaker.Character ~= nil

	workspace.CurrentCamera.CameraSubject = speaker.Character:FindFirstChildWhichIsA('Humanoid')
	workspace.CurrentCamera.CameraType = "Custom"

	speaker.CameraMinZoomDistance = 0.5
	speaker.CameraMaxZoomDistance = 400
	speaker.CameraMode = "Classic"
	speaker.Character.Head.Anchored = false

	local function NoclipLoop()
		if speaker.Character ~= nil then
			for _, child in pairs(speaker.Character:GetDescendants()) do
				if child:IsA("BasePart") and child.CanCollide == true then
					child.CanCollide = false
				end
			end
		end
	end

	Noclipping = game:GetService('RunService').Stepped:connect(NoclipLoop)

	Character = playerss
	PlayerGui = Player.PlayerGui
	Cam = workspace.CurrentCamera
	Backpack = Player.Backpack
	Humanoid = Character.Humanoid
	RootPart = Character.HumanoidRootPart
	Torso = Character.Torso
	Head = Character.Head
	RightArm = Character["Right Arm"]
	LeftArm = Character["Left Arm"]
	RightLeg = Character["Right Leg"]
	LeftLeg = Character["Left Leg"]
	RootJoint = RootPart.RootJoint
	Neck = Torso.Neck
	RightShoulder = Torso["Right Shoulder"]
	LeftShoulder = Torso["Left Shoulder"]
	RightHip = Torso["Right Hip"]
	LeftHip = Torso["Left Hip"]
	cam = workspace.CurrentCamera
	HUM = Character.Humanoid
	ROOT = HUM.Torso
	MOUSEPOS = ROOT.Position

	ExceptEffects = IT("Folder", Character)
	ExceptEffects.Name = "ExceptEffects"
	Effects = IT("Folder", Character)
	Effects.Name = "Effects"
	ANIMATOR = Humanoid.Animator
	ANIMATE = Character.Animate

	if sick ~= nil then sick:Destroy() end

	sick = IT("Sound", Character)
	sick.Name = "epic music aint it"
	sick.SoundId = "rbxassetid://611191130" -- 3134116147
	sick.MaxDistance = "inf"
	sick.Volume = 3
	sick.Looped = true
	sick.Playing = true
	sick:Play()

	wait(1)

	OrbAccAthp = Instance.new("Attachment", RootPart)
	OrbAccAtho = Instance.new("Attachment", RootPart)

	MPASwordAthp1 = Instance.new("Attachment", RootPart)
	MPASwordAtho1 = Instance.new("Attachment", RootPart)

	MPASwordAthp2 = Instance.new("Attachment", RootPart)
	MPASwordAtho2 = Instance.new("Attachment", RootPart)

	MPASwordAthp3 = Instance.new("Attachment", RootPart)
	MPASwordAtho3 = Instance.new("Attachment", RootPart)

	MPASwordAthp4 = Instance.new("Attachment", RootPart)
	MPASwordAtho4 = Instance.new("Attachment", RootPart)

	GenerateStuffs()
	GenerateGlove()
	GenerateGui()

	SwitchMode(ModeCodeName, LastestMusicId)

	for i, v in pairs(game.Players.LocalPlayer.PlayerGui:GetChildren()) do
		if v.Name ~= "Chat" and v.Name ~= "BubbleChat" then
			v:Destroy()
		end
	end

	CannonUi()

	Humanoid.WalkSpeed = 25
end

function CannonUi()
	for i, v in pairs(game.Players.LocalPlayer.PlayerGui:GetChildren()) do
		if v.Name ~= "Chat" and v.Name ~= "BubbleChat" then
			v:Destroy()
		end
	end

	local function CreateLabel(p215, p216, p217, p218, p219, p220, p221, p222, p223)
		local v7127 = Instance.new("TextLabel")
		v7127.BackgroundTransparency = 1
		v7127.Size = UDim2.new(1, 0, 1, 0)
		v7127.Position = UDim2.new(0, 0, 0, 0)
		v7127.TextColor3 = p217
		v7127.TextStrokeTransparency = p222
		v7127.TextTransparency = p220
		v7127.FontSize = p218
		v7127.Font = p219
		v7127.BorderSizePixel = p221
		v7127.TextScaled = false
		v7127.Text = p216
		v7127.Name = p223
		v7127.Parent = p215
		return v7127
	end

	local function CreateFrame(p207, p208, p209, p210, p211, p212, p213, p214)
		local v7123 = Instance.new("Frame")
		v7123.BackgroundTransparency = p208
		v7123.BorderSizePixel = p209
		v7123.Position = p210
		v7123.Size = p211
		v7123.BackgroundColor3 = p212
		v7123.BorderColor3 = p213
		v7123.Name = p214
		v7123.Parent = p207
		return v7123
	end

	CreateLabel_1 = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
	CreateLabel_1.ResetOnSpawn = false
	CreateLabel_1.Name = randomstring_1()

	FixEngineButton = Instance.new("TextButton", CreateLabel_1)
	FixEngineButton.TextScaled = true
	FixEngineButton.Font = "Code"
	FixEngineButton.Name = randomstring_1()
	FixEngineButton.BorderSizePixel = 0
	FixEngineButton.BackgroundTransparency = 0.35
	FixEngineButton.TextColor3 = BrickColor.new("New Yeller").Color
	FixEngineButton.TextStrokeColor3 = BrickColor.new("New Yeller").Color
	FixEngineButton.TextStrokeTransparency = 0
	FixEngineButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	FixEngineButton.Text = "\226\148\131Fix character\226\148\131"
	FixEngineButton.Size = UDim2.new(0.2, 0, 0, 36)
	FixEngineButton.AnchorPoint = Vector2.new(1, 1)
	FixEngineButton.Position = UDim2.new(0.335, 0, 0, 0)

	GoodbyeButton = Instance.new("TextButton", CreateLabel_1)
	GoodbyeButton.TextScaled = true
	GoodbyeButton.Font = "Code"
	GoodbyeButton.Name = randomstring_1()
	GoodbyeButton.BorderSizePixel = 0
	GoodbyeButton.BackgroundTransparency = 0.35
	GoodbyeButton.TextColor3 = BrickColor.new("New Yeller").Color
	GoodbyeButton.TextStrokeColor3 = BrickColor.new("New Yeller").Color
	GoodbyeButton.TextStrokeTransparency = 0
	GoodbyeButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	GoodbyeButton.Text = "\226\148\131Shutdown server\226\148\131"
	GoodbyeButton.Size = UDim2.new(0.2, 0, 0, 36)
	GoodbyeButton.AnchorPoint = Vector2.new(0, 1)
	GoodbyeButton.Position = UDim2.new(0.735, 0, 0, 0)

	CurrentSong = Instance.new("TextButton", CreateLabel_1)
	CurrentSong.TextScaled = true
	CurrentSong.Font = "Code"
	CurrentSong.Name = randomstring_1()
	CurrentSong.BorderSizePixel = 0
	CurrentSong.BackgroundTransparency = 0.35
	CurrentSong.TextColor3 = BrickColor.new("New Yeller").Color
	CurrentSong.TextStrokeColor3 = BrickColor.new("New Yeller").Color
	CurrentSong.TextStrokeTransparency = 0
	CurrentSong.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	CurrentSong.Text = "\226\148\131\226\148\131"
	CurrentSong.Size = UDim2.new(0.2, 0, 0, 36)
	CurrentSong.AnchorPoint = Vector2.new(0, 1)
	CurrentSong.Position = UDim2.new(0.535, 0, 0, 0)

	FPSMeter = Instance.new("TextButton", CreateLabel_1)
	FPSMeter.TextScaled = true
	FPSMeter.Font = "Code"
	FPSMeter.Name = randomstring_1()
	FPSMeter.BorderSizePixel = 0
	FPSMeter.BackgroundTransparency = 0.35
	FPSMeter.TextColor3 = BrickColor.new("New Yeller").Color
	FPSMeter.TextStrokeColor3 = BrickColor.new("New Yeller").Color
	FPSMeter.TextStrokeTransparency = 0
	FPSMeter.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	FPSMeter.Text = "\226\148\1318888\226\148\131"
	FPSMeter.Size = UDim2.new(0.2, 0, 0, 36)
	FPSMeter.AnchorPoint = Vector2.new(0, 1)
	FPSMeter.Position = UDim2.new(0.335, 0, 0, 0)

	local WEAPONGUI = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
	WEAPONGUI.ResetOnSpawn = false
	WEAPONGUI.Name = randomstring_1()
	local v7658 = {}
	v7658[1] = "" .. SCRIPTVERSION .. ""
	v7658[2] = "1 ==> 9"
	v7658[3] = "="
	v7658[4] = "Q"
	v7658[5] = "E"
	v7658[6] = "R"
	v7658[7] = "T"
	v7658[8] = "Y"
	v7658[9] = "U"
	v7658[10] = "P"
	v7658[11] = "F"
	v7658[12] = "G"
	v7658[13] = "H"
	v7658[14] = "J"
	v7658[15] = "K"
	v7658[16] = "L"
	v7658[17] = "Z"
	v7658[18] = "X"
	v7658[19] = "C"
	v7658[20] = "V"
	v7658[21] = "B"
	v7658[22] = "N"
	v7658[23] = "M"
	local v7700 = CreateLabel(CreateFrame(WEAPONGUI, 1, 2, UDim2.new(0.8, 0, 0.9, 0), UDim2.new(0.26, 0, 0.07, 0), Color3.new(0, 0, 0), Color3.new(0, 0, 0), "Skill Frame"), "[FE]", BrickColor.new("New Yeller").Color, 8.5, Enum.Font.Antique, 0, 2, 0.5, "Skill text")

	FixEngineButton.MouseButton1Down:Connect(function()
		FixCharacter()
	end)

	coroutine.resume(coroutine.create(function()
		while true do
			FixEngineButton.TextColor3 = AUDIOBASEDCOLOR
			FixEngineButton.BorderColor3 = AUDIOBASEDCOLOR
			FixEngineButton.TextStrokeColor3 = AUDIOBASEDCOLOR
			FixEngineButton.Font = FONTS[math.random(1, #FONTS)]

			GoodbyeButton.TextColor3 = AUDIOBASEDCOLOR
			GoodbyeButton.BorderColor3 = AUDIOBASEDCOLOR
			GoodbyeButton.TextStrokeColor3 = AUDIOBASEDCOLOR
			GoodbyeButton.Font = FONTS[math.random(1, #FONTS)]

			FPSMeter.TextColor3 = AUDIOBASEDCOLOR
			FPSMeter.BorderColor3 = AUDIOBASEDCOLOR
			FPSMeter.TextStrokeColor3 = AUDIOBASEDCOLOR
			FPSMeter.Font = FONTS[math.random(1, #FONTS)]

			CurrentSong.TextColor3 = AUDIOBASEDCOLOR
			CurrentSong.BorderColor3 = AUDIOBASEDCOLOR
			CurrentSong.TextStrokeColor3 = AUDIOBASEDCOLOR
			CurrentSong.Font = FONTS[math.random(1, #FONTS)]

			NameMode.Font = FONTS[math.random(1, #FONTS)]

			coroutine.resume(coroutine.create(function()
				pcall(function() 
					local SoundAsset = game:GetService("MarketplaceService"):GetProductInfo(tonumber(string.sub(sick.SoundId, 14)))

					CurrentSong.Text = "\226\148\131" .. SoundAsset.Name .. "\226\148\131"
				end)
			end))

			game:GetService("RunService").RenderStepped:Wait()
		end
	end))

	for v7701 = 1, #v7658, 1 do
		v7668 = 0
		v7670 = 0.9
		v7672 = 0.04
		v7671 = v7672 * v7701
		v7669 = v7670 - v7671
		v7670 = 0
		v7671 = 0
		v7672 = 0
		local v7737 = CreateLabel(CreateFrame(WEAPONGUI, 1, 2, UDim2.new(0.8, v7668, v7669, v7670), UDim2.new(0.26, 0, 0.07, v7671), Color3.new(0, 0, 0), Color3.new(0, 0, v7672), "Skill Frame"), "[" .. v7658[v7701] .. "]", BrickColor.new("New Yeller").Color, 7.5, Enum.Font.Antique, 0, 2, 0.5, "Skill text")
	end

	coroutine.resume(coroutine.create(function()
		while true do
			for v34646, v34640 in pairs(WEAPONGUI:GetChildren()) do
				v34640:FindFirstChildWhichIsA("TextLabel").TextColor3 = AUDIOBASEDCOLOR
				v34640:FindFirstChildWhichIsA("TextLabel").TextStrokeColor3 = AUDIOBASEDCOLOR
				v34640:FindFirstChildWhichIsA("TextLabel").Font = FONTS[math.random(1, #FONTS)]
			end

			game:GetService("RunService").RenderStepped:Wait()
		end
	end))

	coroutine.resume(coroutine.create(function()
		local v7248 = Instance.new("LocalScript", FPSMeter)

		game:GetService("RunService").Heartbeat:Connect(function(fps) 
			if v7248.Parent then
				v7248.Parent.Text = "\226\148\131" .. math.floor(1 / fps) .. "\226\148\131"
			end
		end)
	end))
end

function CannonIntro() 
	local v31453 = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
	v31453.Name = "CreditsAndAuthentication"
	v31453.ResetOnSpawn = false
	coroutine.resume(coroutine.create(function()
		while true do
			local v31463 = v31457:IsDescendantOf(game)
			if not v31463 then
				break
			end
			v31463 = v31457
			v31463.TextColor3 = AUDIOBASEDCOLOR
			swait()
		end
	end))
	local v31482 = Instance.new("Sound")
	local v31483 = "DunDunDunDUNDUN"
	v31482.Name = v31483
	v31482.Volume = 9000000000
	v31482.SoundId = "rbxassetid://6112625298"
	v31482.Looped = false
	v31482.Playing = true
	v31482.Parent = v706
	local v60190 = {}
	v60190[1] = "Server locking will not prevent skids but ruins the game - Shadow"
	v60190[2] = "I hate my life but I love the script - Shadow"
	v60190[3] = "Revenge - Shadow"
	v60190[4] = "Perfect script to ruin a server - Shadow"
	v60190[5] = "OwO, I'm getting more hates from peoples baby - Shadow"
	v60190[6] = "Can someone please fuck me? - Shadow"
	v60190[7] = "I am god - Shadow"
	v60190[8] = "A dangerous script has been ran - Shadow"
	v60190[9] = "Hyperskidded Cannon FE Has been loaded."
	v60190[10] = "FE Ultraskidded Lord is 4872394728941859135879 times weaker than this. - Shadow"
	RSTMes = v60190
	local v60196 = RSTMes[math.random(1, #RSTMes)]
	coroutine.resume(coroutine.create(function()
		warnedpeople3(v60196)
	end))
	coroutine.resume(coroutine.create(function()
		local v31501 = 1
		local v31504 = string.len(v60196)
		for v31501 = v31501, v31504, 1 do
			game:GetService("RunService").RenderStepped:Wait()
			coroutine.resume(coroutine.create(function()
				local v31513 = Instance.new("Sound", game.Players.LocalPlayer.Character)
				v31513.SoundId = "rbxassetid://615716445"
				v31513.Volume = 500
				v31513.Name = randomstring_1()
				v31513.PlayOnRemove = true
				v31513:Play()
				v31513:Destroy()
			end))
		end
	end))
	local v31532 = {}
	v31532.AnchorPoint = Vector2.new(0.5, 0)
end

CannonUi()
CannonIntro()

if ChatEnabled then
	game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Hyperskidded Cannon FE (Filtering Enabled) " .. SCRIPTVERSION .. " by Breakfast/ItzNotShadow01. Original(HSC MXA) by SUPER_TIGERPRO/super_tiger123456 loaded.", "All")
end

USLCannonRemover()
USLCannonRemover()
USLCannonRemover()
USLCannonRemover()
USLCannonRemover()
USLCannonRemover()
USLCannonRemover()
USLCannonRemover()
USLCannonRemover()
USLCannonRemover()

g1 = Instance.new("BodyGyro", playerss.HumanoidRootPart)
g1.D = 175
g1.P = 20000
g1.MaxTorque = Vector3.new(0,9000,0)
g1.CFrame = CFrame.new(playerss:FindFirstChild("HumanoidRootPart"),Position, (ORIGIN_POS * CFrame.new(0, 50, 0)).p)

game:GetService("Debris"):AddItem(g1, .05)
playerss:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new((ORIGIN_POS * CFrame.new(0, 100, 0)).p)

local v337 = {}
v337.Title = "Bugs (HSC FE)"
v337.Text = "Sometimes, It just doesn't work. Also lag can destroy HumanoidRootPart."
v337.Duration = 40
v337.Button1 = "Okay :D"
game:GetService("StarterGui"):SetCore("SendNotification", v337)
local v342 = {}
v342.Title = "Hyperskidded Cannon FE"
v342.Text = "Press fix character if your body is disappeared/ruined/destroyed."
v342.Duration = 60
v342.Button1 = "Okay :D"
game:GetService("StarterGui"):SetCore("SendNotification", v342)
local v347 = {}
v347.Title = "Hyperskidded Cannon FE"
v347.Text = "For other modes, press M. HumanoidRootPart disappears after 3 seconds."
v347.Duration = 90
v347.Button1 = "Okay :D"
game:GetService("StarterGui"):SetCore("SendNotification", v347)

coroutine.resume(coroutine.create(function()
	wait(3)
	FlingModeSky = true
end))

Player.Chatted:Connect(function(Message)
	chatfunc(Message, false, true)
end)

spawnwave(Torso.Position)
CreateSound(144699494, Character, 9, 1, false)
SwitchModeEffect()
attackone()

CreateSoundP(6112625298, Character, 9, 1, false)


--//=================================\\
--\\=================================//

local CurrentCamera = game:GetService("Workspace").CurrentCamera

while true do
	if STOPEVERYTHING then return end
	pcall(function() 
		Swait()
		ANIMATE.Parent = nil

		for _,v in next, Humanoid:GetPlayingAnimationTracks() do
			v:Stop();
		end

		SINE = SINE + CHANGE
		FAST_SINE = FAST_SINE + 5

		GroundMababjin.CFrame = RootPart.CFrame * CFrame.new(0,-1.5,0)

		CurrentCamera.FieldOfView = 70 - sick.PlaybackLoudness / 95

		TORSOVELOCITY=(ActualVelocity*Vector3.new(1,0,1)).magnitude
		TORSOVELOCITY=(RootPart.Velocity*Vector3.new(1,0,1)).magnitude

		local TORSOVERTICALVELOCITY = RootPart.Velocity.y
		local HITFLOOR = Raycast(RootPart.Position, (CF(RootPart.Position, RootPart.Position + VT(0, -1, 0))).lookVector, 4, Character)
		local WALKSPEEDVALUE = 6 / (Humanoid.WalkSpeed / 16)

		if TORSOVERTICALVELOCITY > 20 then
			TORSOVERTICALVELOCITY = 20
		elseif TORSOVERTICALVELOCITY < -20 then
			TORSOVERTICALVELOCITY = -20
		end

		v34611 = {}
		v34611.Time = 1
		v34611.EffectType = "Block"
		v34611.Size = VT(1 + (sick.PlaybackLoudness / 500), 1, 1 + (sick.PlaybackLoudness / 500))
		v34611.Size2 = VT(1 + sick.PlaybackLoudness / 300, 1 + sick.PlaybackLoudness / 300, 1 + sick.PlaybackLoudness / 300)
		v34611.Transparency = 0
		v34611.Transparency2 = 1
		v34611.CFrame = RootPart.CFrame * CF(0 + 9 * math.sin(SINE / 35), 0 + 2 * math.sin(SINE / 75), 0 + 9 * math.cos(SINE / 35)) * CFrame.Angles(math.rad(-SINE * 0.5), math.rad(-SINE * 1), math.rad(-SINE * 1.5))
		v34611.MoveToPos = nil
		v34611.RotationX = nil
		v34611.RotationY = 0
		v34611.RotationZ = 0
		v34611.Material = "Neon"
		v34611.Color = AUDIOBASEDCOLOR
		v34611.SoundID = nil
		v34611.SoundPitch = nil
		v34611.SoundVolume = nil
		WACKYEFFECT(v34611)

		local v60540 = {}
		v60540.Time = 12.5
		v60540.EffectType = "Sphere"
		v60540.Size = VT(10 * sick.PlaybackLoudness / 75, 0, sick.PlaybackLoudness / 75)
		v60540.Size2 = VT(1 * sick.PlaybackLoudness / 75, 0.5, 7 * sick.PlaybackLoudness / 75)
		v60540.Transparency = 0
		v60540.Transparency2 = 1
		v60540.CFrame = RootPart.CFrame * CFrame.new(0, -3, 0) * CFrame.Angles(RAD(0), RAD(sick.PlaybackLoudness / 666), RAD(0))
		v60540.RotationX = 0
		v60540.RotationY = 0
		v60540.RotationZ = 0
		v60540.Material = "Neon"
		v60540.Color = AUDIOBASEDCOLOR
		v60540.SoundID = nil
		v60540.SoundPitch = nil
		v60540.SoundVolume = nil
		WACKYEFFECT(v60540)

		local v34685 = {}
		v34685.Time = 12.5
		v34685.EffectType = "Sphere"
		v34685.Size = VT(1 * sick.PlaybackLoudness / 75, 0, 10 * sick.PlaybackLoudness / 75)
		v34685.Size2 = VT(7 * sick.PlaybackLoudness / 75, 0.69, 1 * sick.PlaybackLoudness / 75)
		v34685.Transparency = 0
		v34685.Transparency2 = 1
		v34685.CFrame = RootPart.CFrame * CFrame.new(0, -3, 0) * CFrame.Angles(RAD(0), RAD(sick.PlaybackLoudness / 666), RAD(0))
		v34685.RotationX = 0
		v34685.RotationY = 0
		v34685.RotationZ = 0
		v34685.Material = "Neon"
		v34685.Color = AUDIOBASEDCOLOR
		v34685.SoundID = nil
		v34685.SoundPitch = nil
		v34685.SoundVolume = nil
		WACKYEFFECT(v34685)

		local v34712 = {}
		v34712.Time = 12.5
		v34712.EffectType = "Sphere"
		v34712.Size = VT(4 * sick.PlaybackLoudness / 75, 0, 4 * sick.PlaybackLoudness / 75)
		v34712.Size2 = VT(4 * sick.PlaybackLoudness / 75, 0.5, 4 * sick.PlaybackLoudness / 75)
		v34712.Transparency = 0
		v34712.Transparency2 = 1
		v34712.CFrame = RootPart.CFrame * CFrame.new(0, -3, 0) * CFrame.Angles(RAD(0), RAD(sick.PlaybackLoudness / 666), RAD(0))
		v34712.RotationX = 0
		v34712.RotationY = 0
		v34712.RotationZ = 0
		v34712.Material = "Neon"
		v34712.Color = AUDIOBASEDCOLOR -- Color3.fromRGB(0 + 170 * sick.PlaybackLoudness / 1000, 0, 0 + 170 * sick.PlaybackLoudness / 1000)
		v34712.SoundID = nil
		v34712.SoundPitch = nil
		v34712.SoundVolume = nil
		WACKYEFFECT(v34712)

		LWingWeld.C0 = ClerpHSC(LWingWeld.C0, CFrame.new(-1.35 + 0.35 * math.cos(SINE / 25), -0.8, 1.35 + 0.4 * math.cos(SINE / 25)) * CFrame.Angles(0, math.rad(75 + 25 * math.cos(SINE / 25)), 0), 0.25)
		RWingWeld.C0 = ClerpHSC(RWingWeld.C0, CFrame.new(1.35 - 0.35 * math.cos(SINE / 25), -0.8, 1.35 + 0.4 * math.cos(SINE / 25)) * CFrame.Angles(0, math.rad(105 - 25 * math.cos(SINE / 25)), 0), 0.25)

		if OrbAcc then
			OrbAccAthp.Name = "Attachment1"
			OrbAccAtho.Name = "Attachment2"

			OrbAccAthp.Position = Vector3.new(0 + 9 * math.sin(SINE / 35), 0 + 2 * math.sin(SINE / 75), 0 + 9 * math.cos(SINE / 35))
			OrbAccAtho.Rotation = Vector3.new(math.rad(-SINE * 0.5 * 50), math.rad(-SINE * 1 * 50), math.rad(-SINE * 1.5 * 50))

			OrbAcc:FindFirstChildOfClass("AlignPosition").Attachment1 = OrbAccAthp
			OrbAcc:FindFirstChildOfClass("AlignOrientation").Attachment1 = OrbAccAtho
		end

		if MPASwordAcc1 then
			MPASwordAthp1.Name = "Attachment1"
			MPASwordAtho1.Name = "Attachment2"

			MPASwordAthp1.Position = Vector3.new(2.5 * sick.PlaybackLoudness / 75, -3, 0)
			MPASwordAtho1.Rotation = Vector3.new(90, 0, 45 + 90)

			MPASwordAcc1:FindFirstChildOfClass("AlignPosition").Attachment1 = MPASwordAthp1
			MPASwordAcc1:FindFirstChildOfClass("AlignOrientation").Attachment1 = MPASwordAtho1
		end

		if MPASwordAcc2 then
			MPASwordAthp2.Position = Vector3.new(-2.5 * sick.PlaybackLoudness / 75, -3, 0)
			MPASwordAtho2.Rotation = Vector3.new(90, 0, -45)

			MPASwordAcc2:FindFirstChildOfClass("AlignPosition").Attachment1 = MPASwordAthp2
			MPASwordAcc2:FindFirstChildOfClass("AlignOrientation").Attachment1 = MPASwordAtho2
		end

		if MPASwordAcc3 then
			MPASwordAthp3.Position = Vector3.new(0, -3, 2.5 * sick.PlaybackLoudness / 75)
			MPASwordAtho3.Rotation = Vector3.new(90, 0, -45 - 90)

			MPASwordAcc3:FindFirstChildOfClass("AlignPosition").Attachment1 = MPASwordAthp3
			MPASwordAcc3:FindFirstChildOfClass("AlignOrientation").Attachment1 = MPASwordAtho3
		end

		if MPASwordAcc4 then
			MPASwordAthp4.Position = Vector3.new(0, -3, -2.5 * sick.PlaybackLoudness / 75)
			MPASwordAtho4.Rotation = Vector3.new(90, 0, -45 + 90)

			MPASwordAcc4:FindFirstChildOfClass("AlignPosition").Attachment1 = MPASwordAthp4
			MPASwordAcc4:FindFirstChildOfClass("AlignOrientation").Attachment1 = MPASwordAtho4
		end

		local v34740 = math.random(1, 8)

		if v34740 == 1 then
			local v34741 = {}
			v34741.Time = math.random(15, 65)
			v34741.EffectType = "Slash"
			v34741.Size = VT(0, 0.05, 0)
			v34741.Size2 = VT(0.0625, 0.015, 0.0625) * math.random(1, 8)
			v34741.Transparency = 0
			v34741.Transparency2 = 1
			v34741.CFrame = RootPart.CFrame * CF(0, -2, 0) * CFrame.Angles(math.rad(math.random(-5, 5)), math.rad(math.random(-360, 360)), math.rad(math.random(-5, 5)))
			v34741.MoveToPos = nil
			v34741.RotationX = 0
			v34741.RotationY = 0
			v34741.RotationZ = 0
			v34741.Material = "Neon"
			v34741.Color = AUDIOBASEDCOLOR
			v34741.SoundID = nil
			v34741.SoundPitch = nil
			v34741.SoundVolume = nil
			WACKYEFFECT(v34741)
		end

		--[[ if TORSOVERTICALVELOCITY > 1 and HITFLOOR == nil and ATTACK == false then
			ANIM = "Jump"
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, -0.1 + 0.1 * COS(SINE / 20)) * ANGLES(RAD(10), RAD(0), RAD(0)), 0.3)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * ANGLES(RAD(-40), RAD(0), RAD(0)), 0.3)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-40), RAD(0), RAD(20)) * RIGHTSHOULDERC0, 0.2 / 1.75)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(140 + 5 * COS(SINE /32)), RAD(180), RAD(0)) * RIGHTSHOULDERC0, 0.8 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, -0.3) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-5), RAD(0), RAD(-20)), 0.2 / 1.75)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, -0.3) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-5), RAD(0), RAD(20)), 0.2 / 1.75)		
		elseif TORSOVERTICALVELOCITY < -1 and HITFLOOR == nil and ATTACK == false then
			ANIM = "Fall"
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, -0.1 + 0.1 * COS(SINE / 20)) * ANGLES(RAD(-5), RAD(0), RAD(0)), 0.3)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * ANGLES(RAD(40), RAD(0), RAD(0)), 0.3)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(60)) * RIGHTSHOULDERC0, 0.2 / 1.75)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(140 + 5 * COS(SINE /32)), RAD(180), RAD(0)) * RIGHTSHOULDERC0, 0.8 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(20)), 0.2 / 1.75)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(10)), 0.2 / 1.75)			
		else --]]

		WACKYEFFECT({Time = 20, EffectType = "Sphere", Size = VT(0.6,0,0.6), Size2 = VT(0.35,3.5,0.35), Transparency = 0.3, Transparency2 = 1, CFrame = RootPart.CFrame*CF(0,-3,0)*ANGLES(RAD(0),RAD(MRANDOM(0,360)),RAD(0))*CF(0,0,MRANDOM(1,8)) * ANGLES(RAD(MRANDOM(-15,15)), RAD(0), RAD(MRANDOM(-15,15))), MoveToPos = nil, RotationX = 0, RotationY = MRANDOM(-1,1)*5, RotationZ = 0, Material = "Neon", Color = AUDIOBASEDCOLOR, UseBoomerangMath = true, SizeBoomerang = 50, SoundID = nil, SoundPitch = nil, SoundVolume = nil})

		if ModeCodeName == "Vaporwave" then
			local v59003 = math.random(1, 32 + (sick.PlaybackLoudness / 10))

			if v59003 == 1 then
				CreateSound(363808674, Head, 5, 2.3, false)
			end


			AUDIOBASEDCOLOR = RAINBOWCOLOR
			NameMode.Text = "HSC FE - Vaporwave"

			if ATTACK == false then
				RootJoint.C0 = ClerpHSC(RootJoint.C0, CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * CFrame.new(0, 0, 2 + 1 * math.cos(SINE / 18)) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), 1 / 3)
				Neck.C0 = ClerpHSC(Neck.C0, CFrame.new(0, 1, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * CF(0, 0, 0) * ANGLES(RAD(20 + math.random(-24, 24)), RAD(0 + math.random(-24, 24)), RAD(0 + math.random(-24, 24))), 1 / 3)
				RightShoulder.C0 = ClerpHSC(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(180 + math.random(-24, 24)), RAD(0 + math.random(-24, 24)), RAD(-25 + math.random(-24, 24))) * CFrame.new(-0.5, 0, 0) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)), 1 / 3)
				LeftShoulder.C0 = ClerpHSC(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(180 + math.random(-24, 24)), RAD(0 + math.random(-24, 24)), RAD(25 + math.random(-24, 24))) * CFrame.new(0.5, 0, 0) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0)), 1 / 3)
				RightHip.C0 = ClerpHSC(RightHip.C0, CF(1.5, -1, -0.5) * ANGLES(RAD(0), RAD(0), RAD(0)) * ANGLES(RAD(-20 + 1 * COS(SINE / 18)), RAD(0), RAD(-80)), 1 / 3)
				LeftHip.C0 = ClerpHSC(LeftHip.C0, CF(-1.5, -1, -0.7) * ANGLES(RAD(0), RAD(0), RAD(0)) * ANGLES(RAD(-35 + 1 * COS(SINE / 18)), RAD(0), RAD(80)), 1 / 3)
			end
		elseif ModeCodeName == "Rage" then
			sphereMK(2, math.random(5, 15) / 35, "Add", RootPart.CFrame * CFrame.new(math.random(-11, 11), -10, math.random(-8, 8)) * CFrame.Angles(math.rad(90 + math.random(-20, 20)), math.rad(math.random(-20, 20)), math.rad(math.random(-20, 20))), 0.4, 0.4, 5.35, 0, BrickColor.new("Really red"), 0)

			CameraEnshaking(0.34, sick.PlaybackLoudness / (100 * 4.5))

			NameMode.Text = "HSC FE - Rage"

			AUDIOBASEDCOLOR = Color3.new(sick.PlaybackLoudness / 250, 0, 0)

			if TORSOVELOCITY < 1 and ATTACK == false then
				ANIM = "Idle"
				DOUBLED = false
				READYTODOUBLE = false

				RightHip.C0 = ClerpHSC(RightHip.C0, CFrame.new(1, -0.25, -0.5) * ANGLES(math.rad(0), math.rad(90), math.rad(0)) * ANGLES(math.rad(-2.5), math.rad(0), math.rad(-10)), 0.1)
				LeftHip.C0 = ClerpHSC(LeftHip.C0, CFrame.new(-1, -1, 0) * ANGLES(math.rad(0), math.rad(-90), math.rad(0)) * ANGLES(math.rad(-2.5), math.rad(0), math.rad(10)), 0.1)
				RootJoint.C0 = ClerpHSC(RootJoint.C0, CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * CFrame.new(0, 0, 1.5 + 0.1 * math.cos(SINE / 28)) * ANGLES(math.rad(0 - 1 * math.cos(SINE / 34)), math.rad(0), math.rad(0)), 0.1)
				Neck.C0 = ClerpHSC(Neck.C0, CFrame.new(0, 1, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * CF(0, 0, 0) * ANGLES(RAD(25 + math.random(-5, 5) - 4 * COS(SINE / 12)), RAD(math.random(-5, 5)), RAD(15)), 1 / 3)
				RightShoulder.C0 = ClerpHSC(RightShoulder.C0, CFrame.new(1.5, 0.5, 0) * ANGLES(math.rad(10), math.rad(0), math.rad(20 + 2.5 * math.cos(SINE / 28))), 0.1)
				LeftShoulder.C0 = ClerpHSC(LeftShoulder.C0, CF(-0.7, 0.5 + sick.PlaybackLoudness / 1200, -0.3) * ANGLES(RAD(-200), RAD(0), RAD(30)) * CFrame.new(0.5, 0, 0) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0)), 0.15 / 3)
			elseif TORSOVELOCITY > 1 and ATTACK == false then
				ANIM = "Walk"
				DOUBLED = false
				READYTODOUBLE = false

				RightHip.C0 = ClerpHSC(RightHip.C0, CFrame.new(1, -0.25, -0.5) * ANGLES(math.rad(0), math.rad(90), math.rad(0)) * ANGLES(math.rad(-2.5), math.rad(0), math.rad(-20)), 0.2)
				LeftHip.C0 = ClerpHSC(LeftHip.C0, CFrame.new(-1, -1, 0) * ANGLES(math.rad(0), math.rad(-90), math.rad(0)) * ANGLES(math.rad(-2.5), math.rad(0), math.rad(20)), 0.2)
				RootJoint.C0 = ClerpHSC(RootJoint.C0, CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * CFrame.new(0, -0.5, 0.5 + 0.1 * math.cos(SINE / 28)) * ANGLES(math.rad(75), math.rad(0), math.rad(0)), 0.2)
				Neck.C0 = ClerpHSC(Neck.C0, CFrame.new(0, 1, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * CF(0, 0, 0) * ANGLES(RAD(25 + math.random(-5, 5) - 4 * COS(SINE / 12)), RAD(math.random(-5, 5)), RAD(15)), 1 / 3)
				RightShoulder.C0 = ClerpHSC(RightShoulder.C0, CFrame.new(1.5, 0.5, 0) * ANGLES(math.rad(10), math.rad(0), math.rad(20 + 2.5 * math.cos(SINE / 28))), 0.1)
				LeftShoulder.C0 = ClerpHSC(LeftShoulder.C0, CF(-0.7, 0.5 + sick.PlaybackLoudness / 1200, -0.3) * ANGLES(RAD(-200), RAD(0), RAD(30)) * CFrame.new(0.5, 0, 0) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0)), 0.15 / 3)
			end
		elseif ModeCodeName == "BadApple2" then
			CameraEnshaking(0.2, sick.PlaybackLoudness / (75 * 4.5))

			NameMode.Text = BAChanges[math.random(1, #BAChanges)]

			AUDIOBASEDCOLOR = Color3.new(sick.PlaybackLoudness / 1000, 0, 0)

			if TORSOVELOCITY < 1 and ATTACK == false then
				ANIM = "Idle"
				DOUBLED = false
				READYTODOUBLE = false

				RightHip.C0 = ClerpHSC(RightHip.C0, CFrame.new(1, -0.25, -0.5) * ANGLES(math.rad(0), math.rad(90), math.rad(0)) * ANGLES(math.rad(-2.5), math.rad(0), math.rad(-10)), 0.1)
				LeftHip.C0 = ClerpHSC(LeftHip.C0, CFrame.new(-1, -1, 0) * ANGLES(math.rad(0), math.rad(-90), math.rad(0)) * ANGLES(math.rad(-2.5), math.rad(0), math.rad(10)), 0.1)
				RootJoint.C0 = ClerpHSC(RootJoint.C0, CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * CFrame.new(0, 0, 1.5 + 0.1 * math.cos(SINE / 28)) * ANGLES(math.rad(0 - 1 * math.cos(SINE / 34)), math.rad(0), math.rad(0)), 0.1)
				Neck.C0 = ClerpHSC(Neck.C0, CFrame.new(0, 1, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * ANGLES(math.rad(15), math.rad(0), math.rad(0)), 0.1)
				RightShoulder.C0 = ClerpHSC(RightShoulder.C0, CFrame.new(1, 0.5, -0.25) * CFrame.Angles(0, math.rad(-10), math.rad(-90)) * CFrame.new(-0.5, 0, 0) * CFrame.Angles(0, math.rad(90), 0), 0.25)
				LeftShoulder.C0 = ClerpHSC(LeftShoulder.C0, CFrame.new(-1.5, 0.5, 0) * ANGLES(math.rad(10), math.rad(0), math.rad(-20 - 2.5 * math.cos(SINE / 28))), 0.1)
			elseif TORSOVELOCITY > 1 and ATTACK == false then
				ANIM = "Walk"
				DOUBLED = false
				READYTODOUBLE = false

				RightHip.C0 = ClerpHSC(RightHip.C0, CFrame.new(1, -0.25, -0.5) * ANGLES(math.rad(0), math.rad(90), math.rad(0)) * ANGLES(math.rad(-2.5), math.rad(0), math.rad(-20)), 0.2)
				LeftHip.C0 = ClerpHSC(LeftHip.C0, CFrame.new(-1, -1, 0) * ANGLES(math.rad(0), math.rad(-90), math.rad(0)) * ANGLES(math.rad(-2.5), math.rad(0), math.rad(20)), 0.2)
				RootJoint.C0 = ClerpHSC(RootJoint.C0, CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * CFrame.new(0, -0.5, 0.5 + 0.1 * math.cos(SINE / 28)) * ANGLES(math.rad(75), math.rad(0), math.rad(0)), 0.2)
				Neck.C0 = ClerpHSC(Neck.C0, CFrame.new(0, 1, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * ANGLES(math.rad(-20), math.rad(0), math.rad(0)), 0.2)
				RightShoulder.C0 = ClerpHSC(RightShoulder.C0, CFrame.new(1, 0.5, -0.25) * CFrame.Angles(0, math.rad(-10), math.rad(-90)) * CFrame.new(-0.5, 0, 0) * CFrame.Angles(0, math.rad(90), 0), 0.25)
				LeftShoulder.C0 = ClerpHSC(LeftShoulder.C0, CFrame.new(-1.5, 0.5, 0) * ANGLES(math.rad(-30), math.rad(0), math.rad(-30 - 2.5 * math.cos(SINE / 28))), 0.2)
			end
		elseif ModeCodeName == "appel" then
			NameMode.Text = BAChanges[math.random(1, #BAChanges)]

			if TORSOVELOCITY < 1 and ATTACK == false then
				ANIM = "Idle"
				DOUBLED = false
				READYTODOUBLE = false

				RootJoint.C0 = ClerpHSC(RootJoint.C0, CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.15 / 3)
				Neck.C0 = ClerpHSC(Neck.C0, CFrame.new(0, 1, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * CF(0, 0, 0) * ANGLES(RAD(0 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 0.15 / 3)
				RightShoulder.C0 = ClerpHSC(RightShoulder.C0, CF(1.5, 0.5, -0.03) * ANGLES(RAD(180), RAD(-15), RAD(0)) * CFrame.new(-0.5, 0, 0) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)), 0.15 / 3)
				LeftShoulder.C0 = ClerpHSC(LeftShoulder.C0, CF(-1.45, 0.4, 0.5) * ANGLES(RAD(25), RAD(0), RAD(35)) * CFrame.new(0.5, 0, 0) *  CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0)), 0.15 / 3)
				RightHip.C0 = ClerpHSC(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(75), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)), 0.15 / 3)
				LeftHip.C0 = ClerpHSC(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-75), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)), 0.15 / 3)
			elseif TORSOVELOCITY > 1 and ATTACK == false then
				ANIM = "Walk"
				DOUBLED = false
				READYTODOUBLE = false
			end
		elseif ModeCodeName == "FNFB3" then
			CameraEnshaking(0.2, sick.PlaybackLoudness / (75 * 4.5))

			NameMode.Text = FNFB3Changes[math.random(1, #FNFB3Changes)]

			AUDIOBASEDCOLOR = Color3.new(sick.PlaybackLoudness / 1000, 0, 0)

			if TORSOVELOCITY < 1 and ATTACK == false then
				ANIM = "Idle"
				DOUBLED = false
				READYTODOUBLE = false

				RightHip.C0 = ClerpHSC(RightHip.C0, CFrame.new(1, -0.25, -0.5) * ANGLES(math.rad(0), math.rad(90), math.rad(0)) * ANGLES(math.rad(-2.5), math.rad(0), math.rad(-10)), 0.1)
				LeftHip.C0 = ClerpHSC(LeftHip.C0, CFrame.new(-1, -1, 0) * ANGLES(math.rad(0), math.rad(-90), math.rad(0)) * ANGLES(math.rad(-2.5), math.rad(0), math.rad(10)), 0.1)
				RootJoint.C0 = ClerpHSC(RootJoint.C0, CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * CFrame.new(0, 0, 1.5 + 0.1 * math.cos(SINE / 28)) * ANGLES(math.rad(0 - 1 * math.cos(SINE / 34)), math.rad(0), math.rad(0)), 0.1)
				Neck.C0 = ClerpHSC(Neck.C0, CFrame.new(0, 1, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * ANGLES(math.rad(15), math.rad(0), math.rad(0)), 0.1)
				RightShoulder.C0 = ClerpHSC(RightShoulder.C0, CF(1.55, 0.5, 0.5) * ANGLES(RAD(250), RAD(20), RAD(-80)) * CFrame.new(-0.5, 0, 0) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)), 1 / 3)
				LeftShoulder.C0 = ClerpHSC(LeftShoulder.C0, CFrame.new(-1.5, 0.5, 0) * ANGLES(math.rad(10), math.rad(0), math.rad(-20 - 2.5 * math.cos(SINE / 28))), 0.1)
			elseif TORSOVELOCITY > 1 and ATTACK == false then
				ANIM = "Walk"
				DOUBLED = false
				READYTODOUBLE = false

				RightHip.C0 = ClerpHSC(RightHip.C0, CFrame.new(1, -0.25, -0.5) * ANGLES(math.rad(0), math.rad(90), math.rad(0)) * ANGLES(math.rad(-2.5), math.rad(0), math.rad(-20)), 0.2)
				LeftHip.C0 = ClerpHSC(LeftHip.C0, CFrame.new(-1, -1, 0) * ANGLES(math.rad(0), math.rad(-90), math.rad(0)) * ANGLES(math.rad(-2.5), math.rad(0), math.rad(20)), 0.2)
				RootJoint.C0 = ClerpHSC(RootJoint.C0, CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * CFrame.new(0, -0.5, 0.5 + 0.1 * math.cos(SINE / 28)) * ANGLES(math.rad(75), math.rad(0), math.rad(0)), 0.2)
				Neck.C0 = ClerpHSC(Neck.C0, CFrame.new(0, 1, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * ANGLES(math.rad(-20), math.rad(0), math.rad(0)), 0.2)
				RightShoulder.C0 = ClerpHSC(RightShoulder.C0, CFrame.new(1, 0.5, -0.25) * CFrame.Angles(0, math.rad(-10), math.rad(-90)) * CFrame.new(-0.5, 0, 0) * CFrame.Angles(0, math.rad(90), 0), 0.25)
				LeftShoulder.C0 = ClerpHSC(LeftShoulder.C0, CFrame.new(-1.5, 0.5, 0) * ANGLES(math.rad(-30), math.rad(0), math.rad(-30 - 2.5 * math.cos(28 / 28))), 0.2)
			end
		elseif ModeCodeName == "Relaxed" then
			NameMode.Text = "HSC FE - Relaxed"

			AUDIOBASEDCOLOR = RAINBOWCOLOR

			if TORSOVELOCITY < 1 and ATTACK == false then
				RootJoint.C0 = ClerpHSC(RootJoint.C0, CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * CFrame.new(0, 0, -0.5 * math.sin(SINE / 25)) * CFrame.Angles(math.rad(-90 + 5 * math.cos(SINE / 25)), math.rad(0), math.rad(0)), 0.23333333333333)
				Neck.C0 = ClerpHSC(Neck.C0, CFrame.new(0, 1, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * CFrame.new(0, -0.1, 0) * CFrame.Angles(math.rad(25 + 5 * math.cos(SINE / 25)), math.rad(0), math.rad(0)), 0.23333333333333)
				RightShoulder.C0 = ClerpHSC(RightShoulder.C0, CFrame.new(1, 0.75, 0.1) * CFrame.Angles(math.rad(-165.1 - 5 * math.cos(SINE / 25)), math.rad(0), math.rad(-40)) * CFrame.new(-0.5, 0, 0) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)), 0.23333333333333)
				LeftShoulder.C0 = ClerpHSC(LeftShoulder.C0, CFrame.new(-1, 0.75, 0.1) * CFrame.Angles(math.rad(-165 - 5 * math.cos(SINE / 25)), math.rad(0), math.rad(40)) * CFrame.new(0.5, 0, 0) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0)), 0.23333333333333)
				RightHip.C0 = ClerpHSC(RightHip.C0, CFrame.new(1, -1, 0) * CFrame.Angles(math.rad(0 + 10 * math.cos(SINE / 25)), math.rad(90), math.rad(0)) * CFrame.Angles(math.rad(10), math.rad(0), math.rad(0)), 0.23333333333333)
				LeftHip.C0 = ClerpHSC(LeftHip.C0, CFrame.new(-1, -1, 0) * CFrame.Angles(math.rad(25 + 10 * math.cos(SINE / 25)), math.rad(-90), math.rad(0)) * CFrame.Angles(math.rad(10), math.rad(0), math.rad(0)), 0.23333333333333)
				-- v72927.C0 = ClerpHSC(v794.C0, CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)), 0.5)
			elseif TORSOVELOCITY > 1 and ATTACK == false then
				RootJoint.C0 = ClerpHSC(RootJoint.C0, CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * CFrame.new(0, 0, -0.5 * math.sin(SINE / 25)) * CFrame.Angles(math.rad(-90 + 5 * math.cos(SINE / 25)), math.rad(0), math.rad(0)), 0.23333333333333)
				Neck.C0 = ClerpHSC(Neck.C0, CFrame.new(0, 1, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * CFrame.new(0, -0.1, 0) * CFrame.Angles(math.rad(25 + 5 * math.cos(SINE / 25)), math.rad(0), math.rad(0)), 0.23333333333333)
				RightShoulder.C0 = ClerpHSC(RightShoulder.C0, CFrame.new(1, 0.75, 0.1) * CFrame.Angles(math.rad(-165.1 - 5 * math.cos(SINE / 25)), math.rad(0), math.rad(-40)) * CFrame.new(-0.5, 0, 0) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)), 0.23333333333333)
				LeftShoulder.C0 = ClerpHSC(LeftShoulder.C0, CFrame.new(-1, 0.75, 0.1) * CFrame.Angles(math.rad(-165 - 5 * math.cos(SINE / 25)), math.rad(0), math.rad(40)) * CFrame.new(0.5, 0, 0) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0)), 0.23333333333333)
				RightHip.C0 = ClerpHSC(RightHip.C0, CFrame.new(1, -1, 0) * CFrame.Angles(math.rad(0 + 10 * math.cos(SINE / 25)), math.rad(90), math.rad(0)) * CFrame.Angles(math.rad(10), math.rad(0), math.rad(0)), 0.23333333333333)
				LeftHip.C0 = ClerpHSC(LeftHip.C0, CFrame.new(-1, -1, 0) * CFrame.Angles(math.rad(25 + 10 * math.cos(SINE / 25)), math.rad(-90), math.rad(0)) * CFrame.Angles(math.rad(10), math.rad(0), math.rad(0)), 0.23333333333333)
				-- v72927.C0 = ClerpHSC(v794.C0, CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)), 0.5)
			end
		elseif ModeCodeName == "iNsaNitY" then
			NameMode.Text = INsAnItyChanges[math.random(1, #INsAnItyChanges)]

			CameraEnshaking(0.2, sick.PlaybackLoudness / (75 * 4.5))

			if TORSOVELOCITY < 1 and ATTACK == false then
				ANIM = "Idle"
				DOUBLED = false
				READYTODOUBLE = false

				RootJoint.C0 = ClerpHSC(RootJoint.C0, CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * CFrame.new(0, -0.1, -0.1 + 0.05 * COS(SINE / 12) + sick.PlaybackLoudness / 1200) * ANGLES(RAD(15), RAD(0), RAD(0)), 0.15 / 3)
				RightShoulder.C0 = ClerpHSC(RightShoulder.C0, CF(1.5, 0.5 + 0.025 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(0 - 7.5 * SIN((SINE / 12) / SINE)), RAD(12 + 7.5 * SIN(SINE / 12))) * CFrame.new(-0.5, 0, 0) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)), 0.15 / 3)
				LeftShoulder.C0 = ClerpHSC(LeftShoulder.C0, CF(-0.7, 0.5 + sick.PlaybackLoudness / 1200, -0.3) * ANGLES(RAD(-200), RAD(0), RAD(30)) * CFrame.new(0.5, 0, 0) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0)), 0.15 / 3)
				RightHip.C0 = ClerpHSC(RightHip.C0, CF(1, -1 - 0.05 * COS(v350 / 12), -0.01) * ANGLES(RAD(0), RAD(80), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / 3)
				LeftHip.C0 = ClerpHSC(LeftHip.C0, CF(-1, -1 - 0.05 * COS(v350 / 12), -0.01) * ANGLES(RAD(0), RAD(-80), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 1 / 3)
				Neck.C0 = ClerpHSC(Neck.C0, CFrame.new(0, 1, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * CF(0, 0, 0) * ANGLES(RAD(25 + MATHR(-5, 5) - 4 * COS(v350 / 12)), RAD(MATHR(-5, 5)), RAD(15)), 1 / 3)
			elseif TORSOVELOCITY > 1 and ATTACK == false then

			end
		elseif ModeCodeName == "InsAnitY" then
			NameMode.Text = INsAnItyChanges[math.random(1, #INsAnItyChanges)]

			AUDIOBASEDCOLOR = INsAnItyColorChanges[math.random(1, #INsAnItyColorChanges)]

			if TORSOVELOCITY < 1 and ATTACK == false then
				ANIM = "Idle"
				DOUBLED = false
				READYTODOUBLE = false

				RightHip.C0 = ClerpHSC(RightHip.C0, CFrame.new(1, 0.2 - 0.1 * math.cos(SINE / 20), -0.3) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)) * CFrame.Angles(math.rad(3), math.rad(15 - 2 * math.cos(SINE / 56)), math.rad(50 - 2 * math.cos(SINE / 32))), 0.1)
				LeftHip.C0 = ClerpHSC(LeftHip.C0, CFrame.new(-1, -1 - 0.1 * math.cos(SINE / 20), 0) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0)) * CFrame.Angles(math.rad(3), math.rad(-1 - 2 * math.cos(SINE / 56)), math.rad(20 + 2 * math.cos(SINE / 32))), 0.1)
				RootJoint.C0 = ClerpHSC(RootJoint.C0, CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * CFrame.new(0, -0 + 0.03 * math.cos(SINE / 32), -1.2 + 0.1 * math.cos(SINE / 20)) * CFrame.Angles(math.rad(45 - 2 * math.cos(SINE / 32)), math.rad(0), math.rad(-30 + 2 * math.cos(SINE / 56))), 0.1)
				Neck.C0 = ClerpHSC(Neck.C0, CFrame.new(0, 1, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * CFrame.Angles(math.rad(23 - 2 * math.cos(SINE / 37)), math.rad(0 + 5 * math.cos(SINE / 43) - 5 * math.cos(SINE / 25)), math.rad(22 - 2 * math.cos(SINE / 56))), 0.1)
				RightShoulder.C0 = ClerpHSC(RightShoulder.C0, CFrame.new(1.5, 0.5 + 0.025 * math.cos(SINE / 45), 0) * CFrame.Angles(math.rad(5 + 3 * math.cos(SINE / 43)), math.rad(-14 - 5 * math.cos(SINE / 52)), math.rad(63 + 9 * math.cos(SINE / 45))), 0.1)
				LeftShoulder.C0 = ClerpHSC(LeftShoulder.C0, CFrame.new(-1.35, 1 + 0.025 * math.cos(SINE / 45), -0.2) * CFrame.Angles(math.rad(148 - 2 * math.cos(SINE / 51)), math.rad(0 - 4 * math.cos(SINE / 64)), math.rad(22 - 2 * math.cos(SINE / 45))), 0.1)
				-- v63233.C0 = ClerpHSC(v794.C0, CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)), 0.5)
			elseif TORSOVELOCITY > 1 and ATTACK == false then
				ANIM = "Walk"
				DOUBLED = false
				READYTODOUBLE = false

				RootJoint.C0 = ClerpHSC(RootJoint.C0, CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * CFrame.new(0 - 0.15 * math.cos(SINE / (SINE / 28)), -0.5, 0.5 + 0.1 * math.cos(SINE / 28)) * CFrame.Angles(math.rad(70), math.rad(0 - Head.RotVelocity.Y), math.rad(0 - Head.RotVelocity.Y * 4.5 + 3 * math.cos(SINE / 47))), 0.066666666666667)
				Neck.C0 = ClerpHSC(Neck.C0, CFrame.new(0, 1, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-17 - 5 * math.cos(SINE / 52)), math.rad(0 - 3 * math.cos(SINE / 37)), math.rad(0 + 2 * math.cos(SINE / 78))), 0.066666666666667)
				RightShoulder.C0 = ClerpHSC(RightShoulder.C0, CFrame.new(1.5, 0.5, 0) * CFrame.Angles(math.rad(-41.6 - 4 * math.sin(SINE / 25)), math.rad(math.random(-0.25, 3)), math.rad(math.random(0.25, 3))) * CFrame.new(-0.5, 0, 0) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)), 0.23333333333333)
				LeftShoulder.C0 = ClerpHSC(LeftShoulder.C0, CFrame.new(-1.5, 0.5 + 0.1 * math.cos(SINE / 28), 0) * CFrame.Angles(math.rad(-8 - 3 * math.cos(SINE / 55)), math.rad(20 + 8 * math.cos(SINE / 67)), math.rad(-20 - 4 * math.cos(SINE / 29))) * CFrame.new(0.5, 0, 0) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0)), 0.066666666666667)
				RightHip.C0 = ClerpHSC(RightHip.C0, CFrame.new(1, -0.5, -0.6) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)) * CFrame.Angles(math.rad(1.5), math.rad(0), math.rad(-20 - 5 * math.cos(SINE / 34))), 0.066666666666667)
				LeftHip.C0 = ClerpHSC(LeftHip.C0, CFrame.new(-1, -1, 0) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0)) * CFrame.Angles(math.rad(1), math.rad(0), math.rad(20 + 2 * math.cos(SINE / 38))), 0.066666666666667)
				-- v63233.C0 = Clerp.HSC(v794.C0, CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)), 0.5)
			end
		elseif ModeCodeName == "KARMA" then
			CameraEnshaking(1.9, sick.PlaybackLoudness / (75 * 4.5))

			NameMode.Text = KARChanges[math.random(1, #KARChanges)]

			AUDIOBASEDCOLOR = BrickColor.random().Color

			if TORSOVELOCITY < 1 and ATTACK == false then
				ANIM = "Idle"
				DOUBLED = false
				READYTODOUBLE = false

				RootJoint.C0 = ClerpHSC(RootJoint.C0, CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * CF(0, -0.1, -0.1 + 0.05 * COS(SINE / 12) + sick.PlaybackLoudness / 1200) * ANGLES(RAD(15), RAD(0), RAD(0)), 0.15 / 3)
				Neck.C0 = ClerpHSC(Neck.C0, CFrame.new(0, 1, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * CF(0, 0, 0) * ANGLES(RAD(25 + MATHR(-5, 5) - 4 * COS(SINE / 12)), RAD(MATHR(-5, 5)), RAD(15)), 1 / 3)
				RightShoulder.C0 = ClerpHSC(RightShoulder.C0, CF(1.5, 0.5 + 0.025 * COS(SINE / 12), 0) * ANGLES(RAD(0), RAD(0 - 7.5 * SIN(SINE / 12)), RAD(12 + 7.5 * SIN(SINE / 12))) * CFrame.new(-0.5, 0, 0) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)), 0.15 / 3)
				LeftShoulder.C0 = ClerpHSC(LeftShoulder.C0, CF(-0.7, 0.5 + sick.PlaybackLoudness / 1200, -0.3) * ANGLES(RAD(-200), RAD(0), RAD(30)) * CFrame.new(0.5, 0, 0) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0)), 0.15 / 3)
				RightHip.C0 = ClerpHSC(RightHip.C0, CFrame.new(1, -0.5, -0.5) * CFrame.Angles(math.rad(-11 + 9 * math.cos(SINE / 74)), math.rad(80), math.rad(0)) * CFrame.Angles(math.rad(0 + 5 * math.cos(SINE / 61)), math.rad(0), math.rad(0)), 0.23333333333333)
				LeftHip.C0 = ClerpHSC(LeftHip.C0, CFrame.new(-1, -1, 0) * CFrame.Angles(math.rad(-11 - 9 * math.cos(SINE / 54)), math.rad(-80), math.rad(0)) * CFrame.Angles(math.rad(0 - 5 * math.cos(SINE / 55)), math.rad(0), math.rad(0)), 0.23333333333333)
			elseif TORSOVELOCITY > 1 and ATTACK == false then
				ANIM = "Walk"
				DOUBLED = false
				READYTODOUBLE = false

				RootJoint.C0 = ClerpHSC(RootJoint.C0, CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * CF(0 + 0.25 * COS(SINE / 63) + 0.92 * SIN(SINE / 95), 0, 1 + 1 * SIN(SINE / 53)) * ANGLES(RAD(70), RAD(0 - RootPart.RotVelocity.y), RAD(0 - RootPart.RotVelocity.Y * 4.5 + 3 * COS(SINE / 47))), 0.15 / 3)
				Neck.C0 = ClerpHSC(Neck.C0, CFrame.new(0, 1, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * CF(0, 0, 0) * ANGLES(RAD(15 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 0.15 / 3)
				RightShoulder.C0 = ClerpHSC(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(12 - 4.1 * SIN(SINE / 12))) * CFrame.new(-0.5, 0, 0) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)), 0.15 / 3)
				LeftShoulder.C0 = ClerpHSC(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-12 + 4.1 * SIN(SINE / 12))) * CFrame.new(0.5, 0, 0) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0)), 0.15 / 3)
				RightHip.C0 = ClerpHSC(RightHip.C0, CF(1, -0.5 - 0.02 * SIN(SINE / 12), -0.5) * ANGLES(RAD(-10 - 2.5 * SIN(SINE / 21)), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.15 / 3)
				LeftHip.C0 = ClerpHSC(LeftHip.C0, CF(-1, -1 - 0.02 * SIN(SINE / 12), -0.01) * ANGLES(RAD(-20 - 2.5 * SIN(SINE / 51)), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.15 / 3)
			end
		elseif ModeCodeName == "NulledXD" then
			NameMode.Text = "HSC MXA - NulledXD"

			CameraEnshaking(1.4, sick.PlaybackLoudness / (75 * 4.5)) 

			AUDIOBASEDCOLOR = RAINBOWCOLOR

			if not sick:FindFirstChildOfClass("DistortionSoundEffect") then
				local SoundEffect = Instance.new("DistortionSoundEffect")

				SoundEffect.Priority = 2147483647
				SoundEffect.Level = 0.99
				SoundEffect.Name = randomstring_1()
				SoundEffect.Parent = sick

				coroutine.resume(coroutine.create(function()
					repeat
						Swait()
					until ModeCodeName ~= "NulledXD"

					SoundEffect:Destroy()
				end))
			end

			if ATTACK == false then
				RootJoint.C0 = ClerpHSC(RootJoint.C0, CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * CF(-0.25 * COS(FAST_SINE / 50), 0, -0.5 - 0.5 * COS(FAST_SINE / 25)) * ANGLES(RAD(0), RAD(0), RAD(45 * SIN(FAST_SINE / 50))) * ANGLES(RAD(45 + 22.5 * COS(FAST_SINE / 25)), RAD(0), RAD(0)), 2 / 3)
				Neck.C0 = ClerpHSC(Neck.C0, CFrame.new(0, 1, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * CF(0, 0, 0) * ANGLES(RAD(-45 - 22.5 * COS(FAST_SINE / 25)), RAD(0), RAD(-45 * SIN(FAST_SINE / 50))), 2 / 3)
				RightShoulder.C0 = ClerpHSC(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(175 + 65 * SIN(FAST_SINE / 25)), RAD(0), RAD(-45 * SIN(FAST_SINE / 12.5))) * CF(0, -0.5, 0) * CFrame.new(-0.5, 0, 0) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)), 1 / 3)
				LeftShoulder.C0 = ClerpHSC(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(175 + 65 * SIN(FAST_SINE / 25)), RAD(0), RAD(45 * SIN(FAST_SINE / 12.5))) * CF(0, -0.5, 0) * CFrame.new(0.5, 0, 0) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0)), 1 / 3)
				RightHip.C0 = ClerpHSC(RightHip.C0, CF(1, -0.5 + 0.5 * COS(FAST_SINE / 25), -0.5 - 0.5 * COS(FAST_SINE / 25)) * ANGLES(RAD(0), RAD(70), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 2 / 3)
				LeftHip.C0 = ClerpHSC(LeftHip.C0, CF(-1, -0.5 + 0.5 * COS(FAST_SINE / 25), -0.5 - 0.5 * COS(FAST_SINE / 25)) * ANGLES(RAD(0), RAD(-70), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 2 / 3)
				-- v51514.C0 = ClerpHSC(v794.C0, CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)), 1)
			end
		elseif ModeCodeName == "Rolling girl" then
			NameMode.Text = "HSC MXA - Rolling girl"

			AUDIOBASEDCOLOR = RAINBOWCOLOR

			if ATTACK == false then
				RootJoint.C0 = ClerpHSC(RootJoint.C0, CFrame.new() * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * CFrame.new(0 + 1 * math.sin(SINE / 3), 0 + 1 * math.cos(SINE / 3), -0.75) * CFrame.Angles(math.rad(0), math.rad(-10), math.rad(0)), 1)
				Neck.C0 = ClerpHSC(Neck.C0, CFrame.new(0, 1, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * CFrame.new(), 1)
				RightShoulder.C0 = ClerpHSC(RightShoulder.C0, CFrame.new(1.5, 1, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(90)) * CFrame.new(-0.5, 0, 0) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)), 1)
				LeftShoulder.C0 = ClerpHSC(LeftShoulder.C0, CFrame.new(-1.5, 1, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(-90)) * CFrame.new(0.5, 0, 0) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0)), 1)
				RightHip.C0 = ClerpHSC(RightHip.C0, CFrame.new(1.5, -1, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(70)), 1)
				LeftHip.C0 = ClerpHSC(LeftHip.C0, CFrame.new(-0.5, -1.25, -0.25) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(10)), 1)
				RightHip.C1 = ClerpHSC(RightHip.C1, CFrame.new(), 1)
				LeftHip.C1 = ClerpHSC(LeftHip.C1, CFrame.new(), 1)
				-- v72927.C0 = ClerpHSC(v794.C0, CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)), 1)
			end
		elseif ModeCodeName == "Fave" then
			NameMode.Text = "HSC MXA - Fave"

			AUDIOBASEDCOLOR = RAINBOWCOLOR

			if ATTACK == false then
				RootJoint.C0 = ClerpHSC(RootJoint.C0, CFrame.new() * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * CFrame.new(0, 0, 0), 1)
				Neck.C0 = ClerpHSC(Neck.C0, CFrame.new(0, 1, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * CFrame.new(), 1)
				RightShoulder.C0 = ClerpHSC(RightShoulder.C0, CFrame.new(1.5, 0.5, 0) * CFrame.new(-0.5, 0, 0) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)), 1)
				LeftShoulder.C0 = ClerpHSC(LeftShoulder.C0, CFrame.new(-1.3, 0.7, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(-135)) * CFrame.new(0.5, 0, 0) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0)), 1)
				RightHip.C0 = ClerpHSC(RightHip.C0, CFrame.new(0.5, -2, 0), 1)
				LeftHip.C0 = ClerpHSC(LeftHip.C0, CFrame.new(-0.9, -1.9, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(-25)), 1)
				RightHip.C1 = ClerpHSC(RightHip.C1, CFrame.new(), 1)
				LeftHip.C1 = ClerpHSC(LeftHip.C1, CFrame.new(), 1)
				-- v72927.C0 = ClerpHSC(v794.C0, CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)), 1)
			end
		elseif ModeCodeName == "MemeLol" then
			NameMode.Text = "HSC MXA - ???"

			AUDIOBASEDCOLOR = RAINBOWCOLOR

			if not sick:FindFirstChildOfClass("DistortionSoundEffect") then
				local SoundEffect = Instance.new("DistortionSoundEffect")
				SoundEffect.Priority = 2147483647

				SoundEffect.Level = 0.99
				SoundEffect.Name = randomstring_1()
				SoundEffect.Parent = sick

				coroutine.resume(coroutine.create(function()
					repeat
						Swait()
					until ModeCodeName ~= "NulledXD"

					SoundEffect:Destroy()
				end))
			end

			if ATTACK == false then
				RootJoint.C0 = ClerpHSC(RootJoint.C0, CFrame.new() * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * CFrame.new(math.random(-1, 1) / 2, math.random(-1, 1) / 2, math.random(-1, 1) / 2) * CFrame.Angles(math.rad(math.random(-45, 45)), math.rad(math.random(-45, 45)), 0), 1)
				Neck.C0 = ClerpHSC(Neck.C0, CFrame.new(0, 1, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)), 1)
				RightShoulder.C0 = ClerpHSC(RightShoulder.C0, CFrame.new(2, 0, 0) * CFrame.new(-0.5, 0, 0) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)) * CFrame.Angles(math.rad(-90), 0, 0), 1)
				LeftShoulder.C0 = ClerpHSC(LeftShoulder.C0, CFrame.new(-2, 0, 0) * CFrame.new(0.5, 0, 0) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0)) * CFrame.Angles(math.rad(-90), 0, 0), 1)
				RightHip.C0 = ClerpHSC(RightHip.C0, CFrame.new(0.5, -2, 0), 1)
				LeftHip.C0 = ClerpHSC(LeftHip.C0, CFrame.new(-0.5, -2, 0), 1)
				RightHip.C1 = ClerpHSC(RightHip.C1, CFrame.new(), 1)
				LeftHip.C1 = ClerpHSC(LeftHip.C1, CFrame.new(), 1)
				RightShoulder.C1 = ClerpHSC(RightShoulder.C1, CFrame.new(-0.5, 0.5, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0), 1)
				LeftShoulder.C1 = ClerpHSC(LeftShoulder.C1, CFrame.new(0.5, 0.499975681, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0), 1)
				-- v59318.C0 = ClerpHSC(v794.C0, CFrame.new(0, -1, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)), 1)
			end
		elseif ModeCodeName == "Heck ya" then
			NameMode.Text = "Hyperskidded Cannon FE"

			AUDIOBASEDCOLOR = Color3.new(sick.PlaybackLoudness / 750, 0, 0)

			if TORSOVELOCITY < 1 and ATTACK == false then
				ANIM = "Idle"
				DOUBLED = false
				READYTODOUBLE = false

				Neck.C0 = ClerpHSC(Neck.C0, CFrame.new(0, 1, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-15 - sick.PlaybackLoudness / 7.5), math.rad(0), math.rad(0)), 0.16666666666667)
				RightShoulder.C0 = ClerpHSC(RightShoulder.C0, CFrame.new(1.5, 0.5, 0) * CFrame.Angles(math.rad(40 + sick.PlaybackLoudness / 7.5), math.rad(0), math.rad(10)) * CFrame.new(-0.5, 0, 0) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)), 0.16666666666667)
				RootJoint.C0 = ClerpHSC(RootJoint.C0, CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * CFrame.new(0, 0, 0 + sick.PlaybackLoudness / 1000) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), 0.16666666666667)
				LeftShoulder.C0 = ClerpHSC(LeftShoulder.C0, CFrame.new(-1.4, 0.5, 0) * CFrame.Angles(math.rad(40 + sick.PlaybackLoudness / 7.5), math.rad(0), math.rad(-10)) * CFrame.new(0.5, 0, 0) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0)), 0.16666666666667)
				RightHip.C0 = ClerpHSC(RightHip.C0, CFrame.new(1, -1 - sick.PlaybackLoudness / 1000, -0.01) * CFrame.Angles(math.rad(0), math.rad(80), math.rad(0)) * CFrame.Angles(math.rad(-4), math.rad(0), math.rad(0)), 0.16666666666667)
				LeftHip.C0 = ClerpHSC(LeftHip.C0, CFrame.new(-1, -1 - sick.PlaybackLoudness / 1000, -0.01) * CFrame.Angles(math.rad(0), math.rad(-80), math.rad(0)) * CFrame.Angles(math.rad(-4), math.rad(0), math.rad(0)), 0.16666666666667)
				-- v71769.C0 = ClerpHSC(v794.C0, CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)), 0.5)
			elseif TORSOVELOCITY > 1 and ATTACK == false then
				ANIM = "Walk"
				DOUBLED = false
				READYTODOUBLE = false

				RootJoint.C0 = ClerpHSC(RootJoint.C0, CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * CFrame.new(0 + 0.25 * math.cos(SINE / 63) + 0.92 * math.sin(SINE / 95), 0, 1 + 1 * math.sin(SINE / 53)) * CFrame.Angles(math.rad(70), math.rad(0 - RootPart.RotVelocity.y), math.rad(0 - RootPart.RotVelocity.Y * 4.5 + 3 * math.cos(SINE / 47))), 0.05)
				Neck.C0 = ClerpHSC(Neck.C0, CFrame.new(0, 1, 0) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(180)) * CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(15 - 2.5 * math.sin(SINE / 12)), math.rad(0), math.rad(0)), 0.05)
				RightShoulder.C0 = ClerpHSC(RightShoulder.C0, CFrame.new(1.5, 0.5, 0) * CFrame.Angles(math.rad(180 + sick.PlaybackLoudness / 7.5), math.rad(0), math.rad(10)) * CFrame.new(-0.5, 0, 0) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0)), 0.16666666666667)
				LeftShoulder.C0 = ClerpHSC(LeftShoulder.C0, CFrame.new(-1.4, 0.5, 0) * CFrame.Angles(math.rad(180 + sick.PlaybackLoudness / 7.5), math.rad(0), math.rad(-10)) * CFrame.new(0.5, 0, 0) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0)), 0.16666666666667)
				RightHip.C0 = ClerpHSC(RightHip.C0, CFrame.new(1, -0.5 - 0.02 * math.sin(SINE / 12), -0.5) * CFrame.Angles(math.rad(-10 - 2.5 * math.sin(SINE / 21)), math.rad(90), math.rad(0)) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), 0.05)
				LeftHip.C0 = ClerpHSC(LeftHip.C0, CFrame.new(-1, -1 - 0.02 * math.sin(SINE / 12), -0.01) * CFrame.Angles(math.rad(-20 - 2.5 * math.sin(SINE / 51)), math.rad(-90), math.rad(0)) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), 0.05)
				-- v71769.C0 = Clerp.HSC(v794.C0, CFrame.new(0.05, -1, -0.15) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(0)), 0.5)
			end
		end
		val = MRANDOM(200,255)
		Humanoid.CameraOffset = VT(0,0,0)
		Humanoid.DisplayDistanceType = "None"
		unanchor()
		if Rooted == false then
			Disable_Jump = false
			Humanoid.WalkSpeed = Speed
		elseif Rooted == true then
			Disable_Jump = true
			Humanoid.WalkSpeed = 0
		end
	end)
end
