-- Weapons Service
-- Username
-- October 25, 2022




CollectionService = game:GetService("CollectionService")

local WeaponsService = {Client = {}}
			--make DI

			function WeaponsService:LoadEvents()
				local EventService = self.Services.core.EventService
				return EventService
			end

			local partsWithId = {}
			local awaitRef = {}

			local root = {
				ID = 0;
				Type = "BillboardGui";
				Properties = {
					ExtentsOffsetWorldSpace = Vector3.new(0,1.25,0);
					MaxDistance = 50;
					AlwaysOnTop = true;
					Size = UDim2.new(0,200,0,50);
				};
				Children = {
					{
						ID = 1;
						Type = "TextLabel";
						Properties = {
							FontSize = Enum.FontSize.Size18;
							TextColor3 = Color3.new(1,1,1);
							Text = "0 damage";
							TextStrokeTransparency = 0.5;
							Font = Enum.Font.Cartoon;
							BackgroundTransparency = 1;
							BackgroundColor3 = Color3.new(0,0,0);
							TextSize = 15;
							Size = UDim2.new(0,200,0,18);
						};
						Children = {};
					};
				};
			};

			local function Scan(item, parent)
				local obj = Instance.new(item.Type)
				if (item.ID) then
					local awaiting = awaitRef[item.ID]
					if (awaiting) then
						awaiting[1][awaiting[2]] = obj
						awaitRef[item.ID] = nil
					else
						partsWithId[item.ID] = obj
					end
				end
				for p,v in pairs(item.Properties) do
					if (type(v) == "string") then
						local id = tonumber(v:match("^_R:(%w+)_$"))
						if (id) then
							if (partsWithId[id]) then
								v = partsWithId[id]
							else
								awaitRef[id] = {obj, p}
								v = nil
							end
						end
					end
					obj[p] = v
				end
				for _,c in pairs(item.Children) do
					Scan(c, obj)
				end
				obj.Parent = parent
				return obj
			end


			function CreateTag(Player,Enemy)
				if Enemy ~= nil then
					if (Enemy:FindFirstChild("Player_Tag")) then return end
					local tag = Instance.new("ObjectValue")
					tag.Parent = Enemy
					tag.Name = "Player_Tag"
					tag.Value = Player
				end
			end


			function DestroyTag(Enemy)
				if Enemy ~= nil then
					local tag = Enemy:FindFirstChild("Player_Tag")
					if tag ~= nil then tag:Destroy() end
				end
			end

			local function FindGameItem(RightHand)

				local Children = RightHand:GetChildren()
				local GameItem = nil
					for _, Child in pairs(Children) do
						if CollectionService:HasTag(Child,"GameItem") then
							GameItem = Child
							return GameItem
						end
					end
				
			end

			local function CreateObject(hit,Damage)
				local ObjModel = Instance.new("Model",workspace:FindFirstChild("DebrisHolder") or workspace)
				local Obj = Instance.new("Part")
				Obj.Parent = ObjModel
				-- Appearance
				Obj.BrickColor = BrickColor.new("Bright red")
				Obj.Material = Enum.Material.Neon
				Obj.Transparency = 1
				-- Data
				local HitModel = hit:FindFirstAncestorOfClass("Model")
				if not HitModel then return end
				Obj.Position = HitModel.PrimaryPart.Position + Vector3.new(math.random(-1.6,1.6),5,math.random(-1.6,1.6))
				-- Behavior
				Obj.Anchored = true
				Obj.CanCollide = false
				Obj.Locked = true
				-- Part
				Obj.Shape = Enum.PartType.Ball
				Obj.Size = Vector3.new(0.75,0.75,0.75)
				-- Billboard Gui
				local Gui = script.BillboardGui:Clone()
				Gui.Adornee = ObjModel:FindFirstChild("Part")
				Gui.TextLabel.Text = Damage
				Gui.Parent = ObjModel
				
				local ObjPos = Instance.new("BodyPosition")
				ObjPos.Parent = Obj
				ObjPos.Position = Vector3.new(0,7.85,0)
				for i = 1,0,-0.1 do
					Obj.Transparency = i
					Gui.TextLabel.TextTransparency = i
					Gui.TextLabel.TextStrokeTransparency = i
					task.wait()
				end
				task.wait(0.50)
				for i = 0,1,0.1 do
					Obj.Transparency = i
					Gui.TextLabel.TextTransparency = i
					Gui.TextLabel.TextStrokeTransparency = i
					task.wait()
				end
				return ObjModel
			end

			function WeaponsService.Client:HitBox(Player,WeaponTag,HitBoxSize)
				local Hitbox = Instance.new("Part")
				Hitbox.Name = WeaponTag
				game:GetService("CollectionService"):AddTag(Hitbox,"Weapon")
				local ObjectValue = Instance.new('ObjectValue')
				ObjectValue.Name = "Creator"
				ObjectValue.Parent = Hitbox
				ObjectValue.Value = Player
				Hitbox.Size = HitBoxSize
				Hitbox.CFrame = Player.Character.PrimaryPart.CFrame * CFrame.new(0,0,-5)
				Hitbox.Anchored = true
				Hitbox.CanCollide = false
				Hitbox.CastShadow = false
				Hitbox.Transparency = .6
				Hitbox.Material = Enum.Material.ForceField
				Hitbox.CanQuery = false
				Hitbox.Parent = workspace
				game:GetService('Debris'):AddItem(Hitbox,0.2)
				Hitbox.Destroying:Connect(function()
					game:GetService("CollectionService"):RemoveTag(Hitbox,"Weapon")
				end)

			end

			function WeaponsService.Client:SwordSetUp(plr,WeaponTag)
				task.wait(0.5)
				local EventService = WeaponsService:LoadEvents() 
				if WeaponTag == "" then return end
				local char = plr.Character
				local RightHand = char:FindFirstChild("RightHand") 
				local WeaponEquipped = RightHand:GetChildren()
				for _,Child in pairs(WeaponEquipped) do
					if CollectionService:HasTag(Child,"GameItem") then
						CollectionService:RemoveTag(Child,"GameItem")
						Child:Destroy()
					end
				end
				local leaderstats = plr:FindFirstChild("leaderstats")
				if not leaderstats then return end
				local SwordStat = leaderstats:FindFirstChild("Sword")

				local Weapon = game:GetService("ReplicatedStorage").GameItems:FindFirstChild(WeaponTag)
				if not Weapon then return end
					local Handle = Weapon:Clone()
					Handle.Parent = RightHand
					local weld = Instance.new("ManualWeld")
					weld.Part0 = Handle
					weld.Part1 = RightHand
					weld.C0 = weld.Part1.CFrame:ToObjectSpace(weld.Part1.CFrame) - Vector3.new(0,-0.15,-0.3)
					weld.Parent = weld.Part0
					local h = char:WaitForChild("Humanoid")
					h.HealthDisplayType = "AlwaysOn"
					h.NameOcclusion = Enum.NameOcclusion.NoOcclusion
					CollectionService:AddTag(Handle,"GameItem")
					EventService:FireSwordSetUpClient(plr,WeaponTag)
						h.Died:Connect(function()
							Handle:Destroy()
							CollectionService:RemoveTag(Handle,"GameItem")
						end)
			end
			
			
			function WeaponsService:BuySword(SwordPawn)
				task.wait(0.1)
				local IsSwordPawn = CollectionService:HasTag(SwordPawn,'SwordPawn')
				if not IsSwordPawn then return end
				local P= nil
				local PathConfig = require(game:GetService("ReplicatedStorage").Aero.Shared.Config.PathConfigModule)
				local WeaponConfig = require(PathConfig[SwordPawn.Name])
				local ProximityPrompt = SwordPawn.ProximityPrompt
					ProximityPrompt.ActionText = "Buy "..WeaponConfig.DisplayName
					ProximityPrompt.ObjectText = WeaponConfig.Description
					ProximityPrompt.GamepadKeyCode = Enum.KeyCode.DPadUp
					ProximityPrompt.KeyboardKeyCode = Enum.KeyCode.C
					ProximityPrompt.HoldDuration = 1
					ProximityPrompt.Triggered:Connect(function(player)
						if not player then return end
						local Character = player.Character
						local PrimaryPart = Character:FindFirstChild("HumanoidRootPart")
						if PrimaryPart == nil then return end
						local RightHand = Character:FindFirstChild("RightHand")
						if not RightHand then return end
						local GameItem = FindGameItem(RightHand)
						if GameItem ~= nil then
								return CreateObject(PrimaryPart,"please sell your current sword")
						end
						CreateObject(PrimaryPart, "successful purchase")
						WeaponsService.Client:SwordSetUp(player,SwordPawn.Name)
	
					end)
			end


