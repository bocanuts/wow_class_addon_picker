--[[
  String localization table for Class Addon Picker.
]]

local _, CAP = ...
CAP.L = {
  -- Main window
  profileTitle = "Class Addon Picker",
  selectClass = "Select a Class",
  selectSpec = "Select a Spec",
  noProfile = "No active profile",
  applyProfile = "Apply Profile",
  saveProfile = "Save Profile",
  deleteProfile = "Delete Profile",
  exportProfile = "Export to JSON",
  importProfile = "Import from JSON",

  -- Addon status
  installed = "Installed",
  notInstalled = "Not Installed — check the link for installation",
  configApplied = "Config Applied",
  configFailed = "Config Failed — check saved variables name",

  -- Priority labels
  essential = "Essential",
  recommended = "Recommended",
  optional = "Optional",

  -- Profile management
  createProfile = "Create New Profile",
  profileName = "Profile Name",
  activeProfile = "Active: ",
  noProfilesFound = "No profiles saved yet.",

  -- Scan results
  scanning = "Scanning addons...",
  scanComplete = "Scan complete. Found %d of %d recommended addons installed.",
  allInstalled = "All recommended addons are installed!",

  -- Settings
  settingsTitle = "Addon Settings",
  restoreDefaults = "Restore Defaults",
  reloadUI = "Reload UI to apply changes.",
}
