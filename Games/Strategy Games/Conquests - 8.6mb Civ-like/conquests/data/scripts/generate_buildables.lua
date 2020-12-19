print("generate_buildables.lua enter")

-- Improvements

-- N.B., some effects of Improvements are hardcoded.

-- Arguments: Name, cost, required technology, ai weighting

-- ancient

improvement = conquests_addNewImprovement("Barracks", 40, "Military Tactics", 30)
	-- TODO: avoid hardcoded 25 turns
	conquests_buildableSetInfo(improvement, "The Barracks improvement will automatically produce one military unit of footsoldiers every 25 turns.")
	conquests_improvementRebellionBonus(improvement, 25)
	conquests_buildableSetAdvice(improvement, "A barracks will allow units to be recruited automatically from the general population, as well as helping to keep control of your population.")

improvement = conquests_addNewImprovement("Farmland", 20, "Agriculture", 0)
	-- AI weight 0, handled with specific code
	-- TODO: avoid hardcoded size 3
	conquests_buildableSetInfo(improvement, "Farmland is required for a town to grow beyond population 16,000.")
	conquests_buildableSetAdvice(improvement, "Farmland will allow our town to expand.")

improvement = conquests_addNewImprovement("Aqueduct", 60, "Construction", 0)
	-- AI weight 0, handled with specific code
	-- TODO: avoid hardcoded size 6
	conquests_buildableSetInfo(improvement, "An Aqueduct is required for a city to grow beyond population 31,000.")
	conquests_buildableSetRequiresImprovement(improvement, "Farmland")
	conquests_buildableSetAdvice(improvement, "An Aqueduct will allow our city to expand.")

improvement = conquests_addNewImprovement("Fort", 40, "", 10)
	improvement_fort = improvement
	conquests_buildableSetInfo(improvement, "A Fort increases the defence of your units in the city by 25%, unless the attacker has discovered Gunpowder.")
	conquests_buildableSetObsoletedBy(improvement, "Gunpowder")
	conquests_improvementRebellionBonus(improvement, 25)
	conquests_buildableSetAdvice(improvement, "A Fort will provide some basic protection for our city, as well as helping to reduce disorder.")

improvement = conquests_addNewImprovement("Quarry", 20, "", 40)
	conquests_buildableSetAdvice(improvement, "A Quarry will allow the extraction of large quantities of stone, allowing a greater range of improvements to be built.")

improvement = conquests_addNewImprovement("Harbour", 40, "Sailing", 15)
	improvement_harbour = improvement
	conquests_buildableSetInfo(improvement, "A Harbour allows exploration and travel by sea.")
	conquests_improvementSetRequiresCoastal(improvement, true)
	conquests_improvementSetTravelRange(improvement, 5, false)
	conquests_improvementSetPowerPerTurn(improvement, 1)
	conquests_buildableSetAdvice(improvement, "A Harbour will allow us to explore nearby waters.")

improvement = conquests_addNewImprovement("Library", 40, "Writing", 5)
	conquests_improvementSetResearchMultiplierBonus(improvement, 50, false)
	conquests_improvementSetPowerPerTurn(improvement, 1)
	conquests_improvementSetAIHint(improvement, IMPROVEMENT_AIHINT_RESEARCH)
	conquests_buildableSetAdvice(improvement, "A Library will allow us to preserve and access vital knowledge, allowing our scholars to more quickly make progress in their discoveries.")

improvement = conquests_addNewImprovement("Mine", 20, "Iron Working", 50)
	conquests_buildableSetAdvice(improvement, "A Mine will allow the mining of iron, allowing a range of improvements and powerful military units to be built.")

improvement = conquests_addNewImprovement("Temple", 20, "Masonry", 0)
	improvement_temple = improvement
	conquests_buildableSetObsoletedBy(improvement, "Feudalism")
	conquests_improvementSetPowerPerTurn(improvement, 1)
	conquests_improvementSetGrowthRate(improvement, -1)
	conquests_improvementRebellionBonus(improvement, 25)
	conquests_buildableSetAdvice(improvement, "A Temple will keep the population happy, and make your city grow at a faster rate.")

improvement = conquests_addNewImprovement("Walls", 80, "Masonry", 15)
	conquests_buildableSetInfo(improvement, "City Walls increase the defence of your units in the city by 50%, unless the attacker has discovered Gunpowder. They also protect against population losses when your city is attacked, for cities of population 31,000 of less.\n\nReplaces Fort.")
	conquests_buildableSetObsoletedBy(improvement, "Gunpowder")
	conquests_buildableSetReplacedBy(improvement_fort, improvement)
	conquests_buildableSetAdvice(improvement, "A Wall for your city will provide protection from attack.")

