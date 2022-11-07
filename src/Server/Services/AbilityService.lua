-- Ability Service
-- Username
-- October 25, 2022




local AbilityService = {Client = {}}
local Debris = game:GetService("Debris")


function AbilityService.Client:FastRun(Player, WeaponConfig)
  
    local Character = Player.Character
    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    local Aura = game:GetService("ReplicatedStorage").Effects.FastRun.FastRunAttachment:Clone()
    Aura.Parent = Character.PrimaryPart
    Humanoid.WalkSpeed = WeaponConfig.AbilityRunSpeed
    task.wait(WeaponConfig.AbilityDebrisTimer)
    Humanoid.WalkSpeed = WeaponConfig.WalkSpeed
    Debris:AddItem(Aura,WeaponConfig.AbilityDebrisTimer)
end

function AbilityService.Client:ForceField(Player, WeaponConfig)

    local Character = Player.Character
    local Aura = game:GetService("ReplicatedStorage").Effects.ForceField.ForceFieldAttachment:Clone()
   local ForceField = Instance.new("ForceField")
   ForceField.Parent = Character.PrimaryPart
    Aura.Parent = Character.PrimaryPart
  ForceField.Visible = true
    Debris:AddItem(ForceField,(WeaponConfig.AbilityDebrisTimer)) 
    Debris:AddItem(Aura, (WeaponConfig.AbilityDebrisTimer)) 
end


function AbilityService.Client:Heal(Player, WeaponConfig,Rank)
    local Character = Player.Character
    local Humanoid = Character:FindFirstChild("Humanoid")
    local Aura = game:GetService("ReplicatedStorage").Effects.Heal.HealAttachment:Clone()
    Aura.Parent = Character.PrimaryPart
    for count = 1, WeaponConfig.HealAmount do
        Humanoid.Health = Humanoid.Health 
        task.wait(0.5)
    end
    Aura:Destroy()
end




function AbilityService.Client:Projectile(Player, WeaponConfig,MouseDirectionVector)
    local Character = Player.Character
	local ProjectileOriginal = game:GetService("ReplicatedStorage").Ability:FindFirstChild(WeaponConfig.ProjectileName)
    local Projectile = ProjectileOriginal:Clone()
    Projectile.Name = WeaponConfig.TagName
    game:GetService('CollectionService'):AddTag(Projectile,"Weapon")
    local ObjectValue = Instance.new('ObjectValue')
    ObjectValue.Parent = Projectile
    ObjectValue.Name = "Creator"
    ObjectValue.Value = Player
	Projectile.Position = Character.PrimaryPart.Position + (Character.PrimaryPart.CFrame.LookVector * 2.8)
	Projectile.Anchored = false
	Projectile.CanCollide = false
	Projectile.Parent = workspace
    local ProjectileDirection = MouseDirectionVector
	local Attachment = Instance.new("Attachment")
	Attachment.Parent = Projectile
	local ProjectileForce = Instance.new("LinearVelocity")
	ProjectileForce.Parent = Projectile
	ProjectileForce.Attachment0 = Attachment
	ProjectileForce.Enabled = true
	ProjectileForce.MaxForce = math.huge
	ProjectileForce.LineDirection =ProjectileDirection  *  Vector3.new(WeaponConfig.AbilityForce,0,WeaponConfig.AbilityForce) 
	ProjectileForce.VectorVelocity = ProjectileDirection * Vector3.new(WeaponConfig.AbilityForce,0,WeaponConfig.AbilityForce)
	ProjectileForce.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
    Projectile.Touched:Connect(function(Touched)
        if Touched:FindFirstAncestorOfClass('Model') == Player.Character then return else 
            task.wait(0.3)
        Projectile:Destroy()
        end
    end)
    Debris:AddItem(Projectile,WeaponConfig.AbilityDebrisTimer)
end






return AbilityService