function WeaponsService:Start()
	Scan(root, script)
	local Maid = self.Shared.Maid
	local maid = Maid.new()
	local PathConfig = require(game:GetService("ReplicatedStorage").Aero.Shared.Config.PathConfigModule)
	local SwordPawns = CollectionService:GetTagged("SwordPawn")
	for _,Shop in pairs(SwordPawns) do
		WeaponsService:BuySword(Shop)
	end
	local LastDamage = 0
	maid.WorkspaceSignal = game.Workspace.DescendantAdded:Connect(function(descendant)
		WeaponsService:BuySword(descendant)
		local IsWeapon = CollectionService:HasTag(descendant,"Weapon")
		if not IsWeapon then return end
		local WeaponConfig = require(PathConfig[descendant.Name])
		local Player=  game:GetService('Players'):GetPlayerFromCharacter(descendant:FindFirstAncestorOfClass('Model'))
		local ObjectValue = descendant:FindFirstChildWhichIsA('ObjectValue')
		if ObjectValue and ObjectValue.Name == 'Creator'  then
			Player = ObjectValue.Value
		end
		if descendant:IsA('Part') then
			local Connection
			local Enemy = nil
			Connection = descendant.Touched:Connect(function(HitPart)
				if tick() - LastDamage <= 0.1 then return end
				local Model = HitPart:FindFirstAncestorOfClass("Model")
				if Model == nil then return end
				Enemy = Model:FindFirstChild(WeaponConfig.HumanoidToKill)
				if Enemy == nil then return end
				local Character = Player.Character
				local Humanoid = Character:FindFirstChild("Humanoid")
				local HumanoidRootPart = Character.PrimaryPart
				local HitPlayer = game.Players:GetPlayerFromCharacter(Model)
				if HitPlayer == Player then return end
				if HitPlayer.Team.TeamColor == Player.Team.TeamColor then return end
				LastDamage = tick() 
				local Damage = math.random(WeaponConfig.MinDamage, WeaponConfig.MaxDamage)
				if CollectionService:HasTag(descendant,'Ability') then
					Damage = WeaponConfig.AbilityDamage
				end
				Enemy:TakeDamage(Damage)
				--self.Services.Core.PlayerManagerService:PlayerHit(HitPlayer,Player)
				--Knockback
				if HumanoidRootPart:FindFirstChild("BodyVelocity") ~= nil then					
					local BodyVelocity = Instance.new("BodyVelocity")
					BodyVelocity.Parent = Model.PrimaryPart
					BodyVelocity.MaxForce = Vector3.new(99999,0,99999)
					BodyVelocity.Name = "BodyVelocity"
					BodyVelocity.Velocity = Player.Character.PrimaryPart.CFrame.LookVector * WeaponConfig.PlayerKnockbackVelocity
					game:GetService("Debris"):AddItem(BodyVelocity,0.2)
				end
				local ObjModel = CreateObject(HitPart,Damage)
				ObjModel:Destroy()
				DestroyTag(ObjModel)
				Connection:Disconnect()
			end)
		end
	end)

	function WeaponsService:CleanUp()
		maid:Destroy()
	end
end



function WeaponsService:Init()
	
end


return WeaponsService