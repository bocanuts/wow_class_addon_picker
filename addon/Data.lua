--[[
  Class/spec data + addon recommendations.
  Regenerate with: python3 scripts/generate_lua_data.py
]]

CAPClasses = {
  ["warrior"] = {
    name = "Warrior",
    icon = "class_warrior",
    specs = {
      ["arms"] = { name = "Arms", order = 1 },
      ["fury"] = { name = "Fury", order = 2 },
      ["protection"] = { name = "Protection", order = 3 },
    },
  },
  ["paladin"] = {
    name = "Paladin",
    icon = "class_paladin",
    specs = {
      ["holy"] = { name = "Holy", order = 1 },
      ["retribution"] = { name = "Retribution", order = 2 },
      ["protection"] = { name = "Protection", order = 3 },
    },
  },
  ["hunter"] = {
    name = "Hunter",
    icon = "class_hunter",
    specs = {
      ["beast_mastery"] = { name = "Beast Mastery", order = 1 },
      ["marksmanship"] = { name = "Marksmanship", order = 2 },
      ["survival"] = { name = "Survival", order = 3 },
    },
  },
  ["rogue"] = {
    name = "Rogue",
    icon = "class_rogue",
    specs = {
      ["assassination"] = { name = "Assassination", order = 1 },
      ["outlaw"] = { name = "Outlaw", order = 2 },
      ["subtlety"] = { name = "Subtlety", order = 3 },
    },
  },
  ["priest"] = {
    name = "Priest",
    icon = "class_priest",
    specs = {
      ["discipline"] = { name = "Discipline", order = 1 },
      ["holy"] = { name = "Holy", order = 2 },
      ["shadow"] = { name = "Shadow", order = 3 },
    },
  },
  ["shaman"] = {
    name = "Shaman",
    icon = "class_shaman",
    specs = {
      ["elemental"] = { name = "Elemental", order = 1 },
      ["enhancement"] = { name = "Enhancement", order = 2 },
      ["restoration"] = { name = "Restoration", order = 3 },
    },
  },
  ["mage"] = {
    name = "Mage",
    icon = "class_mage",
    specs = {
      ["arcane"] = { name = "Arcane", order = 1 },
      ["fire"] = { name = "Fire", order = 2 },
      ["frost"] = { name = "Frost", order = 3 },
    },
  },
  ["warlock"] = {
    name = "Warlock",
    icon = "class_warlock",
    specs = {
      ["affliction"] = { name = "Affliction", order = 1 },
      ["demonology"] = { name = "Demonology", order = 2 },
      ["destruction"] = { name = "Destruction", order = 3 },
    },
  },
  ["monk"] = {
    name = "Monk",
    icon = "class_monk",
    specs = {
      ["brewmaster"] = { name = "Brewmaster", order = 1 },
      ["mistweaver"] = { name = "Mistweaver", order = 2 },
      ["windwalker"] = { name = "Windwalker", order = 3 },
    },
  },
  ["druid"] = {
    name = "Druid",
    icon = "class_druid",
    specs = {
      ["balance"] = { name = "Balance", order = 1 },
      ["feral"] = { name = "Feral", order = 2 },
      ["guardian"] = { name = "Guardian", order = 3 },
      ["restoration"] = { name = "Restoration", order = 4 },
    },
  },
  ["death_knight"] = {
    name = "Death Knight",
    icon = "class_deathknight",
    specs = {
      ["blood"] = { name = "Blood", order = 1 },
      ["frost"] = { name = "Frost", order = 2 },
      ["unholy"] = { name = "Unholy", order = 3 },
    },
  },
  ["demon_hunter"] = {
    name = "Demon Hunter",
    icon = "class_demonhunter",
    specs = {
      ["havoc"] = { name = "Havoc", order = 1 },
      ["vengeance"] = { name = "Vengeance", order = 2 },
    },
  },
}

