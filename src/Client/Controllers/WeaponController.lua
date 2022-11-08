-- Weapons Controller
-- Username
-- November 2, 2022







local WeaponController = {}

function WeaponController:OnCharacterAdded()
    local Player = game.Players.LocalPlayer
    local Character = Player.Character
local RightHand = Character:WaitForChild("RightHand")
RightHand.ChildAdded:Connect(function(Weapon)
    local IsTagged = game:GetService('CollectionService'):HasTag(Weapon, "GameItem")
    if not IsTagged then return end
    local WeaponTag = Weapon.Name
    local PathConfig = self.Shared.Config.PathConfigModule
    local WeaponConfig = require(PathConfig[WeaponTag]) 
    local Combo = 1
    local Anim = Instance.new('Animation')
    Anim.Parent = script
    local Walk = WeaponConfig.WalkSpeed 
    local Jump = WeaponConfig.JumpHeight 
    local Tween = game:GetService("TweenService")
    local SwingAnimations = WeaponConfig.SwingAnimations
    local ProjectileAnimation = WeaponConfig.ProjectileAnimation
    local Textures = WeaponConfig.Textures
    local ContextActionService = game:GetService('ContextActionService')
    local LastAbility = 0      
    local LastSwing = 0
    local Humanoid = Player.Character:FindFirstChildOfClass("Humanoid")  
    Humanoid.WalkSpeed = Walk
    Humanoid.JumpHeight = Jump
    
local function Ability(ActionName,input)
        if ActionName == "Ability" and input == Enum.UserInputState.Begin and tick() - LastAbility >= WeaponConfig.AbilityCooldown then      
            LastAbility = tick()
            Anim.AnimationId = ProjectileAnimation
            Humanoid.Animator:LoadAnimation(Anim):Play() 
            self.Controllers.AbilityController.Ability(WeaponConfig)
            Humanoid.WalkSpeed = WeaponConfig.WalkSpeed
       end
    end

local function SlashEffect(EffectSlash,HumanoidRootPart)
            if WeaponConfig.SlashEffect ~= nil then
                WeaponConfig.SlashEffect(Character)
            else
        task.wait(0.2)
                EffectSlash:Destroy()
            end
end

local function slash(comboN)
    local EffectSlash = Instance.new("ParticleEmitter",Weapon)
    local HumanoidRootPart = Character.HumanoidRootPart
    SlashEffect(EffectSlash,HumanoidRootPart)
    local Count = 1
    local connection
    connection = game["Run Service"].RenderStepped:Connect(function()
        Count = Count + 1
        if Count > #Textures then
            Count = 1
            connection:Disconnect()
        end
    end)

    if Character == Character then
        self.Services.WeaponsService:HitBox(WeaponTag,WeaponConfig.HitBoxSize)
        local BodyVelocity = Instance.new("BodyVelocity")
        BodyVelocity.Parent = Character.PrimaryPart
        BodyVelocity.MaxForce = Vector3.new(99999,0,99999)
        BodyVelocity.Name = "BodyVelocity"
        BodyVelocity.P = 10
        game.Debris:AddItem(BodyVelocity,.2)
        if comboN == 5 then
            BodyVelocity.Velocity = Character.PrimaryPart.CFrame.LookVector * 50
        else
            BodyVelocity.Velocity = Character.PrimaryPart.CFrame.LookVector * 20
        end
    end
end

local function WeaponActivated(actionName,input)
    if (actionName == "Slash") and tick() - LastSwing >= WeaponConfig.Cooldown and input == Enum.UserInputState.Begin then   
        if tick() - LastSwing > WeaponConfig.ComboResetTimer then
                Combo = 1
            end
            LastSwing = tick()
            Humanoid.WalkSpeed = 0
            Humanoid.JumpHeight = 0
            Anim.AnimationId = SwingAnimations[Combo]
            Humanoid.Animator:LoadAnimation(Anim):Play()
            local sound = Instance.new("Sound")
            sound.Parent = Humanoid
            sound.SoundId = 'rbxassetid://9119749145'
            sound:Play()
            sound:Destroy()
            slash(Combo)
            if Combo >= #WeaponConfig.SwingAnimations then
                Combo = 1
            else
                Combo = Combo + 1
            end
            Humanoid.WalkSpeed = Walk --game Walk spped
            Humanoid.JumpHeight = Jump --game Jump
        end
end

local IsEquipped = true
local lastEquippedChange = 0
local function EquippedHandler(actionName,input)
    if actionName == "toggle-equip" and input == Enum.UserInputState.Begin and tick() - lastEquippedChange >= 0.5 then      
   lastEquippedChange = tick()
   if IsEquipped then
    IsEquipped = false
    ContextActionService:UnbindAction("Slash")
    ContextActionService:UnbindAction("Ability")
    Humanoid.WalkSpeed = game.StarterPlayer.CharacterWalkSpeed
    Humanoid.JumpHeight = game.StarterPlayer.CharacterJumpHeight
    Weapon.Mesh.Transparency = 1
   else
    IsEquipped = true
    ContextActionService:BindAction("Slash",WeaponActivated,false,Enum.UserInputType.MouseButton1,Enum.KeyCode.ButtonR2,Enum.UserInputType.Touch)
    ContextActionService:BindAction("Ability",Ability,true,Enum.KeyCode.E,Enum.KeyCode.ButtonY)
    Humanoid.WalkSpeed = Walk 
    Humanoid.JumpHeight = Jump 
    Weapon.Mesh.Transparency = 0
    end
    end
end
    ContextActionService:BindAction("Slash",WeaponActivated,false,Enum.UserInputType.MouseButton1,Enum.KeyCode.ButtonR2,Enum.UserInputType.Touch)
    ContextActionService:BindAction("Ability",Ability,true,Enum.KeyCode.E,Enum.KeyCode.ButtonY)
    ContextActionService:BindAction("toggle-equip",EquippedHandler,true,Enum.KeyCode.Q,Enum.KeyCode.ButtonX)      
    
Humanoid.Died:Connect(function()
    ContextActionService:UnbindAction("Slash")
    ContextActionService:UnbindAction("Ability")
    local leaderstats = Player:FindFirstChild("leaderstats")
	if not leaderstats then return end
	local SwordStat = leaderstats:FindFirstChild("Sword")
	if not SwordStat then return end
	local RankStat = SwordStat:FindFirstChild("Rank")
	if not RankStat then return end
	local connection
	connection = Player.CharacterAdded:Connect(function(Character)
		self.Services.WeaponsService:SwordSetUp(SwordStat.Value,RankStat.Value)
		connection:Disconnect()
	end)
end)
end)
end

function WeaponController:UnbindAction()
    local ContextActionService = game:GetService("ContextActionService")
    local character = game.Players.LocalPlayer.Character
    local Humanoid = character:FindFirstChild("Humanoid")
    ContextActionService:UnbindAction("Slash")
    ContextActionService:UnbindAction("Ability")
    Humanoid.WalkSpeed = game.StarterPlayer.CharacterWalkSpeed
    Humanoid.JumpHeight = game.StarterPlayer.CharacterJumpHeight
end



return WeaponController