GameMode = GameMode or {}
ARENA_VERSION = LoadKeyValues("addoninfo.txt").version

local requirements = {
	"libraries/keyvalues",
	"libraries/timers",
	"libraries/projectiles",
	"libraries/notifications",
	"libraries/animations",
	"libraries/attachments",
	"libraries/playertables",
	"libraries/containers",
	"libraries/worldpanels",
	"libraries/statcollection/init",
	--------------------------------------------------
	"data/constants",
	"data/globals",
	"data/kv_data",
	"data/modifiers",
	"data/abilities",
	"data/ability_functions",
	--------------------------------------------------
	"modules/index",

	"events",
	"custom_events",
	"filters",
}

local modifiers = {
	modifier_apocalypse_apocalypse = "heroes/hero_apocalypse/modifier_apocalypse_apocalypse",
	modifier_saitama_limiter = "heroes/hero_saitama/modifier_saitama_limiter",
	modifier_set_attack_range = "modifiers/modifier_set_attack_range",
	modifier_charges = "modifiers/modifier_charges",
	modifier_hero_selection_transformation = "modifiers/modifier_hero_selection_transformation",
	modifier_max_attack_range = "modifiers/modifier_max_attack_range",
	modifier_arena_hero = "modifiers/modifier_arena_hero",
	modifier_item_demon_king_bar_curse = "items/modifier_item_demon_king_bar_curse",
	modifier_hero_out_of_game = "modifiers/modifier_hero_out_of_game",
	modifier_arena_event_proxy = "modifiers/modifier_arena_event_proxy",

	modifier_item_shard_attackspeed_stack = "modifiers/modifier_item_shard_attackspeed_stack",
}

for k,v in pairs(modifiers) do
	LinkLuaModifier(k, v, LUA_MODIFIER_MOTION_NONE)
end

AllPlayersInterval = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23}

for _, requirement in ipairs(requirements) do
	require(requirement)
end

Options:Preload()

function GameMode:Activate()
	math.randomseed(tonumber((string.gsub(string.gsub(GetSystemTime(), ':', ''), '^0+', ''))))

	ListenToGameEvent('entity_killed', Dynamic_Wrap(GameMode, 'OnEntityKilled'), GameMode)
	ListenToGameEvent('player_connect_full', Dynamic_Wrap(GameMode, 'OnConnectFull'), GameMode)
	ListenToGameEvent('tree_cut', Dynamic_Wrap(GameMode, 'OnTreeCut'), GameMode)
	ListenToGameEvent('dota_player_used_ability', Dynamic_Wrap(GameMode, 'OnAbilityUsed'), GameMode)
	ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(GameMode, 'OnGameRulesStateChange'), GameMode)
	ListenToGameEvent('npc_spawned', Dynamic_Wrap(GameMode, 'OnNPCSpawned'), GameMode)
	ListenToGameEvent('dota_team_kill_credit', Dynamic_Wrap(GameMode, 'OnTeamKillCredit'), GameMode)
	ListenToGameEvent("dota_item_combined", Dynamic_Wrap(GameMode, 'OnItemCombined'), GameMode)

	GameMode:SetupRules()

	Containers:SetItemLimit(50)
	Containers:UsePanoramaInventory(false)
	GameRules:GetGameModeEntity():SetFreeCourierModeEnabled(true)
	GameRules:GetGameModeEntity():SetPauseEnabled(IsInToolsMode())
	Events:Emit("activate")

	PlayerTables:CreateTable("arena", {}, AllPlayersInterval)
	PlayerTables:CreateTable("player_hero_indexes", {}, AllPlayersInterval)
	PlayerTables:CreateTable("players_abandoned", {}, AllPlayersInterval)
	PlayerTables:CreateTable("gold", {}, AllPlayersInterval)
	PlayerTables:CreateTable("weather", {}, AllPlayersInterval)
	PlayerTables:CreateTable("disable_help_data", {[0] = {}, [1] = {}, [2] = {}, [3] = {}, [4] = {}, [5] = {}, [6] = {}, [7] = {}, [8] = {}, [9] = {}, [10] = {}, [11] = {}, [12] = {}, [13] = {}, [14] = {}, [15] = {}, [16] = {}, [17] = {}, [18] = {}, [19] = {}, [20] = {}, [21] = {}, [22] = {}, [23] = {}}, AllPlayersInterval)

	GLOBAL_DUMMY = CreateUnitByName("npc_dummy_unit", Vector(0, 0, 0), false, nil, nil, DOTA_TEAM_NEUTRALS)
	GLOBAL_DUMMY:AddNewModifier(GLOBAL_DUMMY, nil, "modifier_arena_event_proxy", nil)
end

function GameMode:OnFirstPlayerLoaded()
	StatsClient:FetchPreGameData()
	if Options:IsEquals("MainHeroList", "NoAbilities") then
		CustomAbilities:PrepareData()
	end
end

