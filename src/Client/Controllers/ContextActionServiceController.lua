-- Context Action Service Controller
-- Username
-- November 2, 2022

local ContextActionService = game:GetService("ContextActionService")
-- Context Action Service Controller
-- Username
-- September 28, 2022

local DoubleJumpAnimation = 'rbxassetid://10857202343'
local BackflipAnimation = "rbxassetid://11162593580"
local LastBackFlip = 0
local LastDoubleJump = 0 
local BackFlipCoolDown = 1
local DoubleJumpCoolDown = 0.8
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
task.wait(5)
print("CharacteraddedContextActionController")    
local Humanoid = Character:WaitForChild("Humanoid")
local RightHand = Character:WaitForChild("RightHand")
Humanoid.WalkSpeed = StartWalkSpeed
Humanoid.JumpHeight = StartJumpHeight
Humanoid.JumpPower = StartJumpPower
  
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
end  
function ContextActionServiceController.DoubleJumpAction()
    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.Space or input.KeyCode == Enum.KeyCode.ButtonA or input.KeyCode == Enum.Button.Jump then
            if tick() - LastDoubleJump <= DoubleJumpCoolDown then return end
            if Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
            LastDoubleJump = tick()
            Anim.AnimationId = DoubleJumpAnimation
            Humanoid.Animator:LoadAnimation(Anim):Play()
            Service:DoubleJump()
            end
        end
    end)
end
    ContextActionServiceController.BackFlipAction()
    ContextActionServiceController.DoubleJumpAction()
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



Humanoid.Died:Connect(function()
        ContextActionService:UnbindAction('backflip')
    end)
end)


player.CharacterRemoving:Connect(function()
ContextActionService:UnbindAction('backflip')
end)

end




return ContextActionServiceController