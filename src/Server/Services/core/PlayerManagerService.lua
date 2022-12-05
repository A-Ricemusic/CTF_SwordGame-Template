-- Player Manager Service
-- Username
-- October 26, 2022



local PlayerManagerService = {}


-- Services
local Players = game.Players
local PointsService = game:GetService('PointsService')

function PlayerManagerService:LoadConfig()
    local Configurations = self.Shared.Config.GameConfigModule
    return Configurations
end

function PlayerManagerService:LoadEvents()
    local EventService = self.Services.core.EventService
    return EventService
end

function PlayerManagerService:LoadDisplayManagerService()
    local DisplayManagerService = self.Services.core.DisplayManagerService
    return DisplayManagerService
end

function PlayerManagerService:LoadTeamManagerService()
    local TeamManagerService = self.Services.core.TeamManagerService
    return TeamManagerService
end

function PlayerManagerService:LoadMainGuiModule()
    local MainGuiModule = self.Modules.Gui.MainGuiModule
    return MainGuiModule
end

-- Game services

-- Local variables
local PlayersCanSpawn = false
local GameRunning = false

function PlayerManagerService:OnPlayerRemoving(player)
	local TeamManagerService = PlayerManagerService:LoadTeamManagerService()
   TeamManagerService:RemovePlayer(player)
end



function PlayerManagerService:OnPlayerAdded(player)
	local DisplayManagerService = PlayerManagerService:LoadDisplayManagerService()
	local Configurations = PlayerManagerService:LoadConfig()
	local TeamManagerService = PlayerManagerService:LoadTeamManagerService()
	local MainGuiModule = PlayerManagerService:LoadMainGuiModule()
	local playerGui = player:WaitForChild("PlayerGui",20)
	local EventService = PlayerManagerService:LoadEvents()
	MainGuiModule:CreateGui(playerGui)
	-- Setup leaderboard stats
	local leaderstats = Instance.new('Model', player)
	leaderstats.Name = 'leaderstats'
	
	local Captures = Instance.new('IntValue', leaderstats)
	Captures.Name = 'Captures'
	Captures.Value = 0
	
	-- Add player to team and configure Gui
	TeamManagerService:AssignPlayerToTeam(player)
	player.CharacterAdded:Connect(function(character)
		character:WaitForChild('Humanoid').Died:connect(function()
			task.wait(Configurations.RESPAWN_TIME)
			if GameRunning then
				player:LoadCharacter()
				EventService:OnCharacterAddedFireClient(player)
			end
		end)
		local character = player.Character
		local guiPlayer = Instance.new("BillboardGui",character)
		guiPlayer.Adornee = character:WaitForChild("Head")
		guiPlayer.Active = true
		guiPlayer.AlwaysOnTop = true
		guiPlayer.Enabled = true
		guiPlayer.Size = UDim2.new(0,100,0,100)
		guiPlayer.ResetOnSpawn = true
		guiPlayer.ExtentsOffsetWorldSpace = Vector3.new(0,5,0)
	local text = Instance.new("TextLabel",guiPlayer)
		text.Text = player.Name
		text.Size = UDim2.new(0,50,0,50)
		text.Visible = true
		text.Selectable = false
		text.TextWrapped = false
		text.TextScaled = false
		text.TextSize = 15
		text.BackgroundTransparency = 1
		text.TextColor = player.TeamColor
		task.wait()
		EventService:OnCharacterAddedFireClient(player)
	end)	
	
	-- Check if player should be spawned	
	if PlayersCanSpawn then
		task.wait(Configurations.RESPAWN_TIME)
		player:LoadCharacter()
		EventService:OnCharacterAddedFireClient(player)
	else
		DisplayManagerService:StartIntermission(player)
	end	

end

-- Public Functions

function PlayerManagerService:SetGameRunning(running)
	GameRunning = running
end

function PlayerManagerService:ClearPlayerScores()
	for _, player in ipairs(Players:GetPlayers()) do
		local leaderstats = player:FindFirstChild('leaderstats')
		if leaderstats then
			local Captures = leaderstats:FindFirstChild('Captures')
			if Captures then
				Captures.Value = 0
			end
		end
	end
end

function PlayerManagerService:LoadPlayers()
	local EventService = PlayerManagerService:LoadEvents()	
	for _, player in ipairs(Players:GetPlayers()) do
		player:LoadCharacter()
		EventService:OnCharacterAddedFireClient(player)
	end
end

function PlayerManagerService:AllowPlayerSpawn(allow)
	PlayersCanSpawn = allow
end

function PlayerManagerService:DestroyPlayers()
	local EventService = PlayerManagerService:LoadEvents()
	for _, player in ipairs(Players:GetPlayers()) do
		player.Character:Destroy()
		for _, item in ipairs(player.Backpack:GetChildren()) do
			item:Destroy()
		end
	end
	EventService:ResetMouseIconFireAllClients()
end

function PlayerManagerService:AddPlayerScore(player, score)
	player.leaderstats.Captures.Value = player.leaderstats.Captures.Value + score
end

-- Event binding

return PlayerManagerService