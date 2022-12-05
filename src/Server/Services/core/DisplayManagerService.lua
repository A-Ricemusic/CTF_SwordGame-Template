local Debris = game:GetService("Debris")
-- Display Manager Service
-- Username
-- October 26, 2022



local DisplayManagerService =  {}


-- ROBLOX Services

local Players = game.Players
-- Local Variables



local StarterGui = game.StarterGui

-- Initialize
local function OnInit()

StarterGui.ResetPlayerGuiOnSpawn = false
local MapPurgeProof = game.Workspace:FindFirstChild('MapPurgeProof')
if not MapPurgeProof then
	MapPurgeProof = Instance.new('Folder', game.Workspace)
	MapPurgeProof.Name = 'MapPurgeProof'
end
end

function DisplayManagerService:LoadEvents()
    local EventService = self.Services.core.EventService
    return EventService
end

function DisplayManagerService:LoadMapManagerService()
    local MapManagerService = self.Services.core.MapManagerService
    return MapManagerService
end

function DisplayManagerService:LoadConfig()
    local config = self.Shared.Config.GameConfigModule
    return config
end

function DisplayManagerService:MapVotingGui(player)
	local PlayerGui = player:WaitForChild("PlayerGui")
	local Configurations = DisplayManagerService:LoadConfig()
	local MapManagerService = DisplayManagerService:LoadMapManagerService()
	local maps = game:GetService("ReplicatedStorage").Maps:GetChildren()
	local MapVoteGui = Instance.new("ScreenGui",PlayerGui)
	MapVoteGui.Name = "MapVoteGui"
	local votingFrame = Instance.new("Frame",MapVoteGui)
	votingFrame.Position = UDim2.new(0.2,0,0.2,0)
	votingFrame.Size = UDim2.new(0.9,0,0.9,0)
	votingFrame.BackgroundTransparency = 0.8
	votingFrame.BorderColor3 = Color3.new()
	local uiConstraint = Instance.new("UIAspectRatioConstraint",votingFrame)
	local uiGridLayout = Instance.new("UIGridLayout",votingFrame)
	for _,map in pairs(maps) do
		local button = Instance.new("TextButton",votingFrame)
		button.Size = uiGridLayout.CellSize
		button.Text = map.Name
		button.TextScaled = true
		button.TextWrapped = true
		button.Active = true
		button.Font = Enum.Font.Fantasy
		button.BackgroundTransparency = 0.5
		button.BackgroundColor = BrickColor.new("Rust")
		button.MouseButton1Click:Connect(function()
				button.Parent.Parent:Destroy()
				MapManagerService:MapSelect(button.Text)
		end)
		button.Activated:Connect(function()
				button.Parent.Parent:Destroy()
				MapManagerService:MapSelect(button.Text)
		end)
	end
	Debris:AddItem(MapVoteGui,Configurations.INTERMISSION_DURATION + 3)
end



-- Public Functions



function DisplayManagerService:StartIntermission(player)
	local EventService = DisplayManagerService:LoadEvents()
	if player then
		EventService:DisplayIntermissionFireClient(player, true)
		local PlayerGui = player:WaitForChild("PlayerGui")
		if PlayerGui:FindFirstChild("MapVoteGui") then return end
		DisplayManagerService:MapVotingGui(player)
	else
		EventService:DisplayIntermissionFireAllClients(true)
		for _,plr in pairs(game.Players:GetPlayers()) do
			local PlayerGui = plr:WaitForChild("PlayerGui")
			if PlayerGui:FindFirstChild("MapVoteGui") then return end
			DisplayManagerService:MapVotingGui(plr)
		end
	end
end

function DisplayManagerService:StopIntermission(player)
    local EventService = DisplayManagerService:LoadEvents()
	if player then
		task.wait(5)
		print(player.." fired")
		EventService:DisplayIntermissionFireClient(player, false)
	else
		EventService:DisplayIntermissionFireAllClients(false)
	end
end

function DisplayManagerService:DisplayNotification(teamColor, message)
    local EventService = DisplayManagerService:LoadEvents()
	EventService:DisplayNotificationFireAllClients(teamColor, message)
end

function DisplayManagerService:UpdateTimerInfo(isIntermission, waitingForPlayers)
    local EventService = DisplayManagerService:LoadEvents()
	EventService:DisplayTimerInfoFireAllClients(isIntermission, waitingForPlayers)
end

function DisplayManagerService:DisplayVictory(winningTeam)
    local EventService = DisplayManagerService:LoadEvents()
	EventService:DisplayVictoryFireAllClients(winningTeam)
end

function DisplayManagerService:UpdateScore(team, score)
    local EventService = DisplayManagerService:LoadEvents()
	EventService:DisplayScroeFireAllClients(team, score)
end

function DisplayManagerService:Init()
	OnInit()
end


return DisplayManagerService