improvement = conquests_addNewImprovement("Market", 40, "Trade", 15)
	conquests_improvementSetPowerPerTurn(improvement, 2)
	conquests_buildableSetAdvice(improvement, "A Market will allow us to trade our gold, bringing extra growth to the city.")

-- medieval

improvement = conquests_addNewImprovement("Armourer", 40, "Medieval Arms", 40)
	improvement_armourer = improvement
	conquests_buildableSetRequiresImprovement(improvement, "Mine")
	conquests_buildableSetObsoletedBy(improvement, "Firearms")
	conquests_buildableSetAdvice(improvement, "An Armourer will allow us to build new and advanced weaponry to defeat our enemies.")

improvement = conquests_addNewImprovement("Castle", 40, "Castles", 20)
	conquests_buildableSetInfo(improvement, "A Castle increases the defence of your units in the city by 50%, unless the attacker has discovered Gunpowder.")
	conquests_buildableSetObsoletedBy(improvement, "Gunpowder")
	conquests_improvementSetPowerPerTurn(improvement, 3)
	conquests_improvementRebellionBonus(improvement, 25)
	conquests_buildableSetAdvice(improvement, "A Castle will allow us to defend our city, and increase public order.")

improvement = conquests_addNewImprovement("Church", 40, "Feudalism", 20)
	conquests_buildableSetObsoletedBy(improvement, "Scientific Method")
	conquests_improvementSetPowerPerTurn(improvement, 3)
	conquests_buildableSetReplacedBy(improvement_temple, improvement)
	conquests_improvementSetGrowthRate(improvement, -1)
	conquests_improvementRebellionBonus(improvement, 25)
	conquests_buildableSetAdvice(improvement, "A Church will keep the population happy, and make your city grow at a faster rate.")

improvement = conquests_addNewImprovement("Cathedral", 100, "Feudalism", 10)
	conquests_buildableSetObsoletedBy(improvement, "Scientific Method")
	conquests_improvementSetPowerPerTurn(improvement, 6)
	conquests_improvementSetGrowthRate(improvement, -1)
	conquests_buildableSetRequiresImprovement(improvement, "Church")
	conquests_improvementRebellionBonus(improvement, 25)
	conquests_buildableSetAdvice(improvement, "A Cathedral will keep the population happy, and make your city grow at a faster rate.")

improvement = conquests_addNewImprovement("Port", 60, "Navigation", 15)
	conquests_buildableSetInfo(improvement, "A Port allows exploration and travel by sea.")
	conquests_improvementSetRequiresCoastal(improvement, true)
	conquests_improvementSetTravelRange(improvement, 10, false)
	conquests_improvementSetPowerPerTurn(improvement, 2)
	conquests_buildableSetReplacedBy(improvement_harbour, improvement)
	conquests_buildableSetAdvice(improvement, "A Harbour will allow us to explore the world's oceans.")

improvement = conquests_addNewImprovement("University", 100, "Education", 5)
	conquests_improvementSetResearchMultiplierBonus(improvement, 50, false)
	conquests_buildableSetRequiresImprovement(improvement, "Library")
	conquests_improvementSetPowerPerTurn(improvement, 4)
	conquests_improvementSetAIHint(improvement, IMPROVEMENT_AIHINT_RESEARCH)
	conquests_buildableSetAdvice(improvement, "A University will increase the level of scientific research and progress in our city.")

-- industrial

improvement = conquests_addNewImprovement("Coastal Defence", 100, "Steam Power", 30)
	conquests_buildableSetInfo(improvement, "A Coastal Defence increases the defence bonus against sea attacks to 50%.")
	conquests_improvementSetRequiresCoastal(improvement, true)
	conquests_buildableSetAdvice(improvement, "A Coastal Defence will help defend our naval units against attacks from the sea.")

improvement = conquests_addNewImprovement("Factory", 400, "Industrial Revolution", 30)
	conquests_buildableSetInfo(improvement, "A Factory increases the maximum city size, once you have discovered Combustion.")
	conquests_buildableSetRequiresImprovement(improvement, "Mine")
	conquests_buildableSetReplacedBy(improvement_armourer, improvement)
	conquests_buildableSetAdvice(improvement, "A Factory will allow us to manufacturer a range of modern improvements and military units.")

improvement = conquests_addNewImprovement("Powder Mill", 80, "Gunpowder", 50)
	conquests_buildableSetRequiresImprovement(improvement, "Mine")
	conquests_buildableSetObsoletedBy(improvement, "Motorised Warfare") -- as after we can build Tanks, Gunpowder is no longer required
	conquests_buildableSetAdvice(improvement, "A Powder Mill will allow us to manufacturer gunpowder, allowing us to develop new weapons to blast our enemies to bits!")

