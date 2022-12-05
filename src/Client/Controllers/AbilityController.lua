-- Ability Controller
-- Username
-- November 2, 2022



local AbilityController = {}
local UserInputService = game:GetService("UserInputService")
function AbilityController:Start()
    local AbilityService = self.Services.AbilityService
    function AbilityController.Ability(WeaponConfig)
        if WeaponConfig.AbilityName == 'Projectile' then
            local Player = game.Players.LocalPlayer
            local Character = Player.Character
            local Humanoid = Character:FindFirstChild("Humanoid")
           local  OriginalWalk = Humanoid.WalkSpeed
            Humanoid.WalkSpeed = 2
            local Mouse = game.Players.LocalPlayer:GetMouse()
            local MouseDirectionVector = Mouse.UnitRay.Direction
            if not UserInputService.GamepadEnabled and not UserInputService.KeyboardEnabled and not UserInputService.VREnabled then
               MouseDirectionVector = Character.PrimaryPart.CFrame.LookVector
            end
            AbilityService:Projectile(WeaponConfig,MouseDirectionVector)
            task.wait(0.1)
            Humanoid.WalkSpeed = OriginalWalk
        end

        if WeaponConfig.AbilityName == 'FastRun' then
            AbilityService:FastRun(WeaponConfig)
        end

        if WeaponConfig.AbilityName == 'Heal' then
            AbilityService:Heal(WeaponConfig)
        end

        if WeaponConfig.AbilityName == 'ForceField' then
            AbilityService:ForceField(WeaponConfig)
        end
	end
end


return AbilityController