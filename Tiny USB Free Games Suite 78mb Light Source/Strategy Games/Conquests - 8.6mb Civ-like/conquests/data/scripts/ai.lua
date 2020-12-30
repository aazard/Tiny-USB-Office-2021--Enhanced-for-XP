-- internal constants used by this file

DECISION_UNDECIDED = -1
DECISION_BUILDCITY = 0
DECISION_WORK = 1
DECISION_ATTACKCITY = 2
DECISION_ATTACKUNITS = 3
DECISION_CONTACT = 4
DECISION_EXPLORE = 5
DECISION_CITY = 6

local ignore_dist_c = 16

function ASSERT( test, text )
	if test == false then
		conquests_log("ASSERTION FAILED: " .. text)
		error("ASSERTION FAILED: " .. text)
	end
end

function getDist( dists, width, x, y )
	--local dist = dists[y*width+x+1] -- +1 as Lua arrays start at 1!
	local dist = conquests_getDistanceCost(dists, width, x, y)
	return dist
end

function chooseBuildPopLimits( ai_city )
	-- need improvements for city growth?
	local year = conquests_getYear()
	if year <= 50 then
		-- prefer to focus on Settlers
		return NULL
	end
	local size = conquests_cityGetPublicInfo(ai_city)
	if size >= 3 then
		local buildable_farmland = conquests_findBuildable("Farmland")
		if conquests_cityCanBuild(ai_city, buildable_farmland) then
			return buildable_farmland
		end
	end
	if size >= 6 then
		local buildable_aqueduct = conquests_findBuildable("Aqueduct")
		if conquests_cityCanBuild(ai_city, buildable_aqueduct) then
			return buildable_aqueduct
		end
	end
	return NULL
end

function needDefenders( is_city_build, ai_city, this_unit, min_defence, candidate_defensiveUnit )
	-- If is_city_build is true, it means we're considering whether to build a new defender; otherwise, it means we're considering whether to keep a defensive unit here.
	-- We should make sure that if this function returns true when city_build is true, it must also return true when city_build is false, otherwise we'll have problem of continually building defensive units, that then move away!
	-- (The other way round is fine; it means that we'll take advantage of any extra defensive units, but won't necessarily worry about building them.)
	local n_defenders = 0
	local undefended = true
	local city_xpos, city_ypos = conquests_cityGetPos(ai_city)
	local size = conquests_cityGetPublicInfo(ai_city)
	local is_capital = conquests_cityGetInfo(ai_city)
	local units = conquests_getUnitsAt(city_xpos, city_ypos)
	for i=1, #units do
		local unit = units[i]
		local unit_template = conquests_unitGetTemplate(unit)
		local unit_can_upgrade_to = conquests_unitCanUpgrade(unit)
		if unit_can_upgrade_to ~= NULL then
			-- if the unit is able to upgrade, we're more interested in the upgraded version (e.g., if a city has 2 Riflemen which can upgrade to Musketmen, there's no point building new Musketmen)
			-- even if the city doesn't have enough elements to upgrade both, it's still better to wait for the units to upgrade, rather than building a new one
			--[[
			local old_unit_name = conquests_unittemplateGetName(unit_template)
			local new_unit_name = conquests_unittemplateGetName(unit_can_upgrade_to)
			print("City of " .. conquests_cityGetName(ai_city) .. ": count " .. old_unit_name .. " as " .. new_unit_name)
			--]]
			unit_template = unit_can_upgrade_to
		end
		local attack, defence, moves, cost = conquests_unittemplateStats(unit_template)
		--print(i, ": ", attack, defence)
		local ok = true
		if unit == this_unit then
			ok = false
		elseif this_unit ~= NULL then
			local this_unit_template = conquests_unitGetTemplate(this_unit)
			local this_attack, this_defence, this_moves, this_cost = conquests_unittemplateStats(this_unit_template)
			--print("this: ", this_attack, this_defence)
			if defence < this_defence then
				-- ignore units not as good as this_unit, so that we prefer to keep stronger units defending the city
 				ok = false
			elseif defence == this_defence and attack > this_attack then
				-- for units of equal defence, prefer to keep the units of weaker attack - so the stronger attack units can be used to leave the city
				ok = false
			end
		end
		if ok then
			if attack > 0 and defence > 0 then
				undefended = false
				-- setting min_defence allows us to only look at defenders of a certain defence when counting (however, we still set the 'undefended' flag)
				--print("defence: ", defence)
				--print("min_defence: ", min_defence)
				if defence >= min_defence then
					n_defenders = n_defenders + 1
				end
			end
		end
	end

	local min_defenders = 0
	if size <= 2 then
		min_defenders = 1
	elseif this_unit == NULL and min_defence == 1 then
		min_defenders = 1 -- if we can only build Peasants, better to wait until we have better units
	else
		min_defenders = 2
		if ( size >= 6 and is_capital ) or size >= 8 then
			local need_extra = true
			if is_city_build == true and candidate_defensiveUnit ~= NULL then
				local attack, defence, moves, cost = conquests_unittemplateStats(candidate_defensiveUnit)
				local is_capital, production, science = conquests_cityGetInfo(ai_city)
				if production == 0 then
					need_extra = false
				else
					local n_turns = cost / production
					-- Whilst having extra defender when at war is useful, we don't want the city to spend ages building it.
					-- This check only applies when is_city_build is true; for units, we'll happily keep a 3rd unit, since it's already there.
					if n_turns > 8 then
						need_extra = false
					end
				end
			end
			if need_extra then
				local is_war = false
				local civilizations = conquests_getCivilizations(GETCIVILIZATIONS_WAR)
				--[[ This will also return the rebel civilization if any units exist. Whilst theoretically a bit odd that we'll therefore
					build more defensive units even if there's just one the other side of the globe, this is arguably no worse than doing
					so, because a civilization the other side of the globe declared war on the AI.
				--]]
				if #civilizations > 0 then
					is_war = true
				end
				if is_war then
					-- a capital medium sized city, or large city; and we're at war!
					min_defenders = 3
				end
			end
		end
	end

	--[[
	print("min_defence: ", min_defence)
	print("min_defenders: ", min_defenders)
	print("n_defenders: ", n_defenders)
	--]]

	local result = false
	if n_defenders < min_defenders then
		result = true
	end
	return result, undefended
end

