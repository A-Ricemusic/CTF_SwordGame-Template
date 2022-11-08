-- Game Manager Service
-- Username
-- November 1, 2022



local GameManagerService = {Client = {}}


-- ROBLOX services
local Players = game.Players

-- load Game services


function GameManagerService:LoadConfig()
    local Configurations = self.Shared.Config.GameConfigModule
    return Configurations
end

function GameManagerService:LoadEvents()
    local EventService = self.Services.core.EventService
    return EventService
end

function GameManagerService:LoadDisplayManagerService()
    local DisplayManagerService = self.Services.core.DisplayManagerService
    return DisplayManagerService
end

function GameManagerService:LoadTeamManagerService()
    local TeamManagerService = self.Services.core.TeamManagerService
    return TeamManagerService
end

function GameManagerService:LoadMapManagerService()
    local MapManagerService = self.Services.core.MapManagerService
    return MapManagerService
end

function GameManagerService:LoadPlayerManagerService()
	local PlayerManagerService = self.Services.core.PlayerManagerService
    return PlayerManagerService
end

function GameManagerService:LoadTaggingService()
	local TaggingService = self.Services.TaggingService
    return TaggingService
end

function GameManagerService:LoadTimeManagerService()
    local TimeManagerService = self.Services.core.TimeManagerService
    return TimeManagerService 
end

-- Local Variables
GameManagerService.IntermissionRunning = true
local EnoughPlayers = false
GameManagerService.GameRunning = false


function GameManagerService:OnPlayerAdded(player)
	local FlagConfigModule = self.Shared.Config.FlagConfigModule
	local PlayerManagerService = GameManagerService:LoadPlayerManagerService()
	local DisplayManagerService = GameManagerService:LoadDisplayManagerService()
	PlayerManagerService:OnPlayerAdded(player)
	FlagConfigModule:OnPlayerAdded(player)
	if GameManagerService.IntermissionRunning then
		DisplayManagerService:StartIntermission(player)
	end
end

function GameManagerService:OnPlayerRemoving(player)
	local PlayerManagerService = GameManagerService:LoadPlayerManagerService()
	PlayerManagerService:OnPlayerRemoving(player)
end


function GameManagerService:OnCaptureFlag(player)
	local DisplayManagerService = GameManagerService:LoadDisplayManagerService()
	local PlayerManagerService = GameManagerService:LoadPlayerManagerService()
	local TeamManagerService = GameManagerService:LoadTeamManagerService()
	PlayerManagerService:AddPlayerScore(player, 1)
	TeamManagerService:AddTeamScore(player.TeamColor, 1)
	DisplayManagerService:DisplayNotification(player.TeamColor, 'Captured Flag!')
end

function GameManagerService:OnReturnFlag(flagColor)
	local DisplayManagerService = GameManagerService:LoadDisplayManagerService()
	DisplayManagerService:DisplayNotification(flagColor, 'Flag Returned!')
end

-- Public Functions
function GameManagerService:Initialize()
	local Players = game.Players:GetPlayers()
		for _,plr in pairs(Players) do
			if not plr then return end
			GameManagerService:OnPlayerAdded(plr)
		end
	local MapManagerService = GameManagerService:LoadMapManagerService()
    MapManagerService:SaveMap()
end

function GameManagerService:MakeFlags()
	local FlagConfigModule = self.Shared.Config.FlagConfigModule
	local CollectionService = game:GetService("CollectionService")
    local FlagStands = CollectionService:GetTagged("FlagStand")

    for _,flagstand in pairs(FlagStands) do 
    FlagConfigModule:Initialize(flagstand)
    end
    
end

function GameManagerService:RunIntermission()
	local Configurations = GameManagerService:LoadConfig()
	local TimeManagerService = GameManagerService:LoadTimeManagerService()
	local DisplayManagerService = GameManagerService:LoadDisplayManagerService()
	GameManagerService.IntermissionRunning = true
	TimeManagerService:StartTimer(Configurations.INTERMISSION_DURATION)
	DisplayManagerService:StartIntermission()
	EnoughPlayers = Players.NumPlayers >= Configurations.MIN_PLAYERS	
	DisplayManagerService:UpdateTimerInfo(true, not EnoughPlayers)
	task.spawn(function()
		repeat
			if EnoughPlayers and Players.NumPlayers < Configurations.MIN_PLAYERS then
				EnoughPlayers = false
			elseif not EnoughPlayers and Players.NumPlayers >= Configurations.MIN_PLAYERS then
				EnoughPlayers = true
			end
			DisplayManagerService:UpdateTimerInfo(true, not EnoughPlayers)
			task.wait(.5)
		until GameManagerService.IntermissionRunning == false
	end)
	
	task.wait(Configurations.INTERMISSION_DURATION)
