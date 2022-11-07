-- Time Manager Controller
-- Username
-- October 27, 2022



local TimeManagerController = {}

-- Local Variables
local TimeObject = game.Workspace:WaitForChild('MapPurgeProof'):WaitForChild('Time')
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui",15)
local MainGui = PlayerGui:WaitForChild("MainGui",15)
local ScoreFrame = MainGui:WaitForChild("ScoreFrame",15)
local Timer = ScoreFrame:WaitForChild("Timer",15)

-- Local Functions
local function OnTimeChanged(newValue)
	local currentTime = math.max(0, newValue)
	local minutes = math.floor(currentTime / 60)-- % 60
	local seconds = math.floor(currentTime) % 60
	Timer.Text = string.format("%02d:%02d", minutes, seconds)
end

function TimeManagerController:OnDisplayTimerInfo(intermission, waitingForPlayers)
	Timer.Intermission.Visible = intermission
	Timer.WaitingForPlayers.Visible = waitingForPlayers
end


function TimeManagerController:Start()
	TimeObject.Changed:Connect(OnTimeChanged)
end


return TimeManagerController