improvement = conquests_addNewImprovement("Hospital", 300, "Medicine", 10)
	conquests_improvementSetPowerPerTurn(improvement, 12)
	conquests_improvementSetGrowthRate(improvement, -2)
	conquests_buildableSetAdvice(improvement, "A Hospital will increase the life expectancy of our citizens, helping us to grow faster.")

improvement = conquests_addNewImprovement("School", 300, "Industrial Revolution", 5)
	conquests_buildableSetInfo(improvement, "A School increases the basic rate of scientific research in the city by 2.")
	conquests_improvementSetPowerPerTurn(improvement, 12)
	conquests_improvementSetAIHint(improvement, IMPROVEMENT_AIHINT_RESEARCH)
	conquests_buildableSetAdvice(improvement, "A school will increase the level of education in our city.")

-- modern

improvement = conquests_addNewImprovement("Airport", 600, "Flight", 30)
	conquests_buildableSetInfo(improvement, "An Airport allows air units to bomb from here, or rebase from or to here, and allows exploration and travel by air.")
	conquests_buildableSetRequiresImprovement(improvement, "Factory")
	conquests_improvementSetTravelRange(improvement, biplane_travel_range_c, true)
	conquests_improvementSetPowerPerTurn(improvement, 25)
	conquests_buildableSetAdvice(improvement, "An Airport will allow us to build air units, as well as transport units by air.")

improvement = conquests_addNewImprovement("Anti-Air Guns", 800, "Advanced Flight", 15)
	improvement_antiairguns = improvement
	conquests_buildableSetInfo(improvement, "Can defend against air attacks, defence 4.")
	conquests_buildableSetRequiresImprovement(improvement, "Factory")
	conquests_improvementSetAirDefence(improvement, 4)
	conquests_buildableSetAdvice(improvement, "Anti-Air Guns will defend our city from enemy invasions by air.")

improvement = conquests_addNewImprovement("Lab", 500, "Computer", 5)
	conquests_buildableSetInfo(improvement, "A Lab increases the rate of scientific research in the city by 50%.")
	conquests_buildableSetRequiresImprovement(improvement, "University")
	conquests_improvementSetPowerPerTurn(improvement, 20)
	conquests_improvementSetAIHint(improvement, IMPROVEMENT_AIHINT_RESEARCH)
	conquests_buildableSetAdvice(improvement, "A Lab will allow our scientists to make greater progress in their research.")

improvement = conquests_addNewImprovement("Missile Launcher", 800, "Rocketry", 30)
	conquests_buildableSetInfo(improvement, "A Missile Launcher allows missile units to bomb from here.")
	conquests_buildableSetRequiresImprovement(improvement, "Factory")
	conquests_improvementSetImmuneFromBombing(improvement, true) -- so if a civilization is nuked, they can retaliate
	conquests_buildableSetAdvice(improvement, "A Missile Launcher will allow us to launch missiles against our enemies!")

improvement = conquests_addNewImprovement("Radar Tower", 600, "Advanced Flight", 30)
	conquests_buildableSetInfo(improvement, "A Radar Tower increases the visibility around a city.")
	conquests_buildableSetRequiresImprovement(improvement, "Factory")
	conquests_improvementSetAIHint(improvement, IMPROVEMENT_AIHINT_FOW)
	conquests_buildableSetAdvice(improvement, "A Radar Tower will allow us to monitor the movements of our enemies near the city.")

improvement = conquests_addNewImprovement("SAM Launcher", 1600, "Rocketry", 30)
	conquests_buildableSetInfo(improvement, "Can defend against air attacks, defence 12.")
	conquests_buildableSetRequiresImprovement(improvement, "Factory")
	conquests_improvementSetAirDefence(improvement, 12)
	conquests_buildableSetReplacedBy(improvement_antiairguns, improvement)
	conquests_buildableSetAdvice(improvement, "A SAM Launcher will defend our city from enemy invasions by air.")

improvement = conquests_addNewImprovement("Bomb Shelter", 1000, "Nuclear Missiles", 30)
	conquests_buildableSetInfo(improvement, "May reduce population deaths from nuclear attacks.")
	conquests_buildableSetRequiresImprovement(improvement, "Factory")
	conquests_improvementSetImmuneFromBombing(improvement, true)
	conquests_buildableSetAdvice(improvement, "A Bomb Shelter will help to reduce deaths in the event of a nuclear attack.")

