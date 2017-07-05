LinkLuaModifier("modifier_sai_divine_flesh_on", "heroes/hero_sai/divine_flesh.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_sai_divine_flesh_off", "heroes/hero_sai/divine_flesh.lua", LUA_MODIFIER_MOTION_NONE)

sai_divine_flesh = class({
	GetIntrinsicModifierName = function() return "modifier_sai_divine_flesh_off" end,
})

if IsServer() then
	function sai_divine_flesh:OnToggle()
		local caster = self:GetCaster()
		if self:GetToggleState() then
			caster:RemoveModifierByName("modifier_sai_divine_flesh_off")
			caster:AddNewModifier(caster, self, "modifier_sai_divine_flesh_on", nil)
		else
			caster:RemoveModifierByName("modifier_sai_divine_flesh_on")
			caster:AddNewModifier(caster, self, "modifier_sai_divine_flesh_off", nil)
		end
	end
end

modifier_sai_divine_flesh_on = class({
	GetEffectName = function() return "particles/arena/units/heroes/hero_sai/divine_flesh.vpcf" end,
})
function modifier_sai_divine_flesh_on:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
	}
end

function modifier_sai_divine_flesh_on:GetModifierPhysicalArmorBonus()
	return self:GetAbility():GetSpecialValueFor("active_bonus_armor")
end

function modifier_sai_divine_flesh_on:GetModifierMagicalResistanceBonus()
	return self:GetAbility():GetSpecialValueFor("active_magic_resistance_pct")
end

if IsServer() then
	function modifier_sai_divine_flesh_on:OnCreated()
		self:StartIntervalThink(self:GetAbility():GetSpecialValueFor("think_interval"))
		self:OnIntervalThink()
	end

	function modifier_sai_divine_flesh_on:OnIntervalThink()
		local ability = self:GetAbility()
		local parent = self:GetParent()
		local damage = parent:GetMaxHealth() * ability:GetSpecialValueFor("active_self_damage_pct") * 0.01 * ability:GetSpecialValueFor("think_interval")
		--[[
		local sai_invulnerability = parent:FindAbilityByName("sai_invulnerability")
		if sai_invulnerability and sai_invulnerability:GetToggleState() then
			damage = damage * (1 + sai_invulnerability:GetSpecialValueFor("incoming_damage_reduction_pct") * 0.01)
		end
		]]
		ApplyDamage({
			victim = parent,
			attacker = parent,
			damage = damage,
			damage_type = DAMAGE_TYPE_PURE,
			damage_flags = DOTA_DAMAGE_FLAG_NO_DAMAGE_MULTIPLIERS + DOTA_DAMAGE_FLAG_HPLOSS,
			ability = ability
		})
	end
end


modifier_sai_divine_flesh_off = class({
	IsHidden = function() return true end,
})

function modifier_sai_divine_flesh_off:DeclareFunctions()
	return {MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE}
end

function modifier_sai_divine_flesh_off:GetModifierHealthRegenPercentage()
	local ability = self:GetAbility()
	local parent = self:GetParent()
	local sai_invulnerability = parent:FindAbilityByName("sai_invulnerability")
	return sai_invulnerability and sai_invulnerability:GetToggleState() and ability:GetSpecialValueFor("health_regeneration_pct") * sai_invulnerability:GetSpecialValueFor("divine_flesh_regen_mult") or ability:GetSpecialValueFor("health_regeneration_pct")
end
