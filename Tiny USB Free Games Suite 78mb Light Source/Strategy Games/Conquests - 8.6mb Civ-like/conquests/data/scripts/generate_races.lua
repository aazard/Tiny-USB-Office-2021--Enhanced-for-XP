-- This script may be modified to change the civilizations in the game, along with their
-- colours, graphical image, starting technology and city names.
-- Civilizations can also be added or removed, though there must be at least 7 civilizations.

print("generate_races.lua enter")

--[[
Ancient:
Egyptians (yellow) [Agriculture] (f)
Greeks (pink) [Alphabet] (m)
Japanese (silver) [The Wheel] (m)
Mayans (purple) [Alphabet] (f)
Romans (white) [Bronze Working] (m)
Vikings (brown) [Sailing] (m)

Modern:
Americans (light blue) [Alphabet] (m)
English (orange) [Sailing] (f)
French (green) [Archery] (f)
Russians (dark red) [Masonry] (m)

Europe: iiiii
Africa: i
N America: i
S America: i
Asia: ii
--]]

-- Arguments: Name, Adjective, red, green, blue, image
race = conquests_addNewRace("The Romans", "Roman", "Julius Caesar", 255, 255, 255, "data/gfx/civs/romans.jpg")
--[[
conquests_raceSetInfo(race, "The Romans were one of the largest and most powerful civilizations of the ancient world. "
	.. "Centered on the city of Rome, they came to dominate Europe for hundreds of years, until overrun by Barbarian "
	.. "invasions.")
--]]
conquests_raceSetStartingTechnology(race, "Bronze Working")
conquests_raceAddCityName(race, "Rome")
conquests_raceAddCityName(race, "Veii")
conquests_raceAddCityName(race, "Antium")
conquests_raceAddCityName(race, "Cumae")
conquests_raceAddCityName(race, "Neapolis")
conquests_raceAddCityName(race, "Pompeii")
conquests_raceAddCityName(race, "Pisae")
conquests_raceAddCityName(race, "Ravenna")
conquests_raceAddCityName(race, "Hispalis")
conquests_raceAddCityName(race, "Viroconium")
conquests_raceAddCityName(race, "Lugundum")
conquests_raceAddCityName(race, "Lutetia")
conquests_raceAddCityName(race, "Byzantium")
conquests_raceAddCityName(race, "Brundisium")
conquests_raceAddCityName(race, "Syracuse")
conquests_raceAddCityName(race, "Caesaraugusta")
conquests_raceAddCityName(race, "Palmyra")
conquests_raceAddCityName(race, "Jerusalem")
conquests_raceAddCityName(race, "Caeserea")
conquests_raceAddCityName(race, "Tarentum")
conquests_raceAddCityName(race, "Nicomedia")
conquests_raceAddCityName(race, "Seleucia")
conquests_raceAddCityName(race, "Artaxata")
conquests_raceAddCityName(race, "Aurelianorum")
conquests_raceAddCityName(race, "Hippo Regius")
conquests_raceAddCityName(race, "Nicopolis")

conquests_buildableSetRaceSpecific("Colosseum", "The Romans");

