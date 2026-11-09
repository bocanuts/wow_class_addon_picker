--[[
  Profile.lua — User profile persistence via SavedVariables.
]]

local _, CAP = ...

-- Global variable for SavedVariables (must match the .toc)
CAPSavedVars = CAPSavedVars or { profiles = {} }

function CAP:SaveProfile(profile)
  -- Find existing profile with same ID and replace it
  local foundIndex = nil
  for i, p in ipairs(CAPSavedVars.profiles) do
    if p.id == profile.id then
      foundIndex = i
      break
    end
  end

  if foundIndex then
    CAPSavedVars.profiles[foundIndex] = profile
  else
    table.insert(CAPSavedVars.profiles, profile)
  end
end

function CAP:DeleteProfile(profileId)
  for i, p in ipairs(CAPSavedVars.profiles) do
    if p.id == profileId then
      table.remove(CAPSavedVars.profiles, i)
      return true
    end
  end
  return false
end

function CAP:GetProfiles()
  return CAPSavedVars.profiles
end

function CAP:ExportProfileToJson(profile)
  -- Serialize to a JSON string that can be saved to disk or copied
  -- Helper: escape a string for JSON output
  local function jsonEscape(str)
    return str:gsub('\\', '\\\\'):gsub('"', '\\"'):gsub('\n', '\\n'):gsub('\r', '\\r'):gsub('\t', '\\t')
  end

  local json = "{\n"
  json = json .. '  "id": "' .. jsonEscape(profile.id) .. '",\n'
  json = json .. '  "name": "' .. jsonEscape(profile.name or "Untitled") .. '",\n'
  json = json .. '  "classId": "' .. jsonEscape(profile.classId) .. '",\n'
  json = json .. '  "specId": "' .. jsonEscape(profile.specId) .. '",\n'
  json = json .. '  "selectedAddons": ['

  for i, key in ipairs(profile.selectedAddons) do
    json = json .. '"' .. jsonEscape(key) .. '"'
    if i < #profile.selectedAddons then
      json = json .. ", "
    end
  end
  json = json .. "],\n"

  -- Custom overrides (simplified — not deep-serializing nested objects)
  if profile.customOverrides and next(profile.customOverrides) then
    json = json .. '  "customOverrides": {}\n'
  else
    json = json .. '  "customOverrides": null\n'
  end

  json = json .. "}\n"
  return json
end

-- Import a profile from JSON (e.g., copied from the web UI)
function CAP:ImportProfileFromJson(jsonString)
  -- Use WoW's built-in JSON decoder
  local ok, data = pcall(C_JSON.Decode, jsonString)
  if not ok or not data then
    return nil, "Invalid JSON"
  end

  if not data.id or not data.classId or not data.specId then
    return nil, "Missing required fields (id, classId, specId)"
  end

  local profile = {
    id = data.id,
    name = data.name or "Imported Profile",
    classId = data.classId,
    specId = data.specId,
    selectedAddons = {},
    customOverrides = data.customOverrides or nil,
    createdAt = data.createdAt or GetTime(),
    updatedAt = GetTime(),
  }

  -- Parse selected addons (they may be stored as a simple array)
  if type(data.selectedAddons) == "table" then
    for _, addonKey in ipairs(data.selectedAddons) do
      table.insert(profile.selectedAddons, addonKey)
    end
  end

  return profile
end
