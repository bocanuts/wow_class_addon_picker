--[[
  Recommendations.lua — In-game addon: recommendation list panel.
]]

local _, CAP = ...

CAPRecs = {
  frame = nil,
  scrollFrame = nil,
  items = {},
  count = 0,
}

function CAPRecs:Create(parent)
  -- Create a container frame for the recommendations list
  local frame = CreateFrame("Frame", nil, parent, "BackdropTemplate")
  frame:SetSize(464, 300)
  frame:SetPoint("TOPLEFT", 16, -8)

  -- Scroll area
  local scroll = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
  scroll:SetPoint("TOPLEFT", 4, -4)
  scroll:SetPoint("BOTTOMRIGHT", -22, 4)
  scroll:SetScrollChild(CreateFrame("Frame", nil, scroll))

  CAPRecs.frame = frame
  CAPRecs.scrollFrame = scroll

  return frame
end

function CAPRecs:Refresh(classId, specId)
  -- Clear existing items
  for i = 1, self.count do
    if self.items[i] then
      self.items[i]:Hide()
      self.items[i]:SetParent(nil)
    end
    self.items[i] = nil
  end
  self.count = 0

  if not classId or not CAPClasses[classId] then return end

  local startY = -8
  local addonList = self:GetAddonList(classId, specId)

  for idx, addon in ipairs(addonList) do
    local item = self:CreateItem(addon)
    item:SetPoint("TOPLEFT", self.scrollFrame:GetScrollChild(), "TOPLEFT", 4, startY - (idx - 1) * 48)
    self.items[idx] = item
    self.count = idx
  end
end

function CAPRecs:GetAddonList(classId, specId)
  -- Build addon list from CAPAddonRegistry + scan results
  local result = {}
  for key, addon in pairs(CAPAddonRegistry) do
    table.insert(result, {
      key = key,
      name = addon.name,
      priority = addon.priority,
      description = addon.description or "",
      url = addon.url,
      installed = false,
      configApplied = false,
      settingsCount = 0,
    })
  end

  -- Mark installed status from scan results
  if CAP.InstalledAddons and next(CAP.InstalledAddons) then
    for key, addon in ipairs(result) do
      for installedName in pairs(CAP.InstalledAddons) do
        if installedName:find(addon.name, 1, true) then
          addon.installed = true
          break
        end
      end
    end
  end

  return result
end

function CAPRecs:CreateItem(addonInfo)
  local frame = CreateFrame("Button", nil, self.scrollFrame:GetScrollChild())
  frame:SetSize(456, 40)
  frame:SetNormalTexture("Interface\\Frames\\UI-DialogBox-Background-Dark")
  frame:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:AddLine(addonInfo.name, 1, 1, 1)
    if addonInfo.installed then
      GameTooltip:AddLine("|cff4fc08fInstalled|r", 0.31, 0.75, 0.29)
    else
      GameTooltip:AddLine("|cffff4040Not Installed|r", 1, 0.25, 0.25)
    end
    if addonInfo.description then
      GameTooltip:AddLine(addonInfo.description, 1, 1, 1)
    end
    GameTooltip:Show()
  end)
  frame:SetScript("OnLeave", function()
    GameTooltip:Hide()
  end)

  -- Priority color bar (left strip)
  local priorityColor
  if addonInfo.priority == "essential" then
    priorityColor = { r = 1, g = 0.14, b = 0.14 }
  elseif addonInfo.priority == "recommended" then
    priorityColor = { r = 0.96, g = 0.62, b = 0.04 }
  else
    priorityColor = { r = 0.23, g = 0.51, b = 0.96 }
  end

  local strip = frame:CreateTexture(nil, "OVERLAY")
  strip:SetSize(4, 32)
  strip:SetPoint("LEFT", 0, 0)
  strip:SetVertexColor(priorityColor.r, priorityColor.g, priorityColor.b)

  -- Status indicator
  local statusTex = frame:CreateTexture(nil, "OVERLAY")
  statusTex:SetSize(16, 16)
  statusTex:SetPoint("LEFT", 8, 0)
  if addonInfo.installed then
    statusTex:SetTexture("Interface\\Icons\\INV_Gear_Titanforge_01")
    statusTex:SetVertexColor(0.31, 0.75, 0.29)
  else
    statusTex:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark_01")
    statusTex:SetVertexColor(1, 1, 1)
  end

  -- Name text
  local nameText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  nameText:SetPoint("LEFT", statusTex, "RIGHT", 4, 0)
  nameText:SetText(addonInfo.name)

  -- Priority label (right-aligned)
  local priorityLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
  priorityLabel:SetPoint("RIGHT", -8, 0)
  priorityLabel:SetText(addonInfo.priority:upper())

  -- Tooltip text
  local descText = frame:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
  descText:SetPoint("TOPLEFT", nameText, "BOTTOMLEFT", 0, -2)
  descText:SetPoint("BOTTOMRIGHT", priorityLabel, "BOTTOMRIGHT", 0, 0)
  descText:SetWidth(350)
  descText:SetJustifyH("LEFT")
  descText:SetText(addonInfo.description or "")

  -- Check box (rightmost)
  local check = CreateFrame("CheckButton", nil, frame, "UICheckBoxTemplate")
  check:SetPoint("RIGHT", -8, 0)
  if addonInfo.installed then
    check:SetChecked(true)
    check:Enable()
    check:SetScript("OnClick", function()
      -- Toggle profile selection for this addon
    end)
  else
    check:SetChecked(false)
    check:Disable()
  end

  frame.strip = strip
  frame.statusTex = statusTex
  frame.nameText = nameText
  frame.priorityLabel = priorityLabel
  frame.descText = descText

  return frame
end
