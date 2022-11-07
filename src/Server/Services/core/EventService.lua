-- Event Service
-- Username
-- October 25, 2022



local EventService = {Client = {}}



function EventService:DisplayIntermissionFireClient(player,display)
    --IsIntermission is a boolean
    self:FireClient("DisplayIntermission",player,display)
end

function EventService:DisplayNotificationFireClient(player,teamColor, message)
    self:FireClient("DisplayNotification",player,teamColor, message)
end


function EventService:CaptureFlagFire(Player)
    local GameManagerService = self.Services.GameManagerService
    GameManagerService:OnCaptureFlag(Player)
end

function EventService:ReturnFlagFire(BrickColor)
    local GameManagerService = self.Services.GameManagerService
    GameManagerService:OnReturnFlag(BrickColor)
end

function EventService:DisplayScoreFireClient(player,team, score)
    self:FireClient("DisplayScore",player,team, score)
end


function EventService:OnCharacterAddedFireClient(player)
    print("Fired")
    self:FireClient("OnCharacterAdded",player)
end




--[[
Here, just In case I want to use it later

function EventService:DisplayTimerInfoFireClient(player,...)
    self:FireAllClients("DisplayTimerInfo",player,...)
end

function EventService:DisplayVictoryFireClient(player,...)
    self:FireAllClients("DisplayVictory",player,...)
end

function EventService:DisplayWaitingForOtherPlayersFireClient(player,...)
    self:FireAllClients("DisplayWaitingForOtherPlayers",player,...)
end

function EventService:ResetMouseIconFireClient(player,...)
    self:FireAllClients("ResetMouseIcon",player,...)
end

function EventService:ReturnFlagFireClient(player,...)
    self:FireAllClients("ReturnFlag",player,...)
end




--]]



--Fire all Clients




function EventService:DisplayIntermissionFireAllClients(display)
     --IsIntermission is a boolean
    self:FireAllClients("DisplayIntermission",display)
end

function EventService:DisplayNotificationFireAllClients(teamColor, message)
    self:FireAllClients("DisplayNotification",teamColor, message)
end

function EventService:DisplayTimerInfoFireAllClients(intermission, waitingForPlayers)
    self:FireAllClients("DisplayTimerInfo",intermission, waitingForPlayers)
end

function EventService:DisplayVictoryFireAllClients(winningTeam)
    self:FireAllClients("DisplayVictory",winningTeam)
end

function EventService:DisplayScroeFireAllClients(team, score)
    self:FireAllClients("DisplayScore",team, score)
end

function EventService:ResetMouseIconFireAllClients()
    self:FireAllClients("ResetMouseIcon")
end

function EventService:OnCharacterAddedFireAllClients()
    self:FireAllClients("OnCharacterAdded")
end


--[[

-- Here just in case I want to use it later

function EventService:CaptureFlagFireAllClients(...)
    self:FireAllClients("CaptureFlag",...)
end

function EventService:DisplayScroeFireAllClients(...)
    self:FireAllClients("DisplayScore",...)
end

function EventService:DisplayWaitingForOtherPlayersFireAllClients(...)
    self:FireAllClients("DisplayWaitingForOtherPlayers",...)
end

function EventService:ReturnFlagFireAllClients(...)
    self:FireAllClients("ReturnFlag",...)
end
]]



function EventService:Init()
    self:RegisterClientEvent("MakeMainGui")
    self:RegisterClientEvent("DisplayIntermission")
    self:RegisterClientEvent("DisplayNotification")
    self:RegisterClientEvent("DisplayScore")
    self:RegisterClientEvent("DisplayTimerInfo")
    self:RegisterClientEvent("DisplayVictory")
    self:RegisterClientEvent("DisplayWaitingForOtherPlayers")
    self:RegisterClientEvent("ResetMouseIcon")
    self:RegisterClientEvent("OnCharacterAdded")
end


return EventService