-- Key addons that the addon can scan and auto-configure.
-- These are the real addon global names (SavedVariables variables).
CAPAddonRegistry = {
  ["dbm"] = {
    key = "dbm",
    name = "Deadly Boss Mods",
    priority = "essential",
    description = "Essential raid boss addon with timers, warnings, and custom alerts for every encounter.",
    url = "https://www.curseforge.com/wow/addons/deadly-boss-mods",
    savedVariableName = "DBM-Core",
    defaultSettings = {
      ["autoDelayTimer"] = true,
      ["alertRange"] = true,
      ["screenFlash"] = true,
      ["warningSound"] = true,
    },
  },
  ["bigwigs"] = {
    key = "bigwigs",
    name = "BigWigs",
    priority = "optional",
    description = "Alternative boss mod to DBM. Use if you prefer BigWigs timers or play with players who use it.",
    url = "https://www.curseforge.com/wow/addons/bigwigs",
    savedVariableName = "BigWigs_Options",
    defaultSettings = {
      ["fontSize"] = 1,
      ["barStyle"] = "smooth",
    },
  },
  ["weakauras"] = {
    key = "weakauras",
    name = "WeakAuras",
    priority = "essential",
    description = "The most powerful aura/icon buff/debuff tracker. Thousands of custom AUs shared by the community.",
    url = "https://www.curseforge.com/wow/addons/weakauras",
    savedVariableName = "WeakAurs",
    defaultSettings = {
      ["useCustomFonts"] = false,
      ["fontSize"] = 14,
    },
  },
  ["details"] = {
    key = "details",
    name = "Details! Damage Meter",
    priority = "essential",
    description = "Real-time damage/healing/threat monitoring during encounters.",
    url = "https://www.curseforge.com/wow/addons/details",
    savedVariableName = "Details!VCData",
    defaultSettings = {
      ["showFloatingCombatText"] = true,
      ["combatLogEnabled"] = true,
    },
  },
  ["bagnon"] = {
    key = "bagnon",
    name = "Bagnon",
    priority = "recommended",
    description = "Combine all your bags into one expandable window with tabs for different item types.",
    url = "https://www.curseforge.com/wow/addons/bagnon",
    defaultSettings = {
      ["bagSize"] = 1,
      ["showAllTabs"] = true,
    },
  },
  ["auctionator"] = {
    key = "auctionator",
    name = "Auctionator",
    priority = "recommended",
    description = "Fast auction house browsing with price comparison and mass posting.",
    url = "https://www.curseforge.com/wow/addons/auctionator",
    defaultSettings = {
      ["underCutAmount"] = 5,
      ["maxStacksToShow"] = 10,
    },
  },
  ["tellmewhen"] = {
    key = "tellmewhen",
    name = "TellMeWhen",
    priority = "essential",
    description = "Highly configurable icon display for cooldowns, procs, and important abilities.",
    url = "https://www.curseforge.com/wow/addons/tellmewhen",
    savedVariableName = "TellMeWhen1DB",
    defaultSettings = {
      ["rows"] = 2,
      ["columns"] = 4,
      ["fontSize"] = 18,
    },
  },
  ["kuinameplates"] = {
    key = "kuinameplates",
    name = "KuiNameplates",
    priority = "recommended",
    description = "Customizable nameplates with threat coloring, casting bars, and health bars.",
    url = "https://www.curseforge.com/wow/addons/kuinameplates",
    savedVariableName = "Kui_NameplatesDB",
    defaultSettings = {
      ["height"] = 60,
      ["width"] = 400,
      ["showCastingBar"] = true,
      ["threatStyle"] = "color",
    },
  },
  ["quartz"] = {
    key = "quartz",
    name = "Quartz",
    priority = "recommended",
    description = "Replace default casting bars with customizable unit frame cast bars.",
    url = "https://www.curseforge.com/wow/addons/quartz",
    savedVariableName = "Quartz30DB",
    defaultSettings = {
      ["width"] = 280,
      ["fontSize"] = 14,
      ["showProgressBar"] = true,
    },
  },
  ["aurafames"] = {
    key = "auraframes",
    name = "AuraFrames",
    priority = "recommended",
    description = "Raid frame addon that shows buff/debuff icons on party/raid members.",
    url = "https://www.curseforge.com/wow/addons/auraframes",
    savedVariableName = "AuraFramesDB",
  },
  ["elvui"] = {
    key = "elvui",
    name = "ElvUI",
    priority = "recommended",
    description = "Complete UI replacement with modular design. Replaces frames, fonts, and layouts.",
    url = "https://www.curseforge.com/wow/addons/elvui",
    savedVariableName = "ElvUI_Config",
  },
}

-- Evoker class data (The War Within)
CAPClasses["evoker"] = {
  name = "Evoker",
  icon = "class_evoker",
  specs = {
    ["devastation"] = { name = "Devastation", order = 1 },
    ["preservation"] = { name = "Preservation", order = 2 },
    ["augmentation"] = { name = "Augmentation", order = 3 },
  },
}
function CAP:GetAllClassSpecKeys()
  local result = {}
  for classId, classData in pairs(CAPClasses) do
    for specId in pairs(classData.specs) do
      table.insert(result, classId .. "_" .. specId)
    end
  end
  return result
end
