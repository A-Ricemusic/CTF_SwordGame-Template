-- Fade Class
-- Username
-- November 1, 2022



local FadeblockClass = {}


function FadeblockClass.new(part,fadeSpeed,cooldown,reset)
	local self = part
	self.Anchored = true
	self.CanCollide = true
	self.Transparency = 0
	local lastTouched = 0
	self.Touched:Connect(function(touched)
		if tick() - lastTouched < cooldown then return end
		lastTouched = tick()
		local humanoid = touched.Parent:FindFirstChild("Humanoid")
		if not humanoid then return end
			for c = 1,10 do
				self.Transparency = c/10
				task.wait(fadeSpeed)
			end
		self.CanCollide = false
		task.wait(reset)
		self.CanCollide = true
		self.Transparency = 0
	end)
	return self

end


return FadeblockClass