race = conquests_addNewRace("The English", "English", "Elizabeth I", 255, 64, 0, "data/gfx/civs/english.jpg")
--[[
conquests_raceSetInfo(race, "The Kingdom of England originated from Anglo-Saxon settlements. Following the Norman "
	.. "conquest of 1066, England grew in power. Under Queen Elizabeth I, England expanded its lands, creating "
	.. "overseas colonies, and building an empire. After the unification with Scotland in 1707, the new United "
	.. "Kingdom grew to become the largest empire in history, at its height spanning a quarter of the world's land.")
--]]
conquests_raceSetStartingTechnology(race, "Sailing")
conquests_raceAddCityName(race, "London")
conquests_raceAddCityName(race, "York")
conquests_raceAddCityName(race, "Nottingham")
conquests_raceAddCityName(race, "Hastings")
conquests_raceAddCityName(race, "Canterbury")
conquests_raceAddCityName(race, "Coventry")
conquests_raceAddCityName(race, "Warwick")
conquests_raceAddCityName(race, "Newcastle")
conquests_raceAddCityName(race, "Oxford")
conquests_raceAddCityName(race, "Liverpool")
conquests_raceAddCityName(race, "Dover")
conquests_raceAddCityName(race, "Brighton")
conquests_raceAddCityName(race, "Norwich")
conquests_raceAddCityName(race, "Leeds")
conquests_raceAddCityName(race, "Reading")
conquests_raceAddCityName(race, "Birmingham")
conquests_raceAddCityName(race, "Richmond")
conquests_raceAddCityName(race, "Exeter")
conquests_raceAddCityName(race, "Cambridge")
conquests_raceAddCityName(race, "Gloucester")
conquests_raceAddCityName(race, "Manchester")
conquests_raceAddCityName(race, "Bristol")
conquests_raceAddCityName(race, "Leicester")
conquests_raceAddCityName(race, "Carlisle")
conquests_raceAddCityName(race, "Ipswich")
conquests_raceAddCityName(race, "Portsmouth")

conquests_buildableSetRaceSpecific("Stonehenge", "The English");

race = conquests_addNewRace("The Egyptians", "Egyptian", "Cleopatra", 255, 255, 0, "data/gfx/civs/egyptians.jpg")
--[[
conquests_raceSetInfo(race, "The Ancient Egyptians were an ancient civilization formed around 3000BC, lasting for "
	.. "thousands of years, before becoming a province of the Roman Empire. Their scientific and technological "
	.. "achievements include irrigation, shipbuilding and mathematics, as well as construction techniques allowing "
	.. "them to build monumental Pyramids.")
--]]
conquests_raceSetStartingTechnology(race, "Agriculture")
conquests_raceAddCityName(race, "Thebes")
conquests_raceAddCityName(race, "Memphis")
conquests_raceAddCityName(race, "Heliopolis")
conquests_raceAddCityName(race, "Elephantine")
conquests_raceAddCityName(race, "Alexandria")
conquests_raceAddCityName(race, "Pi-Ramesses")
conquests_raceAddCityName(race, "Giza")
conquests_raceAddCityName(race, "Byblos")
conquests_raceAddCityName(race, "El-Amarna")
conquests_raceAddCityName(race, "Hieraconpolis")
conquests_raceAddCityName(race, "Abydos")
conquests_raceAddCityName(race, "Asyut")
conquests_raceAddCityName(race, "Avaris")
conquests_raceAddCityName(race, "Lisht")
conquests_raceAddCityName(race, "Buto")
conquests_raceAddCityName(race, "Edfu")
conquests_raceAddCityName(race, "Pithom")
conquests_raceAddCityName(race, "Busiris")
conquests_raceAddCityName(race, "Kahun")
conquests_raceAddCityName(race, "Athribis")
conquests_raceAddCityName(race, "Mendes")
conquests_raceAddCityName(race, "El-Ashmunein")
conquests_raceAddCityName(race, "Tanis")
conquests_raceAddCityName(race, "Buhen")
conquests_raceAddCityName(race, "Bubastis")
conquests_raceAddCityName(race, "This")

conquests_buildableSetRaceSpecific("Pyramids", "The Egyptians");

race = conquests_addNewRace("The Americans", "Amercian", "Abraham Lincoln", 147, 204, 237, "data/gfx/civs/americans.jpg")
--[[
conquests_raceSetInfo(race, "The Americas were first populated by travellers from Asia tens of thousands of years "
	.. "ago. Europeans began settling from 1492, building colonies. The British colonies declared their independence "
	.. "after the Revolutionary War, forming the United States of America. The United States emerged as a world "
	.. "superpower in the 20th Century, and became the world's sole superpower after the collapse of the Soviet "
	.. "Union.")
--]]
conquests_raceSetStartingTechnology(race, "Alphabet")

