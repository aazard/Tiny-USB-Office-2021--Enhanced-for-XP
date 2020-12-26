print("generate_elements.lua enter")

-- Arguments: Name, required improvement, required technology, initial amount for new city (if have required technology), base per turn
-- Note that if an improvement is required, then this includes any improvement that replaces the required improvement

element = conquests_addNewElement("Wood", "", "", 0, 0)
	conquests_elementSetTerrainOutput(element, TYPE_FOREST, 1)

element = conquests_addNewElement("Stone", "Quarry", "", 0, 5)
	conquests_elementSetTerrainOutput(element, TYPE_MOUNTAINS, 1)

element = conquests_addNewElement("Bronze", "", "Bronze Working", 20, 2)
	conquests_elementSetTerrainOutput(element, TYPE_HILLS, 1)

element = conquests_addNewElement("Iron", "Mine", "Iron Working", 0, 5)
	conquests_elementSetTerrainOutput(element, TYPE_HILLS, 1)

element = conquests_addNewElement("Gunpowder", "Powder Mill", "Gunpowder", 0, 5)

element = conquests_addNewElement("Oil", "", "Combustion", 0, 0)
	conquests_elementSetBonusOutput(element, "Oil", 30)
	-- We set Combustion as a technology, even though it's also required for the Oil bonus. This is so that Oil
	-- doesn't show in the City window, until we've discovered it.

-- now add required elements for buildables - needs to be done here, not in generate_buildables.lua, as there we won't have created the elements yet

-- improvements:

conquests_buildableSetRequiresElement("Barracks", "Stone", 10)

conquests_buildableSetRequiresElement("Aqueduct", "Stone", 50)

conquests_buildableSetRequiresElement("Fort", "Wood", 20)

conquests_buildableSetRequiresElement("Library", "Stone", 10)

conquests_buildableSetRequiresElement("Temple", "Stone", 10)

conquests_buildableSetRequiresElement("Walls", "Stone", 50)

conquests_buildableSetRequiresElement("Castle", "Stone", 50)

conquests_buildableSetRequiresElement("Church", "Stone", 30)

conquests_buildableSetRequiresElement("Cathedral", "Stone", 50)

conquests_buildableSetRequiresElement("Port", "Stone", 20)
conquests_buildableSetRequiresElement("Port", "Iron", 20)

conquests_buildableSetRequiresElement("University", "Stone", 50)

conquests_buildableSetRequiresElement("Coastal Defence", "Stone", 40)
conquests_buildableSetRequiresElement("Coastal Defence", "Iron", 20)

conquests_buildableSetRequiresElement("Factory", "Stone", 40)
conquests_buildableSetRequiresElement("Factory", "Iron", 40)

conquests_buildableSetRequiresElement("Hospital", "Stone", 50)
conquests_buildableSetRequiresElement("Hospital", "Iron", 40)

conquests_buildableSetRequiresElement("School", "Stone", 40)

conquests_buildableSetRequiresElement("Airport", "Stone", 40)
conquests_buildableSetRequiresElement("Airport", "Iron", 40)
conquests_buildableSetRequiresElement("Airport", "Oil", 100)

conquests_buildableSetRequiresElement("Anti-Air Guns", "Iron", 20)

conquests_buildableSetRequiresElement("Lab", "Stone", 30)
conquests_buildableSetRequiresElement("Lab", "Iron", 30)

conquests_buildableSetRequiresElement("Missile Launcher", "Iron", 20)

conquests_buildableSetRequiresElement("Radar Tower", "Stone", 30)
conquests_buildableSetRequiresElement("Radar Tower", "Iron", 40)

conquests_buildableSetRequiresElement("SAM Launcher", "Iron", 40)
conquests_buildableSetRequiresElement("SAM Launcher", "Oil", 50)

conquests_buildableSetRequiresElement("Bomb Shelter", "Stone", 10)
conquests_buildableSetRequiresElement("Bomb Shelter", "Iron", 30)

