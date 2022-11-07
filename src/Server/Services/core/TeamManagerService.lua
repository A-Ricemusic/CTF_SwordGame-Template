-- Team Manager Service
-- Username
-- October 26, 2022



local TeamManagerService = {}

-- ROBLOX services
Teams = game.Teams
Players = game.Players

-- Game services
function TeamManagerService:LoadConfig()
    local Configurations = self.Shared.Config.GameConfigModule
    return Configurations
end

function TeamManagerService:LoadDisplayManagerService()
    local DisplayManagerService = self.Services.core.DisplayManagerService
    return DisplayManagerService
end

-- Local variables

local TeamPlayers = {}
local TeamScores = {}


-- Initialization

for _, team in ipairs(Teams:GetTeams()) do
	TeamPlayers[team] = {}
	TeamScores[team] = 0
end

-- Local Functions

local function GetTeamFromColor(teamColor)
	for _, team in ipairs(Teams:GetTeams()) do
		if team.TeamColor == teamColor then
			return team
		end
	end
	return nil
end

-- Public Functions

function TeamManagerService:ClearTeamScores()
	local DisplayManagerService = TeamManagerService:LoadDisplayManagerService()
	for _, team in ipairs(Teams:GetTeams()) do
		TeamScores[team] = 0
		DisplayManagerService:UpdateScore(team, 0)
	end
end

function TeamManagerService:HasTeamWon()
	local Configurations = TeamManagerService:LoadConfig()
	for _, team in ipairs(Teams:GetTeams()) do
		if TeamScores[team] >= Configurations.CAPS_TO_WIN then
			return team
		end
	end
	return false
end

function TeamManagerService:GetWinningTeam()
	local highestScore = 0
	local winningTeam = nil
	for _, team in ipairs(Teams:GetTeams()) do
		if TeamScores[team] > highestScore then
			highestScore = TeamScores[team]
			winningTeam = team
		end
	end
	return winningTeam
end

function TeamManagerService:AreTeamsTied()
	local teams = Teams:GetTeams()
	local highestScore = 0
	local tied = false
	for _, team in ipairs(teams) do
		if TeamScores[team] == highestScore then
			tied = true
		elseif TeamScores[team] > highestScore then
			tied = false
			highestScore = TeamScores[team]
		end
	end
	return tied
end

function TeamManagerService:AssignPlayerToTeam(player)
	local smallestTeam
	local lowestCount = math.huge
	for team, playerList in pairs(TeamPlayers) do
		if #playerList < lowestCount then
			smallestTeam = team
			lowestCount = #playerList
		end
	end
	table.insert(TeamPlayers[smallestTeam], player)
	player.Neutral = false
	player.TeamColor = smallestTeam.TeamColor
end

function TeamManagerService:RemovePlayer(player)
	local team = GetTeamFromColor(player.TeamColor)
	local teamTable = TeamPlayers[team]
	for i = 1, #teamTable do
		if teamTable[i] == player then
			table.remove(teamTable, i)
			return
		end
	end
end

function TeamManagerService:ShuffleTeams()
	for _, team in ipairs(Teams:GetTeams()) do
		TeamPlayers[team] = {}
	end
	local players = Players:GetPlayers()
	while #players > 0 do
		local rIndex = math.random(1, #players)
		local player = table.remove(players, rIndex)
		TeamManagerService:AssignPlayerToTeam(player)
	end
end

function TeamManagerService:AddTeamScore(teamColor, score)
	local DisplayManagerService = TeamManagerService:LoadDisplayManagerService()
	local team = GetTeamFromColor(teamColor)
	TeamScores[team] = TeamScores[team] + score
	DisplayManagerService:UpdateScore(team, TeamScores[team])
end


return TeamManagerService