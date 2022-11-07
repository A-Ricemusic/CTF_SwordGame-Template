-- Time Manager Service
-- Username
-- October 26, 2022



local TimeManagerService = {}


-- Local Variables

local StartTime = 0
local Duration = 0

-- Initialization

local Time = Instance.new('IntValue', game.Workspace:WaitForChild('MapPurgeProof'))
Time.Name = 'Time'

-- Functions

function TimeManagerService:StartTimer(duration)
	StartTime = tick()
	Duration = duration
	task.spawn(function()
		repeat 
			Time.Value = Duration - (tick() - StartTime)
			task.wait()
		until Time.Value <= 0
		Time.Value = 0
	end)
end

function TimeManagerService:TimerDone()
	return tick() - StartTime >= Duration
end

return TimeManagerService