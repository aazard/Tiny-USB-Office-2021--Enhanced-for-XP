print("generate_technologies.lua enter")

-- N.B., although this file can be edited to customise the game behaviour, some effects of
-- technology are hardcoded.
-- Also technologies should not be removed, as there is the risk of unstable behaviour (if
-- internal game logic assumes that a technology exists).

-- Arguments: Name, cost, required technology 1, required technology 2, age, ai weighting

-- ancient

conquests_addNewTechnology("Agriculture", 100, "", "", AGE_ANCIENT, 20)
conquests_addNewTechnology("Alphabet", 100, "", "", AGE_ANCIENT, 10)
conquests_addNewTechnology("Archery", 100, "", "", AGE_ANCIENT, 10)
conquests_addNewTechnology("Bronze Working", 100, "", "", AGE_ANCIENT, 20)
conquests_addNewTechnology("Masonry", 100, "", "", AGE_ANCIENT, 10)
technology = conquests_addNewTechnology("Sailing", 100, "", "", AGE_ANCIENT, 10)
	conquests_technologySetTerrain(technology, TYPE_OCEAN)
technology = conquests_addNewTechnology("The Wheel", 150, "", "", AGE_ANCIENT, 10)
	conquests_technologySetTerrain(technology, TYPE_FOREST)

conquests_addNewTechnology("Construction", 300, "Masonry", "", AGE_ANCIENT, 10)
technology = conquests_addNewTechnology("Iron Working", 300, "Bronze Working", "", AGE_ANCIENT, 30)
	conquests_technologySetTerrain(technology, TYPE_HILLS)
conquests_addNewTechnology("Horse Riding", 300, "The Wheel", "", AGE_ANCIENT, 10)
conquests_addNewTechnology("Mathematics", 300, "Alphabet", "", AGE_ANCIENT, 30)
technology = conquests_addNewTechnology("Maps", 250, "Sailing", "", AGE_ANCIENT, 30)
	conquests_technologySetInfo(technology, "Allows exchanging maps with other Civilizations (that also have this technology).")
conquests_addNewTechnology("Military Tactics", 500, "Archery", "Iron Working", AGE_ANCIENT, 20)
technology = conquests_addNewTechnology("Writing", 250, "Alphabet", "", AGE_ANCIENT, 20)
	conquests_technologySetInfo(technology, "Allows making Right Of Passage agreements with other Civilizations (that also have this technology).")

conquests_addNewTechnology("Trade", 400, "Mathematics", "", AGE_ANCIENT, 10)

-- medieval

conquests_addNewTechnology("Castles", 800, "Construction", "Mathematics", AGE_MEDIEVAL, 30)
conquests_addNewTechnology("Education", 600, "Mathematics", "Writing", AGE_MEDIEVAL, 20)
conquests_addNewTechnology("Feudalism", 800, "Military Tactics", "Horse Riding", AGE_MEDIEVAL, 30)
conquests_addNewTechnology("Medieval Arms", 1000, "Feudalism", "", AGE_MEDIEVAL, 50)
conquests_addNewTechnology("Navigation", 600, "Mathematics", "Maps", AGE_MEDIEVAL, 20)

technology = conquests_addNewTechnology("Gunpowder", 1600, "Medieval Arms", "Castles", AGE_MEDIEVAL, 40)
	conquests_technologySetInfo(technology, "Enemy walls, forts and castles no longer have any effect.")
conquests_addNewTechnology("Firearms", 2000, "Gunpowder", "", AGE_MEDIEVAL, 50)
technology = conquests_addNewTechnology("Magnetism", 1600, "Navigation", "", AGE_MEDIEVAL, 40)
	conquests_technologySetInfo(technology, "Increases range of ports.")
conquests_addNewTechnology("Physics", 1000, "Education", "Navigation", AGE_MEDIEVAL, 30)

-- industrial

technology = conquests_addNewTechnology("Medicine", 1600, "Physics", "", AGE_INDUSTRIAL, 30)
	conquests_technologySetInfo(technology, "Increases attack and defence of units by 20%.")