improvement = conquests_addNewImprovement("Spaceport", 2000, "Satellites", 0)
	conquests_buildableSetRequiresImprovement(improvement, "Airport")
	conquests_improvementSetPowerPerTurn(improvement, 50)
	conquests_buildableSetAdvice(improvement, "A Spaceport will show the world how powerful our civilization is.")

improvement = conquests_addNewImprovement("SDI Lasers", 2000, "Space Militarisation", 40)
	conquests_buildableSetInfo(improvement, "80% chance of preventing nuclear attacks to this city.")
	conquests_buildableSetRequiresImprovement(improvement, "Spaceport")
	conquests_buildableSetAdvice(improvement, "SDI Lasers will allow us to shoot down enemy nuclear missiles.")

-- Race specific

improvement = conquests_addNewImprovement("Pyramids", 200, "Masonry", 30)
	conquests_buildableSetInfo(improvement, "")
	conquests_buildableSetObsoletedBy(improvement, "Gunpowder")
	conquests_improvementSetProductionBonus(improvement, 1, true)
	conquests_buildableSetAdvice(improvement, "The Pyramids represent an immense architectural achievement.")

improvement = conquests_addNewImprovement("Colossus", 200, "", 30)
	conquests_buildableSetInfo(improvement, "")
	conquests_buildableSetObsoletedBy(improvement, "Magnetism")
	conquests_improvementSetGrowthRate(improvement, -5)
	conquests_buildableSetAdvice(improvement, "The Colossus will draw people from all over the known world to come to our city.")

improvement = conquests_addNewImprovement("Himeji Castle", 400, "Castles", 30)
	conquests_buildableSetInfo(improvement, "")
	conquests_buildableSetObsoletedBy(improvement, "Industrial Revolution")
	conquests_improvementSetDefenceBonus(improvement, 50, true)
	conquests_buildableSetAdvice(improvement, "Himeji Castle will provide greater defence across our civilization.")

improvement = conquests_addNewImprovement("Great Temple", 200, "Masonry", 30)
	conquests_buildableSetInfo(improvement, "")
	conquests_buildableSetObsoletedBy(improvement, "Gunpowder")
	conquests_improvementSetGrowthRate(improvement, -5)
	conquests_buildableSetAdvice(improvement, "The Great Temple will draw people from all over the known world to come to our city.")

improvement = conquests_addNewImprovement("Colosseum", 200, "Masonry", 30)
	conquests_buildableSetInfo(improvement, "")
	conquests_buildableSetObsoletedBy(improvement, "Industrial Revolution")
	conquests_improvementSetGrowthRate(improvement, -4)
	conquests_buildableSetAdvice(improvement, "The Colosseum will draw people from all over the known world to come to our city.")

improvement = conquests_addNewImprovement("Hammer of Thor", 100, "Sailing", 30)
	conquests_buildableSetInfo(improvement, "")
	conquests_buildableSetObsoletedBy(improvement, "Magnetism")
	conquests_improvementSetAutoVeteranBonus(improvement, true, true)
	conquests_buildableSetAdvice(improvement, "The Hammer of Thor will be a source of inspiration to all our warriors.")

improvement = conquests_addNewImprovement("Apollo Programme", 3000, "Spaceflight", 30)
	conquests_buildableSetInfo(improvement, "")
	conquests_improvementSetResearchMultiplierBonus(improvement, 100, true)
	conquests_buildableSetAdvice(improvement, "The Apollo Programme will be a great scientific and technological achievement for our civilization.")

improvement = conquests_addNewImprovement("Stonehenge", 100, "", 30)
	conquests_buildableSetInfo(improvement, "")
	conquests_buildableSetObsoletedBy(improvement, "Feudalism")
	conquests_improvementSetGrowthRate(improvement, -4)
	conquests_buildableSetAdvice(improvement, "Stonehenge will draw people from all over the known world to come to our city.")

improvement = conquests_addNewImprovement("Eiffel Tower", 800, "Steam Power", 30)
	conquests_buildableSetInfo(improvement, "")
	conquests_buildableSetObsoletedBy(improvement, "Spaceflight")
	conquests_improvementSetProductionBonus(improvement, 2, true)
	conquests_buildableSetAdvice(improvement, "The Pyramids represent an immense architectural achievement.")

improvement = conquests_addNewImprovement("Mir Space Station", 3000, "Satellites", 30)
	conquests_buildableSetInfo(improvement, "")
	conquests_improvementSetResearchMultiplierBonus(improvement, 100, true)
	conquests_buildableSetAdvice(improvement, "The Mir Space Station will be a great scientific and technological achievement for our civilization.")

--[[
improvement = conquests_addNewImprovement("", 40, "", 15)
	conquests_buildableSetInfo(improvement, "")
	conquests_improvementSet(improvement, )
--]]