conquests_buildableSetRequiresElement("Spaceport", "Stone", 50)
conquests_buildableSetRequiresElement("Spaceport", "Iron", 60)
conquests_buildableSetRequiresElement("Spaceport", "Oil", 100)

conquests_buildableSetRequiresElement("SDI Lasers", "Iron", 50)

conquests_buildableSetRequiresElement("Pyramids", "Stone", 50)

conquests_buildableSetRequiresElement("Colossus", "Bronze", 50)

conquests_buildableSetRequiresElement("Himeji Castle", "Stone", 100)

conquests_buildableSetRequiresElement("Great Temple", "Stone", 50)

conquests_buildableSetRequiresElement("Colosseum", "Stone", 50)

conquests_buildableSetRequiresElement("Hammer of Thor", "Stone", 20)

conquests_buildableSetRequiresElement("Apollo Programme", "Oil", 100)

conquests_buildableSetRequiresElement("Stonehenge", "Stone", 30)

conquests_buildableSetRequiresElement("Eiffel Tower", "Iron", 50)

conquests_buildableSetRequiresElement("Mir Space Station", "Oil", 50)

-- units:

conquests_buildableSetRequiresElement("Catapults", "Wood", 20)
conquests_buildableSetRequiresElement("Catapults", "Stone", 10)

conquests_buildableSetRequiresElement("Swordsmen", "Iron", 20)

conquests_buildableSetRequiresElement("Spearmen", "Bronze", 20)

conquests_buildableSetRequiresElement("Knights", "Iron", 30)

conquests_buildableSetRequiresElement("Men-At-Arms", "Iron", 30)

conquests_buildableSetRequiresElement("Pikemen", "Iron", 10)

conquests_buildableSetRequiresElement("Cannon", "Iron", 30)
conquests_buildableSetRequiresElement("Cannon", "Gunpowder", 20)

conquests_buildableSetRequiresElement("Cuirassiers", "Gunpowder", 20)

conquests_buildableSetRequiresElement("Musketeers", "Gunpowder", 20)

conquests_buildableSetRequiresElement("Tanks", "Iron", 60)
conquests_buildableSetRequiresElement("Tanks", "Oil", 40)

conquests_buildableSetRequiresElement("Modern Infantry", "Oil", 50)

conquests_buildableSetRequiresElement("Modern Tanks", "Iron", 60)
conquests_buildableSetRequiresElement("Modern Tanks", "Oil", 60)

conquests_buildableSetRequiresElement("Biplanes", "Oil", 20)

conquests_buildableSetRequiresElement("Fighters", "Oil", 40)

conquests_buildableSetRequiresElement("Bombers", "Iron", 40)
conquests_buildableSetRequiresElement("Bombers", "Oil", 40)

conquests_buildableSetRequiresElement("Jet Fighters", "Iron", 60)
conquests_buildableSetRequiresElement("Jet Fighters", "Oil", 60)

conquests_buildableSetRequiresElement("Jet Bombers", "Iron", 60)
conquests_buildableSetRequiresElement("Jet Bombers", "Oil", 60)

conquests_buildableSetRequiresElement("Stealth Bombers", "Iron", 60)
conquests_buildableSetRequiresElement("Stealth Bombers", "Oil", 60)

conquests_buildableSetRequiresElement("Cruise Missile", "Iron", 20)
conquests_buildableSetRequiresElement("Cruise Missile", "Oil", 60)

conquests_buildableSetRequiresElement("Nuclear Missile", "Iron", 20)
conquests_buildableSetRequiresElement("Nuclear Missile", "Oil", 60)

conquests_buildableSetRequiresElement("Galleons", "Wood", 50)

conquests_buildableSetRequiresElement("Ironclads", "Iron", 60)

conquests_buildableSetRequiresElement("Dreadnoughts", "Iron", 70)
conquests_buildableSetRequiresElement("Dreadnoughts", "Oil", 80)

conquests_buildableSetRequiresElement("Battleships", "Iron", 80)
conquests_buildableSetRequiresElement("Battleships", "Oil", 100)

print("generate_elements.lua exit")
