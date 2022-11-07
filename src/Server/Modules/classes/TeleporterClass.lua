-- Teleporter Class
-- Username
-- October 29, 2022



local TeleporterClass = {}
function TeleporterClass.new(Teleporter)
	local Cooldown = 3
	local Inetract = Teleporter:FindFirstChild("Interact")
	Inetract.Anchored = true
	Inetract.CanCollide = false
	local Destination = Teleporter:FindFirstChild("Destination")
	local PlaceDescription = Teleporter:FindFirstChild("Place")
	Destination.Anchored = true
	Destination.CanCollide = false
	Destination.Transparency = 1
	local PropimityPrompt = Inetract:FindFirstChild("ProximityPrompt")
	PropimityPrompt.ActionText = "Teleport back to "..PlaceDescription.Value
	PropimityPrompt.GamepadKeyCode = Enum.KeyCode.DPadUp
	PropimityPrompt.KeyboardKeyCode = Enum.KeyCode.C
	PropimityPrompt.HoldDuration = 1
	local lastTriggered = 0
	PropimityPrompt.Enabled = true
		PropimityPrompt.Triggered:Connect(function(player)
			if tick() - lastTriggered < Cooldown then return end
				lastTriggered = tick()
				PropimityPrompt.Enabled = false
				local character = player.Character
				local primaryPart = character.PrimaryPart
				primaryPart.Position = Destination.Position
				task.wait(Cooldown)
				PropimityPrompt.Enabled = true
		end)
end


return TeleporterClass