conquests_raceAddCityName(race, "Washington")
conquests_raceAddCityName(race, "New York")
conquests_raceAddCityName(race, "Boston")
conquests_raceAddCityName(race, "Philadelphia")
conquests_raceAddCityName(race, "Atlanta")
conquests_raceAddCityName(race, "Chicago")
conquests_raceAddCityName(race, "San Francisco")
conquests_raceAddCityName(race, "Buffalo")
conquests_raceAddCityName(race, "St. Louis")
conquests_raceAddCityName(race, "Detroit")
conquests_raceAddCityName(race, "New Orleans")
conquests_raceAddCityName(race, "Baltimore")
conquests_raceAddCityName(race, "Denver")
conquests_raceAddCityName(race, "Cincinnati")
conquests_raceAddCityName(race, "Dallas")
conquests_raceAddCityName(race, "Los Angeles")
conquests_raceAddCityName(race, "Kansas City")
conquests_raceAddCityName(race, "San Diego")
conquests_raceAddCityName(race, "Las Vegas")
conquests_raceAddCityName(race, "Phoenix")
conquests_raceAddCityName(race, "Seattle")
conquests_raceAddCityName(race, "Albuquerque")
conquests_raceAddCityName(race, "Portland")
conquests_raceAddCityName(race, "Minneapolis")

conquests_buildableSetRaceSpecific("Apollo Programme", "The Americans");

race = conquests_addNewRace("The French", "French", "Joan of Arc", 64, 255, 64, "data/gfx/civs/french.jpg")
--[[
conquests_raceSetInfo(race, "After the fall of the Roman Empire, the Kingdom of France grew to become a major "
	.. "power in medieval Europe. France changed from an absolute monarchy to a modern republic after the Frence "
	.. " Revolution.")
--]]
conquests_raceSetStartingTechnology(race, "Archery")
conquests_raceAddCityName(race, "Paris")
conquests_raceAddCityName(race, "Orleans")
conquests_raceAddCityName(race, "Lyons")
conquests_raceAddCityName(race, "Rheims")
conquests_raceAddCityName(race, "Tours")
conquests_raceAddCityName(race, "Marseilles")
conquests_raceAddCityName(race, "Chartres")
conquests_raceAddCityName(race, "Avignon")
conquests_raceAddCityName(race, "Besancon")
conquests_raceAddCityName(race, "Rouen")
conquests_raceAddCityName(race, "Grenoble")
conquests_raceAddCityName(race, "Dijon")
conquests_raceAddCityName(race, "Amiens")
conquests_raceAddCityName(race, "Cherbourg")
conquests_raceAddCityName(race, "Poitiers")
conquests_raceAddCityName(race, "Toulouse")
conquests_raceAddCityName(race, "Bayonne")
conquests_raceAddCityName(race, "Strasbourg")
conquests_raceAddCityName(race, "Brest")
conquests_raceAddCityName(race, "Bordeaux")

conquests_buildableSetRaceSpecific("Eiffel Tower", "The French");

race = conquests_addNewRace("The Greeks", "Greek", "Alexander the Great", 255, 64, 64, "data/gfx/civs/greeks.jpg")
conquests_raceSetStartingTechnology(race, "Alphabet")
conquests_raceAddCityName(race, "Athens")
conquests_raceAddCityName(race, "Sparta")
conquests_raceAddCityName(race, "Thermopylae")
conquests_raceAddCityName(race, "Corinth")
conquests_raceAddCityName(race, "Delphi")
conquests_raceAddCityName(race, "Pharsalos")
conquests_raceAddCityName(race, "Knossos")
conquests_raceAddCityName(race, "Argos")
conquests_raceAddCityName(race, "Mycenae")
conquests_raceAddCityName(race, "Herakleia")
conquests_raceAddCityName(race, "Ephesos")
conquests_raceAddCityName(race, "Thessalonica")
conquests_raceAddCityName(race, "Rhodes")
conquests_raceAddCityName(race, "Eretria")
conquests_raceAddCityName(race, "Troy")
conquests_raceAddCityName(race, "Marathon")
conquests_raceAddCityName(race, "Halicarnassus")
conquests_raceAddCityName(race, "Pergamon")
conquests_raceAddCityName(race, "Miletos")
conquests_raceAddCityName(race, "Artemisium")
conquests_raceAddCityName(race, "Megara")
conquests_raceAddCityName(race, "Phocaea")
conquests_raceAddCityName(race, "Sicyon")
conquests_raceAddCityName(race, "Gortyn")
conquests_raceAddCityName(race, "Mytilene")
conquests_raceAddCityName(race, "Tegea")

