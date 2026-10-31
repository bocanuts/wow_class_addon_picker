--[[
  ConfigScreen.lua — In-game addon: per-addon config panel.
]]

local _, CAP = ...

CAPConfig = {
  frame = nil,
  activeAddonKey = nil,
}

function CAPConfig:Create(parent)
  local frame = CreateFrame("Frame", nil, parent, "BackdropTemplate")
  frame:SetSize(464, 180)
  frame:SetPoint("BOTTOMLEFT", 16, 16)
  frame:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    edgeSize = 12,
    insets = { left = 4, right = 4, top = 4, bottom = 4 },
  })

  -- Title
  local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  title:SetPoint("TOPLEFT", 16, -8)
  title:SetText("Addon Settings")

  -- Addon name label
  self.addonNameLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
  self.addonNameLabel:SetPoint("TOPLEFT", 16, -30)

  -- Settings table (rows of key-value pairs)
  self.settingsFrame = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
  self.settingsFrame:SetPoint("TOPLEFT", 8, -50)
  self.settingsFrame:SetPoint("BOTTOMRIGHT", -16, 12)
  self.settingsFrame:SetScrollChild(CreateFrame("Frame", nil, self.settingsFrame))

  -- Apply button
  local applyBtn = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
  applyBtn:SetSize(120, 22)
  applyBtn:SetPoint("BOTTOMRIGHT", -8, 4)
  applyBtn:SetText("Apply Settings")
  applyBtn:SetScript("OnClick", function()
    self:ApplySettings()
  end)

  -- Restore defaults button
  local restoreBtn = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
  restoreBtn:SetSize(120, 22)
  restoreBtn:SetPoint("BOTTOMRIGHT", applyBtn, "BOTTOMLEFT", -8, 0)
  restoreBtn:SetText("Restore Defaults")
  restoreBtn:SetScript("OnClick", function()
    self:RestoreDefaults()
  end)

  CAPConfig.frame = frame
  return frame
end

function CAPConfig:Open(addonKey)
  local addonInfo = CAPAddonRegistry[addonKey]
  if not addonInfo then return end

  self.activeAddonKey = addonKey
  self.addonNameLabel:SetText(addonInfo.name)

  -- Clear previous settings rows
  local child = self.settingsFrame:GetScrollChild()
  for i = 1, child:GetNumChildren() do
    child:GetChild(i):Hide()
  end

  -- Create setting rows from defaultSettings
  if addonInfo.defaultSettings then
    local yOff = 0
    for key, value in pairs(addonInfo.defaultSettings) do
      local row = self:CreateSettingRow(key, value, addonKey)
      row:SetPoint("TOPLEFT", self.settingsFrame:GetScrollChild(), "TOPLEFT", 8, -yOff)
      yOff = yOff + 28
    end
  end

  CAPConfig.frame:Show()
end

function CAPConfig:CreateSettingRow(key, value, addonKey)
  local frame = CreateFrame("Frame", nil, self.settingsFrame:GetScrollChild())
  frame:SetSize(440, 24)

  -- Key label
  local keyLabel = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
  keyLabel:SetPoint("LEFT", 0, 0)
  keyLabel:SetText(key .. ":")

  -- Value display (text for strings/numbers, checkbox for booleans)
  local valueWidget
  if type(value) == "boolean" then
    local cb = CreateFrame("CheckButton", nil, frame, "UICheckBoxTemplate")
    cb:SetPoint("LEFT", keyLabel, "RIGHT", 8, 0)
    cb:SetChecked(value)
    valueWidget = cb
  else
    local valText = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    valText:SetPoint("LEFT", keyLabel, "RIGHT", 8, 0)
    valText:SetText(tostring(value))
    valueWidget = valText
  end

  return frame
end

function CAPConfig:ApplySettings()
  if not self.activeAddonKey then return end

  local ok, msg = CAP:ApplyAddonSettings(self.activeAddonKey)
  if ok then
    print("|cff4fc08f[CAP]|r Settings applied for " .. self.activeAddonKey)
  else
    print("|cffff4040[CAP]|r Failed to apply settings: " .. msg)
  end
end

function CAPConfig:RestoreDefaults()
  if not self.activeAddonKey then return end

  local addonInfo = CAPAddonRegistry[self.activeAddonKey]
  if not addonInfo or not addonInfo.defaultSettings then return end

  print("|cffff4040[CAP]|r " .. addonInfo.name .. " settings will be restored on next load.")
end
