-- Teleporter Class
-- Username
-- October 29, 2022



local TeleporterGlobalClass = {}
function TeleporterGlobalClass.new(Teleporter)
	local TeleoprtService = game:GetService("TeleportService")
	local Cooldown = 10
	Teleporter.Anchored = true
	Teleporter.CanCollide = false
	local PlaceDescription = Teleporter:FindFirstChild("Place")
	local PlaceId = Teleporter:FindFirstChild("PlaceId")
	local PropimityPrompt = Teleporter:FindFirstChild("ProximityPrompt")
	PropimityPrompt.ActionText = "Teleport to "..PlaceDescription.Value
	PropimityPrompt.GamepadKeyCode = Enum.KeyCode.DPadUp
	PropimityPrompt.KeyboardKeyCode = Enum.KeyCode.C
	PropimityPrompt.HoldDuration = 1
	local lastTriggered = 0
	PropimityPrompt.Enabled = true
		PropimityPrompt.Triggered:Connect(function(player)
			if tick() - lastTriggered < Cooldown then return end
				lastTriggered = tick()
				PropimityPrompt.Enabled = false
				TeleoprtService:Teleport(PlaceId.Value,player)
				task.wait(Cooldown)
				PropimityPrompt.Enabled = true
		end)			
end


return TeleporterGlobalClass