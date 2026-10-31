--[[
  Core.lua — Main entry point and scanning engine.
  Handles addon detection, class/spec detection, and profile management.
]]

local _, CAP = ...

-- ---------------------------------------------------------------------------
-- State
-- ---------------------------------------------------------------------------

CAP.ActiveClass = nil    -- current selected class ID (e.g., "warrior")
CAP.ActiveSpec  = nil    -- current selected spec ID (e.g., "arms")
CAP.InstalledAddons = {} -- table of addon keys that are currently installed
CAP.ScanResults = {}     -- scan results keyed by addon key

-- ---------------------------------------------------------------------------
-- Frame creation
-- ---------------------------------------------------------------------------

CAP.Frame = CreateFrame("Frame", "ClassAddonPickerFrame", UIParent, "UIDialogFrameBackdropTemplate")
CAP.Frame:Hide()
CAP.Frame:SetSize(500, 400)
CAP.Frame:SetPoint("CENTER")
CAP.Frame:SetTitle(L.profileTitle)
CAP.Frame:SetMovable(true)
CAP.Frame:EnableMouse(true)
CAP.Frame:RegisterForDrag("LeftButton")
CAP.Frame:SetScript("OnDragStart", CAP.Frame.StartMoving)
CAP.Frame:SetScript("OnDragStop", CAP.Frame.StopMovingAndSizing)

-- Minimap icon
if not CAP.MinimapIcon then
  CAP.MinimapIcon = CreateFrame("Button", "ClassAddonPickerMinimapIcon", Minimap)
  CAP.MinimapIcon:SetSize(32, 32)
  CAP.MinimapIcon:SetFrameStrata("MEDIUM")
  CAP.MinimapIcon:SetNormalTexture("Interface\\Icons\\INV_Misc_Map_05")
  CAP.MinimapIcon:SetPushableText(L.profileTitle)
  CAP.MinimapIcon:SetScript("OnClick", function()
    if CAP.Frame:IsVisible() then
      CAP.Frame:Hide()
    else
      CAP.Frame:Show()
    end
  end)
  CAP.MinimapIcon:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT")
    GameTooltip:AddLine(L.profileTitle)
    GameTooltip:AddLine("Click to open/close the addon picker.")
    GameTooltip:Show()
  end)
  CAP.MinimapIcon:SetScript("OnLeave", function()
    GameTooltip:Hide()
  end)
end

-- Minimap circle cluster (WoW 10+)
if not CAP.MinimapCluster then
  CAP.MinimapCluster = CreateFrame("GameTooltip", "MinimapCluster", Minimap, "MinimapClusterTooltipTemplate")
  local mmIcon = CAP.MinimapIcon:GetNormalTexture()
  local x, y = mmIcon:GetCenter()
  if x and y then
    -- Cluster the icon with other minimap icons if present
    CAP.MinimapCluster:SetPoint("CENTER", Minimap, "BOTTOMLEFT", x / 800 * Minimap:GetWidth(), y / 600 * Minimap:GetHeight())
  end
end

-- ---------------------------------------------------------------------------
-- Class/Spec detection
-- ---------------------------------------------------------------------------

function CAP:DetectCurrentClassAndSpec()
  -- Get the current specialization for the player's current form (useful for druid/monk)
  local _, classId = UnitClass("player")
  if not classId then
    return nil, nil
  end

  -- Normalize class ID to match CAPClasses keys
  classId = string.lower(classId:gsub(" ", "_"))

  local specId = "none"
  -- Try to get active specialization
  local numSpecs = GetNumSpecializations()
  if numSpecs and numSpecs > 0 then
    local _, currentSpecName = GetActiveSpecialization()
    if currentSpecName then
      -- Find matching spec ID from the class data
      local classData = CAPClasses[classId]
      if classData then
        for sid, sinfo in pairs(classData.specs) do
          if sinfo.name == currentSpecName then
            specId = sid
            break
          end
        end
      end
    end
  else
    -- No specs available (e.g. at character creation or dead)
    specId = "none"
  end

  return classId, specId
end

-- ---------------------------------------------------------------------------
-- Addon scanning
-- ---------------------------------------------------------------------------

function CAP:ScanInstalledAddons()
  self.InstalledAddons = {}
  local total = C_AddOns.GetNumAddOns() or 0
  for i = 1, total do
    local name, title, notes, enableState, loadable, reason, tocTitle, tocInterface = C_AddOns.GetAddOnInfo(i)
    if name and tocTitle then
      self.InstalledAddons[name:lower()] = true
    end
  end
end

function CAP:ScanForRecommendedAddons()
  self.ScanResults = {}
  for key, addon in pairs(CAPAddonRegistry) do
    local found = false
    -- Check by addon name (case-insensitive partial match against installed addons)
    for installedName in pairs(self.InstalledAddons) do
      if installedName:lower():find(addon.name:lower(), 1, true) then
        found = true
        break
      end
    end
    -- Also check by key as fallback
    if not found and self.InstalledAddons[key] then
      found = true
    end

    self.ScanResults[key] = {
      key = key,
      name = addon.name,
      installed = found,
      loaded = false,
    }
  end
end

-- ---------------------------------------------------------------------------
-- Frame initialization and event handling
-- ---------------------------------------------------------------------------

CAP.Frame:SetScript("OnShow", function(self)
  CAP:ScanInstalledAddons()
  CAP:ScanForRecommendedAddons()

  -- Detect current class/spec
  local classId, specId = CAP:DetectCurrentClassAndSpec()
  if classId and CAPClasses[classId] then
    CAP.ActiveClass = classId
  end

  -- Refresh the recommendations panel
  CAPFrameHelper:RefreshRecommendations(CAP.ActiveClass, CAP.ActiveSpec)
end)

-- Slash command to open/close the addon picker
SLASH_CLASSADDONPICKER1 = "/cap"
SLASH_CLASSADDONPICKER2 = "/classaddonpicker"
SlashCmdList["CLASSADDONPICKER"] = function(msg)
  if CAP.Frame:IsVisible() then
    CAP.Frame:Hide()
  else
    -- Detect current class/spec on first open
    local classId, specId = CAP:DetectCurrentClassAndSpec()
    CAP.ActiveClass = classId
    CAP.ActiveSpec = specId
    CAP:ScanInstalledAddons()

    CAP.Frame:Show()
    CAPFrameHelper:RefreshRecommendations(CAP.ActiveClass, CAP.ActiveSpec)
  end
end