end

function GameManagerService:StopIntermission()
	local DisplayManagerService = GameManagerService:LoadDisplayManagerService()
	GameManagerService.IntermissionRunning = false
	DisplayManagerService:UpdateTimerInfo(false, false)
	DisplayManagerService:StopIntermission()
end

function GameManagerService:GameReady()
	local Configurations = GameManagerService:LoadConfig()
	return Players.NumPlayers >= Configurations.MIN_PLAYERS
end

function GameManagerService:StartRound()
	local Configurations = GameManagerService:LoadConfig()
	local TimeManagerService = GameManagerService:LoadTimeManagerService()
	local PlayerManagerService = GameManagerService:LoadPlayerManagerService()
	local TeamManagerService = GameManagerService:LoadTeamManagerService()
	local MapManagerService = GameManagerService:LoadMapManagerService()
	local TaggingService = GameManagerService:LoadTaggingService()
	MapManagerService:GetSelectedMap()
	GameManagerService:MakeFlags()
	TeamManagerService:ClearTeamScores()
	PlayerManagerService:ClearPlayerScores()
	TaggingService:OnStart()
	PlayerManagerService:AllowPlayerSpawn(true)
	PlayerManagerService:LoadPlayers()
	
	GameManagerService.GameRunning = true
	PlayerManagerService:SetGameRunning(true)
	TimeManagerService:StartTimer(Configurations.ROUND_DURATION)
end

function GameManagerService:Update()
	--TODO: Add custom custom game code here
end

function GameManagerService:RoundOver()
	local TimeManagerService = GameManagerService:LoadTimeManagerService()
	local DisplayManagerService = GameManagerService:LoadDisplayManagerService()
	local TeamManagerService = GameManagerService:LoadTeamManagerService()
	local winningTeam = TeamManagerService:HasTeamWon()
	if winningTeam then
		DisplayManagerService:DisplayVictory(winningTeam)
		return true
	end
	if TimeManagerService:TimerDone() then
		if TeamManagerService:AreTeamsTied() then
			DisplayManagerService:DisplayVictory('Tie')
		else
			winningTeam = TeamManagerService:GetWinningTeam()
			DisplayManagerService:DisplayVictory(winningTeam)
		end
		return true
	end
	return false
end

function GameManagerService:RoundCleanup()
	local Configurations = GameManagerService:LoadConfig()
	local MapManagerService = GameManagerService:LoadMapManagerService()
	local DisplayManagerService = GameManagerService:LoadDisplayManagerService()
	local TeamManagerService = GameManagerService:LoadTeamManagerService()
	local PlayerManagerService = GameManagerService:LoadPlayerManagerService()
	PlayerManagerService:SetGameRunning(false)
	task.wait(Configurations.END_GAME_WAIT)
	PlayerManagerService:AllowPlayerSpawn(false)
	PlayerManagerService:DestroyPlayers()
	DisplayManagerService:DisplayVictory(nil)
	TeamManagerService:ClearTeamScores()
	PlayerManagerService:ClearPlayerScores()
	TeamManagerService:ShuffleTeams()
	MapManagerService:ClearMap()
	MapManagerService:LoadMap()
end

--main 
function GameManagerService:Start()
task.wait(5)
GameManagerService:Initialize()
task.wait(2)
game.Players.PlayerAdded:Connect(function(player)
	GameManagerService:OnPlayerAdded(player)
end)

game.Players.PlayerRemoving:Connect(function(player)
	GameManagerService:OnPlayerRemoving(player)
end)

while true do
	repeat
		GameManagerService:RunIntermission()
	until GameManagerService:GameReady()
	
	GameManagerService:StopIntermission()
	GameManagerService:StartRound()	
	
	repeat
		GameManagerService:Update()
		task.wait()
	until GameManagerService:RoundOver()
	
	GameManagerService:RoundCleanup()
end
end


return GameManagerService