--[[
  Config.lua — Addon configuration engine.
  Writes settings to installed addon SavedVariables globals.
]]

local _, CAP = ...

-- ---------------------------------------------------------------------------
-- Settings application
-- ---------------------------------------------------------------------------

function CAP:ApplyAddonSettings(addonKey)
  local addonInfo = CAPAddonRegistry[addonKey]
  if not addonInfo then
    return false, "Unknown addon key"
  end

  -- Check that the addon is actually installed
  local savedVarName = addonInfo.savedVariableName or addonKey
  if not _G[savedVarName] then
    return false, "Addon not found — install " .. addonInfo.name .. " first"
  end

  -- Deep merge default settings into the addon's SavedVariables
  local targetTable = _G[savedVarName]
  for key, value in pairs(addonInfo.defaultSettings or {}) do
    if type(key) == "number" then
      -- Table index — not supported in general WoW Lua tables
      -- Skip for now; this is a known limitation.
      return false, "Indexed settings not supported (key: " .. tostring(key) .. ")"
    end

    -- Create intermediate tables if needed
    if type(value) == "table" then
      if not targetTable[key] or type(targetTable[key]) ~= "table" then
        targetTable[key] = {}
      end
      -- Deep merge
      for k, v in pairs(value) do
        targetTable[key][k] = v
      end
    else
      targetTable[key] = value
    end
  end

  return true, "Settings applied to " .. savedVarName
end

-- Apply settings for all addons in the active profile
function CAP:ApplyProfileSettings(profile)
  local results = {}
  for _, addonKey in ipairs(profile.selectedAddons) do
    local ok, msg = self:ApplyAddonSettings(addonKey)
    table.insert(results, { key = addonKey, ok = ok, message = msg })

    if ok then
      print("|cff4fc08f[CAP]|r " .. L.configApplied .. ": |cffffff00" .. addonKey .. "|r")
    else
      print("|cffff4040[CAP]|r " .. L.configFailed .. ": " .. msg)
    end
  end
  return results
end

-- ---------------------------------------------------------------------------
-- Settings detection for scanning
-- ---------------------------------------------------------------------------

function CAP:GetAddonSettingStatus(addonKey)
  local addonInfo = CAPAddonRegistry[addonKey]
  if not addonInfo then
    return false, "Unknown addon key"
  end

  local savedVarName = addonInfo.savedVariableName or addonKey
  local tableExists = _G[savedVarName] ~= nil

  if not tableExists then
    return false, "Addon not found — install " .. addonInfo.name .. " first"
  end

  -- Check that at least one setting key exists in the target table
  local settingsApplied = false
  local existingTable = _G[savedVarName]
  for key in pairs(addonInfo.defaultSettings or {}) do
    if type(key) == "number" then
      goto continue
    end
    if existingTable[key] ~= nil then
      settingsApplied = true
      goto found
    end
    ::continue::
  end

  ::found::
  return settingsApplied, "Addon is installed — no custom settings yet"
end
