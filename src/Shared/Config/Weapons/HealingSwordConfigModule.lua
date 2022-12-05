-- Bronze Sword Config Module
-- Username
-- September 29, 2022


mult = 3
local HealingSwordWeaponConfig = {}
HealingSwordWeaponConfig.TagName = "HealingSword"
HealingSwordWeaponConfig.DisplayName = "Healing Sword"
HealingSwordWeaponConfig.HumanoidToKill = ("Humanoid")
	HealingSwordWeaponConfig.WalkSpeed = 14
	HealingSwordWeaponConfig.JumpHeight = 10
	HealingSwordWeaponConfig.MaxDamage = 7 * mult
	HealingSwordWeaponConfig.MinDamage = 5 * mult
	HealingSwordWeaponConfig.AbilityDamage = 0
	HealingSwordWeaponConfig.HealAmount = 60
	HealingSwordWeaponConfig.Cooldown = 0.7
	HealingSwordWeaponConfig.Cost = 200
	HealingSwordWeaponConfig.ProjectileCooldown = 1
	HealingSwordWeaponConfig.ProjectileAnimation = "rbxassetid://10149103707"
	HealingSwordWeaponConfig.AbilityForce = 100
	HealingSwordWeaponConfig.AbilityCooldown = 20
	HealingSwordWeaponConfig.AbilityDebrisTimer = 2
	HealingSwordWeaponConfig.PlayerKnockbackVelocity = 10
	HealingSwordWeaponConfig.ComboResetTimer = 1.5
	HealingSwordWeaponConfig.HitBoxSize = Vector3.new(10,3,7)
	HealingSwordWeaponConfig.AbilityName = "Heal"
	HealingSwordWeaponConfig.Description ="Medium Weight Sword, Ability: Avida hands (heals the player over time)"

	-- Animations & Sounds
	HealingSwordWeaponConfig.SwingAnimations = {
		'rbxassetid://9991581812', --1
        'rbxassetid://9991378000', --2
        'rbxassetid://9991581812', --3
        'rbxassetid://9820421213', --4
        'rbxassetid://9991697436', --5
    }
	HealingSwordWeaponConfig.Textures = { -- Slash
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
	HealingSwordWeaponConfig.AttackSoundIds = {
		"rbxasset://sounds\\swordslash.wav",
	}
	--] Advanced
--Send Information to Ability Service
return HealingSwordWeaponConfig