-- Unit Templates

-- Note that any new units must have a corresponding image in conquests/data/gfx/, called unit_NAME.png, where
-- NAME is the unit's name.

-- Arguments: Name, cost, required technology, attack, defence, moves

-- special

unit_template = conquests_addNewUnitTemplate("Settlers", 20, "", 0, 0, 1)
	conquests_buildableSetInfo(unit_template, "Settlers may only be built in cities of population greater than 10,000.")
	conquests_unitTemplateSetFoot(unit_template, true)
	conquests_unitTemplateSetCanBuildCity(unit_template, true)
	conquests_unitTemplateSetCanBuildRoads(unit_template, true)
	conquests_buildableSetAdvice(unit_template, "Settlers will allow us to build new cities, and expand our civilization.")

-- ancient

unit_template = conquests_addNewUnitTemplate("Archers", 15, "Archery", 2, 1, 1)
	unit_template_archers = unit_template
	conquests_unitTemplateSetFoot(unit_template, true)
	conquests_unitTemplateSetUpgrade(unit_template, true)
	conquests_buildableSetAdvice(unit_template, "These will provide us with a basic unit to attack the enemy.")

unit_template = conquests_addNewUnitTemplate("Catapults", 40, "Mathematics", 6, 1, 1)
	unit_template_catapults = unit_template
	conquests_unitTemplateSetSoundEffectCombat(unit_template, SOUNDEFFECT_BREAK)
	conquests_buildableSetAdvice(unit_template, "Catapults are a devastating weapon of war which we can use to crush the enemy.")

unit_template = conquests_addNewUnitTemplate("Chariots", 40, "The Wheel", 4, 1, 2)
	unit_template_chariots = unit_template
	conquests_unitTemplateSetUpgrade(unit_template, true)
	conquests_buildableSetAdvice(unit_template, "Chariots are a fast and powerful attack weapon of the ancient era.")

unit_template = conquests_addNewUnitTemplate("Horsemen", 20, "Horse Riding", 2, 1, 2)
	unit_template_horsemen = unit_template
	conquests_buildableSetAdvice(unit_template, "Horsemen can quickly explore the land.")

unit_template = conquests_addNewUnitTemplate("Swordsmen", 30, "Iron Working", 3, 2, 1)
	unit_template_swordsmen = unit_template
	conquests_unitTemplateSetFoot(unit_template, true)
	conquests_unitTemplateSetCanBuildRoads(unit_template, true)
	conquests_unitTemplateSetUpgrade(unit_template, true)
	--conquests_buildableSetRequiresImprovement(unit_template, "Mine")
	--no longer need mine, now done via Iron element
	conquests_buildableSetAdvice(unit_template, "Swordsmen will allow us to build up a powerful army.")

unit_template = conquests_addNewUnitTemplate("Peasants", 10, "", 1, 1, 1)
	unit_template_peasants = unit_template
	conquests_unitTemplateSetFoot(unit_template, true)
	conquests_unitTemplateSetCanBuildRoads(unit_template, true)
	conquests_unitTemplateSetUpgrade(unit_template, true)
	conquests_buildableSetAdvice(unit_template, "Peasants can be used to build roads for our civilization, as well as providing arrow fodder.")

unit_template = conquests_addNewUnitTemplate("Spearmen", 20, "Bronze Working", 1, 2, 1)
	unit_template_spearmen = unit_template
	conquests_unitTemplateSetFoot(unit_template, true)
	conquests_unitTemplateSetUpgrade(unit_template, true)
	conquests_buildableSetAdvice(unit_template, "Spearmen will defend our city against enemy attack.")

-- medieval

unit_template = conquests_addNewUnitTemplate("Knights", 40, "Medieval Arms", 5, 2, 2)
	unit_template_knights = unit_template
	conquests_buildableSetRequiresImprovement(unit_template, "Armourer")
	conquests_buildableSetReplacedBy(unit_template_chariots, unit_template)
	conquests_buildableSetReplacedBy(unit_template_horsemen, unit_template)
	conquests_buildableSetAdvice(unit_template, "Knights are a fast and powerful force that can be used to crush the enemy.")

unit_template = conquests_addNewUnitTemplate("Men-At-Arms", 30, "Medieval Arms", 3, 3, 1)
	unit_template_men_at_arms = unit_template
	conquests_unitTemplateSetFoot(unit_template, true)
	conquests_unitTemplateSetCanBuildRoads(unit_template, true)
	conquests_unitTemplateSetUpgrade(unit_template, true)
	conquests_buildableSetRequiresImprovement(unit_template, "Armourer")
	conquests_buildableSetReplacedBy(unit_template_swordsmen, unit_template)
	conquests_buildableSetAdvice(unit_template, "Men-At-Arms will allow us to build up a powerful army.")

