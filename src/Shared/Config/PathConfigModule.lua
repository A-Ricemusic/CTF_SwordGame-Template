-- Path Config Module
-- Username
-- October 25, 2022



local ConfigDirs = game:GetService("ReplicatedStorage").Aero.Shared.Config

local PathConfigModule = {
['FireSword'] = ConfigDirs.Weapons.FireSwordConfigModule,
['BlazeSword'] = ConfigDirs.Weapons.BlazeSwordConfigModule,
['HealingSword'] = ConfigDirs.Weapons.HealingSwordConfigModule,
['HeavySword'] = ConfigDirs.Weapons.HeavySwordConfigModule,
['ShortSword'] = ConfigDirs.Weapons.ShortSwordConfigModule,
['Dagger'] = ConfigDirs.Weapons.DaggerConfigModule,
['UltimateSword'] = ConfigDirs.Weapons.UltimateSwordConfigModule,

}

return PathConfigModule