# CLAUDE.md — WoW Class Addon Picker Project Conventions

## Project Structure
```
wow_class_addon_picker/
├── addon/                    # In-game WoW addon (Lua)
│   ├── ClassAddonPicker.toc  # Manifest: Interface version, SavedVariables, file list
│   ├── Core.lua              # Main entry, frame creation, slash commands
│   ├── Data.lua              # Static class/spec data + addon registry
│   ├── Locals.lua            # String table for UI labels
│   ├── Config.lua            # Addon settings writer engine
│   ├── Profile.lua           # User profile CRUD + import/export via SavedVariables
│   └── UI/                   # In-game UI components
│       ├── Framework.lua     # Shared frame/layout helpers
│       ├── Recommendations.lua  # Recommendation list panel
│       └── ConfigScreen.lua    # Per-addon settings config screen
├── shared/                   # Shared TypeScript data between both components
│   ├── classes.json              # Canonical class/spec definitions (13 classes)
│   ├── addon-recommendations.ts  # Real addon recommendations + REGISTRY_ADDONS per spec
│   ├── registry-addons.json      # JSON sidecar for REGISTRY_ADDONS (used by Lua generator)
│   └── types.ts                  # TypeScript type definitions
├── web-ui/                   # Companion web app (React + Vite + TypeScript)
│   ├── package.json          # Dependencies: React, Vite
│   ├── vite.config.ts        # Build config with path aliases
│   ├── tsconfig.json         # TS compiler options
│   ├── index.html            # Shell HTML with theme CSS variables
│   └── src/
│       ├── main.tsx          # React entry point
│       └── App.tsx           # Main app: class selector, spec tabs, addon list, profiles
├── scripts/                  # Build/data tools
│   └── generate_lua_tables.mjs  # Converts shared JSON → Lua tables (needs Node.js)
├── .gitignore
└── README.md
```

## Coding Conventions

### Lua (addon/)
- **Files are loaded in TOC order** — always place includes at the bottom of `.toc` after their dependencies.
- **Module pattern**: `local _, CAP = ...` at top, all functions assigned to `CAP.` or a submodule like `CAPFrameHelper`.
- **SavedVariables**: Declared in .toc (`CAPSavedVars`, `CAPCharSettings`). Never write to globals directly outside the module system.
- **UI frames**: Use Blizzard templates (e.g., `UIDialogFrameBackdropTemplate`, `BasicFrameTemplateWithInset`) for consistency.
- **Localization**: All player-facing strings go in `Locals.lua` under `CAP.L`. Do not hardcode English strings in Lua files.
- **Error handling**: Wrap risky operations (addon detection, SavedVariables writes) in `pcall()`. Print errors with `|cffff4040[CAP]|r` prefix.

### TypeScript/React (web-ui/)
- **Shared data is the source of truth** — never hardcode class/spec/addon data in web UI components. Import from `../shared/`.
- **Component style**: Function components with inline styles only (no external CSS). Use CSS variables defined in `index.html` for theming.
- **Profiles stored in localStorage** under key `cap_profiles`. Each profile is a `UserProfile` object.
- **Export format**: JSON strings that the user can paste into the in-game addon via `/cap import`.

### Data Model
- **classId**: lowercase with underscores (e.g., `death_knight`, `demon_hunter`)
- **specId**: lowercase with underscores (e.g., `beast_mastery`, `marksmanship`)
- **addonKey**: lowercase with underscores (e.g., `weakauras`, `kuinameplates`)
- **SavedVariables global name**: as reported by the addon itself (case-sensitive, e.g., `DBM-Core`, `WeakAurs`)

## Known Constraints & Gotchas
- **WoW sandbox**: The addon cannot install other addons or write outside WoW's file directories. It can only detect installed addons and modify their SavedVariables globals.
- **Chat message limit**: 255 characters for chat commands. Use `/cap import` which prompts for text input (bypasses the limit).
- **Addon loading order**: Addons load asynchronously during `PLAYER_LOGIN`. Check `ADDON_LOADED` events before reading another addon's settings.
- **Interface version**: The `.toc` `## Interface` field must match WoW's internal interface number each expansion. Test against the target client version.
- **WeakAuras complexity**: WA has deeply nested data structures. Consider using its public API (`WeakAuras.LoadFromWAWX()`) for import rather than direct variable manipulation.

## Testing
1. **Web UI**: `cd web-ui && npm install && npm run dev`
2. **In-game addon**: Place the `addon/` folder in WoW's `Interface/Addons/ClassAddonPicker/` directory. Requires a WoW client.
3. **Data consistency**: Ensure `shared/classes.json`, `addon/Data.lua`, and `web-ui/src/App.tsx` stay synchronized when adding/removing classes or specs.

## Adding New Classes/Specs
1. Update `shared/classes.json` with the new class and its specs.
2. Add `SPEC_ADDONS` entries in `shared/addon-recommendations.ts` for each new spec.
3. Update `shared/types.ts` ClassId type union.
4. Run `node scripts/generate_lua_tables.mjs` — Data.lua is entirely auto-generated.

## Adding a New Addon to the Registry

1. Add an entry to `REGISTRY_ADDONS` in `shared/addon-recommendations.ts` with its `savedVariableName` and default settings
2. Re-generate: the new JSON sidecar (`shared/registry-addons.json`) is written from REGISTRY_ADDONS
3. Run `node scripts/generate_lua_tables.mjs` — both `CAPClasses` and `CAPAddonRegistry` are regenerated
