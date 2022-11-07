-- Damageblock Class
-- Username
-- October 29, 2022



local DamageblockClass = {}

function DamageblockClass.new(part,humanoidToKill,Damage,Cooldown)
	local self = part
	self.Anchored = true
	local lastDamage = 0
		self.Touched:Connect(function(touchedPart)
			if tick() - lastDamage < Cooldown then return end
			lastDamage = tick()
			local humanoid = touchedPart.Parent:FindFirstChild(humanoidToKill)
			if humanoid then
				humanoid:TakeDamage(Damage)
			end
		end)
	return self
end


return DamageblockClass