unit_template = conquests_addNewUnitTemplate("Pikemen", 25, "Medieval Arms", 1, 3, 1)
	unit_template_pikemen = unit_template
	conquests_unitTemplateSetFoot(unit_template, true)
	conquests_unitTemplateSetUpgrade(unit_template, true)
	conquests_buildableSetReplacedBy(unit_template_spearmen, unit_template)
	conquests_buildableSetAdvice(unit_template, "Pikemen will provide improved defence for our cities.")

-- industrial

unit_template = conquests_addNewUnitTemplate("Cannon", 60, "Gunpowder", 8, 1, 1)
	unit_template_cannon = unit_template
	conquests_buildableSetReplacedBy(unit_template_catapults, unit_template)
	conquests_unitTemplateSetSoundEffectCombat(unit_template, SOUNDEFFECT_BREAK)
	conquests_buildableSetAdvice(unit_template, "A cannon will allow us to blast our enemies to bits!")

unit_template = conquests_addNewUnitTemplate("Cuirassiers", 80, "Firearms", 6, 3, 3)
	unit_template_cuirassiers = unit_template
	conquests_buildableSetReplacedBy(unit_template_knights, unit_template)
	conquests_unitTemplateSetSoundEffectCombat(unit_template, SOUNDEFFECT_BREAK)
	conquests_buildableSetAdvice(unit_template, "Cuirassiers are a fast, powerful unit.")

unit_template = conquests_addNewUnitTemplate("Militia", 20, "Nationalism", 2, 2, 1)
	conquests_unitTemplateSetFoot(unit_template, true)
	conquests_unitTemplateSetCanBuildRoads(unit_template, true)
	conquests_buildableSetReplacedBy(unit_template_peasants, unit_template)
	conquests_buildableSetReplacedBy(unit_template_archers, unit_template)
	conquests_buildableSetAdvice(unit_template, "Militia can be used to build roads for our civilization, as well as providing cannon fodder.")

unit_template = conquests_addNewUnitTemplate("Musketeers", 50, "Firearms", 3, 6, 1)
	unit_template_musketeers = unit_template
	conquests_unitTemplateSetFoot(unit_template, true)
	conquests_unitTemplateSetCanBuildRoads(unit_template, true)
	conquests_unitTemplateSetUpgrade(unit_template, true)
	conquests_buildableSetReplacedBy(unit_template_men_at_arms, unit_template)
	conquests_buildableSetReplacedBy(unit_template_pikemen, unit_template)
	conquests_unitTemplateSetSoundEffectCombat(unit_template, SOUNDEFFECT_BREAK)
	conquests_buildableSetAdvice(unit_template, "Musketeers will defend our cities using the newly developed firearms.")

unit_template = conquests_addNewUnitTemplate("Riflemen", 80, "Nationalism", 3, 8, 1)
	unit_template_riflemen = unit_template
	conquests_unitTemplateSetFoot(unit_template, true)
	conquests_unitTemplateSetCanBuildRoads(unit_template, true)
	conquests_unitTemplateSetUpgrade(unit_template, true)
	conquests_buildableSetReplacedBy(unit_template_musketeers, unit_template)
	conquests_unitTemplateSetSoundEffectCombat(unit_template, SOUNDEFFECT_BREAK)
	conquests_buildableSetAdvice(unit_template, "Riflemen have improved accuracy shooting at the enemy, and will defend our cities more effectively.")

-- modern

unit_template = conquests_addNewUnitTemplate("Infantry", 200, "Explosives", 8, 14, 1)
	unit_template_infantry = unit_template
	conquests_unitTemplateSetFoot(unit_template, true)
	conquests_unitTemplateSetCanBuildRoads(unit_template, true)
	conquests_unitTemplateSetUpgrade(unit_template, true)
	conquests_buildableSetRequiresImprovement(unit_template, "Factory")
	conquests_buildableSetReplacedBy(unit_template_riflemen, unit_template)
	conquests_buildableSetReplacedBy(unit_template_cannon, unit_template)
	conquests_unitTemplateSetSoundEffectCombat(unit_template, SOUNDEFFECT_BREAK)
	conquests_buildableSetAdvice(unit_template, "Infantry provide us with a modern fighting unit, good for both attack and defence.")