conquests_buildableSetRaceSpecific("Colossus", "The Greeks");

race = conquests_addNewRace("The Vikings", "Viking", "Leif Ericson", 150, 75, 0, "data/gfx/civs/vikings.jpg")
conquests_raceSetStartingTechnology(race, "Sailing")
conquests_raceAddCityName(race, "Nidaros")
conquests_raceAddCityName(race, "Uppsala")
conquests_raceAddCityName(race, "Haithabu")
conquests_raceAddCityName(race, "Birka")
conquests_raceAddCityName(race, "Bergen")
conquests_raceAddCityName(race, "Jelling")
conquests_raceAddCityName(race, "Roskilde")
conquests_raceAddCityName(race, "Tønsberg")
conquests_raceAddCityName(race, "Sigtuna")
conquests_raceAddCityName(race, "Lödöse")
conquests_raceAddCityName(race, "Odense")
conquests_raceAddCityName(race, "Oslo")
conquests_raceAddCityName(race, "Ribe")
conquests_raceAddCityName(race, "Lindholm Høje")
conquests_raceAddCityName(race, "Västerås")
conquests_raceAddCityName(race, "Aarhus")
conquests_raceAddCityName(race, "Lund")
conquests_raceAddCityName(race, "Kaupang")
conquests_raceAddCityName(race, "Reykjavik")
conquests_raceAddCityName(race, "Þingvellir")
conquests_raceAddCityName(race, "Stamford")
conquests_raceAddCityName(race, "Holmgård")
conquests_raceAddCityName(race, "Aldeigjuborg")
conquests_raceAddCityName(race, "Tynwald")
conquests_raceAddCityName(race, "Leirvik")
conquests_raceAddCityName(race, "Vinland")

conquests_buildableSetRaceSpecific("Hammer of Thor", "The Vikings");

race = conquests_addNewRace("The Russians", "Russian", "Joseph Stalin", 127, 0, 0, "data/gfx/civs/russians.jpg")
conquests_raceSetStartingTechnology(race, "Masonry")
conquests_raceAddCityName(race, "Moscow")
conquests_raceAddCityName(race, "St. Petersburg")
conquests_raceAddCityName(race, "Kiev")
conquests_raceAddCityName(race, "Minsk")
conquests_raceAddCityName(race, "Smolensk")
conquests_raceAddCityName(race, "Odessa")
conquests_raceAddCityName(race, "Sevastopol")
conquests_raceAddCityName(race, "Tblisi")
conquests_raceAddCityName(race, "Sverdlovsk")
conquests_raceAddCityName(race, "Yakutsk")
conquests_raceAddCityName(race, "Vladivostok")
conquests_raceAddCityName(race, "Novgorod")
conquests_raceAddCityName(race, "Krasnoyarsk")
conquests_raceAddCityName(race, "Riga")
conquests_raceAddCityName(race, "Rostov")
conquests_raceAddCityName(race, "Astrakhan")
conquests_raceAddCityName(race, "Kharkov")
conquests_raceAddCityName(race, "Grozny")
conquests_raceAddCityName(race, "Dnepropetrovsk")
conquests_raceAddCityName(race, "Maikop")

conquests_buildableSetRaceSpecific("Mir Space Station", "The Russians");

