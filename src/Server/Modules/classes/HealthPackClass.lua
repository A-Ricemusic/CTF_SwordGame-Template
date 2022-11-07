-- Health Pack Class
-- Username
-- November 7, 2022



local HealthPackClass = {}

function HealthPackClass.new(part,healAmount,Cooldown)

local self = part
	self.Anchored = true
	self.CanCollide = false
	self.Transparency = 0
	self.CanTouch = true
	self.Touched:Connect(function(touched)
		local humanoid = touched.Parent:FindFirstChild("Humanoid")
		if humanoid then
			humanoid.Health = humanoid.Health + healAmount
			self.Transparency = 1
			self.CanTouch = false
		end
		task.wait(Cooldown)
		self.Transparency = 1
		self.CanTouch = false
	end)
return self

end


return HealthPackClass