unit_template = conquests_addNewUnitTemplate("Tanks", 800, "Motorised Warfare", 24, 12, 3)
	unit_template_tanks = unit_template
	conquests_buildableSetRequiresImprovement(unit_template, "Factory")
	conquests_buildableSetReplacedBy(unit_template_cuirassiers, unit_template)
	conquests_unitTemplateSetSoundEffectCombat(unit_template, SOUNDEFFECT_GUNSHOT)
	conquests_buildableSetAdvice(unit_template, "Tanks will allow us to break through the stalemate of trench warfare. Let us use these new weapons to defeat the enemy!")

unit_template = conquests_addNewUnitTemplate("Modern Infantry", 800, "Rocketry", 16, 28, 1)
	conquests_unitTemplateSetFoot(unit_template, true)
	conquests_unitTemplateSetCanBuildRoads(unit_template, true)
	conquests_buildableSetRequiresImprovement(unit_template, "Factory")
	conquests_buildableSetReplacedBy(unit_template_infantry, unit_template)
	conquests_unitTemplateSetSoundEffectCombat(unit_template, SOUNDEFFECT_GUNSHOT)
	conquests_buildableSetAdvice(unit_template, "These units carry the latest weaponry, making them excellent at attack and defence.")

unit_template = conquests_addNewUnitTemplate("Modern Tanks", 2500, "Microprocessor", 36, 24, 4)
	conquests_buildableSetRequiresImprovement(unit_template, "Factory")
	--conquests_buildableSetReplacedBy(unit_template_tanks, unit_template)
	conquests_unitTemplateSetSoundEffectCombat(unit_template, SOUNDEFFECT_GUNSHOT)
	conquests_buildableSetAdvice(unit_template, "These tanks are the most advanced fighting units the world has seen!")

-- air units

unit_template = conquests_addNewUnitTemplate("Biplanes", 100, "Flight", 0, 0, 1)
	unit_template_biplanes = unit_template
	conquests_unitTemplateSetAir(unit_template, 1, 1, biplane_travel_range_c, false)
	conquests_unitTemplateSetVisibilityRange(unit_template, biplane_travel_range_c)
	conquests_unitTemplateSetBombard(unit_template, 10, 40)
	conquests_buildableSetAdvice(unit_template, "Let us take advantage of the new flying machines to find a new way to attack the enemy!")

unit_template = conquests_addNewUnitTemplate("Fighters", 200, "Advanced Flight", 0, 0, 1)
	unit_template_fighters = unit_template
	conquests_unitTemplateSetAir(unit_template, 0, 8, bombers_travel_range_c, false)
	conquests_unitTemplateSetVisibilityRange(unit_template, bombers_travel_range_c)
	conquests_unitTemplateSetBombard(unit_template, 0, 0)
	conquests_buildableSetRequiresImprovement(unit_template, "Airport")
	conquests_buildableSetReplacedBy(unit_template_biplanes, unit_template)
	conquests_buildableSetAdvice(unit_template, "We need to defend ourselves from possible attack from the air.")

unit_template = conquests_addNewUnitTemplate("Bombers", 400, "Advanced Flight", 0, 0, 1)
	unit_template_bombers = unit_template
	conquests_unitTemplateSetAir(unit_template, 8, 0, bombers_travel_range_c, false)
	conquests_unitTemplateSetVisibilityRange(unit_template, bombers_travel_range_c)
	conquests_unitTemplateSetBombard(unit_template, 25, 500)
	conquests_buildableSetRequiresImprovement(unit_template, "Airport")
	conquests_buildableSetAdvice(unit_template, "Let us blast the enemy from above!")

unit_template = conquests_addNewUnitTemplate("Jet Fighters", 800, "Rocketry", 0, 0, 1)
	conquests_unitTemplateSetAir(unit_template, 0, 24, jet_travel_range_c, false)
	conquests_unitTemplateSetVisibilityRange(unit_template, jet_travel_range_c)
	conquests_unitTemplateSetBombard(unit_template, 0, 0)
	conquests_buildableSetRequiresImprovement(unit_template, "Airport")
	conquests_buildableSetReplacedBy(unit_template_fighters, unit_template)
	conquests_buildableSetAdvice(unit_template, "We need to defend ourselves from possible attack from the air.")

unit_template = conquests_addNewUnitTemplate("Jet Bombers", 1600, "Rocketry", 0, 0, 1)
	conquests_unitTemplateSetAir(unit_template, 24, 0, jet_travel_range_c, false)
	conquests_unitTemplateSetVisibilityRange(unit_template, jet_travel_range_c)
	conquests_unitTemplateSetBombard(unit_template, 33, 2000)
	conquests_buildableSetRequiresImprovement(unit_template, "Airport")
	conquests_buildableSetReplacedBy(unit_template_bombers, unit_template)
	conquests_buildableSetAdvice(unit_template, "These bombers allow us to bomb enemy installations with increased accuracy.")

