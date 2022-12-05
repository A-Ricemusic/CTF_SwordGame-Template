local UserInputService = game:GetService("UserInputService")
-- Sword Controller
-- Username
-- October 4, 2022



local WeaponController = {}

function WeaponController:OnSetUp(WeaponTag)
    
    local Player = game.Players.LocalPlayer
    local Character = Player.Character
    local RightHand = Character:WaitForChild("RightHand")
    local Weapon = RightHand:WaitForChild(WeaponTag)
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
       end
    end


local function slash(comboN)
    local HumanoidRootPart = Character.HumanoidRootPart
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

local function StyleButtons()
    if UserInputService.GamepadEnabled or UserInputService.KeyboardEnabled or UserInputService.VREnabled then return end
    local abilityButton = ContextActionService:GetButton("Ability")
    abilityButton.Position = UDim2.new(0.4,0,-0.5,0)    
    abilityButton.ImageColor3 = Color3.new(0,0,1)
    local slashButton = ContextActionService:GetButton("Slash")
    slashButton.Position = UDim2.new(0.4,0,0,0)    
    slashButton.ImageColor3 = Color3.new(0,1,0)   
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
    ContextActionService:BindAction("Slash",WeaponActivated,true,Enum.UserInputType.MouseButton1,Enum.KeyCode.ButtonR2,Enum.KeyCode.LeftMeta)
    ContextActionService:BindAction("Ability",Ability,true,Enum.KeyCode.E,Enum.KeyCode.ButtonY)
   StyleButtons()
    Humanoid.WalkSpeed = Walk 
    Humanoid.JumpHeight = Jump 
    Weapon.Mesh.Transparency = 0
    end
    end
end
    ContextActionService:BindAction("Slash",WeaponActivated,true,Enum.UserInputType.MouseButton1,Enum.KeyCode.ButtonR2,Enum.KeyCode.LeftMeta)
    ContextActionService:BindAction("Ability",Ability,true,Enum.KeyCode.E,Enum.KeyCode.ButtonY)
    StyleButtons()
    ContextActionService:BindAction("toggle-equip",EquippedHandler,true,Enum.KeyCode.Q,Enum.KeyCode.ButtonX)      
    local toggleEquipButton = ContextActionService:GetButton("toggle-equip")
    if not UserInputService.GamepadEnabled and not UserInputService.KeyboardEnabled and not UserInputService.VREnabled then
    toggleEquipButton.Position = UDim2.fromScale(0.7,-0.5)
    toggleEquipButton.ImageColor3 = Color3.fromRGB(255, 174, 0) 
    end
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
		self.Services.WeaponsService:SwordSetUp(SwordStat.Value)
		connection:Disconnect()
	end)
end)



function WeaponController:UnbindAction()
    ContextActionService:UnbindAction("Slash")
    ContextActionService:UnbindAction("Ability")
    Humanoid.WalkSpeed = game.StarterPlayer.CharacterWalkSpeed
    Humanoid.JumpHeight = game.StarterPlayer.CharacterJumpHeight

end



end
    

return WeaponController