technology = conquests_addNewTechnology("Scientific Method", 1600, "Magnetism", "Medicine", AGE_INDUSTRIAL, 30)
	conquests_technologySetInfo(technology, "Improves effects of Universities by 10%.")
conquests_addNewTechnology("Electricity", 1800, "Scientific Method", "", AGE_INDUSTRIAL, 30)
technology = conquests_addNewTechnology("Steam Power", 2000, "Gunpowder", "Physics", AGE_INDUSTRIAL, 50)
	conquests_technologySetInfo(technology, "Allows railways, and increases the range of ports to worldwide. Cities with maximum stock of an element can distribute the excess to other cities.")
technology = conquests_addNewTechnology("Agricultural Revolution", 2400, "Steam Power", "", AGE_INDUSTRIAL, 50)
	conquests_technologySetInfo(technology, "Increases maximum city sizes, and adds 2 to city production.")
technology = conquests_addNewTechnology("Industrial Revolution", 3000, "Agricultural Revolution", "", AGE_INDUSTRIAL, 50)
	conquests_technologySetInfo(technology, "Adds 4 to city production.")
technology = conquests_addNewTechnology("Nationalism", 2400, "Agricultural Revolution", "Firearms", AGE_INDUSTRIAL, 30)
	conquests_technologySetPreventsRebellion(technology)
technology = conquests_addNewTechnology("Combustion", 3200, "Industrial Revolution", "", AGE_INDUSTRIAL, 40)
	conquests_technologySetInfo(technology, "Increases maximum city sizes for cities that also have a factory.")

-- modern

conquests_addNewTechnology("Atomic Theory", 3200, "Electricity", "", AGE_MODERN, 30)
conquests_addNewTechnology("Computer", 6400, "Atomic Theory", "", AGE_MODERN, 30)
conquests_addNewTechnology("Explosives", 3200, "Combustion", "Nationalism", AGE_MODERN, 40)
conquests_addNewTechnology("Motorised Warfare", 3200, "Explosives", "", AGE_MODERN, 40)
conquests_addNewTechnology("Flight", 2400, "Combustion", "", AGE_MODERN, 30)
technology = conquests_addNewTechnology("Fission", 10000, "Atomic Theory", "Explosives", AGE_MODERN, 50)
	conquests_technologySetAIHint(technology, TECHNOLOGY_AIHINT_REQUIRES_AIRPORT)
technology = conquests_addNewTechnology("Advanced Flight", 6400, "Flight", "Motorised Warfare", AGE_MODERN, 30)
	conquests_technologySetInfo(technology, "Increases the range of airports.")
technology = conquests_addNewTechnology("Rocketry", 12000, "Advanced Flight", "", AGE_MODERN, 30)
	conquests_technologySetInfo(technology, "Increases the range of airports.")
conquests_addNewTechnology("Nuclear Missiles", 14000, "Fission", "Rocketry", AGE_MODERN, 40)
technology = conquests_addNewTechnology("Spaceflight", 12000, "Computer", "Rocketry", AGE_MODERN, 20)
	conquests_technologySetInfo(technology, "Reveals entire world map.")
technology = conquests_addNewTechnology("Satellites", 20000, "Spaceflight", "", AGE_MODERN, 30)
	conquests_technologySetInfo(technology, "Increases attack and defence of units by 20%; eliminates fog of war.")
conquests_addNewTechnology("Microprocessor", 16000, "Spaceflight", "", AGE_MODERN, 30)
conquests_addNewTechnology("Stealth", 20000, "Microprocessor", "", AGE_MODERN, 30)
technology = conquests_addNewTechnology("Genetics", 25000, "Microprocessor", "", AGE_MODERN, 20)
	conquests_technologySetInfo(technology, "Increases rate of city growth.")
conquests_addNewTechnology("Space Militarisation", 25000, "Satellites", "Microprocessor", AGE_MODERN, 30)

print("generate_technologies.lua exit")
