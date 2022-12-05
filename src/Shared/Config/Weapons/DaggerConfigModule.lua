-- Bronze Sword Config Module
-- Username
-- September 29, 2022


mult = 3
local DaggerWeaponConfig = {}
DaggerWeaponConfig.TagName = "Dagger"
DaggerWeaponConfig.DisplayName = "Dagger"
DaggerWeaponConfig.HumanoidToKill = ("Humanoid")
	DaggerWeaponConfig.WalkSpeed = 22
	DaggerWeaponConfig.JumpHeight = 15
	DaggerWeaponConfig.MaxDamage = 2 * mult
	DaggerWeaponConfig.MinDamage = 1 * mult
	DaggerWeaponConfig.AbilityDamage = 5
	DaggerWeaponConfig.Cooldown = 0.5
	DaggerWeaponConfig.Cost = 200
	DaggerWeaponConfig.ProjectileAnimation = "rbxassetid://10149103707"
	DaggerWeaponConfig.ProjectileName = "ThrowingKnife"
	DaggerWeaponConfig.AbilityForce = 100
	DaggerWeaponConfig.AbilityCooldown = 1
	DaggerWeaponConfig.AbilityDebrisTimer = 0.5
	DaggerWeaponConfig.PlayerKnockbackVelocity = 5
	DaggerWeaponConfig.ComboResetTimer = 1.5
	DaggerWeaponConfig.HitBoxSize = Vector3.new(5,3,5)
	DaggerWeaponConfig.AbilityName = "Projectile"
	DaggerWeaponConfig.Description = "Light weight projectile sword, Ability: Exexly daggers(Throws small daggers very quickly)"
	-- Animations & Sounds
	DaggerWeaponConfig.SwingAnimations = {
        'rbxassetid://9991378000', --1
		'rbxassetid://11656889243', --2
        'rbxassetid://9991697436', --3
        'rbxassetid://9991378000', --4
        'rbxassetid://11656887555', --5
    }
	DaggerWeaponConfig.Textures = { -- Slash
	'rbxassetid://8821193347', --1
	'rbxassetid://8821230983', --2
	'rbxassetid://8821246947', --3
	'rbxassetid://8821254467', --4
	'rbxassetid://8821272181', --5
	'rbxassetid://8821280832', --6
	'rbxassetid://8821300395', --7
	'rbxassetid://8821311218', --8
	'rbxassetid://8896641723', --9
	}
	DaggerWeaponConfig.AttackSoundIds = {
		"rbxasset://sounds\\swordslash.wav",
	}
	--] Advanced
--Send Information to Ability Service
return DaggerWeaponConfig