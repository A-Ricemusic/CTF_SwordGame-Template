-- Event Controller
-- Username
-- October 25, 2022



local EventController = {}


function EventController:Start()
    local NotificationController = self.Controllers.NotificationController
    local TimeManagerController = self.Controllers.TimeManagerController
    local WeaponController = self.Controllers.WeaponController
    local ContextActionServiceController = self.Controllers.ContextActionServiceController
    local DisplayController = self.Controllers.DisplayController
    local EventService = self.Services.core.EventService
    

    EventService.DisplayNotification:Connect(function(teamColor, message)
        NotificationController:OnDisplayNotification(teamColor, message)
    end)

    EventService.DisplayScore:Connect(function(team, score)
        NotificationController:OnScoreChange(team, score)
    end)
    
    EventService.DisplayVictory:Connect(function(winningTeam)
        NotificationController:OnDisplayVictory(winningTeam)
    end)

    EventService.DisplayTimerInfo:Connect(function(intermission, waitingForPlayers)
        TimeManagerController:OnDisplayTimerInfo(intermission, waitingForPlayers)
    end)
    EventService.DisplayIntermission:Connect(function(display)
        DisplayController:OnDisplayIntermission(display)
    end)
    EventService.ResetMouseIcon:Connect(function()
        NotificationController:OnResetMouseIcon()
    end)
    EventService.OnCharacterAdded:Connect(function()
        ContextActionServiceController:OnCharacterAdded()
    end)
  EventService.SwordSetUp:Connect(function(WeaponTag)
        self.Controllers.WeaponController:OnSetUp(WeaponTag)
    end)

    EventService.Unbind:Connect(function(WeaponTag)
        self.Controllers.WeaponController:UnbindAction()
    end)
	
end



return EventController