/**
 * Addon recommendations for every class/spec combo.
 * Each addon has: name, priority (essential/recommended/optional), url, description, and settings to apply.
 * These are real addons from CurseForge/Twitch/WTF.
 */

export type Priority = 'essential' | 'recommended' | 'optional';

export interface AddonRecommendation {
  /** Exact addon display name as shown in Twitch/curseforge */
  name: string;
  /** Internal key used for settings targeting */
  key: string;
  /** Minimum recommended version */
  minVersion?: string;
  /** Priority level */
  priority: Priority;
  /** Short description of what this addon does */
  description: string;
  /** URL to download / install page */
  url?: string;
  /** SavedVariables global name that the addon uses (for auto-configure) */
  savedVariableName?: string;
  /** Default settings overrides to apply */
  defaultSettings: Record<string, unknown>;
}

/** All classes that have spec-specific recommendations */
export const RECOMMENDED_CLASSES = [
  'warrior',
  'paladin',
  'hunter',
  'rogue',
  'priest',
  'shaman',
  'mage',
  'warlock',
  'monk',
  'druid',
  'death_knight',
  'demon_hunter',
] as const;

/** Shared addons recommended for ALL classes/specs */
const SHARED_ADDONS: AddonRecommendation[] = [
  {
    name: 'Deadly Boss Mods',
    key: 'dbm',
    minVersion: '10.0.0',
    priority: 'essential',
    description: 'Essential raid boss addon with timers, warnings, and custom alerts for every encounter.',
    url: 'https://www.curseforge.com/wow/addons/deadly-boss-mods',
    savedVariableName: 'DBM-Core',
    defaultSettings: {
      autoDelayTimer: true,
      alertRange: true,
      screenFlash: true,
      warningSound: true,
    },
  },
  {
    name: 'BigWigs',
    key: 'bigwigs',
    minVersion: '10.0.0',
    priority: 'optional',
    description: 'Alternative boss mod to DBM. Use if you prefer BigWigs timers or play with players who use it.',
    url: 'https://www.curseforge.com/wow/addons/bigwigs',
    savedVariableName: 'BigWigs_Options',
    defaultSettings: {
      fontSize: 1,
      barStyle: 'smooth',
    },
  },
  {
    name: 'WeakAuras',
    key: 'weakauras',
    minVersion: '3.0.0',
    priority: 'essential',
    description: 'The most powerful aura/icon buff/debuff tracker. Thousands of custom AUs shared by the community.',
    url: 'https://www.curseforge.com/wow/addons/weakauras',
    savedVariableName: 'WeakAurs',
    defaultSettings: {
      useCustomFonts: false,
      fontSize: 14,
    },
  },
  {
    name: 'Details! Damage Meter',
    key: 'details',
    minVersion: '2.0.0',
    priority: 'essential',
    description: 'Real-time damage/healing/threat monitoring during encounters.',
    url: 'https://www.curseforge.com/wow/addons/details',
    savedVariableName: 'Details!VCData',
    defaultSettings: {
      showFloatingCombatText: true,
      combatLogEnabled: true,
    },
  },
  {
    name: 'Bagnon',
    key: 'bagnon',
    minVersion: '10.0.0',
    priority: 'recommended',
    description: 'Combine all your bags into one expandable window with tabs for different item types.',
    url: 'https://www.curseforge.com/wow/addons/bagnon',
    defaultSettings: {
      bagSize: 1,
      showAllTabs: true,
    },
  },
  {
    name: 'Auctionator',
    key: 'auctionator',
    minVersion: '10.0.0',
    priority: 'recommended',
    description: 'Fast auction house browsing with price comparison and mass posting.',
    url: 'https://www.curseforge.com/wow/addons/auctionator',
    defaultSettings: {
      underCutAmount: 5,
      maxStacksToShow: 10,
    },
  },
];