function chooseImprovementAI( ai_city )
	local max_value = 0
	local candidates = {}
	local improvements = conquests_cityGetBuildables(ai_city, GETBUILDABLES_IMPROVEMENTS)
	for i=1, #improvements do
		local improvement = improvements[i]
		local ai_weight, ai_hint = conquests_improvementGetInfo(improvement)
		local r = math.random(20) - 1
		local this_value = ai_weight + r
		if this_value > 0 and ai_hint == IMPROVEMENT_AIHINT_RESEARCH then
			if conquests_haveAllTechnology() then
				this_value = 0
			end
		end
		if this_value > 0 and ai_hint == IMPROVEMENT_AIHINT_FOW then
			-- Satellites technology elimates fog of war anyway
			if conquests_haveTechnology("Satellites") then
				this_value = 0
			end
		end
		if this_value > 0 then
			if this_value > max_value then
				candidates = {}
				table.insert(candidates, improvement)
				max_value = this_value
			elseif this_value == max_value then
				table.insert(candidates, improvement)
			end
		end
	end
	if #candidates > 0 then
		local r = math.random( #candidates )
		local improvement = candidates[r]
		return improvement
	end
	return NULL
end

function chooseAirUnitAI( ai_city, bestFighterAirUnit, bestBomberAirUnit, bestConventionalMissileUnit, bestNuclearMissileUnit, war_only )
	local choices = {}
	if bestFighterAirUnit ~= NULL then
		table.insert(choices, bestFighterAirUnit)
	end
	if bestBomberAirUnit ~= NULL then
		table.insert(choices, bestBomberAirUnit)
	end
	if bestConventionalMissileUnit ~= NULL then
		table.insert(choices, bestConventionalMissileUnit)
	end
	if bestNuclearMissileUnit ~= NULL then
		table.insert(choices, bestNuclearMissileUnit)
	end
	if #choices == 0 then
		conquests_log("Didn't expect zero choices for air units")
		error("Didn't expect zero choices for air units")
	end
	local r = math.random( #choices )
	local unit_template = choices[r]
	--[[
	conquests_log("ping")
	if bestFighterAirUnit ~= NULL then
		local unit_name = conquests_buildableGetInfo(bestFighterAirUnit)
		conquests_log("bestFighterAirUnit: " .. unit_name)
		end
	if bestBomberAirUnit ~= NULL then
		local unit_name = conquests_buildableGetInfo(bestBomberAirUnit)
		conquests_log("bestBomberAirUnit: " .. unit_name)
		end
	if bestConventionalMissileUnit ~= NULL then
		local unit_name = conquests_buildableGetInfo(bestConventionalMissileUnit)
		conquests_log("bestConventionalMissileUnit: " .. unit_name)
		end
	if bestNuclearMissileUnit ~= NULL then
		local unit_name = conquests_buildableGetInfo(bestNuclearMissileUnit)
		conquests_log("bestNuclearMissileUnit: " .. unit_name)
		end
	conquests_log("r = " .. r)
	local unit_name = conquests_buildableGetInfo(unit_template)
	conquests_log(unit_name)
	--]]
	if unit_template == bestFighterAirUnit then
		-- defensive unit, so don't need to see if any cities to attack
		conquests_log("build a defensive air unit")
		return unit_template
	end
	local getcivilizations_type = GETCIVILIZATIONS_ALL;
	if war_only then
		getcivilizations_type = GETCIVILIZATIONS_WAR
	end
	--local city_xpos, city_ypos = conquests_cityGetPos(ai_city)
	-- This will return the rebel civ too (if any units), but we only care about cities anyway.
	local civilizations = conquests_getCivilizations(getcivilizations_type)
	for i=1, #civilizations do
		local civilization = civilizations[i]
		-- bomb cities?
		local cities = conquests_getCities(civilization)
		for i=1, #cities do
			local city = cities[i]
			local xpos, ypos = conquests_cityGetPos(city)
			local can_bomb = conquests_canBomb(unit_template, city, xpos, ypos, true)
			if can_bomb then
				conquests_log(conquests_cityGetName(ai_city) .. ": " .. conquests_cityGetName(city) .. " is within range");
				return unit_template
			end
		end
	end
	return NULL
end

-- Function that must be implemented; called when the city needs to choose a new buildable to build
-- receives: pointer to the city
-- returns: pointer to a buildable
function chooseBuild( ai_city )
	local name = conquests_cityGetName(ai_city)

	local ai_civilization = conquests_cityGetCivilization(ai_city)
	local city_xpos, city_ypos = conquests_cityGetPos(ai_city)
	local size = conquests_cityGetPublicInfo(ai_city)
	local is_capital, production, science = conquests_cityGetInfo(ai_city)
	local unit_templates = conquests_cityGetBuildables(ai_city, GETBUILDABLES_UNITS)
	local bestUnit = NULL
	local defensiveUnit = NULL
	local fastestUnit = NULL
	local cheapestUnit = NULL
	local bestFighterAirUnit = NULL
	local bestBomberAirUnit = NULL
	local bestConventionalMissileUnit = NULL
	local bestNuclearMissileUnit = NULL
	local bestSeaUnit = NULL
	local settlersUnit = NULL
	local workerUnit = NULL
	for i=1, #unit_templates do
		local unit_template = unit_templates[i]
		--print("    ", i, " : ", conquests_buildableGetInfo(unit_template))
		local is_foot, is_air, is_missile, is_sea = conquests_unittemplateType(unit_template)
		if is_air == false and is_sea == false then
			local attack, defence, moves, cost = conquests_unittemplateStats(unit_template)
			local can_build_roads, can_build_city = conquests_unittemplateAbility(unit_template)

			local bestUnit_attack, bestUnit_defence, bestUnit_moves, bestUnit_cost = 0, 0, 0, 0
			local defensiveUnit_attack, defensiveUnit_defence, defensiveUnit_moves, defensiveUnit_cost = 0, 0, 0, 0
			local fastestUnit_attack, fastestUnit_defence, fastestUnit_moves, fastestUnit_cost = 0, 0, 0, 0
			local cheapestUnit_attack, cheapestUnit_defence, cheapestUnit_moves, cheapestUnit_cost = 0, 0, 0, 0
			local workerUnit_attack, workerUnit_defence, workerUnit_moves, workerUnit_cost = 0, 0, 0, 0
			if bestUnit ~= NULL then
				bestUnit_attack, bestUnit_defence, bestUnit_moves, bestUnit_cost = conquests_unittemplateStats(bestUnit)
			end
			if defensiveUnit ~= NULL then
				defensiveUnit_attack, defensiveUnit_defence, defensiveUnit_moves, defensiveUnit_cost = conquests_unittemplateStats(defensiveUnit)
			end
			if fastestUnit ~= NULL then
				fastestUnit_attack, fastestUnit_defence, fastestUnit_moves, fastestUnit_cost = conquests_unittemplateStats(fastestUnit)
			end
			if cheapestUnit ~= NULL then
				cheapestUnit_attack, cheapestUnit_defence, cheapestUnit_moves, cheapestUnit_cost = conquests_unittemplateStats(cheapestUnit)
			end
			if workerUnit ~= NULL then
				workerUnit_attack, workerUnit_defence, workerUnit_moves, workerUnit_cost = conquests_unittemplateStats(workerUnit)
			end

			if bestUnit == NULL or attack > bestUnit_attack or
				( attack == bestUnit_attack and cost < bestUnit_cost )
				then
				bestUnit = unit_template
			end
			if defensiveUnit == NULL or defence > defensiveUnit_defence or
				( defence == defensiveUnit_defence and cost < defensiveUnit_cost )
				then
				defensiveUnit = unit_template
			end
			if fastestUnit == NULL or moves > fastestUnit_moves or
				( moves == fastestUnit_moves and cost < fastestUnit_cost )
				then
				fastestUnit = unit_template
			end
			if cheapestUnit == NULL or cost < cheapestUnit_cost or
				( cost == cheapestUnit_cost and attack > cheapestUnit_attack )
				then
				cheapestUnit = unit_template
			end
			if can_build_city then
				if settlersUnit ~= NULL then
					conquests_log("Didn't expect more than one unit that can build cities!")
					error("Didn't expect more than one unit that can build cities!")
				end
				settlersUnit = unit_template
			end
			if can_build_roads then
				if workerUnit == NULL or cost < workerUnit_cost or
					( cost == workerUnit_cost and defence < workerUnit_defence )
					then
					workerUnit = unit_template
				end
			end
		end
		if is_air and is_missile == false then
			local air_attack, air_defence, bombard_power, bombard, air_range, nucleartype = conquests_unittemplateAirStats(unit_template)

			local bestFighterAirUnit_air_attack, bestFighterAirUnit_air_defence, bestFighterAirUnit_bombard_power, bestFighterAirUnit_bombard = 0, 0, 0, 0
			local bestBomberAirUnit_air_attack, bestBomberAirUnit_air_defence, bestBomberAirUnit_bombard_power, bestBomberAirUnit_bombard = 0, 0, 0, 0
			if bestFighterAirUnit ~= NULL then
				bestFighterAirUnit_air_attack, bestFighterAirUnit_air_defence, bestFighterAirUnit_bombard_power, bestFighterAirUnit_bombard = conquests_unittemplateAirStats(bestFighterAirUnit)
			end
			if bestBomberAirUnit ~= NULL then
				bestBomberAirUnit_air_attack, bestBomberAirUnit_air_defence, bestBomberAirUnit_bombard_power, bestBomberAirUnit_bombard = conquests_unittemplateAirStats(bestBomberAirUnit)
			end

			if bestFighterAirUnit == NULL or air_defence > bestFighterAirUnit_air_defence then
				bestFighterAirUnit = unit_template
			end
			if bestBomberAirUnit == NULL or bombard_power > bestBomberAirUnit_bombard_power or
				( bombard_power == bestBomberAirUnit_bombard_power and bombard > bestBomberAirUnit_bombard ) then
					bestBomberAirUnit = unit_template
			end
		end
		if is_air and is_missile then
			local air_attack, air_defence, bombard_power, bombard, air_range, nucleartype = conquests_unittemplateAirStats(unit_template)

			local bestConventionalMissileUnit_air_attack, bestConventionalMissileUnit_air_defence, bestConventionalMissileUnit_bombard_power, bestConventionalMissileUnit_bombard = 0, 0, 0, 0
			local bestNuclearMissileUnit_air_attack, bestNuclearMissileUnit_air_defence, bestNuclearMissileUnit_bombard_power, bestNuclearMissileUnit_bombard, bestNuclearMissileUnit_range, bestNuclearMissileUnit_nucleartype = 0, 0, 0, 0, 0, 0
			if bestConventionalMissileUnit ~= NULL then
				bestConventionalMissileUnit_air_attack, bestConventionalMissileUnit_air_defence, bestConventionalMissileUnit_bombard_power, bestConventionalMissileUnit_bombard = conquests_unittemplateAirStats(bestConventionalMissileUnit)
			end
			if bestNuclearMissileUnit ~= NULL then
				bestNuclearMissileUnit_air_attack, bestNuclearMissileUnit_air_defence, bestNuclearMissileUnit_bombard_power, bestNuclearMissileUnit_bombard, bestNuclearMissileUnit_range, bestNuclearMissileUnit_nucleartype = conquests_unittemplateAirStats(bestNuclearMissileUnit)
			end

			if nucleartype == NUCLEARTYPE_NONE then
				if bestConventionalMissileUnit == NULL or bombard_power > bestConventionalMissileUnit_bombard_power or
					( bombard_power == bestConventionalMissileUnit_bombard_power and bombard > bestConventionalMissileUnit_bombard ) then
						bestConventionalMissileUnit = unit_template
				end
			else
				if bestNuclearMissileUnit == NULL or
					( bestNuclearMissileUnit_nucleartype == NUCLEARTYPE_FISSION and nucleartype == NUCLEARTYPE_FUSION ) then
						bestNuclearMissileUnit = unit_template;
				end
			end
		end
		if is_sea then
			local sea_attack, sea_defence_range = conquests_unittemplateSeaStats(unit_template)
			local best_sea_attack, best_sea_defence_range = 0, 0
			if bestSeaUnit ~= NULL then
				best_sea_attack, best_sea_defence_range = conquests_unittemplateSeaStats(bestSeaUnit)
			end

			if bestSeaUnit == NULL or sea_attack > best_sea_attack then
				bestSeaUnit = unit_template
			end
		end
	end

	-- debug output
	if bestUnit ~= NULL then
		local unit_name = conquests_buildableGetInfo(bestUnit)
		conquests_log("bestUnit: " .. unit_name)
		end
	if defensiveUnit ~= NULL then
		local unit_name = conquests_buildableGetInfo(defensiveUnit)
		conquests_log("defensiveUnit: " .. unit_name)
		end
	if fastestUnit ~= NULL then
		local unit_name = conquests_buildableGetInfo(fastestUnit)
		conquests_log("fastestUnit: " .. unit_name)
		end
	if cheapestUnit ~= NULL then
		local unit_name = conquests_buildableGetInfo(cheapestUnit)
		conquests_log("cheapestUnit: " .. unit_name)
		end
	if bestFighterAirUnit ~= NULL then
		local unit_name = conquests_buildableGetInfo(bestFighterAirUnit)
		conquests_log("bestFighterAirUnit: " .. unit_name)
		end
	if bestBomberAirUnit ~= NULL then
		local unit_name = conquests_buildableGetInfo(bestBomberAirUnit)
		conquests_log("bestBomberAirUnit: " .. unit_name)
		end
	if bestConventionalMissileUnit ~= NULL then
		local unit_name = conquests_buildableGetInfo(bestConventionalMissileUnit)
		conquests_log("bestConventionalMissileUnit: " .. unit_name)
		end
	if bestNuclearMissileUnit ~= NULL then
		local unit_name = conquests_buildableGetInfo(bestNuclearMissileUnit)
		conquests_log("bestNuclearMissileUnit: " .. unit_name)
		end
	if bestSeaUnit ~= NULL then
		local unit_name = conquests_buildableGetInfo(bestSeaUnit)
		conquests_log("bestSeaUnit: " .. unit_name)
		end

	-- checks
	if bestUnit == NULL then
		conquests_log("Couldn't find bestUnit")
		error("Couldn't find bestUnit")
	end
	if fastestUnit == NULL then
		conquests_log("Couldn't find fastestUnit")
		error("Couldn't find fastestUnit")
	end
	if workerUnit == NULL then
		conquests_log("Couldn't find workerUnit")
		error("Couldn't find workerUnit")
	end

	do
		-- having a few fastest and worker units is good too, so do a substitution
		-- update: we build enough worker units either directly, or through barracks - so need more faster units
		local r = math.random(4)
		if r == 1 or r == 2 then
			-- keep with best
		else
			bestUnit = fastestUnit
			--conquests_log("AI: best unit is fastest")
			conquests_log("AI: " .. name .. ": best unit is fastest")
		end
	end

	local n_settlers, n_explorers, n_nukes = 0, 0, 0
	local all_units = conquests_getMyUnits()
	for i=1, #all_units do
		local unit = all_units[i]
		local unit_template = conquests_unitGetTemplate(unit)
		--print("MyUnit:    ", i, " : ", conquests_buildableGetInfo(unit_template))
		local can_build_roads, can_build_city = conquests_unittemplateAbility(unit_template)
		--print(i, ": ", conquests_buildableGetInfo(unit_template), ": ", can_build_roads, can_build_city)
		if can_build_city then
			n_settlers = n_settlers + 1
		end
		if bestNuclearMissileUnit and unit_template == bestNuclearMissileUnit then
			n_nukes = n_nukes + 1
		end
		local xpos, ypos = conquests_unitGetPos(unit)
		local city = conquests_getCityAt(xpos, ypos)
		if city == NULL then
			-- ignore units defending cities
			if unit_template == fastestUnit then
				n_explorers = n_explorers + 1
			end
		end
	end
	--print("n_setters: ", n_settlers)
	--print("n_explorers: ", n_explorers)
	--print("n_nukes: ", n_nukes)
	local year = conquests_getYear()
	--print("year: ", year)
	local all_cities = conquests_getMyCities()
	local max_explorers = #all_cities + 4 -- favour explorers when fewer cities
	if year > 100 and #all_cities > 4 then
		max_explorers = 8 + ( #all_cities - 4 ) / 5
	end
	--print("max_explorers: ", max_explorers)
	local max_settlers = #all_cities+1 -- +1 so that a single City can still build a 2nd Settlers unit when we already have 1 Settlers unit
	if year > 100 and #all_cities > 8 then
		max_settlers = 9 + ( #all_cities - 8 ) / 5
	end
	--print("max_settlers: ", max_settlers)

	local n_settlers_being_built = 0
	local n_explorers_being_built = 0
	local n_nukes_being_built = 0
	for i=1, #all_cities do
		local city = all_cities[i]
		if city ~= ai_city then
			local city_buildable = conquests_cityGetBuildable(city)
			if city_buildable ~= NULL then
			    --print("City of ", conquests_cityGetName(city))
				local city_buildable_name, city_buildable_type = conquests_buildableGetInfo(city_buildable)
				--print("City ", i, " is building ", city_buildable_name, " Type ", city_buildable_type)
				if city_buildable_type == BUILDABLETYPE_UNIT then
					local can_build_roads, can_build_city = conquests_unittemplateAbility(city_buildable)
					if can_build_city then
						n_settlers_being_built = n_settlers_being_built + 1
					end
					local attack, defence, moves, cost = conquests_unittemplateStats(city_buildable)
					local fastestUnit_attack, fastestUnit_defence, fastestUnit_moves, fastestUnit_cost = conquests_unittemplateStats(fastestUnit)
					if moves >= fastestUnit_moves then
						n_explorers_being_built = n_explorers_being_built + 1
					end
					if bestNuclearMissileUnit ~= NULL and city_buildable == bestNuclearMissileUnit then
						n_nukes_being_built = n_nukes_being_built + 1
					end
				end
			end
		end
	end

	if defensiveUnit ~= NULL then
		local defensiveUnit_attack, defensiveUnit_defence, defensiveUnit_moves, defensiveUnit_cost = conquests_unittemplateStats(defensiveUnit)
		local min_defence = 0
		-- if only 1 city and 0 Settlers, we only care about getting a minimum defence, as building Settlers is better
		if #all_cities > 1 or n_settlers > 0 then
			min_defence = defensiveUnit_defence
		end
		local need, undefended = needDefenders( true, ai_city, NULL, min_defence, defensiveUnit )
		if need then
			if production > 0 then
				local attack, defence, moves, cost = conquests_unittemplateStats(defensiveUnit)
				local n_turns = cost / production
				--conquests_log("n_turns = " .. n_turns)
				local turn_limit = 20
				if undefended then
					turn_limit = 40
				end
				if n_turns > turn_limit then
					-- too long to build this unit, try growing first (needed for later stages in game for small cities)
					conquests_log("too long, try growing first?");
					local buildable = chooseBuildPopLimits( ai_city )
					if buildable ~= NULL then
						local buildable_name, buildable_type, buildable_cost = conquests_buildableGetInfo(buildable)
						if buildable_cost < cost then
							-- and only do this if the growth improvement is cheaper!
							conquests_log(conquests_civilizationGetName(ai_civilization) .. " city of " .. name .. " starts building " .. conquests_buildableGetInfo(buildable) .. " [growth (too long to build defensive unit)]")
							return buildable
						end
					end
				end
			end
			conquests_log(conquests_civilizationGetName(ai_civilization) .. " city of " .. name .. " starts building " .. conquests_buildableGetInfo(defensiveUnit) .. " [defender]")
			return defensiveUnit
		end
	end

	if #all_cities > 1 or n_settlers > 0 then
		local buildable = chooseBuildPopLimits( ai_city )
		if buildable ~= NULL then
			conquests_log(conquests_civilizationGetName(ai_civilization) .. " city of " .. name .. " starts building " .. conquests_buildableGetInfo(buildable) .. " [growth]")
			return buildable
		end
	end

	if bestNuclearMissileUnit ~= NULL and n_nukes + n_nukes_being_built < 5 and production > 0 then
		local attack, defence, moves, cost = conquests_unittemplateStats(bestNuclearMissileUnit)
		local n_turns = cost / production
		if n_turns <= 10 then
			conquests_log(conquests_civilizationGetName(ai_civilization) .. " city of " .. name .. " starts building " .. conquests_buildableGetInfo(bestNuclearMissileUnit) .. " [rush build nukes]")
			return bestNuclearMissileUnit
		end
	end

	local tried_improvements = false
	local build_settler = false
	if year <= 100 and n_settlers < max_settlers then
		-- Prefer building Settlers in early game phase.
		-- [Although note this does give the problem of overproduction, on Civs that are on small islands...]
		-- We do the check against max_settlers to avoid overproduction (though note, we don't include the n_settlers_being_built, as we don't want to restrict it that much).
		build_settler = true
	else
		if size >= 3 and math.random(2) == 1 then
			tried_improvements = true
			local buildable = chooseImprovementAI( ai_city )
			if buildable ~= NULL then
				conquests_log(conquests_civilizationGetName(ai_civilization) .. " city of " .. name .. " starts building " .. conquests_buildableGetInfo(buildable) .. " [improvement] (1st phase)")
				return buildable
			end
		end
	end

	local costs, width, height = conquests_calculateDistanceMap(NULL, city_xpos, city_ypos, true)
	--print("width: ", width, "height: ", height)
	--print("n ", #costs)
	--for i=1, #costs do
	--	local dist = costs[i]
	--	print(i, " : ", dist)
	--end

	-- we try to see if we want settlers, even if we can't build them, because in such case, it's better to build a cheap unit rather than wasting time with an expensive improvement!
	if build_settler == false and n_settlers + n_settlers_being_built < max_settlers then
		for y=0, height-1 do
			if build_settler then
				break
			end
			for x=0, width-1 do
				if build_settler then
					break
				end
				--local this_dist = costs[y * width + x]
				local this_dist = getDist(costs, width, x, y)
				--print(x, y, " this_dist = ", this_dist)
				if this_dist ~= -1 and this_dist <= ignore_dist_c * road_move_scale_c then
					if conquests_canBuildCity(x, y) then
						build_settler = true
					end
				end
			end
		end
	end
	--print("build_settler? ", build_settler)
	if build_settler and settlersUnit ~= NULL then
		conquests_log(conquests_civilizationGetName(ai_civilization) .. " city of " .. name .. " starts building " .. conquests_buildableGetInfo(settlersUnit) .. " [build a new city]")
		return settlersUnit
	end

	local n_nearby_workers = 0
	local n_improved_squares = 0 -- also includes those currently being improved
	local need_workers = false
	do
		local xposes, yposes = conquests_getCitySquares(city_xpos, city_ypos, false)
		for square = 1, #xposes do
			local xpos = xposes[square]
			local ypos = yposes[square]
			local can_be_improved = conquests_canBeImproved(xpos, ypos)
			if need_workers == false and can_be_improved then
				local this_dist = getDist(costs, width, xpos, ypos)
				if this_dist ~= -1 then
					need_workers = true
				end
			end
			local is_improved = false
			local units = conquests_getUnitsAt(xpos, ypos)
			for i=1, #units do
				local unit = units[i]
				local unit_template = conquests_unitGetTemplate(unit)
				local can_build_roads = conquests_unittemplateAbility(unit_template)
				local unit_civ = conquests_unitGetCivilization(unit)
				if unit_civ == ai_civilization and can_build_roads then
					n_nearby_workers = n_nearby_workers + 1
					is_improved = true
				end
			end
			if is_improved == false then
				local road = conquests_getRoad(xpos, ypos)
				if can_be_improved == false and road ~= ROAD_UNKNOWN and road ~= ROAD_NONE then
					is_improved = true
				end
			end
			if is_improved then
				n_improved_squares = n_improved_squares + 1
			end
		end
	end
	--print("n_nearby_workers: ", n_nearby_workers)
	--print("n_improved_squares: ", n_improved_squares)
	--print("need_workers: ", need_workers)
	if size <= 2 and n_improved_squares >= max_road_bonus_c then
		need_workers = false -- small cities need fewer improved squares - this allows us to start on settlers sooner (also see corresponding code for Unit AI)
	end
	if n_nearby_workers == 0 and need_workers then
		conquests_log(conquests_civilizationGetName(ai_civilization) .. " city of " .. name .. " starts building " .. conquests_buildableGetInfo(workerUnit) .. " [worker]")
		return workerUnit
	end

	-- build explorers
	local build_explorer = false
	local all_explored  = true
	for y=0, height-1 do
		--print("y = ", y)
		if build_explorer then
			break
		end
		for x=0, width-1 do
			if build_explorer then
				break
			end
			if conquests_isExplored(x, y) then
				-- skip
			else
				--print("unexplored: ", x, ", ", y)
				all_explored = false
				-- need to look at adjacent squares for dist!
				local found_dist = false
				local this_dist = 0
				local xposes, yposes = conquests_getAdjacentSquares(x, y, false)
				--local xposes, yposes = conquests_getAdjacentSquares(city_xpos, city_ypos, false)
				--print("    adjacent: ", #xposes, ", ", #yposes)
				for square = 1, #xposes do
					local xpos = xposes[square]
					local ypos = yposes[square]
					--local adj_dist = costs[ypos * width + xpos]
					local adj_dist = getDist(costs, width, xpos, ypos)
					--print("    adj: ", xpos, ", ", ypos, " : cost: ", adj_dist)
					if adj_dist ~= -1 then
						if found_dist == false or adj_dist < this_dist then
							found_dist = true
							this_dist = adj_dist
						end
					end
				end
				if found_dist == false then
					-- the square is surrounded by unexplored squares, so there must be another one closer
				else
					if this_dist > ignore_dist_c * road_move_scale_c then
						-- don't bother considering
					else
						build_explorer = true
					end
				end
			end
		end
	end
	-- don't build more explorers if we have lots of nearby workers who could do the job later (if the explorer unit can also work, we just end up building loads of explorers...)
	if n_nearby_workers < 2 and n_explorers + n_explorers_being_built < max_explorers and build_explorer then
		conquests_log(conquests_civilizationGetName(ai_civilization) .. " city of " .. name .. " starts building " .. conquests_buildableGetInfo(fastestUnit) .. " [explorer]")
		return fastestUnit
	end

	-- now try again
	do
		local buildable = chooseBuildPopLimits( ai_city )
		if buildable ~= NULL then
			conquests_log(conquests_civilizationGetName(ai_civilization) .. " city of " .. name .. " starts building " .. conquests_buildableGetInfo(buildable) .. " [growth]")
			return buildable
		end
	end

	if build_explorer == false and all_explored == false then
		-- if build_explorer is false, it means there are no nearby squares left to explore - try building sea improvements
		-- if all explored, not as urgent to do this (still useful for travel, but we'll build them with the other improvements)
		local buildable_port = conquests_findBuildable("Port")
		if conquests_cityCanBuild(ai_city, buildable_port) then
			conquests_log(conquests_civilizationGetName(ai_civilization) .. " city of " .. name .. " starts building " .. conquests_buildableGetInfo(buildable_port) .. " [port]")
			return buildable_port
		end
		local buildable_harbour = conquests_findBuildable("Harbour")
		if conquests_cityCanBuild(ai_city, buildable_harbour) then
			conquests_log(conquests_civilizationGetName(ai_civilization) .. " city of " .. name .. " starts building " .. conquests_buildableGetInfo(buildable_harbour) .. " [harbour]")
			return buildable_harbour
		end
	end

	if size == 1 and build_settler then
		-- remember, only a viable tactic if the city is going to grow to size 2
		conquests_log(conquests_civilizationGetName(ai_civilization) .. " city of " .. name .. " starts building " .. conquests_buildableGetInfo(cheapestUnit) .. " [cheap unit whilst growing]")
		return cheapestUnit
	end

	-- check already have a sea unit
	do
		local units = conquests_getUnitsAt(city_xpos, city_ypos)
		for i=1, #units do
			local unit = units[i]
			local unit_template = conquests_unitGetTemplate(unit)
			local is_foot, is_air, is_missile, is_sea = conquests_unittemplateType(unit_template)
			if is_sea then
				--print("city already has a sea unit")
				bestSeaUnit = NULL
				break
			end
		end
	end

	if bestSeaUnit ~= NULL
		and math.random(2) == 1 -- only build sea units some of the time
		then
		conquests_log(conquests_civilizationGetName(ai_civilization) .. " city of " .. name .. " starts building " .. conquests_buildableGetInfo(bestSeaUnit) .. " [sea unit]")
		return bestSeaUnit
	end

	-- check already built enough air units
	do
		local units = conquests_getUnitsAt(city_xpos, city_ypos)
		local n_fighters, n_bombers = 0, 0
		for i=1, #units do
			local unit = units[i]
			local unit_template = conquests_unitGetTemplate(unit)
			if bestFighterAirUnit ~= NULL and bestFighterAirUnit == unit_template then
				n_fighters = n_fighters + 1
			end
			if bestBomberAirUnit ~= NULL and bestBomberAirUnit == unit_template then
				n_bombers = n_bombers + 1
			end
		end
		if n_fighters >= 4 then
			--print("city already has enough fighters: ", n_fighters)
			bestFighterAirUnit = NULL
		end
		if n_bombers >= 4 then
			--print("city already has enough bombers: ", n_bombers)
			bestBomberAirUnit = NULL
		end
	end

	if ( bestFighterAirUnit ~= NULL or bestBomberAirUnit ~= NULL or bestConventionalMissileUnit ~= NULL or bestNuclearMissileUnit ~= NULL )
		and ( math.random(2) == 1 ) -- only build air/missile units some of the time
		then
		local buildable = chooseAirUnitAI(ai_city, bestFighterAirUnit, bestBomberAirUnit, bestConventionalMissileUnit, bestNuclearMissileUnit, true)
		if buildable ~= NULL then
			conquests_log(conquests_civilizationGetName(ai_civilization) .. " city of " .. name .. " starts building " .. conquests_buildableGetInfo(buildable) .. " [bomb enemy city, at war]")
			return buildable
		end
	end

	if bestUnit ~= NULL then
		local civilizations = conquests_getCivilizations(GETCIVILIZATIONS_WAR)
		--[[ This check will include rebel units - but that's fine, as it's reasonable we'll want to attack rebels, even if not in our territory - the ignore_dist_c check will stop us from
			 building units to attack rebels a long way away.
		--]]
		for i=1, #civilizations do
			local civilization = civilizations[i]
			-- attack cities?
			local cities = conquests_getCities(civilization)
			for i=1, #cities do
				local city = cities[i]
				local xpos, ypos = conquests_cityGetPos(city)
				local dist = getDist(costs, width, xpos, ypos)
				if dist ~= -1 and dist <= ignore_dist_c * road_move_scale_c then
					conquests_log(conquests_civilizationGetName(ai_civilization) .. " city of " .. name .. " starts building " .. conquests_buildableGetInfo(bestUnit) .. " [attack enemy city of " .. conquests_cityGetName(city) .. "]")
					return bestUnit
				end
			end
			-- attack units?
			local units = conquests_getUnits(civilization)
			for i=1, #units do
				local unit = units[i]
				local xpos, ypos = conquests_unitGetPos(unit)
				local dist = getDist(costs, width, xpos, ypos)
				if dist ~= -1 and dist <= ignore_dist_c * road_move_scale_c then
					conquests_log(conquests_civilizationGetName(ai_civilization) .. " city of " .. name .. " starts building " .. conquests_buildableGetInfo(bestUnit) .. " [attack enemy unit at " .. xpos .. ", " .. ypos .. "]")
					return bestUnit
				end
			end
		end
	end

	if tried_improvements == false then
		local buildable = chooseImprovementAI( ai_city )
		if buildable ~= NULL then
			conquests_log(conquests_civilizationGetName(ai_civilization) .. " city of " .. name .. " starts building " .. conquests_buildableGetInfo(buildable) .. " [improvement] (2nd phase)")
			return buildable
		end
	end

	-- air/missile units for civs at peace
	if ( bestFighterAirUnit ~= NULL or bestBomberAirUnit ~= NULL or bestConventionalMissileUnit ~= NULL or bestNuclearMissileUnit ~= NULL )
		and ( bestUnit == NULL or math.random(2) == 1 ) -- only build air/missile units some of the time
		then
		local buildable = chooseAirUnitAI(ai_city, bestFighterAirUnit, bestBomberAirUnit, bestConventionalMissileUnit, bestNuclearMissileUnit, false)
		if buildable ~= NULL then
			conquests_log(conquests_civilizationGetName(ai_civilization) .. " city of " .. name .. " starts building " .. conquests_buildableGetInfo(buildable) .. " [bomb enemy city, at peace]")
			return buildable
		end
	end

	-- default to attacker unit:
	conquests_log(conquests_civilizationGetName(ai_civilization) .. " city of " .. name .. " starts building " .. conquests_buildableGetInfo(bestUnit) .. " [default]")
	return bestUnit
end

function doUnitAIAir( ai_unit )
	local ai_civilization = conquests_unitGetCivilization(ai_unit)
	local unit_template = conquests_unitGetTemplate(ai_unit)
	local can_build_roads, can_build_city, can_bomb = conquests_unittemplateAbility(unit_template)
	local name = conquests_buildableGetInfo(unit_template)
	--conquests_log("doUnitAIAir for: " .. name)

	-- initial checks
	-- n.b., conquests_canBomb will do these checks too, but we do them here for performance
	if can_bomb == false then
		return UNITACTION_NOTHING, 0, 0, true
	end

	local unit_xpos, unit_ypos = conquests_unitGetPos(ai_unit)
	local ai_city = conquests_getCityAt(unit_xpos, unit_ypos)
	ASSERT(ai_city ~= NULL, "Air unit not located at a city")
	if conquests_cityCanLaunch(ai_city, unit_template) == false then
		-- city no longer has launch capability (airport, missile launcher)
		return UNITACTION_NOTHING, 0, 0, true
	end

	local candidates = {}
	local is_foot, is_air, is_missile = conquests_unittemplateType(unit_template)
	local air_attack, air_defence, bombard_power, bombard, air_range, nucleartype = conquests_unittemplateAirStats(unit_template)
	-- This check will include the rebel civ if any units exist, but we're only concerned with cities anyway.
	local civilizations = conquests_getCivilizations(GETCIVILIZATIONS_WAR)
	local best_score = -1
	for i=1, #civilizations do
		local civilization = civilizations[i]
		local cities = conquests_getCities(civilization)
		for i=1, #cities do
			local city = cities[i]
			local city_size = conquests_cityGetPublicInfo(city)
			local consider_bombing = true
			if is_missile then
				local min_city_size = 0
				if nucleartype == NUCLEARTYPE_NONE then
					min_city_size = 6
				else
					min_city_size = 10
				end
				if city_size < min_city_size then
					-- don't waste missiles on smaller cities
					consider_bombing = false
				end
			end
			local xpos, ypos = conquests_cityGetPos(city)
			if consider_bombing and conquests_canBomb(unit_template, ai_city, xpos, ypos, true) then
				-- prefer largest cities (with some randomness)
				local score = city_size + math.random(2) - 1;
				--conquests_log("AI: " .. conquests_civilizationGetName(ai_civilization) .. " consider bombing " .. conquests_cityGetName(city) .. ", score " .. score)
				if #candidates == 0 or score > best_score then
					candidates = {}
					table.insert(candidates, city)
					best_score = score
				elseif score == best_score then
					table.insert(candidates, city)
				end
			end
		end
	end

	if #candidates == 0 then
		-- do nothing
		return UNITACTION_NOTHING, 0, 0, true
	end
	local r = math.random(#candidates);
	local city = candidates[r]
	local civilization = conquests_cityGetCivilization(city)
	conquests_log("AI: " .. conquests_civilizationGetName(ai_civilization) .. " " .. conquests_buildableGetInfo(unit_template) .. " bombs " .. conquests_civilizationGetName(civilization) .. " city of " .. conquests_cityGetName(city))
	local xpos, ypos = conquests_cityGetPos(city)

	return UNITACTION_MOVE, xpos, ypos, true
end

-- Function that must be implemented; called for each unit that must be moved
-- receives: pointer to the unit
-- returns: unit_action UNITACTION_* (int), target_square_x (int), target_square_y (int), allow_travel (bool)
-- N.B., target_square_x/y are only relevant for some unit_action types, but values should still always returned (e.g., as 0)
function doUnitAI( ai_unit )
	-- IMPORTANT: random choices should only be used to select between equal distances, otherwise we risk unstable behaviour between turns, with a unit continually changing its mind!
	-- IMPORTANT: whilst preferring longer distances is okay, this should be based on some fixed (non-random) criteria. Being further away shouldn't make a choice more likely, otherwise we'll then get unstable behaviour as the unit moves towards it!
	local unit_template = conquests_unitGetTemplate(ai_unit)
	local ai_civilization = conquests_unitGetCivilization(ai_unit)
	local name = conquests_buildableGetInfo(unit_template)
	--conquests_log("doUnitAI for: " .. name)

	local unit_xpos, unit_ypos = conquests_unitGetPos(ai_unit)
	--conquests_log("at " .. unit_xpos .. ", " .. unit_ypos)
	local is_foot, is_air, is_missile = conquests_unittemplateType(unit_template)

	--return UNITACTION_NOTHING, 0, 0, true
	--if is_air == false then
	--	return UNITACTION_MOVE, unit_xpos+1, unit_ypos, true
	--end

	if is_air then
		return doUnitAIAir( ai_unit )
	end

	local attack, defence, moves, cost = conquests_unittemplateStats(unit_template)
	local can_build_roads, can_build_city = conquests_unittemplateAbility(unit_template)

	if can_build_city == false then
		-- checking whether a City can be built here too is important - otherwise Units will end up waiting endlessly for a Settler that has nowhere to go!
		if conquests_canBuildCity(unit_xpos, unit_ypos) then
			local units = conquests_getUnitsAt(unit_xpos, unit_ypos)
			local settler_present = false
			for i=1, #units do
				local unit = units[i]
				local this_unit_template = conquests_unitGetTemplate(unit)
				local can_build_roads, can_build_city = conquests_unittemplateAbility(this_unit_template)
				if can_build_city then
					settler_present = true
					break
				end
			end
			if settler_present then
				-- wait for Settler to move first
				--conquests_log("wait for settlers to move first\n")
				return UNITACTION_WAIT, 0, 0, true
			end
		end
	end

	local found_target = false
	local decision = DECISION_UNDECIDED
	local allow_travel = true
	local dist = -1
	local candidates_x, candidates_y = {}, {} -- candidates should be a list of possible destinations, at equal distances away (the distance of which is given in "dist")

	--local work_only = false
	local city_at_sq = conquests_getCityAt(unit_xpos, unit_ypos)

	-- defend city (check this first, to avoid creating distance map)
	if found_target == false and defence > 0 then
		if city_at_sq ~= NULL then
			-- do we need to defend city?
			local need, undefended = needDefenders( false, city_at_sq, ai_unit, 0, NULL )
			if need then
				local unit_action = UNITACTION_NOTHING
				-- but might as well build roads if needed
				if can_build_roads and conquests_canBeImproved(unit_xpos, unit_ypos) then
					unit_action = UNITACTION_WORK
					--conquests_log("AI: " .. conquests_civilizationGetName(ai_civilization) .. " unit " .. name .. " at (" .. unit_xpos .. ", " .. unit_ypos .. ") works land")
				end
				return unit_action, 0, 0, true
			end
		end
	end

	--if is_air == false then
	--	return UNITACTION_MOVE, unit_xpos+1, unit_ypos, true
	--end

	local costs, width, height = conquests_calculateDistanceMap(ai_unit, unit_xpos, unit_ypos, true)
	--print("width: ", width, "height: ", height)
	--print("n ", #costs)
	--print("### cost: ", getDist(costs, width, 4, 8))
	local avoid_enemy_territory = defence == 0

	if can_build_city then
		-- search for city space, or explore
		if conquests_canBuildCity(unit_xpos, unit_ypos) then
			-- can build city here, but do a quick check for better adjacent squares
			local coastal = false
			local goodterrain = false
			local forest = false
			local bonus = false
			local best_pos_x = -1
			local best_pos_y = -1
			local first = true
			local has_enemies = false
			local xposes, yposes = conquests_getAdjacentSquares(unit_xpos, unit_ypos, true)
			for square = 1, #xposes do
				local xpos = xposes[square]
				local ypos = yposes[square]
				if has_enemies == false and conquests_hasEnemies(xpos, ypos) then
					has_enemies = true -- this check must be done before the dists check, as we can't get to a square with an enemy on it (since it's a Settler unit)
				end
				local this_dist = getDist(costs, width, xpos, ypos)
				if this_dist ~= -1 and conquests_canBuildCity(xpos, ypos) then
					local is_coastal = false
					do
						local xposes2, yposes2 = conquests_getAdjacentSquares(xpos, ypos, true)
						for square2 = 1, #xposes2 do
							local xpos2 = xposes2[square2]
							local ypos2 = yposes2[square2]
							local terrain2 = conquests_getTerrain(xpos2, ypos2)
							if terrain2 == TYPE_OCEAN then
								is_coastal = true
								break
							end
						end
					end
					local terrain = conquests_getTerrain(xpos, ypos)
					local is_goodterrain = terrain == TYPE_GRASSLAND or terrain == TYPE_HILLS
					local is_forest = false
					local is_bonus = false
					do
						local xposes2, yposes2 = conquests_getCitySquares(xpos, ypos, false)
						for square2 = 1, #xposes2 do
							local xpos2 = xposes2[square2]
							local ypos2 = yposes2[square2]
							if is_forest == false then
								local terrain2 = conquests_getTerrain(xpos2, ypos2)
								if terrain2 == TYPE_FOREST then
									is_forest = true
									--break
								end
							end
							if is_bonus == false then
								is_bonus = conquests_hasBonusResource(xpos2, ypos2)
							end
							if is_forest and is_bonus then
								break
							end
						end
					end
					--print(xpos, ", ", ypos, ": terrain: ", terrain, ": coastal: ", coastal, " goodterrain: ", goodterrain, "forest: ", forest, "bonus: ", bonus)
					--print(xpos, ", ", ypos, ": terrain: ", terrain, ": is_coastal: ", is_coastal, " is_goodterrain: ", is_goodterrain, "is_forest: ", is_forest, "is_bonus: ", is_bonus)
					if first then
						first = false
						coastal = is_coastal
						goodterrain = is_goodterrain
						forest = is_forest
						bonus = is_bonus
						best_pos_x = xpos
						best_pos_y = ypos
					else
						local prefer = false
						if is_goodterrain and goodterrain == false then
							-- always prefer good terrain
							prefer = true
						elseif is_goodterrain == goodterrain then
							-- for equal terrain, prefer bonus
							if is_bonus and bonus == false then
								prefer = true
							elseif is_bonus == bonus then
								-- for equal bonus, prefer forest
								if is_forest and forest == false then
									prefer = true
								elseif is_forest == forest then
									if is_coastal and coastal == false then
										-- for equal forest, prefer coastal
										prefer = true
									elseif is_coastal == coastal then
										-- for equal coastal, prefer current square
										if xpos == unit_xpos and ypos == unit_ypos then
											prefer = true
										end
									end
								end
							end
						end
						--print("prefer? ", prefer)
						if prefer then
							coastal = is_coastal
							goodterrain = is_goodterrain
							forest = is_forest
							bonus = is_bonus
							best_pos_x = xpos
							best_pos_y = ypos
						end
					end
				end
			end

			--print("has_enemies?: ", has_enemies)
			if has_enemies then
				-- enemy adjacent, don't build city here!
			elseif best_pos_x == unit_xpos and best_pos_y == unit_ypos then
				-- build city here
				return UNITACTION_BUILD_CITY, 0, 0, true
			else
				candidates_x, candidates_y = {}, {}
				table.insert(candidates_x, best_pos_x)
				table.insert(candidates_y, best_pos_y)
				found_target = true
				decision = DECISION_BUILDCITY
				allow_travel = true
				dist = getDist(costs, width, best_pos_x, best_pos_y)
			end
		end
		if found_target == false then
			for y=0, height-1 do
				for x=0, width-1 do
					if x ~= unit_xpos or y ~= unit_ypos then
						-- we've already tested whether we should build a city at the current square
						local this_dist = getDist(costs, width, x, y)
						if this_dist ~= -1 then
							local adjacent_unexplored = conquests_hasAdjacentUnexplored(x, y) -- whether there's an adjacent unexplored square - i.e., moving to this square will uncover it
							local proceed = true
							--[[
							if adjacent_unexplored == false and conquests_canBuildCity(x, y) == false then -- if not explored, consider exploring anyway, so carry on
								proceed = false
							end
							if conquests_getYear() > 100 and adjacent_unexplored == false then
								-- after early period, we leave exploring to the next phase below (hence, they may also do work if there is a closer square)
								proceed = false
							end
							--]]
							if conquests_canBuildCity(x, y) == false then
								-- if in the early period, still try looking here if unexplored square is adjacent
								-- after early period, we leave exploring to the next phase below (hence, they may also do work if there is a closer square)
								if adjacent_unexplored and conquests_getYear() <= 100 then
									-- okay
								else
									proceed = false
								end
							end
							if proceed and ( found_target == false or this_dist <= dist ) then
								-- only consider if a settler isn't already here!
								local units = conquests_getUnitsAt(x, y)
								local settler_present = false
								for i=1, #units do
									local unit = units[i]
									local this_unit_template = conquests_unitGetTemplate(unit)
									local can_build_roads, can_build_city = conquests_unittemplateAbility(this_unit_template)
									if can_build_city then
										settler_present = true
										break
									end
								end

								if settler_present == false then
									if decision ~= DECISION_BUILDCITY or this_dist < dist then
										candidates_x, candidates_y = {}, {}
									end
									table.insert(candidates_x, x)
									table.insert(candidates_y, y)
									found_target = true
									decision = DECISION_BUILDCITY
									allow_travel = true
									dist = this_dist
								end
							end
						end
					end
				end
			end
		end
	end

	--print("attack = ", attack)
	-- build roads, attack or explore - whichever is closer
	if found_target == false then
		-- check to see whether it'd be better to attack an adjacent enemy
		-- n.b., in practice, attacking adjacent units seems to done as priority over moving to work adjacent square, but might as well still keep this code to be sure - and we
		-- need something here, to prevent case where the unit works the current square instead of attacking
		local xposes, yposes = conquests_getAdjacentSquares(unit_xpos, unit_ypos, true)
		local ok_to_work = true
		for square = 1, #xposes do
			local xpos = xposes[square]
			local ypos = yposes[square]
			if conquests_hasEnemies(xpos, ypos) then
				local best_defender = conquests_getBestDefenderAt(xpos, ypos) -- n.b., will be NULL if the enemy is at a city
				--conquests_log(xpos .. ", " .. ypos .. "\n")
				if best_defender ~= NULL then
					local best_defender_unit_template = conquests_unitGetTemplate(best_defender)
					local best_defender_attack, best_defender_defence, best_defender_moves, best_defender_cost = conquests_unittemplateStats(best_defender_unit_template)
					if best_defender_attack > 0 then
						local ratio_attack = (100 * attack) / best_defender_defence
						local ratio_defend = (100 * defence) / best_defender_attack
						if ratio_attack > ratio_defend then
							ok_to_work = false
						end
					end
				end
			end
		end
		if ok_to_work then
			-- automate build roads - keep as a Conquests function for now?
			--found_target, dist, candidates_x, candidates_y = conquests_automateWorker(ai_unit, costs, squares)
			found_target, dist, candidates_x, candidates_y = conquests_automateWorker(ai_unit, costs)
			if found_target then
				decision = DECISION_WORK
				allow_travel = true
				if candidates_x[1] == unit_xpos and candidates_y[1] == unit_ypos then
					--print("work")
					return UNITACTION_WORK, 0, 0, true
					--[[
					if ok_to_work then
						return UNITACTION_WORK, 0, 0, true
					else
						-- leave it to the later code to attack
						found_target = false
						decision = DECISION_UNDECIDED
						dist = -1
						candidates_x, candidates_y = {}, {}
					end
					--]]
				end
			end
		end

		-- attack
		if attack > 0 then
			--conquests_log("try attack")
			local attack_allow_travel = true -- whether to try attacking via travel
			local attack_costs = costs
			if city_at_sq ~= NULL then
				--conquests_log("launching from city...")
				local units = conquests_getUnitsAt(unit_xpos, unit_ypos)
				local sea_unit_present = false
				for i=1, #units do
					local unit = units[i]
					local unit_template = conquests_unitGetTemplate(unit)
					local is_foot, is_air, is_missile, is_sea = conquests_unittemplateType(unit_template)
					if is_sea then
						sea_unit_present = true
						break
					end
				end
				if sea_unit_present == false then
					--print("No sea units present...")
					-- we're at a city, with no sea unit to protect us - see if we can build them
					-- if we can't build any sea units, then doesn't matter - still allow travel
					local unit_templates = conquests_cityGetBuildables(city_at_sq, GETBUILDABLES_UNITS)
					for i=1, #unit_templates do
						local unit_template = unit_templates[i]
						local is_foot, is_air, is_missile, is_sea = conquests_unittemplateType(unit_template)
						--print("can build " .. conquests_buildableGetInfo(unit_template))
						if is_sea then
							attack_allow_travel = false
							--print("don't allow travel!")
							break
						end
					end
				end
			end
			if attack_allow_travel == false then
				-- recalculate distance map, without travel
				local temp_costs, temp_width, temp_height = conquests_calculateDistanceMap(ai_unit, unit_xpos, unit_ypos, false)
				attack_costs = temp_costs
			end
			-- This check also returns the rebel civ - see below for where we check for this more specifically.
			local civilizations = conquests_getCivilizations(GETCIVILIZATIONS_ALL)
			for i=1, #civilizations do
				local civilization = civilizations[i]
				local made_contact, at_war = conquests_getRelationshipInfo(civilization)
				if at_war then
					--conquests_log("at war")
					local is_rebel_civ = conquests_isRebelCiv(civilization)
					-- attack cities?
					local cities = conquests_getCities(civilization)
					local best_score = -1
					for i=1, #cities do
						local city = cities[i]
						local c_xpos, c_ypos = conquests_cityGetPos(city)
						local this_dist = getDist(attack_costs, width, c_xpos, c_ypos)
						local city_size = conquests_cityGetPublicInfo(city)
						-- prefer largest cities (with some randomness)
						local this_score = city_size + math.random(2) - 1;
						--local this_dist, this_squares, this_travelling = conquests_getDistanceCost(attack_costs, width, c_xpos, c_ypos)
						--if this_travelling and attack_allow_travel == false then
						--	-- don't allow travel
						--elseif this_dist ~= -1 then
						if this_dist ~= -1 then
							-- if equal dists, prefer cities with the best "score"
							--[[
							if found_target == false or this_dist <= dist or ( this_dist == dist and this_score < best_score ) then
								if decision ~= DECISION_ATTACKCITY or this_dist < dist then
									candidates_x, candidates_y = {}, {}
								end
							--]]
							if found_target == false or this_dist < dist or ( this_dist == dist and this_score >= best_score ) then
								if decision ~= DECISION_ATTACKCITY or this_dist < dist or ( this_dist == dist and this_score > best_score ) then
									candidates_x, candidates_y = {}, {}
								end
								table.insert(candidates_x, c_xpos)
								table.insert(candidates_y, c_ypos)
								decision = DECISION_ATTACKCITY
								allow_travel = attack_allow_travel
								found_target = true
								dist = this_dist
								best_score = this_score
							end
						end
					end
					-- attack units?
					local attack_adj = false
					local stronger_adj_attacker = true
					local units = conquests_getUnits(civilization)
					for i=1, #units do
						local unit = units[i]
						local u_xpos, u_ypos = conquests_unitGetPos(unit)
						--[[
						conquests_log("Unit at" .. u_xpos .. " .. " .. u_ypos)
						local temp_unit_template = conquests_unitGetTemplate(ai_unit)
						local temp_name = conquests_buildableGetInfo(unit_template)
						conquests_log("Name " .. temp_name);
						--]]
						local this_dist = getDist(attack_costs, width, u_xpos, u_ypos)
						--local this_dist, this_squares, this_travelling = conquests_getDistanceCost(attack_costs, width, u_xpos, u_ypos)
						--conquests_log("    dist = " .. this_dist)
						--if this_travelling and attack_allow_travel == false then
						--	-- don't allow travel
						--elseif this_dist ~= -1 then
						if this_dist ~= -1 then
							local ok_to_attack = true
							if this_dist <= road_move_scale_c then
								-- check whether better to attack, or be attacked
								-- note, this test should not depend on unit's current location, otherwise we risk an infinite move loop!
								-- for the best attacker units, we try attacking anyway, to avoid stalemates
								local is_better_unit = false
								local all_units = conquests_getMyUnits()
								for i=1, #all_units do
									if is_better_unit then
										break
									end
									local unit2 = all_units[i]
									local this_unit_template = conquests_unitGetTemplate(unit2)
									local this_attack, this_defence, this_moves, this_cost = conquests_unittemplateStats(this_unit_template)
									if this_attack > attack then
										is_better_unit = true
									end
								end
								if is_better_unit then
									local best_defender = conquests_getBestDefenderAt(u_xpos, u_ypos)
									ASSERT(best_defender ~= NULL, "Couldn't find best defender")
									local best_defender_unit_template = conquests_unitGetTemplate(best_defender)
									local best_defender_attack, best_defender_defence, best_defender_moves, best_defender_cost = conquests_unittemplateStats(best_defender_unit_template)
									if best_defender_attack > 0 then
										--ASSERT( best_defender->getTemplate()->getDefence() > 0 );
										local ratio_attack = (100 * attack) / best_defender_defence
										local ratio_defend = (100 * defence) / best_defender_attack
										if ratio_attack < ratio_defend then
											ok_to_attack = false
										end
									end
								end
							end
							--[[ If not a rebel civ, then attacking a unit even a long way away is reasonable. But we don't want to do this if it is a
								 rebel civ - in particular, we don't want to help out the other civilizations, by defeating rebels in their territory!
							--]]
							if ok_to_attack and is_rebel_civ then
								--conquests_log("### should we move from " .. unit_xpos .. " , " .. unit_ypos .. " to attack the rebels at " .. u_xpos .. " , " .. u_ypos .. "?")
								if this_dist > ignore_dist_c * road_move_scale_c then
									--conquests_log("NO!")
									ok_to_attack = false
								end
							end
							if ok_to_attack then
								-- Prefer attacking cities to attacking units if equal distances. Even if we want to change this behaviour and allow a random choice, we still want to prefer undefended cities.
								--if( !found_target || this_dist < dist || ( this_dist == dist && decision == DECISION_ATTACKUNITS ) ) {
								if found_target == false or this_dist < dist or ( this_dist == dist and decision ~= DECISION_ATTACKCITY ) then
									if decision ~= DECISION_ATTACKUNITS or this_dist < dist then
										candidates_x, candidates_y = {}, {}
									end
									table.insert(candidates_x, u_xpos)
									table.insert(candidates_y, u_ypos)
									decision = DECISION_ATTACKUNITS
									allow_travel = attack_allow_travel
									found_target = true
									dist = this_dist
								end
							end
						end
					end
				end
				if made_contact == false then
					-- contact cities?
					--[[
					local cities = conquests_getCities(civilization)
					for i=1, #cities do
						local city = cities[i]
						local c_xpos, c_ypos = conquests_cityGetPos(city)
						-- need to look at adjacent squares, as the distance map will say we can't move to a square with a non-enemy unit!
						local xposes, yposes = conquests_getAdjacentSquares(c_xpos, c_ypos, false)
						for square = 1, #xposes do
							local xpos = xposes[square]
							local ypos = yposes[square]
							local this_dist = getDist(costs, width, xpos, ypos)
							if this_dist ~= -1 then
								--conquests_log("CONTACT CITY: " .. xpos, ", " .. ypos .. " : " .. u_xpos .. ", " .. u_ypos)
								if found_target == false or this_dist <= dist then
									if decision ~= DECISION_CONTACT or this_dist < dist then
										candidates_x, candidates_y = {}, {}
									end
									table.insert(candidates_x, xpos)
									table.insert(candidates_y, ypos)
									decision = DECISION_CONTACT
									allow_travel = true
									found_target = true
									dist = this_dist
								end
							end
						end
					end
					--]]
					-- contact units?
					local units = conquests_getUnits(civilization)
					for i=1, #units do
						local unit = units[i]
						local u_xpos, u_ypos = conquests_unitGetPos(unit)
						-- need to look at adjacent squares, as the distance map will say we can't move to a square with a non-enemy unit!
						local xposes, yposes = conquests_getAdjacentSquares(u_xpos, u_ypos, false)
						for square = 1, #xposes do
							local xpos = xposes[square]
							local ypos = yposes[square]
							local this_dist = getDist(costs, width, xpos, ypos)
							if this_dist ~= -1 and ( xpos ~= unit_xpos or ypos ~= unit_ypos ) then
								--print("CONTACT UNIT: ", xpos, ", ", ypos, " : ", u_xpos, ", ", u_ypos)
								if found_target == false or this_dist <= dist then
									if decision ~= DECISION_CONTACT or this_dist < dist then
										candidates_x, candidates_y = {}, {}
									end
									table.insert(candidates_x, xpos)
									table.insert(candidates_y, ypos)
									decision = DECISION_CONTACT
									allow_travel = true
									found_target = true
									dist = this_dist
								end
							end
						end
					end
				end
			end
		end
		-- contact via enemy territory
		for y=0, height-1 do
			for x=0, width-1 do
				local civilization = conquests_getTerritory(x, y)
				--print(x, y, "civilization: ", civilization)
				if civilization ~= NULL and civilization ~= ai_civilization then
					local made_contact, at_war = conquests_getRelationshipInfo(civilization)
					if made_contact == false then
						-- we need to move to an adjacent explored square, as the dists array will be -1
						local xposes, yposes = conquests_getAdjacentSquares(x, y, false)
						for square = 1, #xposes do
							local xpos = xposes[square]
							local ypos = yposes[square]
							local this_dist = getDist(costs, width, xpos, ypos)
							if this_dist ~= -1 and ( xpos ~= unit_xpos or ypos ~= unit_ypos ) then
								--print("CONTACT TERRITORY: ", xpos, ", ", ypos, " : ", x, ", ", y)
								if found_target == false or this_dist <= dist then
									if decision ~= DECISION_CONTACT or this_dist < dist then
										candidates_x, candidates_y = {}, {}
									end
									table.insert(candidates_x, xpos)
									table.insert(candidates_y, ypos)
									decision = DECISION_CONTACT
									allow_travel = true
									found_target = true
									dist = this_dist
								end
							end
						end
					end
				end
			end
		end

		-- explore
		for y=0, height-1 do
			for x=0, width-1 do
				--if conquests_isExplored(x, y) == false then
				if conquests_isExplorable(x, y) then
					-- we need to move to an adjacent explored square, as the dists array will be -1
					local xposes, yposes = conquests_getAdjacentSquares(x, y, false)
					for square = 1, #xposes do
						local xpos = xposes[square]
						local ypos = yposes[square]
						local this_dist = getDist(costs, width, xpos, ypos)
						if this_dist ~= -1 and ( xpos ~= unit_xpos or ypos ~= unit_ypos ) then
							if found_target == false or this_dist < dist or ( this_dist == dist and decision == DECISION_EXPLORE ) or ( decision == DECISION_WORK and can_build_city ) then
								-- if we can build cities, then exploring should take priority over working
								if decision ~= DECISION_EXPLORE or this_dist < dist then
									candidates_x, candidates_y = {}, {}
								end
								table.insert(candidates_x, xpos)
								table.insert(candidates_y, ypos)
								found_target = true
								decision = DECISION_EXPLORE
								allow_travel = true
								dist = this_dist
							end
						end
					end
				end
			end
		end
	end

	-- Retreat to a city - prefer those with travel ability.
	-- This should be done as lower priority to previous actions, even if the city is closer.
	-- Note that we try to spread units evenly.
	if found_target == false then
		--conquests_log("LOOK FOR CITY TO RETREAT TO");
		local weight = 0
		local all_cities = conquests_getMyCities()
		for i=1, #all_cities do
			local city = all_cities[i]
			local city_xpos, city_ypos = conquests_cityGetPos(city)
			--ASSERT( this->civilization->isExplored(city_pos.x, city_pos.y) );
			local this_dist = getDist(costs, width, city_xpos, city_ypos)
			if this_dist ~= -1 then
				local units = conquests_getUnitsAt(city_xpos, city_ypos)
				local n_units = 0
				for i=1, #units do
					local unit = units[i]
					local this_unit_template = conquests_unitGetTemplate(unit)
					if unit ~= ai_unit and this_unit_template == unit_template then
						--mustn't include this unit in the count, otherwise we get unstable behaviour - a unit will decide to leave the city, but then have to return due to the count then reducing!
						n_units = n_units + 1
					end
				end
				--local is_capital, production, science, sea_travel_range, air_travel_range = conquests_cityGetInfo(city)
				local sea_travel_range, air_travel_range = conquests_cityGetRanges(city)
				local max_range = 100; -- just so we can put a limit on it; needed for the code for defender units
				if sea_travel_range > max_range then
					sea_travel_range = max_range
				end
				if air_travel_range > max_range then
					air_travel_range = max_range
				end
				local range_weight = sea_travel_range + air_travel_range;
				if defence > attack and n_units < 3 then
					-- If this is a "defender" unit, then we should give priority to cities that have fewer of this kind of defenders - protecting cities more important for defender units.
					-- Need to make sure that the weight is higher than the weights for any cities that don't need defending.
					-- Note that between several cities that need defending, we don't care about the travel ranges - only care about the number of units already there.
					range_weight = 2 * max_range + 1;
				end
				local this_weight = ( 100 * ( range_weight + 1 ) ) / ( n_units + 1 )
				--conquests_log("    City at " .. city_xpos .. ", " .. city_ypos .. " has sea " .. sea_travel_range .. " air " .. air_travel_range .. " n " .. n_units .. " : weight " .. this_weight);
				if found_target == false or this_weight > weight or ( this_weight == weight and this_dist < dist ) then
					candidates_x, candidates_y = {}, {}
					table.insert(candidates_x, city_xpos)
					table.insert(candidates_y, city_ypos)
					found_target = true
					decision = DECISION_CITY
					allow_travel = true
					dist = this_dist
					weight = this_weight
				end
			end
		end
		--found_target = false
		--decision = DECISION_UNDECIDED
		--allow_travel = true
		--candidates_x, candidates_y = {}, {}
		if found_target then
			--ASSERT( candidates.size() == 1 );
			if candidates_x[1] == unit_xpos and candidates_y[1] == unit_ypos then
				-- already at best square - reset (needed, as it's illegal to return that we're moving to the current square)
				found_target = false
				decision = DECISION_UNDECIDED
				allow_travel = true
				candidates_x, candidates_y = {}, {}
			end
		end
	end

	if found_target then
		if decision == DECISION_UNDECIDED then
			conquests_log("No decision set")
			error("No decision set")
		end
		if #candidates_x <= 0 then
			conquests_log("No candidates set")
			error("No candidates set")
		end
		if #candidates_x ~= #candidates_y then
			conquests_log("Unequal x and y candidates")
			error("Unequal x and y candidates")
		end
		local target_x, target_y = 0, 0
		local found = false
		-- prefer to stick with the choice calculated for the previous move/turn - this is particularly important with Railways, to avoid the AI moving in loops back and forth along the railways, as it keeps changing its mind!
		-- less important, now that we do caching of the target square in Conquests? Also doesn't take into account the situation changing!
		--[[
		for i=1, #candidates_x do
			local candidate_xpos = candidates_x[i]
			local candidate_ypos = candidates_y[i]
			if candidate_xpos == unit_xpos and candidate_ypos == unit_ypos then
				print("candidate equal to unit's current position")
				error("candidate equal to unit's current position")
				if( candidate_target == last_target ) {
					target = candidate_target;
					found = true;
				}
			end
		}
		--]]
		if found == false then
			-- last choice no longer available, so pick a new one at random
			local r = math.random(#candidates_x)
			target_x = candidates_x[r]
			target_y = candidates_y[r]
			--last_target = target;
		end

		do
			local decision_string = ""
			if decision == DECISION_BUILDCITY then
				decision_string = "Build city"
			elseif decision == DECISION_WORK then
				decision_string = "Work"
			elseif decision == DECISION_ATTACKCITY then
				decision_string = "Attack city"
			elseif decision == DECISION_ATTACKUNITS then
				decision_string = "Attack units"
			elseif decision == DECISION_CONTACT then
				decision_string = "Contact"
			elseif decision == DECISION_EXPLORE then
				decision_string = "Explore"
			elseif decision == DECISION_CITY then
				decision_string = "Retreat to city"
			end
			conquests_log("AI: " .. conquests_civilizationGetName(ai_civilization) .. " unit " .. name .. " at (" .. unit_xpos .. ", " .. unit_ypos .. ") moving towards (" .. target_x .. ", " .. target_y .. ") [" .. decision_string .. "]")
		end

		return UNITACTION_MOVE, target_x, target_y, allow_travel
	end

	-- else can't do anything
	return UNITACTION_NOTHING, 0, 0, true
end
