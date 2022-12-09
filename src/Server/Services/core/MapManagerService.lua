-- Map Manager Service
-- Username
-- October 26, 2022



local MapManagerService = {Client = {}}


-- Local Variables
local MapSave = Instance.new('Folder', game.ServerStorage)
MapSave.Name = 'MapSave'
local Maps = game:GetService("ReplicatedStorage").Maps:GetChildren()
local mapTable = {}

for _,map in pairs(Maps)  do
mapTable[map.Name] = 0
end

function MapManagerService:MapSelect(mapSelected)
	if mapTable[mapSelected] == nil then return end
	mapTable[mapSelected] = mapTable[mapSelected] + 1
end

-- Initialization

local MapPurgeProof = game.Workspace:FindFirstChild('MapPurgeProof')
if not MapPurgeProof then
	MapPurgeProof = Instance.new('Folder', game.Workspace)
	MapPurgeProof.Name = 'MapPurgeProof'
end

-- Functions

function MapManagerService:GetSelectedMap()
	
	local mapSelected = ''
	local mapSelectedClone
	for key,value in pairs(mapTable) do
		local voteCount = 0
		if mapTable[key] > voteCount then
			voteCount = mapTable[key]
			mapSelected = key
		end
	end
		local mapSelectedModel = game:GetService("ReplicatedStorage").Maps:FindFirstChild(mapSelected)
		if mapSelectedModel then
			mapSelectedClone = mapSelectedModel:Clone()
		else
			mapSelectedClone = Maps[1]:Clone()
		end
			mapSelectedClone.Parent = game.Workspace
			mapSelectedClone = nil
		for key,value in pairs(mapTable) do
			 mapTable[key] = 0
	end
	mapSelected = nil
	
end


function MapManagerService:SaveMap()
	for _, child in ipairs(game.Workspace:GetChildren()) do
		if not child:IsA('Camera') and not child:IsA('Terrain') and not child:IsA('Folder') then
			local copy = child:Clone()
			if copy then
				copy.Parent = MapSave
			end	
		end
	end
end

function MapManagerService:ClearMap()
	for _, child in ipairs(game.Workspace:GetChildren()) do
		if not child:IsA('Camera') and not child:IsA('Terrain') and not child:IsA('Folder') then
			child:Destroy()
		end
	end
end

function MapManagerService:LoadMap()
	spawn(function()
		for _, child in ipairs(MapSave:GetChildren()) do
			local copy = child:Clone()
			copy.Parent = game.Workspace
		end
	end)
end
	


return MapManagerService
