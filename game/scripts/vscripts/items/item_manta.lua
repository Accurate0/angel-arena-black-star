function item_manta_arena_on_spell_start(keys)
	local caster = keys.caster
	local ability = keys.ability

	local manta_particle = ParticleManager:CreateParticle("particles/items2_fx/manta_phase.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	Timers:CreateTimer(keys.InvulnerabilityDuration, function() ParticleManager:DestroyParticle(manta_particle, false) end)
	caster:EmitSound("DOTA_Item.Manta.Activate")
	caster:Purge(false, true, false, false, false)
	ProjectileManager:ProjectileDodge(caster)
	if caster:IsHero() then
		ability:CreateVisibilityNode(caster:GetAbsOrigin(), keys.VisionRadius, keys.InvulnerabilityDuration)
		caster:AddNoDraw()
		ability:ApplyDataDrivenModifier(caster, caster, "modifier_item_manta_arena_invulnerability", nil)

		if caster.MantaIllusions then
			for _,v in ipairs(caster.MantaIllusions) do
				if v and not v:IsNull() and v:IsAlive() then
					v:ForceKill(false)
				end
			end
		end
	end
end

function modifier_item_manta_arena_invulnerability_on_destroy(keys)
	local caster = keys.caster
	local ability = keys.ability
	caster.MantaIllusions = Illusions:create({
		unit = caster,
		count = ability:GetSpecialValueFor("images_count"),
		padding = 100,
		scramblePosition = true,
		damageIncoming = ability:GetSpecialValueFor("illusion_damage_percent_incoming_tooltip"),
		damageOutgoing = ability:GetSpecialValueFor("illusion_damage_percent_outgoing_tooltip"),
		duration = ability:GetSpecialValueFor("illusion_duration"),
	})

	caster:RemoveNoDraw()
end