/** DPS-spec focused addons (used by ALL specs except tanks/healers) */
const DPS_FOCUSED_ADDONS: AddonRecommendation[] = [
  {
    name: 'WeakAuras: Ovale / KWPawn',
    key: 'weakauras_ovale',
    priority: 'recommended',
    description: 'Rotation advisor WeakAura that shows your next ability in a number wheel.',
    url: 'https://www.curseforge.com/wow/addons/ovale',
  },
  {
    name: 'KuiNameplates',
    key: 'kuinameplates',
    priority: 'recommended',
    description: 'Customizable nameplates with threat coloring, casting bars, and health bars.',
    url: 'https://www.curseforge.com/wow/addons/kuinameplates',
    savedVariableName: 'Kui_NameplatesDB',
    defaultSettings: {
      height: 60,
      width: 400,
      showCastingBar: true,
      threatStyle: 'color',
    },
  },
  {
    name: 'GlowingCooldowns',
    key: 'glowingcooldowns',
    priority: 'optional',
    description: 'Add glowing/flashing effects to cooldown buttons so you never miss an ability.',
    url: 'https://www.curseforge.com/wow/addons/glowing-cooldowns',
  },
];

/** Tank-spec focused addons */
const TANK_FOCUSED_ADDONS: AddonRecommendation[] = [
  {
    name: 'TellMeWhen',
    key: 'tellmewhen',
    priority: 'essential',
    description: 'Highly configurable icon display for cooldowns, procs, and important abilities.',
    url: 'https://www.curseforge.com/wow/addons/tellmewhen',
    savedVariableName: 'TellMeWhen1DB',
    defaultSettings: {
      rows: 2,
      columns: 4,
      fontSize: 18,
    },
  },
  {
    name: 'KuiNameplates (Tank Mode)',
    key: 'kuinameplates_tank',
    priority: 'essential',
    description: 'Nameplates with threat coloring (red/yellow/green) for targeting priority.',
    url: 'https://www.curseforge.com/wow/addons/kuinameplates',
  },
  {
    name: 'Powerauras ZERO',
    key: 'powerauras_zero',
    priority: 'recommended',
    description: 'Alternative to WeakAuras for showing important procs and cooldowns with custom animations.',
    url: 'https://www.curseforge.com/wow/addons/power-auras-zero',
  },
];

/** Healer-spec focused addons */
const HEALER_FOCUSED_ADDONS: AddonRecommendation[] = [
  {
    name: 'TellMeWhen',
    key: 'tellmewhen',
    priority: 'essential',
    description: 'Track cooldowns (Tranquility, Mass Rescue, etc.), important procs, and external cooldowns.',
    url: 'https://www.curseforge.com/wow/addons/tellmewhen',
    savedVariableName: 'TellMeWhen1DB',
    defaultSettings: {
      rows: 3,
      columns: 4,
      fontSize: 18,
    },
  },
  {
    name: 'KuiNameplates',
    key: 'kuinameplates_healer',
    priority: 'recommended',
    description: 'Nameplates with threat and casting bars — essential for managing adds.',
    url: 'https://www.curseforge.com/wow/addons/kuinameplates',
  },
  {
    name: 'Details! Encounter Stats',
    key: 'details_encounter',
    priority: 'recommended',
    description: 'Post-encounter healing/death stats breakdown for review.',
    url: 'https://www.curseforge.com/wow/addons/details',
  },
  {
    name: 'Quartz',
    key: 'quartz',
    priority: 'recommended',
    description: 'Replace default casting bars with customizable unit frame cast bars.',
    url: 'https://www.curseforge.com/wow/addons/quartz',
    savedVariableName: 'Quartz30DB',
    defaultSettings: {
      width: 280,
      fontSize: 14,
      showProgressBar: true,
    },
  },
];

