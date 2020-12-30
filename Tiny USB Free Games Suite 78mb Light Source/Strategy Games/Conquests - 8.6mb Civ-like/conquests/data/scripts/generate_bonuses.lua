print("generate_bonuses.lua enter")

-- Arguments: Name, red, green, blue, terrain, required improvement, required technology, bonus production, bonus reduced growth time
-- Note that if an improvement is required, then this includes any improvement that replaces the required improvement (e.g., so if a Harbour is required, then a Port will also satisfy this)

--conquests_addNewBonus("Iron", 160, 160, 160, TYPE_HILLS, "Mine", "Iron Working", 1, 0) -- Iron is now an Element
conquests_addNewBonus("Coal", 32, 32, 32, TYPE_HILLS, "Mine", "Steam Power", 5, 0)
conquests_addNewBonus("Wine", 240, 32, 240, TYPE_HILLS, "", "", 0, 1)
conquests_addNewBonus("Gold", 240, 160, 16, TYPE_HILLS, "Market", "", 0, 1)
	conquests_buildableSetRequiresBonus("Market", "Gold")
conquests_addNewBonus("Sheep", 240, 240, 240, TYPE_GRASSLAND, "Farmland", "", 0, 1)
conquests_addNewBonus("Fish", 240, 160, 0, TYPE_OCEAN, "Harbour", "Sailing", 0, 1)
bonus = conquests_addNewBonus("Oil", 0, 0, 0, TYPE_OCEAN, "", "Combustion", 0, 0)
	conquests_bonusAddTerrain(bonus, TYPE_DESERT);
	conquests_bonusAddTerrain(bonus, TYPE_ARTIC);

print("generate_bonuses.lua exit")
