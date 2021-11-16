LINKED_ABILITIES = {
	shredder_chakram_2 = {"shredder_return_chakram_2"},
	shredder_chakram = {"shredder_return_chakram"},
	kunkka_x_marks_the_spot = {"kunkka_return"},
	life_stealer_infest = {"life_stealer_control", "life_stealer_consume"},
	rubick_telekinesis = {"rubick_telekinesis_land"},
	bane_nightmare = {"bane_nightmare_end"},
	phoenix_icarus_dive = {"phoenix_icarus_dive_stop"},
	phoenix_fire_spirits = {"phoenix_launch_fire_spirit"},
	ancient_apparition_ice_blast = {"ancient_apparition_ice_blast_release"},
	wisp_tether = {"wisp_tether_break"},
	alchemist_unstable_concoction = {"alchemist_unstable_concoction_throw"},
	monkey_king_mischief = {"monkey_king_untransform"},
	monkey_king_primal_spring = {"monkey_king_primal_spring_early"},
	snapfire_gobble_up = {"snapfire_spit_creep"},
}

ABILITY_SHOP_BANNED = {
	["obsidian_destroyer_essence_aura"] = { "nevermore_shadowraze3", "nevermore_shadowraze2", "nevermore_shadowraze1", "tinker_rearm_arena", "rocket_barrage_arena", "storm_spirit_ball_lightning", "bristleback_quill_spray", "pugna_life_drain", "shredder_chakram_2", "shredder_return_chakram_2", "shredder_chakram", "shredder_return_chakram", "techies_focused_detonate", "spectre_reality", "oracle_purifying_flames", "templar_assassin_trap", "skywrath_mage_arcane_bolt", "shadow_demon_shadow_poison_release", "nyx_assassin_unburrow", "nyx_assassin_burrow", "shadow_demon_shadow_poison", "saber_mana_burst", },
	["batrider_sticky_napalm"] = { "nevermore_shadowraze3", "nevermore_shadowraze2", "nevermore_shadowraze1", "rocket_barrage_arena", "sandking_sand_storm", "shadow_shaman_shackles", "doom_bringer_scorched_earth", "venomancer_venomous_gale", "venomancer_poison_nova", "ember_spirit_flame_guard", "weaver_the_swarm", "dark_seer_ion_shell", "spectre_dispersion", "shadow_demon_shadow_poison", },
	["earthshaker_aftershock"] = { "nevermore_shadowraze3", "nevermore_shadowraze2", "nevermore_shadowraze1", "monkey_king_mischief", "tinker_rearm_arena", "rocket_barrage_arena", "obsidian_destroyer_arcane_orb", "storm_spirit_ball_lightning", "pugna_life_drain", "shredder_chakram_2", "shredder_return_chakram_2", "shredder_chakram", "shredder_return_chakram", "techies_focused_detonate", "spectre_reality", "oracle_purifying_flames", "templar_assassin_trap", "skywrath_mage_arcane_bolt", "zuus_arc_lightning", "shadow_demon_shadow_poison_release", "nyx_assassin_unburrow", "nyx_assassin_burrow", "bristleback_quill_spray", "bristleback_viscous_nasal_goo", "shadow_demon_shadow_poison", "jakiro_dual_breath", "saber_mana_burst", },
	["zuus_static_field"] = { "nevermore_shadowraze3", "nevermore_shadowraze2", "nevermore_shadowraze1", "monkey_king_mischief", "tinker_rearm_arena", "rocket_barrage_arena", "storm_spirit_ball_lightning", "bristleback_quill_spray", "pugna_life_drain", "bristleback_viscous_nasal_goo", "shredder_chakram_2", "shredder_return_chakram_2", "shredder_chakram", "shredder_return_chakram", "techies_focused_detonate", "spectre_reality", "oracle_purifying_flames", "templar_assassin_trap", "skywrath_mage_arcane_bolt", "shadow_demon_shadow_poison_release", "nyx_assassin_unburrow", "nyx_assassin_burrow", "shadow_demon_shadow_poison", "jakiro_dual_breath", "saber_mana_burst", },
	["storm_spirit_overload"] = { "troll_warlord_berserkers_rage", "wisp_spirits_out", "wisp_spirits_in", "wisp_overcharge", "rocket_barrage_arena", "cherub_synthesis", "pudge_rot_arena", "pudge_rot", "skeleton_king_vampiric_aura", "witch_doctor_voodoo_restoration", "leshrac_pulse_nova", "wisp_overcharge", "pugna_life_drain", "shredder_chakram_2", "shredder_return_chakram_2", "shredder_chakram", "shredder_return_chakram", "techies_focused_detonate", "spectre_reality", "oracle_purifying_flames", "templar_assassin_trap", "skywrath_mage_arcane_bolt", "shadow_demon_shadow_poison_release", "nyx_assassin_unburrow", "nyx_assassin_burrow", "bristleback_viscous_nasal_goo", "shadow_demon_shadow_poison", "jakiro_dual_breath", "saber_mana_burst", },
	["pudge_meat_hook_lua"] = { "rocket_barrage_arena", "furion_teleportation", "kunkka_x_marks_the_spot", "ogre_magi_multicast_arena",  "bloodseeker_thirst", "antimage_blink", "queenofpain_blink", },
	["tusk_walrus_punch"] = { "tiny_grow", "earthshaker_enchant_totem", "drow_ranger_marksmanship", },
	["bounty_hunter_jinada"] = { "tiny_grow", "earthshaker_enchant_totem", "drow_ranger_marksmanship", },
	["obsidian_destroyer_arcane_orb"] = { "earthshaker_aftershock", "zuus_static_field", "obsidian_destroyer_essence_aura", },
	["lina_fiery_soul"] = { "spectre_reality", "templar_assassin_trap", "shadow_demon_shadow_poison_release", "techies_focused_detonate" },
}