unit_template = conquests_addNewUnitTemplate("Stealth Bombers", 2400, "Stealth", 0, 0, 1)
	conquests_unitTemplateSetAir(unit_template, 36, 0, jet_travel_range_c, false)
	conquests_unitTemplateSetVisibilityRange(unit_template, jet_travel_range_c)
	conquests_unitTemplateSetBombard(unit_template, 33, 2000)
	conquests_buildableSetRequiresImprovement(unit_template, "Airport")
	conquests_buildableSetAdvice(unit_template, "Now we can bomb the enemy with less chance of failure.")

unit_template = conquests_addNewUnitTemplate("Cruise Missile", 200, "Rocketry", 0, 0, 1)
	conquests_unitTemplateSetAir(unit_template, 0, 0, 30, true)
	conquests_unitTemplateSetVisibilityRange(unit_template, 0)
	conquests_unitTemplateSetBombard(unit_template, 50, 2000)
	conquests_buildableSetRequiresImprovement(unit_template, "Missile Launcher")
	conquests_buildableSetAdvice(unit_template, "Let us bomb the enemy's installations from a great distance!")

unit_template = conquests_addNewUnitTemplate("Fission Bomb", 800, "Fission", 0, 0, 1)
	unit_template_fission_bomb = unit_template
	conquests_unitTemplateSetAir(unit_template, 0, 0, bombers_travel_range_c, true)
	conquests_unitTemplateSetVisibilityRange(unit_template, 0)
	conquests_unitTemplateSetNuclearType(unit_template, NUCLEARTYPE_FISSION)
	conquests_buildableSetRequiresImprovement(unit_template, "Airport")
	conquests_buildableSetAdvice(unit_template, "This new and devastating weapon will take out an entire city, and make enemies think twice about attacking us!")

unit_template = conquests_addNewUnitTemplate("Nuclear Missile", 1200, "Nuclear Missiles", 0, 0, 1)
	conquests_unitTemplateSetAir(unit_template, 0, 0, 100, true)
	conquests_unitTemplateSetVisibilityRange(unit_template, 0)
	conquests_unitTemplateSetNuclearType(unit_template, NUCLEARTYPE_FUSION)
	conquests_buildableSetRequiresImprovement(unit_template, "Missile Launcher")
	conquests_buildableSetAdvice(unit_template, "These powerful weapons are essential to defend our nation.")

-- sea units

unit_template = conquests_addNewUnitTemplate("Galleons", 120, "Magnetism", 0, 0, 1)
	unit_template_galleons = unit_template
	conquests_unitTemplateSetSea(unit_template, 1, 2)
	conquests_buildableSetRequiresImprovement(unit_template, "Port")
	conquests_buildableSetAdvice(unit_template, "Let us attack the enemy by sea!")

unit_template = conquests_addNewUnitTemplate("Ironclads", 300, "Steam Power", 0, 0, 1)
	unit_template_ironclads = unit_template
	conquests_unitTemplateSetSea(unit_template, 8, 4)
	conquests_buildableSetRequiresImprovement(unit_template, "Port")
	-- n.b., don't replace Galleons - still has advantage of being a cheap unit for player to build, compared with Ironclads.
	conquests_buildableSetAdvice(unit_template, "These new iron vessels will smash Galleons with ease.")

unit_template = conquests_addNewUnitTemplate("Dreadnoughts", 600, "Explosives", 0, 0, 1)
	unit_template_dreadnoughts = unit_template
	conquests_unitTemplateSetSea(unit_template, 16, 5)
	conquests_buildableSetRequiresImprovement(unit_template, "Port")
	conquests_buildableSetReplacedBy(unit_template_galleons, unit_template)
	conquests_buildableSetReplacedBy(unit_template_ironclads, unit_template)
	conquests_buildableSetAdvice(unit_template, "With their large guns, these units will allow us to rule the seas.")

unit_template = conquests_addNewUnitTemplate("Battleships", 1200, "Rocketry", 0, 0, 1)
	conquests_unitTemplateSetSea(unit_template, 24, 6)
	conquests_buildableSetRequiresImprovement(unit_template, "Port")
	conquests_buildableSetReplacedBy(unit_template_dreadnoughts, unit_template)
	conquests_buildableSetAdvice(unit_template, "We must build up our force to rule the world's oceans.")

--[[
unit_template = conquests_addNewUnitTemplate("", 20, "", 0, 0, 1)
	conquests_buildableSetInfo(unit_template, "")
	conquests_unitTemplateSet(unit_template, )
--]]

print("generate_buildables.lua exit")
