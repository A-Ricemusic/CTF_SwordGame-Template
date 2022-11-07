local CollectionService = game:GetService("CollectionService")
-- Tagging Service
-- Username
-- October 29, 2022



local TaggingService = {}
CollectionService = game:GetService("CollectionService")

function TaggingService:MakeTeleportersLocal()
    local teleporterClass = self.Modules.classes.TeleporterClass
    local teleporterslocal = CollectionService:GetTagged('TeleporterLocal')
        for _,teleporter in pairs(teleporterslocal) do
            teleporterClass.new(teleporter)
            teleporter = nil
        end
end

function TaggingService:MakeTeleportersGlobal()
    local teleporterGlobalClass = self.Modules.classes.TeleporterGlobalClass
    local teleportersGlobal = CollectionService:GetTagged('GlobalTeleporter')
        for _,teleporter in pairs(teleportersGlobal) do
            teleporterGlobalClass.new(teleporter)
            teleporter = nil
        end
end


function TaggingService:MakeSlowDamageblock()
    local DamageblockClass = self.Modules.classes.DamageblockClass
    local SlowDamageblocks = CollectionService:GetTagged('SlowDamageblock')
        for _,block in pairs(SlowDamageblocks) do
            DamageblockClass.new(block,"Humanoid",2,0.5)
        end
end

function TaggingService:MakeMediumDamageblock()
    local DamageblockClass = self.Modules.classes.DamageblockClass
    local MediumDamageblocks = CollectionService:GetTagged('MediumDamageblock')
        for _,block in pairs(MediumDamageblocks) do
            DamageblockClass.new(block,"Humanoid",15,0.5)
        end
end

function TaggingService:MakeKillblockHumanoid()
    local DamageblockClass = self.Modules.classes.DamageblockClass
    local KillblockHumanoid = CollectionService:GetTagged('KillblockHumanoid')
        for _,block in pairs(KillblockHumanoid) do
            DamageblockClass.new(block,"Humanoid",10000,0.5)
        end
end

function TaggingService:MakeMediumFadeblock()
    local FadeblockClass = self.Modules.classes.FadeblockClass
    local MediumFadeblocks = CollectionService:GetTagged('FadeMedium')
        for _,block in pairs(MediumFadeblocks) do
            FadeblockClass.new(block,0.1,0.5,3)
        end
end


function TaggingService:MakeHealthPacks()
    local HealthPackClass = self.Modules.classes.HealthPackClass
    local HealthPacks = CollectionService:GetTagged('Healthpack')
        for _,block in pairs(HealthPacks) do
            HealthPackClass.new(block,40,15)
        end
end


function TaggingService:OnStart()
    TaggingService:MakeHealthPacks()
    TaggingService:MakeKillblockHumanoid()
    TaggingService:MakeMediumFadeblock()
end


function TaggingService:Init()
	
end


return TaggingService