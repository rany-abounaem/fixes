local combats = {}

-- define combat areas for the spell
local areas = {
    -- Area 1
    {{0, 0, 0, 0, 0, 0, 0},
	 {0, 0, 0, 0, 0, 0, 0},
     {0, 1, 0, 0, 0, 0, 0},
     {1, 0, 0, 2, 0, 0, 1},
     {0, 1, 0, 0, 0, 0, 0},
     {0, 0, 1, 0, 0, 0, 0},
     {0, 0, 0, 1, 0, 0, 0}},

	 -- Area 2
	 {{0, 0, 0, 0, 0, 0, 0},
	 {0, 0, 1, 0, 1, 0, 0},
     {0, 0, 0, 0, 0, 1, 0},
     {0, 0, 0, 2, 0, 0, 0},
     {0, 0, 0, 1, 0, 1, 0},
     {0, 0, 0, 0, 0, 0, 0},
     {0, 0, 0, 0, 0, 0, 0}},

	 -- Area 3
	 {{0, 0, 0, 0, 0, 0, 0},
	 {0, 0, 0, 0, 0, 0, 0},
     {0, 0, 0, 0, 0, 0, 0},
     {0, 0, 1, 2, 1, 0, 0},
     {0, 0, 0, 0, 0, 0, 0},
     {0, 0, 0, 0, 1, 0, 0},
     {0, 0, 0, 0, 0, 0, 0}},

	  -- Area 4
	  {{0, 0, 0, 1, 0, 0, 0},
	  {0, 0, 0, 0, 0, 0, 0},
	  {0, 0, 0, 1, 0, 0, 0},
	  {0, 0, 0, 2, 0, 0, 0},
	  {0, 0, 0, 0, 0, 0, 0},
	  {0, 0, 0, 0, 0, 0, 0},
	  {0, 0, 0, 0, 0, 0, 0}},

}

-- loop with areas count and for each area, create combat and set its parameters up
for i = 1, #areas do
	combats[i] = Combat()
	combats[i]:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
	combats[i]:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)
	combats[i]:setArea(createCombatArea(areas[i]))
	function onGetFormulaValues(player, level, magicLevel)
		local min = (level / 5) + (magicLevel * 8) + 50
		local max = (level / 5) + (magicLevel * 12) + 75
		return -min, -max
	end
    -- attach the previous function as callback
	combats[i]:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")
end

local function castSpell(creatureId, variant, combatIndex)
    -- check if creature is still alive/connected
    local creature = Creature(creatureId)
    if creature then
        combats[combatIndex]:execute(creature, variant)
    end
end

function onCastSpell(creature, variant)
    -- schedule all areas after first one
	for i = 2, #areas do
		addEvent(castSpell, 200 * i, creature:getId(), variant, i)
	end

    -- from the videos breakdown, it is most probable there is are 4 areas that repeat 3 times
    -- this is the closest I could get to the original video :)
	for j = 1, 2 do
		for i = 1, #areas do
			addEvent(castSpell, 200 * (i + (j * #areas)), creature:getId(), variant, i)
		end
	end
    return combats[1]:execute(creature, variant)
end
