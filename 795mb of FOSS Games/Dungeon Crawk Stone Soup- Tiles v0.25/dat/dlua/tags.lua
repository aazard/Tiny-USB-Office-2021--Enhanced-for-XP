-- Autogenerated by util/gen-luatags.pl, do not edit.

------------------------------------------------------------------------------
-- tags.lua:
-- Tag and version compatibility functions and info.
------------------------------------------------------------------------------
tags = {}

------------------------------------------------------------------------------
-- simpler access to tag_major_version
------------------------------------------------------------------------------

function tags.major_version ()
  return file.major_version()
end

tags.TAG_MINOR_RESET = 0
tags.TAG_MINOR_BRANCHES_LEFT = 1
tags.TAG_MINOR_VAULT_LIST = 2
tags.TAG_MINOR_TRAPS_DETERM = 3
tags.TAG_MINOR_ACTION_THROW = 4
tags.TAG_MINOR_TEMP_MUTATIONS = 5
tags.TAG_MINOR_AUTOINSCRIPTIONS = 6
tags.TAG_MINOR_UNCANCELLABLES = 7
tags.TAG_MINOR_DEEP_ABYSS = 8
tags.TAG_MINOR_COORD_SERIALIZER = 9
tags.TAG_MINOR_REMOVE_ABYSS_SEED = 10
tags.TAG_MINOR_REIFY_SUBVAULTS = 11
tags.TAG_MINOR_VEHUMET_SPELL_GIFT = 12
tags.TAG_MINOR_LUA_DUMMY_0 = 13
tags.TAG_MINOR_LUA_DUMMY_1 = 14
tags.TAG_MINOR_LUA_DUMMY_2 = 15
tags.TAG_MINOR_LUA_DUMMY_3 = 16
tags.TAG_MINOR_0_11 = 17
tags.TAG_MINOR_0_12 = 18
tags.TAG_MINOR_BATTLESPHERE_MID = 19
tags.TAG_MINOR_MALMUTATE = 20
tags.TAG_MINOR_VEHUMET_MULTI_GIFTS = 21
tags.TAG_MINOR_ADD_ABYSS_SEED = 22
tags.TAG_MINOR_COMPANION_LIST = 23
tags.TAG_MINOR_INCREMENTAL_RECALL = 24
tags.TAG_MINOR_GOD_GIFT = 25
tags.TAG_MINOR_NOME_NO_MORE = 26
tags.TAG_MINOR_NO_SPLINT = 27
tags.TAG_MINOR_ORIG_MONNUM = 28
tags.TAG_MINOR_SPRINT_SCORES = 29
tags.TAG_MINOR_FOOD_AUTOPICKUP = 30
tags.TAG_MINOR_LORC_TEMPERATURE = 31
tags.TAG_MINOR_GARGOYLE_DR = 32
tags.TAG_MINOR_TRAVEL_ALLY_PACE = 33
tags.TAG_MINOR_AUTOMATIC_MANUALS = 34
tags.TAG_MINOR_RM_GARGOYLE_DR = 35
tags.TAG_MINOR_STAT_ZERO = 36
tags.TAG_MINOR_BOX_OF_BEASTS_CHARGES = 37
tags.TAG_MINOR_WAR_DOG_REMOVAL = 38
tags.TAG_MINOR_CANARIES = 39
tags.TAG_MINOR_CHIMERA_GHOST_DEMON = 40
tags.TAG_MINOR_MONSTER_PARTS = 41
tags.TAG_MINOR_OPTIONAL_PARTS = 42
tags.TAG_MINOR_SHORT_SPELL_TYPE = 43
tags.TAG_MINOR_FORGOTTEN_MAP = 44
tags.TAG_MINOR_CONTAM_SCALE = 45
tags.TAG_MINOR_SUMMONER = 46
tags.TAG_MINOR_STAT_MUT = 47
tags.TAG_MINOR_MAP_ORDER = 48
tags.TAG_MINOR_FIXED_CONSTRICTION = 49
tags.TAG_MINOR_SEEDS = 50
tags.TAG_MINOR_ABYSS_BRANCHES = 51
tags.TAG_MINOR_BRANCH_ENTRY = 52
tags.TAG_MINOR_16_BIT_TABLE = 53
tags.TAG_MINOR_ABIL_1000 = 54
tags.TAG_MINOR_CLASS_HP_0 = 55
tags.TAG_MINOR_NOISES = 56
tags.TAG_MINOR_ABIL_GOD_FIXUP = 57
tags.TAG_MINOR_NEMELEX_DUNGEONS = 58
tags.TAG_MINOR_DEMONSPAWN = 59
tags.TAG_MINOR_EVENT_TIMERS = 60
tags.TAG_MINOR_EVENT_TIMER_FIX = 61
tags.TAG_MINOR_MONINFO_ENERGY = 62
tags.TAG_MINOR_BOOK_ID = 63
tags.TAG_MINOR_MISC_SHOP_CHANGE = 64
tags.TAG_MINOR_HORN_GERYON_CHANGE = 65
tags.TAG_MINOR_NEMELEX_WEIGHTS = 66
tags.TAG_MINOR_UNSEEN_MONSTER = 67
tags.TAG_MINOR_MR_ITEM_RESCALE = 68
tags.TAG_MINOR_MANGROVES = 69
tags.TAG_MINOR_FIX_FEAT_SHIFT = 70
tags.TAG_MINOR_FUNGUS_FORM = 71
tags.TAG_MINOR_STEALTH_RESCALE = 72
tags.TAG_MINOR_ATTACK_DESCS = 73
tags.TAG_MINOR_BRIBE_BRANCH = 74
tags.TAG_MINOR_CLOUD_OWNER = 75
tags.TAG_MINOR_NO_POTION_HEAL = 76
tags.TAG_MINOR_DIET_MUT = 77
tags.TAG_MINOR_SAGE_REMOVAL = 78
tags.TAG_MINOR_CALC_UNRAND_REACTS = 79
tags.TAG_MINOR_SAPROVOROUS = 80
tags.TAG_MINOR_CE_HA_DIET = 81
tags.TAG_MINOR_NO_POT_FOOD = 82
tags.TAG_MINOR_ROT_IMMUNITY = 83
tags.TAG_MINOR_FOUL_STENCH = 84
tags.TAG_MINOR_FOOD_PURGE = 85
tags.TAG_MINOR_FOOD_PURGE_AP_FIX = 86
tags.TAG_MINOR_WEIGHTLESS = 87
tags.TAG_MINOR_DS_CLOUD_MUTATIONS = 88
tags.TAG_MINOR_FRIENDLY_PICKUP = 89
tags.TAG_MINOR_STICKY_FLAME = 90
tags.TAG_MINOR_SLAYRING_PLUSES = 91
tags.TAG_MINOR_MERGE_EW = 92
tags.TAG_MINOR_WEAPON_PLUSES = 93
tags.TAG_MINOR_SAVE_TERRAIN_COLOUR = 94
tags.TAG_MINOR_REMOVE_BASE_MP = 95
tags.TAG_MINOR_METABOLISM = 96
tags.TAG_MINOR_RU_SACRIFICES = 97
tags.TAG_MINOR_IS_UNDEAD = 98
tags.TAG_MINOR_REMOVE_MON_AC_EV = 99
tags.TAG_MINOR_DISPLAY_MON_AC_EV = 100
tags.TAG_MINOR_PLACE_UNPACK = 101
tags.TAG_MINOR_NO_JUMP = 102
tags.TAG_MINOR_MONSTER_SPELL_SLOTS = 103
tags.TAG_MINOR_ARB_SPELL_SLOTS = 104
tags.TAG_MINOR_CUT_CUTLASSES = 105
tags.TAG_MINOR_NO_GHOST_SPELLCASTER = 106
tags.TAG_MINOR_MID_BEHOLDERS = 107
tags.TAG_MINOR_REMOVE_ITEM_COLOUR = 108
tags.TAG_MINOR_CORPSE_CRASH = 109
tags.TAG_MINOR_INIT_RND = 110
tags.TAG_MINOR_RING_PLUSSES = 111
tags.TAG_MINOR_BLESSED_WPNS = 112
tags.TAG_MINOR_MON_COLOUR_LOOKUP = 113
tags.TAG_MINOR_CONSUM_APPEARANCE = 114
tags.TAG_MINOR_NEG_IDESC = 115
tags.TAG_MINOR_GHOST_ENERGY = 116
tags.TAG_MINOR_TENTACLE_MID = 117
tags.TAG_MINOR_CORPSE_COLOUR = 118
tags.TAG_MINOR_MANGLE_CORPSES = 119
tags.TAG_MINOR_ZOT_OPEN = 120
tags.TAG_MINOR_EXPLORE_MODE = 121
tags.TAG_MINOR_RANDLICHES = 122
tags.TAG_MINOR_ISFLAG_HANDLED = 123
tags.TAG_MINOR_SHOP_HACK = 124
tags.TAG_MINOR_STACKABLE_EVOKERS = 125
tags.TAG_MINOR_REALLY_16_BIT_VEC = 126
tags.TAG_MINOR_FIX_8_BIT_VEC_MAX = 127
tags.TAG_MINOR_TRACK_BANISHER = 128
tags.TAG_MINOR_SHOALS_LITE = 129
tags.TAG_MINOR_FIX_EXPLORE_MODE = 130
tags.TAG_MINOR_UNSTACKABLE_EVOKERS = 131
tags.TAG_MINOR_NO_NEGATIVE_VULN = 132
tags.TAG_MINOR_MAX_XL = 133
tags.TAG_MINOR_NO_RPOIS_MINUS = 134
tags.TAG_MINOR_XP_PENANCE = 135
tags.TAG_MINOR_SPIT_POISON = 136
tags.TAG_MINOR_REAL_MUTS = 137
tags.TAG_MINOR_NO_FORLORN = 138
tags.TAG_MINOR_MP_WANDS = 139
tags.TAG_MINOR_TELEPORTITIS = 140
tags.TAG_MINOR_ROTTING = 141
tags.TAG_MINOR_STAT_ZERO_DURATION = 142
tags.TAG_MINOR_INT_REGEN = 143
tags.TAG_MINOR_NAGA_METABOLISM = 144
tags.TAG_MINOR_BOOL_FLIGHT = 145
tags.TAG_MINOR_STAT_LOSS_XP = 146
tags.TAG_MINOR_DETERIORATION = 147
tags.TAG_MINOR_RU_DELAY_STACKING = 148
tags.TAG_MINOR_NO_TWISTER = 149
tags.TAG_MINOR_NO_ZOTDEF = 150
tags.TAG_MINOR_SAVED_PIETY = 151
tags.TAG_MINOR_GHOST_SINV = 152
tags.TAG_MINOR_ID_STATES = 153
tags.TAG_MINOR_MON_HD_INFO = 154
tags.TAG_MINOR_NO_LEVEL_FLAGS = 155
tags.TAG_MINOR_EXORCISE = 156
tags.TAG_MINOR_BLINK_MUT = 157
tags.TAG_MINOR_RUNE_TYPE = 158
tags.TAG_MINOR_ZIGFIGS = 159
tags.TAG_MINOR_RU_PIETY_CONSISTENCY = 160
tags.TAG_MINOR_SAC_PIETY_LEN = 161
tags.TAG_MINOR_MULTI_HOLI = 162
tags.TAG_MINOR_SHOPINFO = 163
tags.TAG_MINOR_UNSHOPINFO = 164
tags.TAG_MINOR_UNUNSHOPINFO = 165
tags.TAG_MINOR_MESSAGE_REPEATS = 166
tags.TAG_MINOR_GHOST_NOSINV = 167
tags.TAG_MINOR_NO_DRACO_TYPE = 168
tags.TAG_MINOR_DEMONIC_SPELLS = 169
tags.TAG_MINOR_MUMMY_RESTORATION = 170
tags.TAG_MINOR_DECUSTOM_CLOUDS = 171
tags.TAG_MINOR_PAKELLAS_WRATH = 172
tags.TAG_MINOR_GLOBAL_BR_INFO = 173
tags.TAG_MINOR_SPIT_POISON_AGAIN = 174
tags.TAG_MINOR_HIDE_TO_SCALE = 175
tags.TAG_MINOR_NO_PRIORITY = 176
tags.TAG_MINOR_MOTTLED_REMOVAL = 177
tags.TAG_MINOR_NEMELEX_WRATH = 178
tags.TAG_MINOR_SLIME_WALL_CLEAR = 179
tags.TAG_MINOR_FOOD_PURGE_RELOADED = 180
tags.TAG_MINOR_ELYVILON_WRATH = 181
tags.TAG_MINOR_DESOLATION_GLOBAL = 182
tags.TAG_MINOR_NO_MORE_LORC = 183
tags.TAG_MINOR_NO_ITEM_TRANSIT = 184
tags.TAG_MINOR_TOMB_HATCHES = 185
tags.TAG_MINOR_TRANSPORTERS = 186
tags.TAG_MINOR_SPIT_POISON_AGAIN_AGAIN = 187
tags.TAG_MINOR_TRANSPORTER_LANDING = 188
tags.TAG_MINOR_STATLOCKED_GNOLLS = 189
tags.TAG_MINOR_LIGHTNING_ROD_XP_FIX = 190
tags.TAG_MINOR_LEVEL_XP_INFO = 191
tags.TAG_MINOR_LEVEL_XP_INFO_FIX = 192
tags.TAG_MINOR_FOLLOWER_TRANSIT_TIME = 193
tags.TAG_MINOR_GNOLLS_REDUX = 194
tags.TAG_MINOR_TRAINING_TARGETS = 195
tags.TAG_MINOR_XP_SCALING = 196
tags.TAG_MINOR_NO_ACTOR_HELD = 197
tags.TAG_MINOR_GOLDIFY_BOOKS = 198
tags.TAG_MINOR_VETO_DISINT = 199
tags.TAG_MINOR_LEVEL_XP_VAULTS = 200
tags.TAG_MINOR_REVEAL_TRAPS = 201
tags.TAG_MINOR_GAUNTLET_TRAPPED = 202
tags.TAG_MINOR_REMOVE_DECKS = 203
tags.TAG_MINOR_GAMESEEDS = 204
tags.TAG_MINOR_YELLOW_DRACONIAN_RACID = 205
tags.TAG_MINOR_THROW_CONSOLIDATION = 206
tags.TAG_MINOR_VAMPIRE_NO_EAT = 207
tags.TAG_MINOR_SINGULAR_THEY = 208
tags.TAG_MINOR_ABYSS_UNIQUE_VAULTS = 209
tags.TAG_MINOR_INCREMENTAL_PREGEN = 210
tags.TAG_MINOR_NO_SUNLIGHT = 211
tags.TAG_MINOR_POSITIONAL_MAGIC = 212
tags.TAG_MINOR_GHOST_MAGIC = 213
tags.TAG_MINOR_MORE_GHOST_MAGIC = 214
tags.TAG_MINOR_DUMMY_AGILITY = 215
tags.TAG_MINOR_TRACK_REGEN_ITEMS = 216
tags.TAG_MINOR_MORGUE_SCREENSHOTS = 217
tags.TAG_MINOR_UNSTACK_TREMORSTONES = 218
tags.TAG_MINOR_MONSTER_TYPE_SIZE = 219
tags.NUM_TAG_MINORS = 220
tags.TAG_MINOR_NO_GHOST_SPELLCASTER = 221
tags.TAG_MINOR_MON_COLOUR_LOOKUP = 222
tags.TAG_MINOR_GHOST_ENERGY = 223
tags.TAG_MINOR_BOOL_FLIGHT = 224
tags.TAG_MINOR_POSITIONAL_MAGIC = 225
tags.TAG_MINOR_GHOST_MAGIC = 226
tags.TAG_MINOR_VERSION = tags.NUM_TAG_MINORS - 1