function GameMode:OnHeroSelectionStart()
	StatsClient:CalculateAverageRating()
	Teams:PostInitialize()
	Options:CalculateVotes()
	DynamicMinimap:Init()
	Spawner:PreloadSpawners()
	Bosses:InitAllBosses()
	CustomRunes:Init()
	CustomTalents:Init()
	Timers:CreateTimer(0.1, function()
		for playerId, data in pairs(PLAYER_DATA) do
			if PlayerResource:IsPlayerAbandoned(playerId) then
				PlayerResource:RemoveAllUnits(playerId)
			end
			if PlayerResource:IsBanned(playerId) then
				PlayerResource:KickPlayer(playerId)
			end
		end
	end)
end

function GameMode:OnHeroSelectionEnd()
	Timers:CreateTimer(CUSTOM_GOLD_TICK_TIME, Dynamic_Wrap(GameMode, "GameModeThink"))
	PanoramaShop:StartItemStocks()
	Duel:CreateGlobalTimer()
	Weather:Init()
	GameRules:GetGameModeEntity():SetPauseEnabled(Options:IsEquals("EnablePauses"))

	Timers:CreateTimer(10, function()
		for playerId = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
			if PlayerResource:IsValidPlayerID(playerId) and not PlayerResource:IsFakeClient(playerId) and GetConnectionState(playerId) == DOTA_CONNECTION_STATE_CONNECTED then
				local heroName = HeroSelection:GetSelectedHeroName(playerId) or ""
				if heroName == "" or heroName == FORCE_PICKED_HERO then
					GameMode:BreakGame("arena_end_screen_error_broken")
					return
				end
			end
		end
	end)
end

function GameMode:PrecacheUnitQueueed(name)
	if not table.includes(RANDOM_OMG_PRECACHED_HEROES, name) then
		if not IS_PRECACHE_PROCESS_RUNNING then
			IS_PRECACHE_PROCESS_RUNNING = true
			table.insert(RANDOM_OMG_PRECACHED_HEROES, name)
			PrecacheUnitByNameAsync(name, function()
				IS_PRECACHE_PROCESS_RUNNING = nil
			end)
		else
			Timers:CreateTimer(0.5, function()
				GameMode:PrecacheUnitQueueed(name)
			end)
		end
	end
end

local mapMin = Vector(-MAP_LENGTH, -MAP_LENGTH)
local mapClampMin = ExpandVector(mapMin, -MAP_BORDER)
local mapMax = Vector(MAP_LENGTH, MAP_LENGTH)
local mapClampMax = ExpandVector(mapMax, -MAP_BORDER)
function GameMode:GameModeThink()
	for i = 0, 23 do
		if PlayerResource:IsValidPlayerID(i) then
			local hero = PlayerResource:GetSelectedHeroEntity(i)
			if hero then
				MeepoFixes:ShareItems(hero)
				for _, v in ipairs(hero:GetFullName() == "npc_dota_hero_meepo" and MeepoFixes:FindMeepos(hero, true) or { hero }) do
					local position = v:GetAbsOrigin()
					if not IsInBox(position, mapMin, mapMax) then
						FindClearSpaceForUnit(v, VectorOnBoxPerimeter(position, mapClampMin, mapClampMax), true)
					end
				end
			end
			if GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
				local goldPerTick = 0

				local courier = Structures:GetCourier(i)
				if courier and courier:IsAlive() then
					goldPerTick = CUSTOM_GOLD_PER_TICK
				end

				if hero then
					if hero.talent_keys and hero.talent_keys.bonus_gold_per_minute then
						goldPerTick = goldPerTick + hero.talent_keys.bonus_gold_per_minute / 60 * CUSTOM_GOLD_TICK_TIME
					end
					if hero.talent_keys and hero.talent_keys.bonus_xp_per_minute then
						hero:AddExperience(hero.talent_keys.bonus_xp_per_minute / 60 * CUSTOM_GOLD_TICK_TIME, 0, false, false)
					end
				end

				Gold:AddGold(i, goldPerTick)
			end
			AntiAFK:Think(i)
		end
	end
	return CUSTOM_GOLD_TICK_TIME
end

function GameMode:SetupRules()
	GameRules:SetCustomGameSetupAutoLaunchDelay(IsInToolsMode() and 3 or 15)
	GameRules:LockCustomGameSetupTeamAssignment(false)
	GameRules:EnableCustomGameSetupAutoLaunch(true)
	GameRules:SetTreeRegrowTime(60)
	GameRules:SetUseCustomHeroXPValues(true)

	local gameMode = GameRules:GetGameModeEntity()
	gameMode:SetBuybackEnabled(false)
	gameMode:SetTopBarTeamValuesOverride(true)
	gameMode:SetUseCustomHeroLevels(true)
	gameMode:SetCustomXPRequiredToReachNextLevel(XP_PER_LEVEL_TABLE)
	gameMode:SetMaximumAttackSpeed(750)
	gameMode:SetMinimumAttackSpeed(60)
end

function GameMode:BreakGame(message)
	GameMode.Broken = message
	Tutorial:ForceGameStart()
	GameMode:OnOneTeamLeft(-1)
end

function GameMode:BreakSetup(message)
	GameRules:SetPostGameTime(0)
	GameRules:SetSafeToLeave(true)
	PlayerTables:CreateTable("stats_setup_error", message, AllPlayersInterval)
	Timers:CreateTimer(60, function() GameMode:BreakGame(true) end)
end
