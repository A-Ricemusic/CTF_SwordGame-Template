local ContextActionService = game:GetService("ContextActionService")
-- Context Action Service Controller
-- Username
-- September 28, 2022

local DoubleJumpAnimation = 'rbxassetid://11696628767'
local BackflipAnimation = "rbxassetid://11162593580"
local LastBackFlip = 0
local LastDoubleJump = 0 
local BackFlipCoolDown = 1
local canDoubleJump = false
local hasDoubleJumped = false
local TIME_BETWEEN_JUMPS = 0.2
local DOUBLE_JUMP_POWER_MULTIPLIER = 1.3
local ContextActionServiceController = {}

function ContextActionServiceController:OnCharacterAdded()
local Service = self.Services.CharacterManagerService
local ContextActionService = game:GetService("ContextActionService")
local UserInputService = game:GetService("UserInputService")
local player = game:GetService("Players").LocalPlayer
local StartWalkSpeed = game.StarterPlayer.CharacterWalkSpeed
local StartJumpHeight = game.StarterPlayer.CharacterJumpHeight
local StartJumpPower = game.StarterPlayer.CharacterJumpPower
local Anim = Instance.new("Animation")
Anim.Parent = script  
local Character = player.Character


   
local Humanoid = Character:WaitForChild("Humanoid",10)
local RightHand = Character:WaitForChild("RightHand",10)
Humanoid.WalkSpeed = StartWalkSpeed
Humanoid.JumpHeight = StartJumpHeight
Humanoid.JumpPower = StartJumpPower
local oldPower = Humanoid.JumpPower
  
function ContextActionServiceController.BackFlipAction()
    local function backflip(ActionName,input)
        if tick() - LastBackFlip >= BackFlipCoolDown and ActionName == "backflip" and input == Enum.UserInputState.Begin then
            local Weapons = RightHand:GetChildren()
	for _,Child in pairs(Weapons) do
	    local IsTagged = game:GetService('CollectionService'):HasTag(Child, "GameItem")
            if IsTagged then 
                if Child.Mesh.Transparency == 0 then 
                    local WeaponTag = Child.Name
                    local PathConfig = self.Shared.Config.PathConfigModule
                    local WeaponConfig = require(PathConfig[WeaponTag]) 
                    StartWalkSpeed = WeaponConfig.WalkSpeed 
                    StartJumpHeight = WeaponConfig.JumpHeight
                else
                    StartWalkSpeed = game.StarterPlayer.CharacterWalkSpeed
                    StartJumpHeight = game.StarterPlayer.CharacterJumpHeight
                end
            else
                StartWalkSpeed = game.StarterPlayer.CharacterWalkSpeed
                StartJumpHeight = game.StarterPlayer.CharacterJumpHeight
            end
	end 
        LastBackFlip = tick()
        Anim.AnimationId = BackflipAnimation
        Humanoid.Animator:LoadAnimation(Anim):Play() 
        Service:Backflip(StartWalkSpeed,StartJumpHeight)
      
       end
    end
    ContextActionService:BindAction("backflip",backflip,true,Enum.KeyCode.LeftControl,Enum.KeyCode.ButtonB)
    local backflipButton = ContextActionService:GetButton("backflip")
    if not UserInputService.GamepadEnabled and not UserInputService.KeyboardEnabled and not UserInputService.VREnabled then
    backflipButton.Position = UDim2.fromScale(0.7,0)  
    backflipButton.ImageColor3 = Color3.new(1,0,0)   
    end 
end  
ContextActionServiceController.BackFlipAction()

--Double jump
local function onJumpRequest()
	if not Character or not Humanoid or not Character:IsDescendantOf(workspace) or
	 Humanoid:GetState() == Enum.HumanoidStateType.Dead then
		return
	end
	
	if canDoubleJump and not hasDoubleJumped then
		hasDoubleJumped = true
		Humanoid.JumpPower = oldPower * DOUBLE_JUMP_POWER_MULTIPLIER
		Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end
	
	Humanoid.StateChanged:connect(function(old, new)
		if new == Enum.HumanoidStateType.Landed then
			canDoubleJump = false
			hasDoubleJumped = false
			Humanoid.JumpPower = oldPower
		elseif new == Enum.HumanoidStateType.Freefall then
			wait(TIME_BETWEEN_JUMPS)
			canDoubleJump = true
		end
	end)
 
UserInputService.JumpRequest:Connect(onJumpRequest)
   
  --configure swimming 
Humanoid.StateChanged:Connect(function()
    local swimConnect
    swimConnect = UserInputService.InputBegan:Connect(function(input)
        if Humanoid:GetState() == Enum.HumanoidStateType.Swimming then 
            if input.KeyCode == Enum.KeyCode.Space or input.KeyCode == Enum.KeyCode.ButtonA or input.KeyCode == Enum.Button.Jump  then
                Service:Swim()
            end
        else
            swimConnect:Disconnect()
        end
    end)
end)


Humanoid.Died:Connect(function()
        ContextActionService:UnbindAction('backflip')
end)



player.CharacterRemoving:Connect(function()
ContextActionService:UnbindAction('backflip')
end)

end




return ContextActionServiceController