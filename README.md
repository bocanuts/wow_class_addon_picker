# Class Addon Picker

A World of Warcraft addon that suggests and auto-configures the best addons for each character class and spec — plus a companion web app to browse, manage, and export your profiles.

## What It Does

- **Detects** which popular addons are installed on your character's profile
- **Recommends** the best addons per class and spec (DPS, tank, or healer) with essential / recommended / optional priorities
- **Auto-configures** installed addons by writing their SavedVariables settings to match your chosen profile
- **Manages profiles** — create, save, switch, and export addon profiles for every one of WoW's 12 classes across 39 specs (including the Evoker)
- **Companion web UI** lets you browse recommendations, build profiles with a rich interface, and export JSON files that the in-game addon imports

## Architecture

```
wow_class_addon_picker/
├── addon/                    # In-game WoW addon (.toc + Lua)
│   ├── ClassAddonPicker.toc  # Manifest (WoW 11.03+ compatible)
│   ├── Core.lua              # Entry, slash commands (/cap), frame & minimap icon
│   ├── Data.lua              # All 12 classes, 39 specs, 12 addon registry entries
│   ├── Locals.lua            # UI string table
│   ├── Config.lua            # Settings write-back engine (plugin registry pattern)
│   ├── Profile.lua           # Profile CRUD + import/export via SavedVariables
│   └── UI/
│       ├── Framework.lua         # Shared frame/layout helpers
│       ├── Recommendations.lua  # Recommendation list panel
│       └── ConfigScreen.lua     # Per-addon settings screen
├── shared/                   # Canonical data source for both components
│   ├── classes.json              # All classes and specs
│   ├── addon-recommendations.ts  # Real addon recommendations per spec
│   └── types.ts                  # TypeScript type definitions
├── web-ui/                   # Companion web app (React + Vite + TS)
│   ├── package.json
│   ├── vite.config.ts
│   ├── tsconfig.json
│   ├── index.html
│   └── src/
│       ├── main.tsx
│       └── App.tsx           # Class selector, spec tabs, addon list, profiles
├── scripts/
│   └── generate_lua_tables.mjs   # Converts shared data → Lua tables
└── CLAUDE.md                   # Project conventions & constraints
```

## Installation

### In-Game Addon

1. Extract the `addon/` folder into your WoW directory:
   ```
   World of Warcraft/_retail_/Interface/Addons/ClassAddonPicker/
   ```
2. Reload UI (`/reload`) or restart your client
3. Open with `/cap` or click the minimap icon

### Companion Web App

1. Navigate to `web-ui/`:
   ```bash
   cd web-ui && npm install && npm run dev
   ```
2. Browse all 12 classes and 39 specs
3. Select addons for your profile
4. Export the profile as JSON — paste it into-game via `/cap import`

## Addon Registry

The addon knows about these real addons (with auto-configure support):

| Key | Name | Priority | Settings Target |
|-----|------|----------|----------------|
| `dbm` | Deadly Boss Mods | Essential | `DBM-Core` |
| `bigwigs` | BigWigs | Optional | `BigWigs_Options` |
| `weakauras` | WeakAuras 3 | Essential | `WeakAurs` |
| `details` | Details! Damage Meter | Essential | `Details!VCData` |
| `bagnon` | Bagnon | Recommended | — |
| `auctionator` | Auctionator | Recommended | — |
| `tellmewhen` | TellMeWhen | Essential | `TellMeWhen1DB` |
| `kuinameplates` | KuiNameplates | Recommended | `Kui_NameplatesDB` |
| `quartz` | Quartz | Recommended | `Quartz30DB` |
| `auraframes` | AuraFrames | Recommended | `AuraFramesDB` |
| `elvui` | ElvUI | Recommended | `ElvUI_Config` |

## Classes & Specs

All 12 classes with every spec (as of The War Within):

| Class | Specs |
|-------|-------|
| Warrior | Arms · Fury · Protection |
| Paladin | Holy · Retribution · Protection |
| Hunter | Beast Mastery · Marksmanship · Survival |
| Rogue | Assassination · Outlaw · Subtlety |
| Priest | Discipline · Holy · Shadow |
| Shaman | Elemental · Enhancement · Restoration |
| Mage | Arcane · Fire · Frost |
| Warlock | Affliction · Demonology · Destruction |
| Monk | Brewmaster · Mistweaver · Windwalker |
| Druid | Balance · Feral · Guardian · Restoration |
| Death Knight | Blood · Frost · Unholy |
| Evoker | Devastation · Preservation · Augmentation |

## Slash Commands

| Command | Action |
|---------|--------|
| `/cap` | Open/close the addon picker panel |
| `/classaddonpicker` | Same as `/cap` (longer name) |

## How Profiles Sync

Profiles live in two places — **not automatically synced**:

1. **Web UI** — Saved in browser localStorage under `cap_profiles`. Use "Export to JSON" to get a portable copy.
2. **In-game** — Saved in WoW's SavedVariables (`CAPSavedVars`) under your character's WTF/profile directory.
3. **Import into game** — Copy the exported JSON → open WoW → type `/cap import` and paste the string when prompted.

Data flows from web to game only via manual copy/paste due to WoW's sandbox restrictions (no network or filesystem access).

## Limitations

- **No auto-install** — The addon can detect which addons are already installed, but cannot download or install addons automatically. The web UI provides CurseForge/WoWInterface download links.
- **Settings write-back is addon-dependent** — It works by writing to each addon's SavedVariables global table. Addons that use protected APIs or custom storage may not be configurable.
- **WeakAuras complexity** — WA uses deeply nested data structures; for full configuration support, use its `WeakAuras.LoadFromWAWX()` import API instead of direct variable manipulation.
- **SavedVariables limit** — ~512 KB practical limit per SavedVariable. Large profiles may approach this.
- **Chat message limit** — Chat commands are limited to 255 characters; the `/cap import` slash command bypasses this with a text input prompt.

## Development

### Add new class or spec

1. Update `shared/classes.json`
2. Add entries in `shared/addon-recommendations.ts` (`SPEC_ADDONS`)
3. Add data in `addon/Data.lua` (`CAPClasses["class_id"]`)
4. Update `shared/types.ts` ClassId union
5. Run `node scripts/generate_lua_tables.mjs` (or update `Data.lua` manually)

### Run the web UI

```bash
cd web-ui
npm install
npm run dev
```

### Add new addon support

1. Add an entry to `CAPAddonRegistry` in `addon/Data.lua` with its SavedVariables global name and default settings
2. Add recommendations in `shared/addon-recommendations.ts` under the appropriate focused set (DPS / tank / healer) or per-spec entries
3. If the addon has a documented public API, use that instead of direct SavedVariables access

## License

Proprietary — created by Jason Collier.