ABILITY_SHOP_BANNED_GROUPS = {
	{
		"troll_warlord_berserkers_rage",
		"slardar_bash",
		"spirit_breaker_greater_bash",
		"faceless_void_time_lock",
	},
	{
		"antimage_blink",
		"queenofpain_blink"
	}
}

ABILITY_SHOP_DATA = {
	["puck_ethereal_jaunt"] = { cost = 0, },
	["shadow_demon_shadow_poison_release"] = { cost = 0, },
	["spectre_reality"] = { cost = 0, },
	["templar_assassin_trap"] = { cost = 0, },
	["techies_focused_detonate"] = { cost = 0, },

	["tinker_rearm_arena"] = { cost = 16, },
	["ogre_magi_multicast_arena"] = { cost = 10, },
	["alchemist_goblins_greed"] = { cost = 6, },
	["kunkka_tidebringer"] = { cost = 3, },
	["earthshaker_enchant_totem"] = { cost = 2, },
	["slark_essence_shift"] = { cost = 2, },
	["sven_great_cleave"] = { cost = 4, },
	["axe_counter_helix"] = { cost = 2, },
	["sandking_caustic_finale"] = { cost = 2, },
	["beastmaster_wild_axes"] = { cost = 2, },
	["weaver_geminate_attack"] = { cost = 5, },
	["riki_permanent_invisibility"] = { cost = 2, },
	["shinobu_vampire_blood"] = { cost = 7, },
	["ember_spirit_sleight_of_fist"] = { cost = 8, },
	["flak_cannon_arena"] = { cost = 4, },
	["dark_seer_ion_shell"] = { cost = 5, },
	["spectre_dispersion"] = { cost = 3, },
	["rocket_barrage_arena"] = { cost = 2, },
	["keeper_of_the_light_illuminate"] = { cost = 2, },
	["magnataur_empower"] = { cost = 2, },
	["ursa_fury_swipes"] = { cost = 2, },
	["razor_plasma_field"] = { cost = 5, },
	["doom_bringer_devour"] = { cost = 3, },
	["techies_suicide"] = { cost = 6, },
	["zen_gehraz_mystic_twister"] = { cost = 3, },
	["abyssal_underlord_firestorm"] = { cost = 2, },
	["disruptor_thunder_strike"] = { cost = 4 },
	["mirratie_impaling_shot"] = { cost = 12, },
	["venomancer_venomous_gale"] = { cost = 2, },
	["techies_land_mines"] = { cost = 2, },
	["bloodseeker_bloodrage"] = { cost = 2, },
	["tiny_avalanche"] = { cost = 2, },
	["tiny_toss"] = { cost = 2, },
	["tiny_craggy_exterior"] = { cost = 2, },
	["vengefulspirit_command_aura"] = { cost = 2, },
	["luna_lunar_blessing"] = { cost = 2, },
	["luna_moon_glaive"] = { cost = 2, },
	["terrorblade_metamorphosis"] = { cost = 2, },
	["apocalypse_agnis_touch"] = { cost = 4, },
	["templar_assassin_psi_blades"] = { cost = 2, },
	["cherub_flower_garden"] = { cost = 4, },
	["weaver_the_swarm"] = { cost = 2, },
	["sven_storm_bolt"] = { cost = 2, },
	["kadash_immortality"] = { cost = 15, },
	["elder_titan_natural_order"] = { cost = 3, },
	["zen_gehraz_divine_intervention"] = { cost = 3, },
	["bristleback_quill_spray"] = { cost = 2, },
	["batrider_sticky_napalm"] = { cost = 4, },
	["sandking_sand_storm"] = { cost = 2, },
	["sniper_shrapnel"] = { cost = 3, },
	["zuus_thundergods_wrath"] = { cost = 6, },
	["kadash_survival_skills"] = { cost = 2, },
	["stegius_brightness_of_desolate"] = { cost = 3, },
	["queenofblades_army"] = { cost = 3, },
	["viper_corrosive_skin"] = { cost = 2, },
	["sniper_assassinate"] = { cost = 6, },
	["sniper_take_aim"] = { cost = 9, },
	["kunkka_ghostship"] = { cost = 7, },
	["kunkka_torrent"] = { cost = 4, },
	["nevermore_dark_lord"] = { cost = 2, },
	["chaos_knight_chaos_strike"] = { cost = 4, },
	["undying_decay"] = { cost = 2, },
	["monkey_king_mischief"] = { cost = 2, },
	["nevermore_shadowraze1"] = { cost = 2, },
	["nevermore_shadowraze2"] = { cost = 2, },
	["nevermore_shadowraze3"] = { cost = 2, },
	["freya_strike_the_ice"] = { cost = 16, },
	["freya_ice_cage"] = { cost = 20, },
	["freya_pain_reflection"] = { cost = 24, },
	["freya_frozen_strike"] = { cost = 26, },
	["shinobu_yumewatari_lua"] = { cost = 9, },
	["arthas_plus_morality"] = { cost = 6, },
	["saber_mana_burst"] = { cost = 4, },
	["saber_avalon"] = { cost = 5, },
	["saber_excalibur"] = { cost = 12, },
	["saitama_push_ups"] = { cost = 3, },
	["saitama_sit_ups"] = { cost = 3, },
	["saitama_squats"] = { cost = 3, },
	["saitama_jogging"] = { cost = 3, },
	["destroyer_body_reconstruction"] = { cost = 12, },
}

ABILITY_SHOP_SKIP_HEROES = {
	npc_dota_hero_base = true,
	npc_dota_hero_invoker = true,
	npc_dota_hero_earth_spirit = true,
	npc_dota_hero_rubick = true,
	npc_dota_hero_arena_base = true,
	npc_arena_hero_sara = true,
	npc_arena_hero_doppelganger = true,
	npc_dota_hero_phantom_lancer = true,
	npc_arena_hero_zaken = true,
}

ABILITY_SHOP_SKIP_ABILITIES = {
	"broodmother_spin_web",
	"morphling_morph_agi",
	"morphling_morph_str",
	"morphling_replicate",
	"keeper_of_the_light_recall",
	"keeper_of_the_light_blinding_light",
	"doom_bringer_empty1",
	"doom_bringer_empty2",
	"phoenix_sun_ray",
	"ogre_magi_unrefined_fireblast",
	"keeper_of_the_light_spirit_form",
	"mirratie_sixth_sense",
	"wisp_spirits_in",
	"wisp_spirits_out",
	"meepo_divided_we_stand",
	"saitama_limiter",
	"sai_release_of_forge",
	"spectre_dispersion",
}
