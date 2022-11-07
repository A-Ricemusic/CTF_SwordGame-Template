-- Notification Controller
-- Username
-- October 27, 2022



local NotificationController = {}


--Local Variables

local Player = game.Players.LocalPlayer	
local Mouse = Player:GetMouse()
local MouseIcon = Mouse.Icon
local PlayerGui = Player:WaitForChild("PlayerGui",20)
local MainGui = PlayerGui:WaitForChild("MainGui",20)
local ScoreFrame = MainGui:WaitForChild("ScoreFrame")
local VictoryFrame = MainGui:WaitForChild("VictoryMessage")

-- Local Functions
function NotificationController:OnDisplayNotification(teamColor, message)
	local notificationFrame = ScoreFrame[tostring(teamColor)].Notification
	notificationFrame.Text = message
	notificationFrame:TweenSize(UDim2.new(1,0,1,0), Enum.EasingDirection.Out,
		Enum.EasingStyle.Quad, .25, false)
	task.wait(1.5)
	notificationFrame:TweenSize(UDim2.new(1,0,0,0), Enum.EasingDirection.Out,
		Enum.EasingStyle.Quad, .1, false)
end

function NotificationController:OnScoreChange(team, score)
	ScoreFrame[tostring(team.TeamColor)].Text = score
end

function NotificationController:OnDisplayVictory(winningTeam)
	if winningTeam then
		VictoryFrame.Visible = true
		if winningTeam == 'Tie' then
			VictoryFrame.Tie.Visible = true
		else
			VictoryFrame.Win.Visible = true
			local WinningFrame = VictoryFrame.Win[winningTeam.Name]
			WinningFrame.Visible = true
		end
	else
		VictoryFrame.Visible = false
		VictoryFrame.Win.Visible = false
		VictoryFrame.Win.Red.Visible = false
		VictoryFrame.Win.Blue.Visible = false
		VictoryFrame.Tie.Visible = false
	end
end

function NotificationController:OnResetMouseIcon()
	Mouse.Icon = MouseIcon
end


return NotificationController