-- Display Controller
-- Username
-- November 1, 2022



local DisplayController = {}

local RunService = game:GetService('RunService')

-- Local Variables


local Camera = game.Workspace.CurrentCamera
local Player = game.Players.LocalPlayer
local InIntermission = false
game.StarterGui.ResetPlayerGuiOnSpawn = false
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui",5)
local MainGui = PlayerGui:WaitForChild("MainGui",5)
local ScoreFrame = MainGui:WaitForChild("ScoreFrame",5)
local Timer = ScoreFrame:WaitForChild("Timer",5)
local IntermissionTextBox = Timer:WaitForChild("Intermission",5)

function DisplayController:LoadMapManagerService()
	local MapManagerService = self.Services.core.MapManagerService
	return MapManagerService
end
-- Initialization





-- Local Functions
local function StartIntermission()
	local MapManagerService = DisplayController:LoadMapManagerService()
	-- Find flag to circle. Default to circle center of map
	local possiblePoints = {}
	table.insert(possiblePoints, Vector3.new(0,50,0))
	
	for _, child in ipairs(game.Workspace:GetChildren()) do
		if child.Name == "FlagStand" then
			table.insert(possiblePoints, child.FlagStand.Position)
		end
	end
	
	local focalPoint = possiblePoints[math.random(#possiblePoints)]
	Camera.CameraType = Enum.CameraType.Scriptable
	Camera.Focus = CFrame.new(focalPoint)
	
	local angle = 0
	game.Lighting.Blur.Enabled = true
	RunService:BindToRenderStep('IntermissionRotate', Enum.RenderPriority.Camera.Value, function()
		local cameraPosition = focalPoint + Vector3.new(50 * math.cos(angle), 20, 50 * math.sin(angle))
		Camera.CoordinateFrame = CFrame.new(cameraPosition, focalPoint)
		angle = angle + math.rad(.25)
	end)	
end

local function StopIntermission()
	game.Lighting.Blur.Enabled = false
	RunService:UnbindFromRenderStep('IntermissionRotate')
	Camera.CameraType = Enum.CameraType.Custom
end

function DisplayController:OnDisplayIntermission(display)
	if display and not InIntermission then
		InIntermission = true
		IntermissionTextBox.Text = "Intermission"
		StartIntermission()
	end	
	if not display and InIntermission then
		InIntermission = false
		IntermissionTextBox.Visible = InIntermission
		IntermissionTextBox.Text = "In Round"
		StopIntermission()
		local mapVoteGui = PlayerGui:FindFirstChild("MapVoteGui")
		if mapVoteGui then
			mapVoteGui:Destroy()
		end
	end
end





return DisplayController