race = conquests_addNewRace("The Japanese", "Japanese", "Toyotomi Hideyoshi", 127, 127, 127, "data/gfx/civs/japanese.jpg")
conquests_raceSetStartingTechnology(race, "The Wheel")
conquests_raceAddCityName(race, "Kyoto")
conquests_raceAddCityName(race, "Osaka")
conquests_raceAddCityName(race, "Tokyo")
conquests_raceAddCityName(race, "Edo")
conquests_raceAddCityName(race, "Satsuma")
conquests_raceAddCityName(race, "Kagoshima")
conquests_raceAddCityName(race, "Nara")
conquests_raceAddCityName(race, "Nagoya")
conquests_raceAddCityName(race, "Izumo")
conquests_raceAddCityName(race, "Nagasaki")
conquests_raceAddCityName(race, "Yokohama")
conquests_raceAddCityName(race, "Shimonoseki")
conquests_raceAddCityName(race, "Matsuyama")
conquests_raceAddCityName(race, "Sapporo")
conquests_raceAddCityName(race, "Hakodate")
conquests_raceAddCityName(race, "Ise")
conquests_raceAddCityName(race, "Toyama")
conquests_raceAddCityName(race, "Fukushima")
conquests_raceAddCityName(race, "Suo")
conquests_raceAddCityName(race, "Bizen")

conquests_buildableSetRaceSpecific("Himeji Castle", "The Japanese");

-- Arguments: Name, Adjective, red, green, blue, image
race = conquests_addNewRace("The Mayans", "Mayan", "Yohl Ik'nal", 255, 0, 255, "data/gfx/civs/mayans.jpg")
conquests_raceSetStartingTechnology(race, "Alphabet")
conquests_raceAddCityName(race, "Lamanai") --- 1600BC
conquests_raceAddCityName(race, "Kaminaljuyu") --- 1500BC
conquests_raceAddCityName(race, "Nakbe") --- 1400BC
conquests_raceAddCityName(race, "Takalik Abaj") --- 900BC
conquests_raceAddCityName(race, "Chunchucmil") --- 675BC
conquests_raceAddCityName(race, "Piedras Negras") --- 650BC
conquests_raceAddCityName(race, "El Mirador") --- 600BC
conquests_raceAddCityName(race, "Izapa") --- 600BC
conquests_raceAddCityName(race, "Cival") --- 600BC
conquests_raceAddCityName(race, "Becan") --- 550BC
conquests_raceAddCityName(race, "El Perú") --- 500BC
conquests_raceAddCityName(race, "Cerros") --- 400BC
conquests_raceAddCityName(race, "Aguateca") --- 300BC
conquests_raceAddCityName(race, "El Chal") --- 300BC
conquests_raceAddCityName(race, "Kabah") --- 300BC
conquests_raceAddCityName(race, "Palenque") --- 100BC
conquests_raceAddCityName(race, "Seibal") --- 400BC
conquests_raceAddCityName(race, "Coba") --- 1AD
conquests_raceAddCityName(race, "Tikal") --- 200AD
conquests_raceAddCityName(race, "Xunantunich") --- 200AD
conquests_raceAddCityName(race, "Naranjo") --- 350AD
conquests_raceAddCityName(race, "Copán") --- 400AD
conquests_raceAddCityName(race, "Río Azul") --- 400AD
conquests_raceAddCityName(race, "Caracol") --- 485AD
conquests_raceAddCityName(race, "Uxmal") --- 500AD
conquests_raceAddCityName(race, "Toniná") --- 500AD
conquests_raceAddCityName(race, "Calakmul") --- 520AD
conquests_raceAddCityName(race, "Chichen Itza") --- 600AD
conquests_raceAddCityName(race, "Dos Pilas") --- 629AD
conquests_raceAddCityName(race, "Cancuén") --- 700AD
conquests_raceAddCityName(race, "Sayil") --- 800AD
conquests_raceAddCityName(race, "Labna") --- 862AD
conquests_raceAddCityName(race, "Xultun") --- 899AD

conquests_buildableSetRaceSpecific("Great Temple", "The Mayans");

--[[
race = conquests_addNewRace("The ", "", 255, 64, 0, "data/gfx/civs/.jpg")
conquests_raceSetStartingTechnology(race, "")
conquests_raceAddCityName(race, "")
--]]

print("generate_races.lua exit")
