function CheckDeath(keys)
	local caster = keys.caster
	local ability = keys.ability
	local target = keys.unit or keys.caster
	if target:GetHealth() > 1 or target.is_reincarnating or target:IsIllusion() or target:HasModifier("modifier_skeleton_king_reincarnation_cooldown") or target:IsIllusion() then
		target:RemoveModifierByName("modifier_skeleton_king_reincarnation_life_saver")
		return
	end
	if target == caster then
		if PreformAbilityPrecastActions(caster, ability) then
			ability:ApplyDataDrivenModifier(caster, target, "modifier_skeleton_king_reincarnation_life_saver", {})
			caster:SetHealth(1)
			ability:ApplyDataDrivenModifier(caster, target, "modifier_skeleton_king_reincarnation_reincarnation", {})
		else
			target:RemoveModifierByName("modifier_skeleton_king_reincarnation_life_saver")
		end
	else
		ability:ApplyDataDrivenModifier(caster, target, "modifier_skeleton_king_reincarnation_reincarnation", {})
	end
	if keys.aftercast_modifier then
		ability:ApplyDataDrivenModifier(caster, target, keys.aftercast_modifier, {})
	end
end

function OnModCreated(keys)
	local target = keys.target
	local ability = keys.ability
	local slow_radius = ability:GetLevelSpecialValueFor("slow_radius", ability:GetLevel() - 1)

	target:AddNoDraw()
	target.is_reincarnating = true
	if not ability.pfx_reincarnation_respawn_timer then ability.pfx_reincarnation_respawn_timer = {} end
	ability.pfx_reincarnation_respawn_timer[target:GetEntityIndex()] = ParticleManager:CreateParticle("particles/units/heroes/hero_skeletonking/wraith_king_reincarnate.vpcf", PATTACH_ABSORIGIN, target)
	ParticleManager:SetParticleControl(ability.pfx_reincarnation_respawn_timer[target:GetEntityIndex()], 0, target:GetAbsOrigin())
	ParticleManager:SetParticleControl(ability.pfx_reincarnation_respawn_timer[target:GetEntityIndex()], 1, Vector(slow_radius, 0, 0))
	ability:CreateVisibilityNode(target:GetAbsOrigin(), keys.vision_radius, keys.Duration)
	target:EmitSound("Hero_SkeletonKing.Reincarnate")
	target:EmitSound("Hero_SkeletonKing.Death")
	local model = "models/props_gameplay/tombstoneb01.vmdl"
	local grave = Entities:CreateByClassname("prop_dynamic")
	grave:SetModel(model)
	grave:SetAbsOrigin(target:GetAbsOrigin())
	if not ability.npc_reincarnation_tombstone then ability.npc_reincarnation_tombstone = {} end
	ability.npc_reincarnation_tombstone[target:GetEntityIndex()] = grave
	local particle1 = ParticleManager:CreateParticle( "particles/units/heroes/hero_skeletonking/skeleton_king_death_bits.vpcf", PATTACH_ABSORIGIN, target )
	ParticleManager:SetParticleControl(particle1, 0, target:GetAbsOrigin())
	local particle2 = ParticleManager:CreateParticle( "particles/units/heroes/hero_skeletonking/skeleton_king_death_dust.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControl(particle2, 0, target:GetAbsOrigin())
	local particle3 = ParticleManager:CreateParticle( "particles/units/heroes/hero_skeletonking/skeleton_king_death_dust_reincarnate.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControl(particle3, 0, target:GetAbsOrigin())
	target:Purge(false, true, false, true, false)
end

function OnModDestroy(keys)
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local slow_radius = ability:GetLevelSpecialValueFor("slow_radius", ability:GetLevel() - 1)

	target:EmitSound("Hero_SkeletonKing.Reincarnate.Stinger")
	target.is_reincarnating = false
	target:RemoveNoDraw()
	target:SetHealth(target:GetMaxHealth())
	target:SetMana(target:GetMaxMana())
	target:Purge(false, true, false, true, false)
	ParticleManager:DestroyParticle(ability.pfx_reincarnation_respawn_timer[target:GetEntityIndex()], false)
	ability.npc_reincarnation_tombstone[target:GetEntityIndex()]:RemoveSelf()

	local enemies = FindUnitsInRadius(caster:GetTeamNumber(), target:GetAbsOrigin(), nil, ability:GetLevelSpecialValueFor("slow_radius", ability:GetLevel() - 1), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
		
	for _,unit in pairs(enemies) do
		ability:ApplyDataDrivenModifier(caster, unit, "modifier_skeleton_king_reincarnation_slow", nil)
	end
end

function ThinkScepter(keys)
	local caster = keys.caster
	local ability = keys.ability
	local modifier = "modifier_skeleton_king_reincarnation_aura"
	if HasScepter(caster) and not caster:HasModifier(modifier) then
		ability:ApplyDataDrivenModifier(caster, caster, modifier, {})
	elseif not HasScepter(caster) and caster:HasModifier(modifier) then
		caster:RemoveModifierByName(modifier)
	end
end

function CheckAllyForCdModifier(keys)
	local caster = keys.caster
	local ability = keys.ability
	local target = keys.target
	if not target:HasModifier("modifier_skeleton_king_reincarnation_cooldown") and not target:HasModifier("modifier_skeleton_king_reincarnation_ally") then
		ability:ApplyDataDrivenModifier(caster, target, "modifier_skeleton_king_reincarnation_ally", {})
	elseif target:HasModifier("modifier_skeleton_king_reincarnation_cooldown") and target:HasModifier("modifier_skeleton_king_reincarnation_ally") then
		target:RemoveModifierByName("modifier_skeleton_king_reincarnation_ally")
	end
end