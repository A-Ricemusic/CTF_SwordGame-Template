-- Game Music Controller
-- Username
-- November 2, 2022



local GameMusicController = {}

function GameMusicController:Start()
    local gameSounds = game.SoundService:GetChildren()
    local tableLength = #gameSounds
    local waitTimer = 3
    local count = 0
    task.wait(waitTimer)
    while true do
        task.wait(waitTimer)
        count = count + 1
        if count > tableLength then
            count = 1
        end
        local sound = gameSounds[count]
        sound:Play()
        task.wait(sound.TimeLength)
        sound:Stop()
        sound = nil
    end
    
end


function GameMusicController:Init()
	
end


return GameMusicController