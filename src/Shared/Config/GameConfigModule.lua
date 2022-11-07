-- Game Config Module
-- Username
-- October 25, 2022



local GameConfigModule = {}

GameConfigModule.ROUND_DURATION = 5 * 60 -- Seconds
GameConfigModule.MIN_PLAYERS = 1
GameConfigModule.CAPS_TO_WIN = 5
GameConfigModule.REQUIRE_RETURN_BEFORE_CAP = true
GameConfigModule.FLAG_RESPAWN_TIME = 3 -- Seconds
GameConfigModule.RETURN_FLAG_ON_DROP = true
GameConfigModule.FLAG_RETURN_ON_TOUCH = true
GameConfigModule.INTERMISSION_DURATION = 60 -- Seconds
GameConfigModule.END_GAME_WAIT = 10 -- Seconds
GameConfigModule.RESPAWN_TIME = 5 -- Seconds

return GameConfigModule