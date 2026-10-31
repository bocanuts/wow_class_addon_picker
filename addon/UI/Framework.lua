--[[
  Framework.lua — Shared UI helper functions for frame/layout creation.
]]

local _, CAP = ...

CAPFrameHelper = CAPFrameHelper or {}

-- Create a styled button with icon and text
function CAPFrameHelper:CreateAddonButton(parent, addonKey, iconPath)
  local btn = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
  btn:SetSize(200, 32)

  -- Icon (use inventory item texture if available)
  local tex = btn:CreateTexture(nil, "OVERLAY")
  tex:SetSize(16, 16)
  tex:SetPoint("LEFT", 4, 0)
  tex:SetTexture(iconPath or "Interface\\Icons\\INV_Misc_Bag_07")

  -- Text label
  local text = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
  text:SetPoint("LEFT", tex, "RIGHT", 4, 0)
  addonText:SetText(addonKey)

  btn.text = text
  btn.icon = tex
  return btn
end

-- Create a class/spec selector row
function CAPFrameHelper:CreateClassSpecSelector(parent)
  -- Class list (left side scrollable list)
  local classList = CreateFrame("ScrollBox", "CAP_ClassList", parent, "NeoScrollViewBackdropTemplate")
  classList:SetSize(150, 320)
  classList:SetPoint("TOPLEFT", 16, -48)
  classList:SetPoint("BOTTOMLEFT", 16, 16)

  -- Spec tabs (right side horizontal tabs)
  local specTabs = CreateFrame("Frame", nil, parent)
  specTabs:SetSize(320, 32)
  specTabs:SetPoint("TOPRIGHT", -16, -48)

  -- Recommendations panel (below selectors)
  local recPanel = CreateFrame("ScrollBox", "CAP_RecommendationsPanel", parent, "NeoScrollViewBackdropTemplate")
  recPanel:SetSize(500, 200)
  recPanel:SetPoint("TOPLEFT", classList, "BOTTOMLEFT", 0, -8)
  recPanel:SetPoint("TOPRIGHT", specTabs, "BOTTOMRIGHT", 0, -8)

  return {
    classList = classList,
    specTabs = specTabs,
    recommendationsPanel = recPanel,
  }
end

-- Refresh the recommendation list for a given class/spec
function CAPFrameHelper:RefreshRecommendations(classId, specId)
  -- This will be called from Core.lua when the user selects a new class or spec
  -- It should populate CAP_FrameHelper.recommendationList with addon cards
  -- based on the shared recommendation data.

  if not classId or not CAPClasses[classId] then return end

  local panel = self.recommendationsPanel or _G["CAP_RecommendationsPanel"]
  if not panel then return end

  -- Clear existing items
  if panel.ResetList then
    panel:ResetList()
  end

  -- Build recommendation list from CAPClasses and CAPAddonRegistry
  -- This is a simplified placeholder — the full implementation would iterate
  -- CAPClasses[classId].specs, match against spec-specific addon data,
  -- and create addon card frames.

  print("|cff4fc08f[CAP]|r Showing recommendations for |cffffff00" .. (CAPClasses[classId] and CAPClasses[classId].name or classId) .. "|r")
end