/** Per-spec recommendation sets */
const SPEC_ADDONS: Record<string, AddonRecommendation[]> = {
  // === WARRIOR ===
  warrior_arms: [
    ...DPS_FOCUSED_ADDONS,
    {
      name: 'WeakAuras: Warrior Arms DPS',
      key: 'weakauras_warrior_arms',
      priority: 'recommended' as Priority,
      description: 'Pre-built WeakAura with specific arms combo breakers and bloodthirst tracking.',
      url: 'https://wago.io/search?q=warrior+arms+dps',
    },
  ],
  warrior_fury: [
    ...DPS_FOCUSED_ADDONS,
    {
      name: 'WeakAuras: Warrior Fury DPS',
      key: 'weakauras_warrior_fury',
      priority: 'recommended' as Priority,
      description: 'Pre-built WeakAura tracking whirlwind procs and slaem timer.',
      url: 'https://wago.io/search?q=warrior+fury+dps',
    },
  ],
  warrior_protection: [
    ...TANK_FOCUSED_ADDONS,
    {
      name: 'WeakAuras: Warrior Tank',
      key: 'weakauras_warrior_tank',
      priority: 'recommended' as Priority,
      description: 'Pre-built WeakAura for shield block and intimidate cooldowns.',
      url: 'https://wago.io/search?q=warrior+tank',
    },
  ],

  // === PALADIN ===
  paladin_holy: [
    ...HEALER_FOCUSED_ADDONS,
    {
      name: 'WeakAuras: Paladin Holy',
      key: 'weakauras_paladin_holy',
      priority: 'recommended' as Priority,
      description: 'Pre-built WeakAura for light of dawn and holy fire cooldown tracking.',
      url: 'https://wago.io/search?q=paladin+holy',
    },
  ],
  paladin_retribution: [
    ...DPS_FOCUSED_ADDONS,
    {
      name: 'WeakAuras: Paladin Retribution DPS',
      key: 'weakauras_paladin_ret',
      priority: 'recommended' as Priority,
      description: 'Pre-built WeakAura for Crusade stacks and Avenging Wrath optimization.',
      url: 'https://wago.io/search?q=paladin+retribution+dps',
    },
  ],
  paladin_protection: [
    ...TANK_FOCUSED_ADDONS,
    {
      name: 'WeakAuras: Paladin Tank',
      key: 'weakauras_paladin_tank',
      priority: 'recommended' as Priority,
      description: 'Pre-built WeakAura for lay on hands and divine shield tracking.',
      url: 'https://wago.io/search?q=paladin+tank',
    },
  ],

  // === HUNTER ===
  hunter_beast_mastery: [
    ...DPS_FOCUSED_ADDONS,
    {
      name: 'WeakAuras: Hunter Beast Mastery DPS',
      key: 'weakauras_hunter_bm',
      priority: 'recommended' as Priority,
      description: 'Pre-built WeakAura for kill command cooldown and stampion tracking.',
      url: 'https://wago.io/search?q=hunter+beast+mastery+dps',
    },
  ],
  hunter_marksmanship: [
    ...DPS_FOCUSED_ADDONS,
    {
      name: 'WeakAuras: Hunter Marksmanship DPS',
      key: 'weakauras_hunter_mm',
      priority: 'recommended' as Priority,
      description: 'Pre-built WeakAura for rapid fire and stun trap timers.',
      url: 'https://wago.io/search?q=hunter+marksmanship+dps',
    },
  ],
  hunter_survival: [
    ...DPS_FOCUSED_ADDONS,
    {
      name: 'WeakAuras: Hunter Survival DPS',
      key: 'weakauras_hunter_surv',
      priority: 'recommended' as Priority,
      description: 'Pre-built WeakAura for raptor swiftness and flame cleft tracking.',
      url: 'https://wago.io/search?q=hunter+survival+dps',
    },
  ],

  // === ROGUE ===
  rogue_assassination: [
    ...DPS_FOCUSED_ADDONS,
    {
      name: 'WeakAuras: Rogue Assassination DPS',
      key: 'weakauras_rogue_assassin',
      priority: 'recommended' as Priority,
      description: 'Pre-built WeakAura for blade flip timer and poison refresh tracking.',
      url: 'https://wago.io/search?q=rogue+assassination+dps',
    },
  ],
  rogue_outlaw: [
    ...DPS_FOCUSED_ADDONS,
    {
      name: 'WeakAuras: Rogue Outlaw DPS',
      key: 'weakauras_rogue_outlaw',
      priority: 'recommended' as Priority,
      description: 'Pre-built WeakAura for swordboard procs and gilnean blade tracking.',
      url: 'https://wago.io/search?q=rogue+outlaw+dps',
    },
  ],
  rogue_subtlety: [
    ...DPS_FOCUSED_ADDONS,
    {
      name: 'WeakAuras: Rogue Subtlety DPS',
      key: 'weakauras_rogue_sub',
      priority: 'recommended' as Priority,
      description: 'Pre-built WeakAura for shadow dance stacks and preparation tracking.',
      url: 'https://wago.io/search?q=rogue+subtlety+dps',
    },
  ],

  // === PRIEST ===
  priest_discipline: [
    ...HEALER_FOCUSED_ADDONS,
    {
      name: 'WeakAuras: Priest Discipline',
      key: 'weakauras_priest_disc',
      priority: 'recommended' as Priority,
      description: 'Pre-built WeakAura for power word shield and penance cooldowns.',
      url: 'https://wago.io/search?q=priest+discipline',
    },
  ],
  priest_holy: [
    ...HEALER_FOCUSED_ADDONS,
    {
      name: 'WeakAuras: Priest Holy',
      key: 'weakauras_priest_holy',
      priority: 'recommended' as Priority,
      description: 'Pre-built WeakAura for holy word serenity and divine hymn cooldowns.',
      url: 'https://wago.io/search?q=priest+holy',
    },
  ],
  priest_shadow: [
    ...DPS_FOCUSED_ADDONS,
    {
      name: 'WeakAuras: Priest Shadow DPS',
      key: 'weakauras_priest_shadow',
      priority: 'recommended' as Priority,
      description: 'Pre-built WeakAura for shadowfiel cooldown and mind flay stack tracking.',
      url: 'https://wago.io/search?q=priest+shadow+dps',
    },
  ],

  // === SHAMAN ===
  shaman_elemental: [
    ...DPS_FOCUSED_ADDONS,
    {
      name: 'WeakAuras: Shaman Elemental DPS',
      key: 'weakauras_shaman_elem',
      priority: 'recommended' as Priority,
      description: 'Pre-built WeakAura for elemental blast and lightning surge tracking.',
      url: 'https://wago.io/search?q=shaman+elemental+dps',
    },
  ],
  shaman_enhancement: [
    ...DPS_FOCUSED_ADDONS,
    {
      name: 'WeakAuras: Shaman Enhancement DPS',
      key: 'weakauras_shaman_enh',
      priority: 'recommended' as Priority,
      description: 'Pre-built WeakAura for flood tide stacks and elixir of elemental power.',
      url: 'https://wago.io/search?q=shaman+enhancement+dps',
    },
  ],
  shaman_restoration: [
    ...HEALER_FOCUSED_ADDONS,
    {
      name: 'WeakAuras: Shaman Restoration',
      key: 'weakauras_shaman_rest',
      priority: 'recommended' as Priority,
      description: 'Pre-built WeakAura for stormkeeper and riptide cooldowns.',
      url: 'https://wago.io/search?q=shaman+restoration',
    },
  ],

  // === MAGE ===
  mage_arcane: [
    ...DPS_FOCUSED_ADDONS,
    {
      name: 'WeakAuras: Mage Arcane DPS',
      key: 'weakauras_mage_arcane',
      priority: 'recommended' as Priority,
      description: 'Pre-built WeakAura for arcane charges and mana comet tracking.',
      url: 'https://wago.io/search?q=mage+arcane+dps',
    },
  ],
  mage_fire: [
    ...DPS_FOCUSED_ADDONS,
    {
      name: 'WeakAuras: Mage Fire DPS',
      key: 'weakauras_mage_fire',
      priority: 'recommended' as Priority,
      description: 'Pre-built WeakAura for living bomb and pyroclasm stack tracking.',
      url: 'https://wago.io/search?q=mage+fire+dps',
    },
  ],
  mage_frost: [
    ...DPS_FOCUSED_ADDONS,
    {
      name: 'WeakAuras: Mage Frost DPS',
      key: 'weakauras_mage_frost',
      priority: 'recommended' as Priority,
      description: 'Pre-built WeakAura for freeze and brain freeze proc tracking.',
      url: 'https://wago.io/search?q=mage+frost+dps',
    },
  ],

  // === WARLOCK ===
  warlock_affliction: [
    ...DPS_FOCUSED_ADDONS,
    {
      name: 'WeakAuras: Warlock Affliction DPS',
      key: 'weakauras_warlock_afflict',
      priority: 'recommended' as Priority,
      description: 'Pre-built WeakAura for drain soul and malefic grin tracking.',
      url: 'https://wago.io/search?q=warlock+affliction+dps',
    },
  ],
  warlock_demonology: [
    ...DPS_FOCUSED_ADDONS,
    {
      name: 'WeakAuras: Warlock Demonology DPS',
      key: 'weakauras_warlock_demo',
      priority: 'recommended' as Priority,
      description: 'Pre-built WeakAura for demon arm and call of the underworld tracking.',
      url: 'https://wago.io/search?q=warlock+demonology+dps',
    },
  ],
  warlock_destruction: [
    ...DPS_FOCUSED_ADDONS,
    {
      name: 'WeakAuras: Warlock Destruction DPS',
      key: 'weakauras_warlock_destro',
      priority: 'recommended' as Priority,
      description: 'Pre-built WeakAura for emberstorm and cataclysm stack tracking.',
      url: 'https://wago.io/search?q=warlock+destruction+dps',
    },
  ],

  // === MONK ===
  monk_brewmaster: [
    ...TANK_FOCUSED_ADDONS,
    {
      name: 'WeakAuras: Monk Brewmaster Tank',
      key: 'weakauras_monk_bw',
      priority: 'recommended' as Priority,
      description: 'Pre-built WeakAura for stagger gauge and fortifying brew tracking.',
      url: 'https://wago.io/search?q=monk+brewmaster+tank',
    },
  ],
  monk_mistweaver: [
    ...HEALER_FOCUSED_ADDONS,
    {
      name: 'WeakAuras: Monk Mistweaver Healer',
      key: 'weakauras_monk_mw',
      priority: 'recommended' as Priority,
      description: 'Pre-built WeakAura for chi egg and mana tea tracking.',
      url: 'https://wago.io/search?q=monk+mistweaver',
    },
  ],
  monk_windwalker: [
    ...DPS_FOCUSED_ADDONS,
    {
      name: 'WeakAuras: Monk Windwalker DPS',
      key: 'weakauras_monk_ww',
      priority: 'recommended' as Priority,
      description: 'Pre-built WeakAura for combo brew and black out kick stack tracking.',
      url: 'https://wago.io/search?q=monk+windwalker+dps',
    },
  ],

  // === DRUID ===
  druid_balance: [
    ...DPS_FOCUSED_ADDONS,
    {
      name: 'WeakAuras: Druid Balance DPS',
      key: 'weakauras_druid_bal',
      priority: 'recommended' as Priority,
      description: 'Pre-built WeakAura for moonkin form and solar/nightfall tracking.',
      url: 'https://wago.io/search?q=druid+balance+dps',
    },
  ],
  druid_feral: [
    ...DPS_FOCUSED_ADDONS,
    {
      name: 'WeakAuras: Druid Feral DPS',
      key: 'weakauras_druid_fer',
      priority: 'recommended' as Priority,
      description: 'Pre-built WeakAura for fury and shred stack tracking.',
      url: 'https://wago.io/search?q=druid+feral+dps',
    },
  ],
  druid_guardian: [
    ...TANK_FOCUSED_ADDONS,
    {
      name: 'WeakAuras: Druid Guardian Tank',
      key: 'weakauras_druid_gua',
      priority: 'recommended' as Priority,
      description: 'Pre-built WeakAura for ironbark and bears form cooldown tracking.',
      url: 'https://wago.io/search?q=druid+guardian+tank',
    },
  ],
  druid_restoration: [
    ...HEALER_FOCUSED_ADDONS,
    {
      name: 'WeakAuras: Druid Restoration Healer',
      key: 'weakauras_druid_rest',
      priority: 'recommended' as Priority,
      description: 'Pre-built WeakAura for wild growth and regrowth cooldown tracking.',
      url: 'https://wago.io/search?q=druid+restoration',
    },
  ],

  // === DEATH KNIGHT ===
  death_knight_blood: [
    ...TANK_FOCUSED_ADDONS,
    {
      name: 'WeakAuras: DK Blood Tank',
      key: 'weakauras_dk_blood',
      priority: 'recommended' as Priority,
      description: 'Pre-built WeakAura for death strike and heart strike cooldown tracking.',
      url: 'https://wago.io/search?q=death+knight+blood+tank',
    },
  ],
  death_knight_frost: [
    ...DPS_FOCUSED_ADDONS,
    {
      name: 'WeakAuras: DK Frost DPS',
      key: 'weakauras_dk_frost',
      priority: 'recommended' as Priority,
      description: 'Pre-built WeakAura for obliterate and death strike stack tracking.',
      url: 'https://wago.io/search?q=death+knight+frost+dps',
    },
  ],
  death_knight_unholy: [
    ...DPS_FOCUSED_ADDONS,
    {
      name: 'WeakAuras: DK Unholy DPS',
      key: 'weakauras_dk_unholy',
      priority: 'recommended' as Priority,
      description: 'Pre-built WeakAura for foul feast and grip of death tracking.',
      url: 'https://wago.io/search?q=death+knight+unholy+dps',
    },
  ],

  // === EVOKER ===
  evoker_devastation: [
    ...DPS_FOCUSED_ADDONS,
    {
      name: 'WeakAuras: Evoker Devastation DPS',
      key: 'weakauras_evoker_dev',
      priority: 'recommended' as Priority,
      description: 'Pre-built WeakAura for breath cooldowns and time slip tracking.',
      url: 'https://wago.io/search?q=evoker+devastation+dps',
    },
  ],
  evoker_preservation: [
    ...HEALER_FOCUSED_ADDONS,
    {
      name: 'WeakAuras: Evoker Preservation Healer',
      key: 'weakauras_evoker_pres',
      priority: 'recommended' as Priority,
      description: 'Pre-built WeakAura for wings healing cooldown and breathe timer.',
      url: 'https://wago.io/search?q=evoker+preservation',
    },
  ],
  evoker_augmentation: [
    ...DPS_FOCUSED_ADDONS,
    {
      name: 'WeakAuras: Evoker Augmentation DPS',
      key: 'weakauras_evoker_aug',
      priority: 'recommended' as Priority,
      description: 'Pre-built WeakAura for dragonflight buff and time stop tracking.',
      url: 'https://wago.io/search?q=evoker+augmentation+dps',
    },
  ],

  // === DEMON HUNTER ===
  demon_hunter_havoc: [
    ...DPS_FOCUSED_ADDONS,
    {
      name: 'WeakAuras: DH Havoc DPS',
      key: 'weakauras_dh_havoc',
      priority: 'recommended' as Priority,
      description: 'Pre-built WeakAura for metamorphosis and eye beam tracking.',
      url: 'https://wago.io/search?q=demon+hunter+havoc+dps',
    },
  ],
  demon_hunter_vengeance: [
    ...TANK_FOCUSED_ADDONS,
    {
      name: 'WeakAuras: DH Vengeance Tank',
      key: 'weakauras_dh_vengeance',
      priority: 'recommended' as Priority,
      description: 'Pre-built WeakAura for met and soul barrier tracking.',
      url: 'https://wago.io/search?q=demon+hunter+vengeance+tank',
    },
  ],
};

/** Get the full addon list for a given class/spec combo */
export function getAddonsForClassSpec(
  classId: string,
  specId: string,
): AddonRecommendation[] {
  const key = `${classId}_${specId}`;
  const specAddons = SPEC_ADDONS[key] ?? [];
  return [...SHARED_ADDONS, ...specAddons];
}

/** Get the full addon list for ALL classes/specs (for data export) */
export function getAllRecommendations(): Record<string, AddonRecommendation[]> {
  const result: Record<string, AddonRecommendation[]> = {};
  for (const [key, addons] of Object.entries(SPEC_ADDONS)) {
    result[key] = [...SHARED_ADDONS, ...addons];
  }
  return result;
}
