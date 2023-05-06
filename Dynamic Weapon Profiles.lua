local AWF = require("AWF Core")

local new_profile_name = ""
local show_profile_editor = false

local scene_manager = sdk.get_native_singleton("via.SceneManager")
local scene = nil
local CS_Inventory = nil
local last_inventory_count = -1
local RED9_OwnerEquipment = nil
local RED9_Has_Stock = false
local TMP_OwnerEquipment = nil
local TMP_Has_Stock = false
local VP70_OwnerEquipment = nil
local VP70_Has_Stock = false

local Weapon_Vars = {
  Selected_Profile = "1",
  HNDC_DMG = false,
  No_Recoil = false,
  No_Spread = false,
  No_Ammo_Cost = false,
  Always_Focus = false,
  BM4_Slug = false,
  SKUL_Slug = false,
  M870_Slug = false,
  STKR_Slug = false,
  CTW_DMG = false,
  OG_WINCE = false,
  No_Reticles = false,
  Extra_Break = false,
  Headshots_Kill = false,
  CQBR_Smg = false,
  Kil7_HG = false,
  BRB_HG = false,
  HNDC_HG = false,
  Harpoon_DMG = false,
  Weapon_Profiles = {
    ["1"] = "None",
    ["2"] = "Better Weapon Balance"
  }
}

Weapon_Vars = json.load_file("DWP\\Saved.json") or {
  Selected_Profile = "1",
  Weapon_Profiles = {
    ["1"] = "None",
    ["2"] = "Better Weapon Balance"
  }
}

local Selected_Weapon = "1"
local Available_Weapons = {
  ["1"] = "SG-09R",
  ["2"] = "Punisher",
  ["3"] = "Red 9",
  ["4"] = "Blacktail",
  ["5"] = "Matilda",
  ["6"] = "Sentinel 9",
  ["7"] = "W-870",
  ["8"] = "Riot Gun",
  ["9"] = "Striker",
  ["10"] = "Skull Shaker",
  ["11"] = "TMP",
  ["12"] = "Chicago Sweeper",
  ["13"] = "LE5",
  ["14"] = "SR M1903",
  ["15"] = "Stingray",
  ["16"] = "CQBR",
  ["17"] = "Broken Butterfly",
  ["18"] = "Killer 7",
  ["19"] = "Handcannon"

}

local function SetAWFWeapon_DMGValues()
  -- load weapon profile from json files
  local path = Weapon_Vars.Weapon_Profiles[Weapon_Vars.Selected_Profile]

  local tempSG09R = json.load_file("DWP\\" .. path .. "\\SG09R.json") or {}
  local tempPUN = json.load_file("DWP\\" .. path .. "\\PUN.json") or {}
  local tempRED9 = json.load_file("DWP\\" .. path .. "\\RED9.json") or {}
  local tempBT = json.load_file("DWP\\" .. path .. "\\BT.json") or {}
  local tempVP70 = json.load_file("DWP\\" .. path .. "\\VP70.json") or {}
  local tempSEN9 = json.load_file("DWP\\" .. path .. "\\SEN9.json") or {}
  local tempM870 = json.load_file("DWP\\" .. path .. "\\M870.json") or {}
  local tempBM4 = json.load_file("DWP\\" .. path .. "\\BM4.json") or {}
  local tempSTKR = json.load_file("DWP\\" .. path .. "\\STKR.json") or {}
  local tempSKUL = json.load_file("DWP\\" .. path .. "\\SKUL.json") or {}
  local tempTMP = json.load_file("DWP\\" .. path .. "\\TMP.json") or {}
  local tempCTW = json.load_file("DWP\\" .. path .. "\\CTW.json") or {}
  local tempLE5 = json.load_file("DWP\\" .. path .. "\\LE5.json") or {}
  local tempM1G = json.load_file("DWP\\" .. path .. "\\M1G.json") or {}
  local tempSAR = json.load_file("DWP\\" .. path .. "\\SAR.json") or {}
  local tempCQBR = json.load_file("DWP\\" .. path .. "\\CQBR.json") or {}
  local tempBRB = json.load_file("DWP\\" .. path .. "\\BRB.json") or {}
  local tempKIL7 = json.load_file("DWP\\" .. path .. "\\KIL7.json") or {}
  local tempHNDC = json.load_file("DWP\\" .. path .. "\\HNDC.json") or {}

  for k, v in pairs(tempSG09R) do
    AWF.WeaponData.SG09R[k] = v
  end

  for k, v in pairs(tempPUN) do
    AWF.WeaponData.PUN[k] = v
  end

  for k, v in pairs(tempRED9) do
    AWF.WeaponData.RED9[k] = v
  end

  for k, v in pairs(tempBT) do
    AWF.WeaponData.BT[k] = v
  end

  for k, v in pairs(tempVP70) do
    AWF.WeaponData.VP70[k] = v
  end

  for k, v in pairs(tempSEN9) do
    AWF.WeaponData.SEN9[k] = v
  end

  for k, v in pairs(tempM870) do
    AWF.WeaponData.M870[k] = v
  end

  for k, v in pairs(tempBM4) do
    AWF.WeaponData.BM4[k] = v
  end

  for k, v in pairs(tempSTKR) do
    AWF.WeaponData.STKR[k] = v
  end

  for k, v in pairs(tempSKUL) do
    AWF.WeaponData.SKUL[k] = v
  end

  for k, v in pairs(tempTMP) do
    AWF.WeaponData.TMP[k] = v
  end

  for k, v in pairs(tempCTW) do
    AWF.WeaponData.CTW[k] = v
  end

  for k, v in pairs(tempLE5) do
    AWF.WeaponData.LE5[k] = v
  end

  for k, v in pairs(tempM1G) do
    AWF.WeaponData.M1G[k] = v
  end

  for k, v in pairs(tempSAR) do
    AWF.WeaponData.SAR[k] = v
  end

  for k, v in pairs(tempCQBR) do
    AWF.WeaponData.CQBR[k] = v
  end

  for k, v in pairs(tempBRB) do
    AWF.WeaponData.BRB[k] = v
  end

  for k, v in pairs(tempKIL7) do
    AWF.WeaponData.KIL7[k] = v
  end

  for k, v in pairs(tempHNDC) do
    AWF.WeaponData.HNDC[k] = v
  end

  -- apply additional custom settings

  -----/// Main Tree ///-----
  if Weapon_Vars.No_Recoil then
    AWF.WeaponData.SG09R.Recoil_YawMin = 0.0
    AWF.WeaponData.SG09R.Recoil_YawMax = 0.0
    AWF.WeaponData.SG09R.Recoil_PitchMin = 0.0
    AWF.WeaponData.SG09R.Recoil_PitchMax = 0.0
    AWF.WeaponData.PUN.Recoil_YawMin = 0
    AWF.WeaponData.PUN.Recoil_YawMax = 0
    AWF.WeaponData.PUN.Recoil_PitchMin = 0
    AWF.WeaponData.PUN.Recoil_PitchMax = 0
    AWF.WeaponData.RED9.Recoil_YawMin = 0
    AWF.WeaponData.RED9.Recoil_YawMax = 0
    AWF.WeaponData.RED9.Recoil_PitchMin = 0
    AWF.WeaponData.RED9.Recoil_PitchMax = 0
    AWF.WeaponData.BT.Recoil_YawMin = 0
    AWF.WeaponData.BT.Recoil_YawMax = 0
    AWF.WeaponData.BT.Recoil_PitchMin = 0
    AWF.WeaponData.BT.Recoil_PitchMax = 0
    AWF.WeaponData.VP70.Recoil_YawMin = 0
    AWF.WeaponData.VP70.Recoil_YawMax = 0
    AWF.WeaponData.VP70.Recoil_PitchMin = 0
    AWF.WeaponData.VP70.Recoil_PitchMax = 0
    AWF.WeaponData.SEN9.Recoil_YawMin = 0
    AWF.WeaponData.SEN9.Recoil_YawMax = 0
    AWF.WeaponData.SEN9.Recoil_PitchMin = 0
    AWF.WeaponData.SEN9.Recoil_PitchMax = 0
    AWF.WeaponData.M870.Recoil_YawMin = 0
    AWF.WeaponData.M870.Recoil_YawMax = 0
    AWF.WeaponData.M870.Recoil_PitchMin = 0
    AWF.WeaponData.M870.Recoil_PitchMax = 0
    AWF.WeaponData.BM4.Recoil_YawMin = 0
    AWF.WeaponData.BM4.Recoil_YawMax = 0
    AWF.WeaponData.BM4.Recoil_PitchMin = 0
    AWF.WeaponData.BM4.Recoil_PitchMax = 0
    AWF.WeaponData.STKR.Recoil_YawMin = 0
    AWF.WeaponData.STKR.Recoil_YawMax = 0
    AWF.WeaponData.STKR.Recoil_PitchMin = 0
    AWF.WeaponData.STKR.Recoil_PitchMax = 0
    AWF.WeaponData.SKUL.Recoil_YawMin = 0
    AWF.WeaponData.SKUL.Recoil_YawMax = 0
    AWF.WeaponData.SKUL.Recoil_PitchMin = 0
    AWF.WeaponData.SKUL.Recoil_PitchMax = 0
    AWF.WeaponData.TMP.Recoil_YawMin = 0
    AWF.WeaponData.TMP.Recoil_YawMax = 0
    AWF.WeaponData.TMP.Recoil_PitchMin = 0
    AWF.WeaponData.TMP.Recoil_PitchMax = 0
    AWF.WeaponData.CTW.Recoil_YawMin = 0
    AWF.WeaponData.CTW.Recoil_YawMax = 0
    AWF.WeaponData.CTW.Recoil_PitchMin = 0
    AWF.WeaponData.CTW.Recoil_PitchMax = 0
    AWF.WeaponData.LE5.Recoil_YawMin = 0
    AWF.WeaponData.LE5.Recoil_YawMax = 0
    AWF.WeaponData.LE5.Recoil_PitchMin = 0
    AWF.WeaponData.LE5.Recoil_PitchMax = 0
    AWF.WeaponData.M1G.Recoil_YawMin = 0
    AWF.WeaponData.M1G.Recoil_YawMax = 0
    AWF.WeaponData.M1G.Recoil_PitchMin = 0
    AWF.WeaponData.M1G.Recoil_PitchMax = 0
    AWF.WeaponData.SAR.Recoil_YawMin = 0
    AWF.WeaponData.SAR.Recoil_YawMax = 0
    AWF.WeaponData.SAR.Recoil_PitchMin = 0
    AWF.WeaponData.SAR.Recoil_PitchMax = 0
    AWF.WeaponData.CQBR.Recoil_YawMin = 0
    AWF.WeaponData.CQBR.Recoil_YawMax = 0
    AWF.WeaponData.CQBR.Recoil_PitchMin = 0
    AWF.WeaponData.CQBR.Recoil_PitchMax = 0
    AWF.WeaponData.BRB.Recoil_YawMin = 0
    AWF.WeaponData.BRB.Recoil_YawMax = 0
    AWF.WeaponData.BRB.Recoil_PitchMin = 0
    AWF.WeaponData.BRB.Recoil_PitchMax = 0
    AWF.WeaponData.KIL7.Recoil_YawMin = 0
    AWF.WeaponData.KIL7.Recoil_YawMax = 0
    AWF.WeaponData.KIL7.Recoil_PitchMin = 0
    AWF.WeaponData.KIL7.Recoil_PitchMax = 0
    AWF.WeaponData.HNDC.Recoil_YawMin = 0
    AWF.WeaponData.HNDC.Recoil_YawMax = 0
    AWF.WeaponData.HNDC.Recoil_PitchMin = 0
    AWF.WeaponData.HNDC.Recoil_PitchMax = 0
  end

  if Weapon_Vars.No_Spread then
    AWF.WeaponData.SG09R.SMG_Random = 0.0
    AWF.WeaponData.SG09R.SMG_RandomFit = 0.0
    AWF.WeaponData.PUN.SMG_Random = 0.0
    AWF.WeaponData.PUN.SMG_RandomFit = 0.0
    AWF.WeaponData.RED9.SMG_Random = 0.0
    AWF.WeaponData.RED9.SMG_RandomFit = 0.0
    AWF.WeaponData.BT.SMG_Random = 0.0
    AWF.WeaponData.BT.SMG_RandomFit = 0.0
    AWF.WeaponData.VP70.SMG_Random = 0.0
    AWF.WeaponData.VP70.SMG_RandomFit = 0.0
    AWF.WeaponData.SEN9.SMG_Random = 0.0
    AWF.WeaponData.SEN9.SMG_RandomFit = 0.0
    AWF.WeaponData.TMP.SMG_Random = 0.0
    AWF.WeaponData.TMP.SMG_RandomFit = 0.0
    AWF.WeaponData.CTW.SMG_Random = 0.0
    AWF.WeaponData.CTW.SMG_RandomFit = 0.0
    AWF.WeaponData.LE5.SMG_Random = 0.0
    AWF.WeaponData.LE5.SMG_RandomFit = 0.0
    AWF.WeaponData.M1G.SMG_Random = 0.0
    AWF.WeaponData.M1G.SMG_RandomFit = 0.0
    AWF.WeaponData.SAR.SMG_Random = 0.0
    AWF.WeaponData.SAR.SMG_RandomFit = 0.0
    AWF.WeaponData.CQBR.SMG_Random = 0.0
    AWF.WeaponData.CQBR.SMG_RandomFit = 0.0
    AWF.WeaponData.BRB.SMG_Random = 0.0
    AWF.WeaponData.BRB.SMG_RandomFit = 0.0
    AWF.WeaponData.KIL7.SMG_Random = 0.0
    AWF.WeaponData.KIL7.SMG_RandomFit = 0.0
    AWF.WeaponData.HNDC.SMG_Random = 0.0
    AWF.WeaponData.HNDC.SMG_RandomFit = 0.0
  end

  if Weapon_Vars.Always_Focus then
    AWF.WeaponData.SG09R.Focus_Limit = 0.0
    AWF.WeaponData.SG09R.Focus_HoldAdd = 1000
    AWF.WeaponData.PUN.Focus_Limit = 0.0
    AWF.WeaponData.PUN.Focus_HoldAdd = 1000
    AWF.WeaponData.RED9.Focus_Limit = 0.0
    AWF.WeaponData.RED9.Focus_HoldAdd = 1000
    AWF.WeaponData.BT.Focus_Limit = 0.0
    AWF.WeaponData.BT.Focus_HoldAdd = 1000
    AWF.WeaponData.VP70.Focus_Limit = 0.0
    AWF.WeaponData.VP70.Focus_HoldAdd = 1000
    AWF.WeaponData.SEN9.Focus_Limit = 0.0
    AWF.WeaponData.SEN9.Focus_HoldAdd = 1000
    AWF.WeaponData.TMP.Focus_Limit = 0.0
    AWF.WeaponData.TMP.Focus_HoldAdd = 1000
    AWF.WeaponData.CTW.Focus_Limit = 0.0
    AWF.WeaponData.CTW.Focus_HoldAdd = 1000
    AWF.WeaponData.LE5.Focus_Limit = 0.0
    AWF.WeaponData.LE5.Focus_HoldAdd = 1000
    AWF.WeaponData.M1G.Focus_Limit = 0.0
    AWF.WeaponData.M1G.Focus_HoldAdd = 1000
    AWF.WeaponData.SAR.Focus_Limit = 0.0
    AWF.WeaponData.SAR.Focus_HoldAdd = 1000
    AWF.WeaponData.CQBR.Focus_Limit = 0.0
    AWF.WeaponData.CQBR.Focus_HoldAdd = 1000
    AWF.WeaponData.BRB.Focus_Limit = 0.0
    AWF.WeaponData.BRB.Focus_HoldAdd = 1000
    AWF.WeaponData.KIL7.Focus_Limit = 0.0
    AWF.WeaponData.KIL7.Focus_HoldAdd = 1000
    AWF.WeaponData.HNDC.Focus_Limit = 0.0
    AWF.WeaponData.HNDC.Focus_HoldAdd = 1000
  end

  if Weapon_Vars.No_Ammo_Cost then
    AWF.WeaponData.SG09R.BaseAmmoCost = 0
    AWF.WeaponData.PUN.BaseAmmoCost = 0
    AWF.WeaponData.RED9.BaseAmmoCost = 0
    AWF.WeaponData.BT.BaseAmmoCost = 0
    AWF.WeaponData.VP70.BaseAmmoCost = 0
    AWF.WeaponData.SEN9.BaseAmmoCost = 0
    AWF.WeaponData.M870.BaseAmmoCost = 0
    AWF.WeaponData.BM4.BaseAmmoCost = 0
    AWF.WeaponData.STKR.BaseAmmoCost = 0
    AWF.WeaponData.SKUL.BaseAmmoCost = 0
    AWF.WeaponData.TMP.BaseAmmoCost = 0
    AWF.WeaponData.CTW.BaseAmmoCost = 0
    AWF.WeaponData.LE5.BaseAmmoCost = 0
    AWF.WeaponData.M1G.BaseAmmoCost = 0
    AWF.WeaponData.SAR.BaseAmmoCost = 0
    AWF.WeaponData.CQBR.BaseAmmoCost = 0
    AWF.WeaponData.BRB.BaseAmmoCost = 0
    AWF.WeaponData.KIL7.BaseAmmoCost = 0
    AWF.WeaponData.HNDC.BaseAmmoCost = 0
  end

  if Weapon_Vars.Extra_Break then
    AWF.WeaponData.SG09R.HG_BaseBRK = 10
    AWF.WeaponData.SG09R.BRK_LVL_02 = 10
    AWF.WeaponData.SG09R.BRK_LVL_03 = 10
    AWF.WeaponData.SG09R.BRK_LVL_04 = 10
    AWF.WeaponData.SG09R.BRK_LVL_05 = 10
    AWF.WeaponData.PUN.HG_BaseBRK = 10
    AWF.WeaponData.PUN.BRK_LVL_02 = 10
    AWF.WeaponData.PUN.BRK_LVL_03 = 10
    AWF.WeaponData.PUN.BRK_LVL_04 = 10
    AWF.WeaponData.PUN.BRK_LVL_05 = 10
    AWF.WeaponData.RED9.HG_BaseBRK = 10
    AWF.WeaponData.RED9.BRK_LVL_02 = 10
    AWF.WeaponData.RED9.BRK_LVL_03 = 10
    AWF.WeaponData.RED9.BRK_LVL_04 = 10
    AWF.WeaponData.RED9.BRK_LVL_05 = 10
    AWF.WeaponData.BT.HG_BaseBRK = 10
    AWF.WeaponData.BT.BRK_LVL_02 = 10
    AWF.WeaponData.BT.BRK_LVL_03 = 10
    AWF.WeaponData.BT.BRK_LVL_04 = 10
    AWF.WeaponData.BT.BRK_LVL_05 = 10
    AWF.WeaponData.VP70.HG_BaseBRK = 10
    AWF.WeaponData.VP70.BRK_LVL_02 = 10
    AWF.WeaponData.VP70.BRK_LVL_03 = 10
    AWF.WeaponData.VP70.BRK_LVL_04 = 10
    AWF.WeaponData.VP70.BRK_LVL_05 = 10
    AWF.WeaponData.SEN9.HG_BaseBRK = 10
    AWF.WeaponData.SEN9.BRK_LVL_02 = 10
    AWF.WeaponData.SEN9.BRK_LVL_03 = 10
    AWF.WeaponData.SEN9.BRK_LVL_04 = 10
    AWF.WeaponData.SEN9.BRK_LVL_05 = 10
    AWF.WeaponData.M870.HG_BaseBRK = 10
    AWF.WeaponData.M870.BRK_LVL_02 = 10
    AWF.WeaponData.M870.BRK_LVL_03 = 10
    AWF.WeaponData.M870.BRK_LVL_04 = 10
    AWF.WeaponData.M870.BRK_LVL_05 = 10
    AWF.WeaponData.BM4.HG_BaseBRK = 10
    AWF.WeaponData.BM4.BRK_LVL_02 = 10
    AWF.WeaponData.BM4.BRK_LVL_03 = 10
    AWF.WeaponData.BM4.BRK_LVL_04 = 10
    AWF.WeaponData.BM4.BRK_LVL_05 = 10
    AWF.WeaponData.STKR.HG_BaseBRK = 10
    AWF.WeaponData.STKR.BRK_LVL_02 = 10
    AWF.WeaponData.STKR.BRK_LVL_03 = 10
    AWF.WeaponData.STKR.BRK_LVL_04 = 10
    AWF.WeaponData.STKR.BRK_LVL_05 = 10
    AWF.WeaponData.SKUL.HG_BaseBRK = 10
    AWF.WeaponData.SKUL.BRK_LVL_02 = 10
    AWF.WeaponData.SKUL.BRK_LVL_03 = 10
    AWF.WeaponData.SKUL.BRK_LVL_04 = 10
    AWF.WeaponData.SKUL.BRK_LVL_05 = 10
    AWF.WeaponData.TMP.HG_BaseBRK = 10
    AWF.WeaponData.TMP.BRK_LVL_02 = 10
    AWF.WeaponData.TMP.BRK_LVL_03 = 10
    AWF.WeaponData.TMP.BRK_LVL_04 = 10
    AWF.WeaponData.TMP.BRK_LVL_05 = 10
    AWF.WeaponData.CTW.HG_BaseBRK = 10
    AWF.WeaponData.CTW.BRK_LVL_02 = 10
    AWF.WeaponData.CTW.BRK_LVL_03 = 10
    AWF.WeaponData.CTW.BRK_LVL_04 = 10
    AWF.WeaponData.CTW.BRK_LVL_05 = 10
    AWF.WeaponData.LE5.HG_BaseBRK = 10
    AWF.WeaponData.LE5.BRK_LVL_02 = 10
    AWF.WeaponData.LE5.BRK_LVL_03 = 10
    AWF.WeaponData.LE5.BRK_LVL_04 = 10
    AWF.WeaponData.LE5.BRK_LVL_05 = 10
    AWF.WeaponData.M1G.HG_BaseBRK = 10
    AWF.WeaponData.M1G.BRK_LVL_02 = 10
    AWF.WeaponData.M1G.BRK_LVL_03 = 10
    AWF.WeaponData.M1G.BRK_LVL_04 = 10
    AWF.WeaponData.M1G.BRK_LVL_05 = 10
    AWF.WeaponData.SAR.HG_BaseBRK = 10
    AWF.WeaponData.SAR.BRK_LVL_02 = 10
    AWF.WeaponData.SAR.BRK_LVL_03 = 10
    AWF.WeaponData.SAR.BRK_LVL_04 = 10
    AWF.WeaponData.SAR.BRK_LVL_05 = 10
    AWF.WeaponData.CQBR.HG_BaseBRK = 10
    AWF.WeaponData.CQBR.BRK_LVL_02 = 10
    AWF.WeaponData.CQBR.BRK_LVL_03 = 10
    AWF.WeaponData.CQBR.BRK_LVL_04 = 10
    AWF.WeaponData.CQBR.BRK_LVL_05 = 10
    AWF.WeaponData.BRB.HG_BaseBRK = 10
    AWF.WeaponData.BRB.BRK_LVL_02 = 10
    AWF.WeaponData.BRB.BRK_LVL_03 = 10
    AWF.WeaponData.BRB.BRK_LVL_04 = 10
    AWF.WeaponData.BRB.BRK_LVL_05 = 10
    AWF.WeaponData.KIL7.HG_BaseBRK = 10
    AWF.WeaponData.KIL7.BRK_LVL_02 = 10
    AWF.WeaponData.KIL7.BRK_LVL_03 = 10
    AWF.WeaponData.KIL7.BRK_LVL_04 = 10
    AWF.WeaponData.KIL7.BRK_LVL_05 = 10
    AWF.WeaponData.HNDC.HG_BaseBRK = 10
    AWF.WeaponData.HNDC.BRK_LVL_02 = 10
    AWF.WeaponData.HNDC.BRK_LVL_03 = 10
    AWF.WeaponData.HNDC.BRK_LVL_04 = 10
    AWF.WeaponData.HNDC.BRK_LVL_05 = 10
  end

  if Weapon_Vars.Headshots_Kill then
    AWF.WeaponData.SG09R.HG_CritRate = 100
    AWF.WeaponData.SG09R.HG_CritRateEX = 100
    AWF.WeaponData.PUN.HG_CritRate = 100
    AWF.WeaponData.PUN.HG_CritRateEX = 100
    AWF.WeaponData.RED9.HG_CritRate = 100
    AWF.WeaponData.RED9.HG_CritRateEX = 100
    AWF.WeaponData.BT.HG_CritRate = 100
    AWF.WeaponData.BT.HG_CritRateEX = 100
    AWF.WeaponData.VP70.HG_CritRate = 100
    AWF.WeaponData.VP70.HG_CritRateEX = 100
    AWF.WeaponData.SEN9.HG_CritRate = 100
    AWF.WeaponData.SEN9.HG_CritRateEX = 100
    AWF.WeaponData.M870.SG_Center_CritRate = 100
    AWF.WeaponData.M870.SG_Center_CritRate_EX = 100
    AWF.WeaponData.M870.SG_Around_CritRate = 100
    AWF.WeaponData.M870.SG_Around_CritRate_EX = 100
    AWF.WeaponData.BM4.SG_Center_CritRate = 100
    AWF.WeaponData.BM4.SG_Center_CritRate_EX = 100
    AWF.WeaponData.BM4.SG_Around_CritRate = 100
    AWF.WeaponData.BM4.SG_Around_CritRate_EX = 100
    AWF.WeaponData.STKR.SG_Center_CritRate = 100
    AWF.WeaponData.STKR.SG_Center_CritRate_EX = 100
    AWF.WeaponData.STKR.SG_Around_CritRate = 100
    AWF.WeaponData.STKR.SG_Around_CritRate_EX = 100
    AWF.WeaponData.SKUL.SG_Center_CritRate = 100
    AWF.WeaponData.SKUL.SG_Center_CritRate_EX = 100
    AWF.WeaponData.SKUL.SG_Around_CritRate = 100
    AWF.WeaponData.SKUL.SG_Around_CritRate_EX = 100
    AWF.WeaponData.TMP.HG_CritRate = 100
    AWF.WeaponData.TMP.HG_CritRateEX = 100
    AWF.WeaponData.CTW.HG_CritRate = 100
    AWF.WeaponData.CTW.HG_CritRateEX = 100
    AWF.WeaponData.LE5.HG_CritRate = 100
    AWF.WeaponData.LE5.HG_CritRateEX = 100
    AWF.WeaponData.M1G.HG_CritRate = 100
    AWF.WeaponData.M1G.HG_CritRateEX = 100
    AWF.WeaponData.SAR.HG_CritRate = 100
    AWF.WeaponData.SAR.HG_CritRateEX = 100
    AWF.WeaponData.CQBR.HG_CritRate = 100
    AWF.WeaponData.CQBR.HG_CritRateEX = 100
    AWF.WeaponData.BRB.HG_CritRate = 100
    AWF.WeaponData.BRB.HG_CritRateEX = 100
    AWF.WeaponData.KIL7.HG_CritRate = 100
    AWF.WeaponData.KIL7.HG_CritRateEX = 100
    AWF.WeaponData.HNDC.HG_CritRate = 100
    AWF.WeaponData.HNDC.HG_CritRateEX = 100
  end

  ----/// SLUGS TREE ///-----
  if Weapon_Vars.BM4_Slug then
    AWF.WeaponData.BM4.ReticleType = 1
    AWF.WeaponData.BM4.SG_Center_Random = 0.003
    AWF.WeaponData.BM4.SG_Center_RandomFit = 0.003
    AWF.WeaponData.BM4.SG_AroundBulletCount = 0
    AWF.WeaponData.BM4.SG_CenterLife_Distance = 300
    AWF.WeaponData.BM4.SG_Center_BaseDMG = 1.25
    AWF.WeaponData.BM4.DMG_LVL_01_INFO = "8.00"
    AWF.WeaponData.BM4.DMG_LVL_02_INFO = "9.6"
    AWF.WeaponData.BM4.DMG_LVL_03_INFO = "11.2"
    AWF.WeaponData.BM4.DMG_LVL_04_INFO = "12.8"
    AWF.WeaponData.BM4.DMG_LVL_05_INFO = "14.4"
    AWF.WeaponData.BM4.DMG_LVL_02 = 1.5
    AWF.WeaponData.BM4.DMG_LVL_03 = 1.75
    AWF.WeaponData.BM4.DMG_LVL_04 = 2.0
    AWF.WeaponData.BM4.DMG_LVL_05 = 2.25
  end

  if Weapon_Vars.M870_Slug then
    AWF.WeaponData.M870.ReticleType = 1
    AWF.WeaponData.M870.SG_Center_Random = 0.003
    AWF.WeaponData.M870.SG_Center_RandomFit = 0.003
    AWF.WeaponData.M870.SG_AroundBulletCount = 0
    AWF.WeaponData.M870.SG_CenterLife_Distance = 300
    AWF.WeaponData.M870.SG_Center_BaseDMG = 1.25
    AWF.WeaponData.M870.DMG_LVL_01_INFO = "7.00"
    AWF.WeaponData.M870.DMG_LVL_02_INFO = "8.40"
    AWF.WeaponData.M870.DMG_LVL_03_INFO = "9.80"
    AWF.WeaponData.M870.DMG_LVL_04_INFO = "11.20"
    AWF.WeaponData.M870.DMG_LVL_05_INFO = "12.60"
    AWF.WeaponData.M870.DMG_LVL_02 = 1.5
    AWF.WeaponData.M870.DMG_LVL_03 = 1.75
    AWF.WeaponData.M870.DMG_LVL_04 = 2.0
    AWF.WeaponData.M870.DMG_LVL_05 = 2.25
  end

  if Weapon_Vars.SKUL_Slug then
    AWF.WeaponData.SKUL.ReticleType = 1
    AWF.WeaponData.SKUL.SG_Center_Random = 0.003
    AWF.WeaponData.SKUL.SG_Center_RandomFit = 0.003
    AWF.WeaponData.SKUL.SG_AroundBulletCount = 0
    AWF.WeaponData.SKUL.SG_CenterLife_Distance = 300
    AWF.WeaponData.SKUL.SG_Center_BaseDMG = 1.25
    AWF.WeaponData.SKUL.DMG_LVL_01_INFO = "6.75"
    AWF.WeaponData.SKUL.DMG_LVL_02_INFO = "8.10"
    AWF.WeaponData.SKUL.DMG_LVL_03_INFO = "9.45"
    AWF.WeaponData.SKUL.DMG_LVL_04_INFO = "10.80"
    AWF.WeaponData.SKUL.DMG_LVL_05_INFO = "12.15"
    AWF.WeaponData.SKUL.DMG_LVL_02 = 1.5
    AWF.WeaponData.SKUL.DMG_LVL_03 = 1.75
    AWF.WeaponData.SKUL.DMG_LVL_04 = 2.0
    AWF.WeaponData.SKUL.DMG_LVL_05 = 2.25
  end

  if Weapon_Vars.STKR_Slug then
    AWF.WeaponData.STKR.ReticleType = 1
    AWF.WeaponData.STKR.SG_Center_Random = 0.003
    AWF.WeaponData.STKR.SG_Center_RandomFit = 0.003
    AWF.WeaponData.STKR.SG_AroundBulletCount = 0
    AWF.WeaponData.STKR.SG_CenterLife_Distance = 300
    AWF.WeaponData.STKR.SG_Center_BaseDMG = 1.25
    AWF.WeaponData.STKR.DMG_LVL_01_INFO = "11.25"
    AWF.WeaponData.STKR.DMG_LVL_02_INFO = "13.50"
    AWF.WeaponData.STKR.DMG_LVL_03_INFO = "15.75"
    AWF.WeaponData.STKR.DMG_LVL_04_INFO = "18.00"
    AWF.WeaponData.STKR.DMG_LVL_05_INFO = "20.25"
    AWF.WeaponData.STKR.DMG_LVL_02 = 1.5
    AWF.WeaponData.STKR.DMG_LVL_03 = 1.75
    AWF.WeaponData.STKR.DMG_LVL_04 = 2.0
    AWF.WeaponData.STKR.DMG_LVL_05 = 2.25
  end

  -----/// OG Options TREE ///-----
  if Weapon_Vars.HNDC_DMG then
    AWF.WeaponData.HNDC.HG_BaseDMG = 2.775
    AWF.WeaponData.HNDC.DMG_LVL_02 = 4.166667
    AWF.WeaponData.HNDC.DMG_LVL_03 = 5.55
    AWF.WeaponData.HNDC.DMG_LVL_04 = 6.9375
    AWF.WeaponData.HNDC.DMG_LVL_05 = 8.325
    AWF.WeaponData.HNDC.DMG_LVL_01_INFO = "33.3"
    AWF.WeaponData.HNDC.DMG_LVL_02_INFO = "50.0"
    AWF.WeaponData.HNDC.DMG_LVL_03_INFO = "66.6"
    AWF.WeaponData.HNDC.DMG_LVL_04_INFO = "83.25"
    AWF.WeaponData.HNDC.DMG_LVL_05_INFO = "99.9"
  end

  if Weapon_Vars.CTW_DMG then
    AWF.WeaponData.CTW.ReticleType = 203
    AWF.WeaponData.CTW.HG_Distance = 300.0
    AWF.WeaponData.CTW.SMG_Random = 0.01
    AWF.WeaponData.CTW.SMG_RandomFit = 0.005
    AWF.WeaponData.CTW.HG_BaseDMG = 5.0
    AWF.WeaponData.CTW.HG_BaseWINC = 2.0
    AWF.WeaponData.CTW.Recoil_YawMin = -0.2
    AWF.WeaponData.CTW.Recoil_YawMax = 0.4
    AWF.WeaponData.CTW.Recoil_PitchMin = -0.3
    AWF.WeaponData.CTW.Recoil_PitchMax = 0.8
    AWF.WeaponData.CTW.DMG_LVL_01_INFO = "2.00"
    AWF.WeaponData.CTW.DMG_LVL_02_INFO = "4.00"
    AWF.WeaponData.CTW.DMG_LVL_03_INFO = "6.00"
    AWF.WeaponData.CTW.DMG_LVL_04_INFO = "8.00"
    AWF.WeaponData.CTW.DMG_LVL_05_INFO = "10.0"
    AWF.WeaponData.CTW.DMG_LVL_02 = 10
    AWF.WeaponData.CTW.DMG_LVL_03 = 15
    AWF.WeaponData.CTW.DMG_LVL_04 = 20
    AWF.WeaponData.CTW.DMG_LVL_05 = 25
    AWF.WeaponData.CTW.Focus_HoldAdd = 360.0
    AWF.WeaponData.CTW.Focus_MoveSub = 370.0
    AWF.WeaponData.CTW.Focus_CamSub = 370.0
    AWF.WeaponData.CTW.HG_BulletGravityIgnore = 40
  end

  if Weapon_Vars.OG_WINCE then
    AWF.WeaponData.SG09R.HG_BaseWINC = 10.0
    AWF.WeaponData.PUN.HG_BaseWINC = 10.0
    AWF.WeaponData.RED9.HG_BaseWINC = 10.0
    AWF.WeaponData.BT.HG_BaseWINC = 10.0
    AWF.WeaponData.VP70.HG_BaseWINC = 10.0
    AWF.WeaponData.SEN9.HG_BaseWINC = 10.0
    AWF.WeaponData.M870.HG_BaseWINC = 10.0
    AWF.WeaponData.BM4.HG_BaseWINC = 10.0
    AWF.WeaponData.STKR.HG_BaseWINC = 10.0
    AWF.WeaponData.SKUL.HG_BaseWINC = 10.0
    AWF.WeaponData.TMP.HG_BaseWINC = 10.0
    AWF.WeaponData.CTW.HG_BaseWINC = 10.0
    AWF.WeaponData.LE5.HG_BaseWINC = 10.0
    AWF.WeaponData.M1G.HG_BaseWINC = 10.0
    AWF.WeaponData.SAR.HG_BaseWINC = 10.0
    AWF.WeaponData.CQBR.HG_BaseWINC = 10.0
    AWF.WeaponData.BRB.HG_BaseWINC = 10.0
    AWF.WeaponData.KIL7.HG_BaseWINC = 10.0
    AWF.WeaponData.HNDC.HG_BaseWINC = 10.0
  end

  -----/// MISC TREE ///-----
  if Weapon_Vars.No_Reticles then
    AWF.WeaponData.SG09R.ReticleType = 100000
    AWF.WeaponData.PUN.ReticleType = 100000
    AWF.WeaponData.RED9.ReticleType = 100000
    AWF.WeaponData.BT.ReticleType = 100000
    AWF.WeaponData.VP70.ReticleType = 100000
    AWF.WeaponData.SEN9.ReticleType = 100000
    AWF.WeaponData.M870.ReticleType = 100000
    AWF.WeaponData.BM4.ReticleType = 100000
    AWF.WeaponData.STKR.ReticleType = 100000
    AWF.WeaponData.SKUL.ReticleType = 100000
    AWF.WeaponData.TMP.ReticleType = 100000
    AWF.WeaponData.CTW.ReticleType = 100000
    AWF.WeaponData.LE5.ReticleType = 100000
    AWF.WeaponData.M1G.ReticleType = 100000
    AWF.WeaponData.SAR.ReticleType = 100000
    AWF.WeaponData.CQBR.ReticleType = 100000
    AWF.WeaponData.BRB.ReticleType = 100000
    AWF.WeaponData.KIL7.ReticleType = 100000
    AWF.WeaponData.HNDC.ReticleType = 100000
  end

  if Weapon_Vars.CQBR_Smg then
    AWF.WeaponData.CQBR.AmmoType = 112806400
  end

  if Weapon_Vars.Kil7_HG then
    AWF.WeaponData.KIL7.AmmoType = 112800000
  end

  if Weapon_Vars.BRB_HG then
    AWF.WeaponData.BRB.AmmoType = 112800000
  end

  if Weapon_Vars.HNDC_HG then
    AWF.WeaponData.HNDC.AmmoType = 112800000
  end
end

local function apply_changes()
  json.dump_file("DWP\\Saved.json", Weapon_Vars)

  SetAWFWeapon_DMGValues()

  AWF.WeaponData.SG09R.Changed = true
  AWF.WeaponData.PUN.Changed = true
  AWF.WeaponData.RED9.Changed = true
  AWF.WeaponData.BT.Changed = true
  AWF.WeaponData.VP70.Changed = true
  AWF.WeaponData.SEN9.Changed = true
  AWF.WeaponData.M870.Changed = true
  AWF.WeaponData.BM4.Changed = true
  AWF.WeaponData.STKR.Changed = true
  AWF.WeaponData.SKUL.Changed = true
  AWF.WeaponData.TMP.Changed = true
  AWF.WeaponData.CTW.Changed = true
  AWF.WeaponData.LE5.Changed = true
  AWF.WeaponData.M1G.Changed = true
  AWF.WeaponData.SAR.Changed = true
  AWF.WeaponData.CQBR.Changed = true
  AWF.WeaponData.BRB.Changed = true
  AWF.WeaponData.KIL7.Changed = true
  AWF.WeaponData.HNDC.Changed = true
end

local function draw_profile_editor_ui()
  imgui.set_next_window_size({550, 1000}, 8)
  local stayOpen = imgui.begin_window("Profile Editor", show_profile_editor, 0)
  if not stayOpen then
    show_profile_editor = false
  end

  imgui.text("Press Enter to apply changes for a live preview. \nSave Changes button saves changes to the selected profile.")

  imgui.new_line()

  selectedProfileChanged, Weapon_Vars.Selected_Profile = imgui.combo("Weapon Profile", Weapon_Vars.Selected_Profile, Weapon_Vars.Weapon_Profiles)
  changed, Selected_Weapon = imgui.combo("Weapon", Selected_Weapon, Available_Weapons)

  if selectedProfileChanged then
    apply_changes()
  end

  local currentWeapon = nil
  local currentAWFWeapon = nil

  if Selected_Weapon == "1" then
    currentWeapon = AWF.WeaponData.SG09R
    currentAWFWeapon = AWF.AWFWeapons.SG09R
  elseif Selected_Weapon == "2" then
    currentWeapon = AWF.WeaponData.PUN
    currentAWFWeapon = AWF.AWFWeapons.PUN
  elseif Selected_Weapon == "3" then
    currentWeapon = AWF.WeaponData.RED9
    currentAWFWeapon = AWF.AWFWeapons.RED9
  elseif Selected_Weapon == "4" then
    currentWeapon = AWF.WeaponData.BT
    currentAWFWeapon = AWF.AWFWeapons.BT
  elseif Selected_Weapon == "5" then
    currentWeapon = AWF.WeaponData.VP70
    currentAWFWeapon = AWF.AWFWeapons.VP70
  elseif Selected_Weapon == "6" then
    currentWeapon = AWF.WeaponData.SEN9
    currentAWFWeapon = AWF.AWFWeapons.SEN9
  elseif Selected_Weapon == "7" then
    currentWeapon = AWF.WeaponData.M870
    currentAWFWeapon = AWF.AWFWeapons.M870
  elseif Selected_Weapon == "8" then
    currentWeapon = AWF.WeaponData.BM4
    currentAWFWeapon = AWF.AWFWeapons.BM4
  elseif Selected_Weapon == "9" then
    currentWeapon = AWF.WeaponData.STKR
    currentAWFWeapon = AWF.AWFWeapons.STKR
  elseif Selected_Weapon == "10" then
    currentWeapon = AWF.WeaponData.SKUL
    currentAWFWeapon = AWF.AWFWeapons.SKUL
  elseif Selected_Weapon == "11" then
    currentWeapon = AWF.WeaponData.TMP
    currentAWFWeapon = AWF.AWFWeapons.TMP
  elseif Selected_Weapon == "12" then
    currentWeapon = AWF.WeaponData.CTW
    currentAWFWeapon = AWF.AWFWeapons.CTW
  elseif Selected_Weapon == "13" then
    currentWeapon = AWF.WeaponData.LE5
    currentAWFWeapon = AWF.AWFWeapons.LE5
  elseif Selected_Weapon == "14" then
    currentWeapon = AWF.WeaponData.M1G
    currentAWFWeapon = AWF.AWFWeapons.M1G
  elseif Selected_Weapon == "15" then
    currentWeapon = AWF.WeaponData.SAR
    currentAWFWeapon = AWF.AWFWeapons.SAR
  elseif Selected_Weapon == "16" then
    currentWeapon = AWF.WeaponData.CQBR
    currentAWFWeapon = AWF.AWFWeapons.CQBR
  elseif Selected_Weapon == "17" then
    currentWeapon = AWF.WeaponData.BRB
    currentAWFWeapon = AWF.AWFWeapons.BRB
  elseif Selected_Weapon == "18" then
    currentWeapon = AWF.WeaponData.KIL7
    currentAWFWeapon = AWF.AWFWeapons.KIL7
  elseif Selected_Weapon == "19" then
    currentWeapon = AWF.WeaponData.HNDC
    currentAWFWeapon = AWF.AWFWeapons.HNDC
  end

  imgui.new_line()

  if imgui.tree_node("General") then
    -- ItemSize
    ItemSizeChanged, updatedItemSize = imgui.input_text("ItemSize", currentWeapon.ItemSize, 33)
    if ItemSizeChanged then
      currentWeapon.ItemSize = tonumber(updatedItemSize)
      currentWeapon.Changed = true
    end

    -- AmmoType
    AmmoTypeChanged, updatedAmmoType = imgui.input_text("Ammo Type", currentWeapon.AmmoType, 33)
    if AmmoTypeChanged then
      currentWeapon.AmmoType = tonumber(updatedAmmoType)
      currentWeapon.Changed = true
    end

    -- ReticleType
    ReticleTypeChanged, updatedReticleType = imgui.input_text("Reticle Type", currentWeapon.ReticleType, 33)
    if ReticleTypeChanged then
      currentWeapon.ReticleType = tonumber(updatedReticleType)
      currentWeapon.Changed = true
    end
    imgui.tree_pop()
  end

  if (currentAWFWeapon.WPtype == "HG") or (currentAWFWeapon.WPtype == "SMG") or (currentAWFWeapon.WPtype == "SR") or (currentAWFWeapon.WPtype == "SR_PUMP") or
    (currentAWFWeapon.WPtype == "MAG") or (currentAWFWeapon.WPtype == "MAG_SEMI") then
    if imgui.tree_node("HG General") then
      -- HG_Distance 
      HG_DistanceChanged, updatedHG_Distance = imgui.input_text("HG Distance", currentWeapon.HG_Distance, 33)
      if HG_DistanceChanged then
        currentWeapon.HG_Distance = tonumber(updatedHG_Distance)
        currentWeapon.Changed = true
      end

      imgui.new_line()

      -- SMG_Random
      SMG_RandomChanged, updatedSMG_Random = imgui.input_text("SMG Random", currentWeapon.SMG_Random, 33)
      if SMG_RandomChanged then
        currentWeapon.SMG_Random = tonumber(updatedSMG_Random)
        currentWeapon.Changed = true
      end

      -- SMG_RandomFit
      SMG_RandomFitChanged, updatedSMG_RandomFit = imgui.input_text("SMG Random Fit", currentWeapon.SMG_RandomFit, 33)
      if SMG_RandomFitChanged then
        currentWeapon.SMG_RandomFit = tonumber(updatedSMG_RandomFit)
        currentWeapon.Changed = true
      end

      imgui.new_line()

      -- HG_CritRate
      HG_CritRateChanged, updatedHG_CritRate = imgui.input_text("HG Crit Rate", currentWeapon.HG_CritRate, 33)
      if HG_CritRateChanged then
        currentWeapon.HG_CritRate = tonumber(updatedHG_CritRate)
        currentWeapon.Changed = true
      end

      -- HG_CritRateEX
      HG_CritRateEXChanged, updatedHG_CritRateEX = imgui.input_text("HG Crit Rate EX", currentWeapon.HG_CritRateEX, 33)
      if HG_CritRateEXChanged then
        currentWeapon.HG_CritRateEX = tonumber(updatedHG_CritRateEX)
        currentWeapon.Changed = true
      end
      imgui.tree_pop()
    end

    if imgui.tree_node("Focus") then
      -- Focus_HoldAdd
      Focus_HoldAddChanged, updatedFocus_HoldAdd = imgui.input_text("Focus Hold Add", currentWeapon.Focus_HoldAdd, 33)
      if Focus_HoldAddChanged then
        currentWeapon.Focus_HoldAdd = tonumber(updatedFocus_HoldAdd)
        currentWeapon.Changed = true
      end

      -- Focus_MoveSub
      Focus_MoveSubChanged, updatedFocus_MoveSub = imgui.input_text("Focus Move Sub", currentWeapon.Focus_MoveSub, 33)
      if Focus_MoveSubChanged then
        currentWeapon.Focus_MoveSub = tonumber(updatedFocus_MoveSub)
        currentWeapon.Changed = true
      end

      -- Focus_CamSub
      Focus_CamSubChanged, updatedFocus_CamSub = imgui.input_text("Focus Cam Sub", currentWeapon.Focus_CamSub, 33)
      if Focus_CamSubChanged then
        currentWeapon.Focus_CamSub = tonumber(updatedFocus_CamSub)
        currentWeapon.Changed = true
      end

      -- Focus_Limit
      Focus_LimitChanged, updatedFocus_Limit = imgui.input_text("Focus Limit", currentWeapon.Focus_Limit, 33)
      if Focus_LimitChanged then
        currentWeapon.Focus_Limit = tonumber(updatedFocus_Limit)
        currentWeapon.Changed = true
      end
      -- Focus_ShootSub
      Focus_ShootSubChanged, updatedFocus_ShootSub = imgui.input_text("Focus Shoot Sub", currentWeapon.Focus_ShootSub, 33)
      if Focus_ShootSubChanged then
        currentWeapon.Focus_ShootSub = tonumber(updatedFocus_ShootSub)
        currentWeapon.Changed = true
      end
      imgui.tree_pop()
    end

    if imgui.tree_node("Recoil") then
      -- Recoil_YawMin
      Recoil_YawMinChanged, updatedRecoil_YawMin = imgui.input_text("Recoil Yaw Min", currentWeapon.Recoil_YawMin, 33)
      if Recoil_YawMinChanged then
        currentWeapon.Recoil_YawMin = tonumber(updatedRecoil_YawMin)
        currentWeapon.Changed = true
      end

      -- Recoil_YawMax
      Recoil_YawMaxChanged, updatedRecoil_YawMax = imgui.input_text("Recoil Yaw Max", currentWeapon.Recoil_YawMax, 33)
      if Recoil_YawMaxChanged then
        currentWeapon.Recoil_YawMax = tonumber(updatedRecoil_YawMax)
        currentWeapon.Changed = true
      end

      -- Recoil_PitchMin
      Recoil_PitchMinChanged, updatedRecoil_PitchMin = imgui.input_text("Recoil Pitch Min", currentWeapon.Recoil_PitchMin, 33)
      if Recoil_PitchMinChanged then
        currentWeapon.Recoil_PitchMin = tonumber(updatedRecoil_PitchMin)
        currentWeapon.Changed = true
      end

      -- Recoil_PitchMax
      Recoil_PitchMaxChanged, updatedRecoil_PitchMax = imgui.input_text("Recoil Pitch Max", currentWeapon.Recoil_PitchMax, 33)
      if Recoil_PitchMaxChanged then
        currentWeapon.Recoil_PitchMax = tonumber(updatedRecoil_PitchMax)
        currentWeapon.Changed = true
      end
      imgui.tree_pop()
    end
  end

  if (currentAWFWeapon.WPtype == "SG") or (currentAWFWeapon.WPtype == "SG_PUMP") then
    if imgui.tree_node("Center Pellet Settings") then
      -- SG_CenterLife_Distance
      SG_CenterLife_DistanceChanged, updatedSG_CenterLife_Distance = imgui.input_text("SG Center Life Distance", currentWeapon.SG_CenterLife_Distance, 33)
      if SG_CenterLife_DistanceChanged then
        currentWeapon.SG_CenterLife_Distance = tonumber(updatedSG_CenterLife_Distance)
        currentWeapon.Changed = true
      end

      -- SG_CenterMove_Speed
      SG_CenterMove_SpeedChanged, updatedSG_CenterMove_Speed = imgui.input_text("SG Center Move Speed", currentWeapon.SG_CenterMove_Speed, 33)
      if SG_CenterMove_SpeedChanged then
        currentWeapon.SG_CenterMove_Speed = tonumber(updatedSG_CenterMove_Speed)
        currentWeapon.Changed = true
      end

      -- SG_CenterMove_IGD
      SG_CenterMove_IGDChanged, updatedSG_CenterMove_IGD = imgui.input_text("SG Center Move IGD", currentWeapon.SG_CenterMove_IGD, 33)
      if SG_CenterMove_IGDChanged then
        currentWeapon.SG_CenterMove_IGD = tonumber(updatedSG_CenterMove_IGD)
        currentWeapon.Changed = true
      end

      -- SG_Center_BulletCol
      SG_Center_BulletColChanged, updatedSG_Center_BulletCol = imgui.input_text("SG Center Bullet Col", currentWeapon.SG_Center_BulletCol, 33)
      if SG_Center_BulletColChanged then
        currentWeapon.SG_Center_BulletCol = tonumber(updatedSG_Center_BulletCol)
        currentWeapon.Changed = true
      end

      -- SG_Center_Random
      SG_Center_RandomChanged, updatedSG_Center_Random = imgui.input_text("SG Center Random", currentWeapon.SG_Center_Random, 33)
      if SG_Center_RandomChanged then
        currentWeapon.SG_Center_Random = tonumber(updatedSG_Center_Random)
        currentWeapon.Changed = true
      end

      -- SG_Center_RandomFit
      SG_Center_RandomFitChanged, updatedSG_Center_RandomFit = imgui.input_text("SG Center Random Fit", currentWeapon.SG_Center_RandomFit, 33)
      if SG_Center_RandomFitChanged then
        currentWeapon.SG_Center_RandomFit = tonumber(updatedSG_Center_RandomFit)
        currentWeapon.Changed = true
      end

      -- SG_Center_CritRate
      SG_Center_CritRateChanged, updatedSG_Center_CritRate = imgui.input_text("SG Center Crit Rate", currentWeapon.SG_Center_CritRate, 33)
      if SG_Center_CritRateChanged then
        currentWeapon.SG_Center_CritRate = tonumber(updatedSG_Center_CritRate)
        currentWeapon.Changed = true
      end

      -- SG_Center_CritRate_EX
      SG_Center_CritRate_EXChanged, updatedSG_Center_CritRate_EX = imgui.input_text("SG Center Crit Rate EX", currentWeapon.SG_Center_CritRate_EX, 33)
      if SG_Center_CritRate_EXChanged then
        currentWeapon.SG_Center_CritRate_EX = tonumber(updatedSG_Center_CritRate_EX)
        currentWeapon.Changed = true
      end

      -- SG_Center_BaseDMG
      SG_Center_BaseDMGChanged, updatedSG_Center_BaseDMG = imgui.input_text("SG Center Base DMG", currentWeapon.SG_Center_BaseDMG, 33)
      if SG_Center_BaseDMGChanged then
        currentWeapon.SG_Center_BaseDMG = tonumber(updatedSG_Center_BaseDMG)
        currentWeapon.Changed = true
      end

      -- SG_Center_BaseWINC
      SG_Center_BaseWINCChanged, updatedSG_Center_BaseWINC = imgui.input_text("SG Center Base WINC", currentWeapon.SG_Center_BaseWINC, 33)
      if SG_Center_BaseWINCChanged then
        currentWeapon.SG_Center_BaseWINC = tonumber(updatedSG_Center_BaseWINC)
        currentWeapon.Changed = true
      end

      -- SG_Center_BaseBRK
      SG_Center_BaseBRKChanged, updatedSG_Center_BaseBRK = imgui.input_text("SG Center Base BRK", currentWeapon.SG_Center_BaseBRK, 33)
      if SG_Center_BaseBRKChanged then
        currentWeapon.SG_Center_BaseBRK = tonumber(updatedSG_Center_BaseBRK)
        currentWeapon.Changed = true
      end

      -- SG_Center_BaseSTOP
      SG_Center_BaseSTOPChanged, updatedSG_Center_BaseSTOP = imgui.input_text("SG Center Base STOP", currentWeapon.SG_Center_BaseSTOP, 33)
      if SG_Center_BaseSTOPChanged then
        currentWeapon.SG_Center_BaseSTOP = tonumber(updatedSG_Center_BaseSTOP)
        currentWeapon.Changed = true
      end
      imgui.tree_pop()
    end

    if imgui.tree_node("Around Pellet Settings") then
      -- SG_AroundLife_Distance
      SG_AroundLife_DistanceChanged, updatedSG_AroundLife_Distance = imgui.input_text("SG Around Life Distance", currentWeapon.SG_AroundLife_Distance, 33)
      if SG_AroundLife_DistanceChanged then
        currentWeapon.SG_AroundLife_Distance = tonumber(updatedSG_AroundLife_Distance)
        currentWeapon.Changed = true
      end

      -- SG_AroundMove_Speed
      SG_AroundMove_SpeedChanged, updatedSG_AroundMove_Speed = imgui.input_text("SG Around Move Speed", currentWeapon.SG_AroundMove_Speed, 33)
      if SG_AroundMove_SpeedChanged then
        currentWeapon.SG_AroundMove_Speed = tonumber(updatedSG_AroundMove_Speed)
        currentWeapon.Changed = true
      end

      -- SG_AroundMove_IGD
      SG_AroundMove_IGDChanged, updatedSG_AroundMove_IGD = imgui.input_text("SG Around Move IGD", currentWeapon.SG_AroundMove_IGD, 33)
      if SG_AroundMove_IGDChanged then
        currentWeapon.SG_AroundMove_IGD = tonumber(updatedSG_AroundMove_IGD)
        currentWeapon.Changed = true
      end

      -- SG_Around_BulletCol
      SG_Around_BulletColChanged, updatedSG_Around_BulletCol = imgui.input_text("SG Around Bullet Col", currentWeapon.SG_Around_BulletCol, 33)
      if SG_Around_BulletColChanged then
        currentWeapon.SG_Around_BulletCol = tonumber(updatedSG_Around_BulletCol)
        currentWeapon.Changed = true
      end

      -- SG_Around_Random
      SG_Around_RandomChanged, updatedSG_Around_Random = imgui.input_text("SG Around Random", currentWeapon.SG_Around_Random, 33)
      if SG_Around_RandomChanged then
        currentWeapon.SG_Around_Random = tonumber(updatedSG_Around_Random)
        currentWeapon.Changed = true
      end

      -- SG_Around_RandomFit
      SG_Around_RandomFitChanged, updatedSG_Around_RandomFit = imgui.input_text("SG Around Random Fit", currentWeapon.SG_Around_RandomFit, 33)
      if SG_Around_RandomFitChanged then
        currentWeapon.SG_Around_RandomFit = tonumber(updatedSG_Around_RandomFit)
        currentWeapon.Changed = true
      end

      -- SG_Around_CritRate
      SG_Around_CritRateChanged, updatedSG_Around_CritRate = imgui.input_text("SG Around Crit Rate", currentWeapon.SG_Around_CritRate, 33)
      if SG_Around_CritRateChanged then
        currentWeapon.SG_Around_CritRate = tonumber(updatedSG_Around_CritRate)
        currentWeapon.Changed = true
      end

      -- SG_Around_CritRate_EX
      SG_Around_CritRate_EXChanged, updatedSG_Around_CritRate_EX = imgui.input_text("SG Around Crit Rate EX", currentWeapon.SG_Around_CritRate_EX, 33)
      if SG_Around_CritRate_EXChanged then
        currentWeapon.SG_Around_CritRate_EX = tonumber(updatedSG_Around_CritRate_EX)
        currentWeapon.Changed = true
      end

      -- SG_Around_BaseDMG
      SG_Around_BaseDMGChanged, updatedSG_Around_BaseDMG = imgui.input_text("SG Around Base DMG", currentWeapon.SG_Around_BaseDMG, 33)
      if SG_Around_BaseDMGChanged then
        currentWeapon.SG_Around_BaseDMG = tonumber(updatedSG_Around_BaseDMG)
        currentWeapon.Changed = true
      end

      -- SG_Around_BaseWINC
      SG_Around_BaseWINCChanged, updatedSG_Around_BaseWINC = imgui.input_text("SG Around Base WINC", currentWeapon.SG_Around_BaseWINC, 33)
      if SG_Around_BaseWINCChanged then
        currentWeapon.SG_Around_BaseWINC = tonumber(updatedSG_Around_BaseWINC)
        currentWeapon.Changed = true
      end

      -- SG_Around_BaseBRK
      SG_Around_BaseBRKChanged, updatedSG_Around_BaseBRK = imgui.input_text("SG Around Base BRK", currentWeapon.SG_Around_BaseBRK, 33)
      if SG_Around_BaseBRKChanged then
        currentWeapon.SG_Around_BaseBRK = tonumber(updatedSG_Around_BaseBRK)
        currentWeapon.Changed = true
      end

      -- SG_Around_BaseSTOP
      SG_Around_BaseSTOPChanged, updatedSG_Around_BaseSTOP = imgui.input_text("SG Around Base STOP", currentWeapon.SG_Around_BaseSTOP, 33)
      if SG_Around_BaseSTOPChanged then
        currentWeapon.SG_Around_BaseSTOP = tonumber(updatedSG_Around_BaseSTOP)
        currentWeapon.Changed = true
      end

      -- SG_AroundBulletCount
      SG_AroundBulletCountChanged, updatedSG_AroundBulletCount = imgui.input_text("SG Around Bullet Count", currentWeapon.SG_AroundBulletCount, 33)
      if SG_AroundBulletCountChanged then
        currentWeapon.SG_AroundBulletCount = tonumber(updatedSG_AroundBulletCount)
        currentWeapon.Changed = true
      end

      -- SG_CenterBulletCount
      SG_CenterBulletCountChanged, updatedSG_CenterBulletCount = imgui.input_text("SG Center Bullet Count", currentWeapon.SG_CenterBulletCount, 33)
      if SG_CenterBulletCountChanged then
        currentWeapon.SG_CenterBulletCount = tonumber(updatedSG_CenterBulletCount)
        currentWeapon.Changed = true
      end

      -- SG_InnerRadius
      SG_InnerRadiusChanged, updatedSG_InnerRadius = imgui.input_text("SG Inner Radius", currentWeapon.SG_InnerRadius, 33)
      if SG_InnerRadiusChanged then
        currentWeapon.SG_InnerRadius = tonumber(updatedSG_InnerRadius)
        currentWeapon.Changed = true
      end

      -- SG_OuterRadius
      SG_OuterRadiusChanged, updatedSG_OuterRadius = imgui.input_text("SG Outer Radius", currentWeapon.SG_OuterRadius, 33)
      if SG_OuterRadiusChanged then
        currentWeapon.SG_OuterRadius = tonumber(updatedSG_OuterRadius)
        currentWeapon.Changed = true
      end

      -- SG_AroundVertMin
      SG_AroundVertMinChanged, updatedSG_AroundVertMin = imgui.input_text("SG Around Vert Min", currentWeapon.SG_AroundVertMin, 33)
      if SG_AroundVertMinChanged then
        currentWeapon.SG_AroundVertMin = tonumber(updatedSG_AroundVertMin)
        currentWeapon.Changed = true
      end

      -- SG_AroundVertMax
      SG_AroundVertMaxChanged, updatedSG_AroundVertMax = imgui.input_text("SG Around Vert Max", currentWeapon.SG_AroundVertMax, 33)
      if SG_AroundVertMaxChanged then
        currentWeapon.SG_AroundVertMax = tonumber(updatedSG_AroundVertMax)
        currentWeapon.Changed = true
      end

      -- SG_AroundHorMin
      SG_AroundHorMinChanged, updatedSG_AroundHorMin = imgui.input_text("SG Around Hor Min", currentWeapon.SG_AroundHorMin, 33)
      if SG_AroundHorMinChanged then
        currentWeapon.SG_AroundHorMin = tonumber(updatedSG_AroundHorMin)
        currentWeapon.Changed = true
      end

      -- SG_AroundHorMax
      SG_AroundHorMaxChanged, updatedSG_AroundHorMax = imgui.input_text("SG Around Hor Max", currentWeapon.SG_AroundHorMax, 33)
      if SG_AroundHorMaxChanged then
        currentWeapon.SG_AroundHorMax = tonumber(updatedSG_AroundHorMax)
        currentWeapon.Changed = true
      end
      imgui.tree_pop()
    end
  end

  if imgui.tree_node("Damage") then
    -- HG_BaseDMG
    HG_BaseDMGChanged, updatedHG_BaseDMG = imgui.input_text("HG Base DMG", currentWeapon.HG_BaseDMG, 33)
    if HG_BaseDMGChanged then
      currentWeapon.HG_BaseDMG = tonumber(updatedHG_BaseDMG)
      currentWeapon.Changed = true
    end

    imgui.new_line()

    -- DMG_LVL_01_INFO
    DMG_LVL_01_INFOChanged, updatedDMG_LVL_01_INFO = imgui.input_text("DMG LVL 01 Info", currentWeapon.DMG_LVL_01_INFO, 32)
    if DMG_LVL_01_INFOChanged then
      currentWeapon.DMG_LVL_01_INFO = updatedDMG_LVL_01_INFO
      currentWeapon.Changed = true
    end

    imgui.new_line()

    -- DMG_LVL_02
    DMG_LVL_02Changed, updatedDMG_LVL_02 = imgui.input_text("DMG LVL 02", currentWeapon.DMG_LVL_02, 33)
    if DMG_LVL_02Changed then
      currentWeapon.DMG_LVL_02 = tonumber(updatedDMG_LVL_02)
      currentWeapon.Changed = true
    end

    -- DMG_LVL_02_INFO
    DMG_LVL_02_INFOChanged, updatedDMG_LVL_02_INFO = imgui.input_text("DMG LVL 02 Info", currentWeapon.DMG_LVL_02_INFO, 32)
    if DMG_LVL_02_INFOChanged then
      currentWeapon.DMG_LVL_02_INFO = updatedDMG_LVL_02_INFO
      currentWeapon.Changed = true
    end

    -- DMG_LVL_02_COST
    DMG_LVL_02_COSTChanged, updatedDMG_LVL_02_COST = imgui.input_text("DMG LVL 02 Cost", currentWeapon.DMG_LVL_02_COST, 33)
    if DMG_LVL_02_COSTChanged then
      currentWeapon.DMG_LVL_02_COST = tonumber(updatedDMG_LVL_02_COST)
      currentWeapon.Changed = true
    end

    imgui.new_line()

    -- DMG_LVL_03
    DMG_LVL_03Changed, updatedDMG_LVL_03 = imgui.input_text("DMG LVL 03", currentWeapon.DMG_LVL_03, 33)
    if DMG_LVL_03Changed then
      currentWeapon.DMG_LVL_03 = tonumber(updatedDMG_LVL_03)
      currentWeapon.Changed = true
    end

    -- DMG_LVL_03_INFO
    DMG_LVL_03_INFOChanged, updatedDMG_LVL_03_INFO = imgui.input_text("DMG LVL 03 Info", currentWeapon.DMG_LVL_03_INFO, 32)
    if DMG_LVL_03_INFOChanged then
      currentWeapon.DMG_LVL_03_INFO = updatedDMG_LVL_03_INFO
      currentWeapon.Changed = true
    end

    -- DMG_LVL_03_COST
    DMG_LVL_03_COSTChanged, updatedDMG_LVL_03_COST = imgui.input_text("DMG LVL 03 Cost", currentWeapon.DMG_LVL_03_COST, 33)
    if DMG_LVL_03_COSTChanged then
      currentWeapon.DMG_LVL_03_COST = tonumber(updatedDMG_LVL_03_COST)
      currentWeapon.Changed = true
    end

    imgui.new_line()

    -- DMG_LVL_04
    DMG_LVL_04Changed, updatedDMG_LVL_04 = imgui.input_text("DMG LVL 04", currentWeapon.DMG_LVL_04, 33)
    if DMG_LVL_04Changed then
      currentWeapon.DMG_LVL_04 = tonumber(updatedDMG_LVL_04)
      currentWeapon.Changed = true
    end

    -- DMG_LVL_04_INFO
    DMG_LVL_04_INFOChanged, updatedDMG_LVL_04_INFO = imgui.input_text("DMG LVL 04 Info", currentWeapon.DMG_LVL_04_INFO, 32)
    if DMG_LVL_04_INFOChanged then
      currentWeapon.DMG_LVL_04_INFO = updatedDMG_LVL_04_INFO
      currentWeapon.Changed = true
    end

    -- DMG_LVL_04_COST
    DMG_LVL_04_COSTChanged, updatedDMG_LVL_04_COST = imgui.input_text("DMG LVL 04 Cost", currentWeapon.DMG_LVL_04_COST, 33)
    if DMG_LVL_04_COSTChanged then
      currentWeapon.DMG_LVL_04_COST = tonumber(updatedDMG_LVL_04_COST)
      currentWeapon.Changed = true
    end

    imgui.new_line()

    -- DMG_LVL_05
    DMG_LVL_05Changed, updatedDMG_LVL_05 = imgui.input_text("DMG LVL 05", currentWeapon.DMG_LVL_05, 33)
    if DMG_LVL_05Changed then
      currentWeapon.DMG_LVL_05 = tonumber(updatedDMG_LVL_05)
      currentWeapon.Changed = true
    end

    -- DMG_LVL_05_INFO
    DMG_LVL_05_INFOChanged, updatedDMG_LVL_05_INFO = imgui.input_text("DMG LVL 05 Info", currentWeapon.DMG_LVL_05_INFO, 32)
    if DMG_LVL_05_INFOChanged then
      currentWeapon.DMG_LVL_05_INFO = updatedDMG_LVL_05_INFO
      currentWeapon.Changed = true
    end

    -- DMG_LVL_05_COST
    DMG_LVL_05_COSTChanged, updatedDMG_LVL_05_COST = imgui.input_text("DMG LVL 05 Cost", currentWeapon.DMG_LVL_05_COST, 33)
    if DMG_LVL_05_COSTChanged then
      currentWeapon.DMG_LVL_05_COST = tonumber(updatedDMG_LVL_05_COST)
      currentWeapon.Changed = true
    end

    if imgui.tree_node("Wince") then
      -- HG_BaseWINC
      HG_BaseWINCChanged, updatedHG_BaseWINC = imgui.input_text("HG Base WINC", currentWeapon.HG_BaseWINC, 33)
      if HG_BaseWINCChanged then
        currentWeapon.HG_BaseWINC = tonumber(updatedHG_BaseWINC)
        currentWeapon.Changed = true
      end
      -- WINC_LVL_01
      WINC_LVL_01Changed, updatedWINC_LVL_01 = imgui.input_text("WINC LVL 01", currentWeapon.WINC_LVL_01, 33)
      if WINC_LVL_01Changed then
        currentWeapon.WINC_LVL_01 = tonumber(updatedWINC_LVL_01)
        currentWeapon.Changed = true
      end

      -- WINC_LVL_02
      WINC_LVL_02Changed, updatedWINC_LVL_02 = imgui.input_text("WINC LVL 02", currentWeapon.WINC_LVL_02, 33)
      if WINC_LVL_02Changed then
        currentWeapon.WINC_LVL_02 = tonumber(updatedWINC_LVL_02)
        currentWeapon.Changed = true
      end

      -- WINC_LVL_03
      WINC_LVL_03Changed, updatedWINC_LVL_03 = imgui.input_text("WINC LVL 03", currentWeapon.WINC_LVL_03, 33)
      if WINC_LVL_03Changed then
        currentWeapon.WINC_LVL_03 = tonumber(updatedWINC_LVL_03)
        currentWeapon.Changed = true
      end

      -- WINC_LVL_04
      WINC_LVL_04Changed, updatedWINC_LVL_04 = imgui.input_text("WINC LVL 04", currentWeapon.WINC_LVL_04, 33)
      if WINC_LVL_04Changed then
        currentWeapon.WINC_LVL_04 = tonumber(updatedWINC_LVL_04)
        currentWeapon.Changed = true
      end

      -- WINC_LVL_05
      WINC_LVL_05Changed, updatedWINC_LVL_05 = imgui.input_text("WINC LVL 05", currentWeapon.WINC_LVL_05, 33)
      if WINC_LVL_05Changed then
        currentWeapon.WINC_LVL_05 = tonumber(updatedWINC_LVL_05)
        currentWeapon.Changed = true
      end
      imgui.tree_pop()
    end

    if imgui.tree_node("Break") then
      -- HG_BaseBRK
      HG_BaseBRKChanged, updatedHG_BaseBRK = imgui.input_text("HG Base BRK", currentWeapon.HG_BaseBRK, 33)
      if HG_BaseBRKChanged then
        currentWeapon.HG_BaseBRK = tonumber(updatedHG_BaseBRK)
        currentWeapon.Changed = true
      end
      -- BRK_LVL_01
      BRK_LVL_01Changed, updatedBRK_LVL_01 = imgui.input_text("BRK LVL 01", currentWeapon.BRK_LVL_01, 33)
      if BRK_LVL_01Changed then
        currentWeapon.BRK_LVL_01 = tonumber(updatedBRK_LVL_01)
        currentWeapon.Changed = true
      end

      -- BRK_LVL_02
      BRK_LVL_02Changed, updatedBRK_LVL_02 = imgui.input_text("BRK LVL 02", currentWeapon.BRK_LVL_02, 33)
      if BRK_LVL_02Changed then
        currentWeapon.BRK_LVL_02 = tonumber(updatedBRK_LVL_02)
        currentWeapon.Changed = true
      end

      -- BRK_LVL_03
      BRK_LVL_03Changed, updatedBRK_LVL_03 = imgui.input_text("BRK LVL 03", currentWeapon.BRK_LVL_03, 33)
      if BRK_LVL_03Changed then
        currentWeapon.BRK_LVL_03 = tonumber(updatedBRK_LVL_03)
        currentWeapon.Changed = true
      end

      -- BRK_LVL_04
      BRK_LVL_04Changed, updatedBRK_LVL_04 = imgui.input_text("BRK LVL 04", currentWeapon.BRK_LVL_04, 33)
      if BRK_LVL_04Changed then
        currentWeapon.BRK_LVL_04 = tonumber(updatedBRK_LVL_04)
        currentWeapon.Changed = true
      end

      -- BRK_LVL_05
      BRK_LVL_05Changed, updatedBRK_LVL_05 = imgui.input_text("BRK LVL 05", currentWeapon.BRK_LVL_05, 33)
      if BRK_LVL_05Changed then
        currentWeapon.BRK_LVL_05 = tonumber(updatedBRK_LVL_05)
        currentWeapon.Changed = true
      end
      imgui.tree_pop()
    end

    if imgui.tree_node("Stopping Power") then
      -- HG_BaseSTOP
      HG_BaseSTOPChanged, updatedHG_BaseSTOP = imgui.input_text("HG Base STOP", currentWeapon.HG_BaseSTOP, 33)
      if HG_BaseSTOPChanged then
        currentWeapon.HG_BaseSTOP = tonumber(updatedHG_BaseSTOP)
        currentWeapon.Changed = true
      end

      -- STOP_LVL_01
      STOP_LVL_01Changed, updatedSTOP_LVL_01 = imgui.input_text("STOP LVL 01", currentWeapon.STOP_LVL_01, 33)
      if STOP_LVL_01Changed then
        currentWeapon.STOP_LVL_01 = tonumber(updatedSTOP_LVL_01)
        currentWeapon.Changed = true
      end

      -- STOP_LVL_02
      STOP_LVL_02Changed, updatedSTOP_LVL_02 = imgui.input_text("STOP LVL 02", currentWeapon.STOP_LVL_02, 33)
      if STOP_LVL_02Changed then
        currentWeapon.STOP_LVL_02 = tonumber(updatedSTOP_LVL_02)
        currentWeapon.Changed = true
      end

      -- STOP_LVL_03
      STOP_LVL_03Changed, updatedSTOP_LVL_03 = imgui.input_text("STOP LVL 03", currentWeapon.STOP_LVL_03, 33)
      if STOP_LVL_03Changed then
        currentWeapon.STOP_LVL_03 = tonumber(updatedSTOP_LVL_03)
        currentWeapon.Changed = true
      end

      -- STOP_LVL_04
      STOP_LVL_04Changed, updatedSTOP_LVL_04 = imgui.input_text("STOP LVL 04", currentWeapon.STOP_LVL_04, 33)
      if STOP_LVL_04Changed then
        currentWeapon.STOP_LVL_04 = tonumber(updatedSTOP_LVL_04)
        currentWeapon.Changed = true
      end

      -- STOP_LVL_05
      STOP_LVL_05Changed, updatedSTOP_LVL_05 = imgui.input_text("STOP LVL 05", currentWeapon.STOP_LVL_05, 33)
      if STOP_LVL_05Changed then
        currentWeapon.STOP_LVL_05 = tonumber(updatedSTOP_LVL_05)
        currentWeapon.Changed = true
      end
      imgui.tree_pop()
    end
  end

  if imgui.tree_node("Capacity") then
    -- BaseAmmoNum
    BaseAmmoNumChanged, updatedBaseAmmoNum = imgui.input_text("Base Ammo Num", currentWeapon.BaseAmmoNum, 33)
    if BaseAmmoNumChanged then
      currentWeapon.BaseAmmoNum = tonumber(updatedBaseAmmoNum)
      currentWeapon.Changed = true
    end

    -- BaseAmmoCost
    BaseAmmoCostChanged, updatedBaseAmmoCost = imgui.input_text("Base Ammo Cost", currentWeapon.BaseAmmoCost, 33)
    if BaseAmmoCostChanged then
      currentWeapon.BaseAmmoCost = tonumber(updatedBaseAmmoCost)
      currentWeapon.Changed = true
    end

    imgui.new_line()

    -- AMMO_LVL_01_INFO
    AMMO_LVL_01_INFOChanged, updatedAMMO_LVL_01_INFO = imgui.input_text("AMMO LVL 01 INFO", currentWeapon.AMMO_LVL_01_INFO, 32)
    if AMMO_LVL_01_INFOChanged then
      currentWeapon.AMMO_LVL_01_INFO = updatedAMMO_LVL_01_INFO
      currentWeapon.Changed = true
    end

    imgui.new_line()

    -- AMMO_LVL_02
    AMMO_LVL_02Changed, updatedAMMO_LVL_02 = imgui.input_text("AMMO LVL 02", currentWeapon.AMMO_LVL_02, 33)
    if AMMO_LVL_02Changed then
      currentWeapon.AMMO_LVL_02 = tonumber(updatedAMMO_LVL_02)
      currentWeapon.Changed = true
    end

    -- AMMO_LVL_02_INFO
    AMMO_LVL_02_INFOChanged, updatedAMMO_LVL_02_INFO = imgui.input_text("AMMO LVL 02 INFO", currentWeapon.AMMO_LVL_02_INFO, 32)
    if AMMO_LVL_02_INFOChanged then
      currentWeapon.AMMO_LVL_02_INFO = updatedAMMO_LVL_02_INFO
      currentWeapon.Changed = true
    end

    -- AMMO_LVL_02_COST
    AMMO_LVL_02_COSTChanged, updatedAMMO_LVL_02_COST = imgui.input_text("AMMO LVL 02 COST", currentWeapon.AMMO_LVL_02_COST, 33)
    if AMMO_LVL_02_COSTChanged then
      currentWeapon.AMMO_LVL_02_COST = tonumber(updatedAMMO_LVL_02_COST)
      currentWeapon.Changed = true
    end

    imgui.new_line()

    -- AMMO_LVL_03
    AMMO_LVL_03Changed, updatedAMMO_LVL_03 = imgui.input_text("AMMO LVL 03", currentWeapon.AMMO_LVL_03, 33)
    if AMMO_LVL_03Changed then
      currentWeapon.AMMO_LVL_03 = tonumber(updatedAMMO_LVL_03)
      currentWeapon.Changed = true
    end

    -- AMMO_LVL_03_INFO
    AMMO_LVL_03_INFOChanged, updatedAMMO_LVL_03_INFO = imgui.input_text("AMMO LVL 03 INFO", currentWeapon.AMMO_LVL_03_INFO, 32)
    if AMMO_LVL_03_INFOChanged then
      currentWeapon.AMMO_LVL_03_INFO = updatedAMMO_LVL_03_INFO
      currentWeapon.Changed = true
    end

    -- AMMO_LVL_03_COST
    AMMO_LVL_03_COSTChanged, updatedAMMO_LVL_03_COST = imgui.input_text("AMMO LVL 03 COST", currentWeapon.AMMO_LVL_03_COST, 33)
    if AMMO_LVL_03_COSTChanged then
      currentWeapon.AMMO_LVL_03_COST = tonumber(updatedAMMO_LVL_03_COST)
      currentWeapon.Changed = true
    end

    imgui.new_line()

    -- AMMO_LVL_04
    AMMO_LVL_04Changed, updatedAMMO_LVL_04 = imgui.input_text("AMMO LVL 04", currentWeapon.AMMO_LVL_04, 33)
    if AMMO_LVL_04Changed then
      currentWeapon.AMMO_LVL_04 = tonumber(updatedAMMO_LVL_04)
      currentWeapon.Changed = true
    end

    -- AMMO_LVL_04_INFO
    AMMO_LVL_04_INFOChanged, updatedAMMO_LVL_04_INFO = imgui.input_text("AMMO LVL 04 INFO", currentWeapon.AMMO_LVL_04_INFO, 32)
    if AMMO_LVL_04_INFOChanged then
      currentWeapon.AMMO_LVL_04_INFO = updatedAMMO_LVL_04_INFO
      currentWeapon.Changed = true
    end

    -- AMMO_LVL_04_COST
    AMMO_LVL_04_COSTChanged, updatedAMMO_LVL_04_COST = imgui.input_text("AMMO LVL 04 COST", currentWeapon.AMMO_LVL_04_COST, 33)
    if AMMO_LVL_04_COSTChanged then
      currentWeapon.AMMO_LVL_04_COST = tonumber(updatedAMMO_LVL_04_COST)
      currentWeapon.Changed = true
    end

    imgui.new_line()

    -- AMMO_LVL_05
    AMMO_LVL_05Changed, updatedAMMO_LVL_05 = imgui.input_text("AMMO LVL 05", currentWeapon.AMMO_LVL_05, 33)
    if AMMO_LVL_05Changed then
      currentWeapon.AMMO_LVL_05 = tonumber(updatedAMMO_LVL_05)
      currentWeapon.Changed = true
    end

    -- AMMO_LVL_05_INFO
    AMMO_LVL_05_INFOChanged, updatedAMMO_LVL_05_INFO = imgui.input_text("AMMO LVL 05 INFO", currentWeapon.AMMO_LVL_05_INFO, 32)
    if AMMO_LVL_05_INFOChanged then
      currentWeapon.AMMO_LVL_05_INFO = updatedAMMO_LVL_05_INFO
      currentWeapon.Changed = true
    end

    -- AMMO_LVL_05_COST
    AMMO_LVL_05_COSTChanged, updatedAMMO_LVL_05_COST = imgui.input_text("AMMO LVL 05 COST", currentWeapon.AMMO_LVL_05_COST, 33)
    if AMMO_LVL_05_COSTChanged then
      currentWeapon.AMMO_LVL_05_COST = tonumber(updatedAMMO_LVL_05_COST)
      currentWeapon.Changed = true
    end
    imgui.tree_pop()
  end

  if imgui.tree_node("Reload Speed") then
    -- ReloadType
    ReloadTypeChanged, updatedReloadType = imgui.input_text("Reload Type", currentWeapon.ReloadType, 33)
    if ReloadTypeChanged then
      currentWeapon.ReloadType = tonumber(updatedReloadType)
      currentWeapon.Changed = true
    end

    -- ReloadNum
    ReloadNumChanged, updatedReloadNum = imgui.input_text("Reload Num", currentWeapon.ReloadNum, 33)
    if ReloadNumChanged then
      currentWeapon.ReloadNum = tonumber(updatedReloadNum)
      currentWeapon.Changed = true
    end

    -- ReloadSpeedRate
    ReloadSpeedRateChanged, updatedReloadSpeedRate = imgui.input_text("Reload Speed Rate", currentWeapon.ReloadSpeedRate, 33)
    if ReloadSpeedRateChanged then
      currentWeapon.ReloadSpeedRate = tonumber(updatedReloadSpeedRate)
      currentWeapon.Changed = true
    end

    imgui.new_line()

    -- RELOAD_LVL_01
    RELOAD_LVL_01Changed, updatedRELOAD_LVL_01 = imgui.input_text("RELOAD LVL 01", currentWeapon.RELOAD_LVL_01, 33)
    if RELOAD_LVL_01Changed then
      currentWeapon.RELOAD_LVL_01 = tonumber(updatedRELOAD_LVL_01)
      currentWeapon.Changed = true
    end

    -- RELOAD_LVL_01_INFO
    RELOAD_LVL_01_INFOChanged, updatedRELOAD_LVL_01_INFO = imgui.input_text("RELOAD LVL 01 INFO", currentWeapon.RELOAD_LVL_01_INFO, 32)
    if RELOAD_LVL_01_INFOChanged then
      currentWeapon.RELOAD_LVL_01_INFO = updatedRELOAD_LVL_01_INFO
      currentWeapon.Changed = true
    end

    -- RELOAD_LVL_01_COST
    RELOAD_LVL_01_COSTChanged, updatedRELOAD_LVL_01_COST = imgui.input_text("RELOAD LVL 01 COST", currentWeapon.RELOAD_LVL_01_COST, 33)
    if RELOAD_LVL_01_COSTChanged then
      currentWeapon.RELOAD_LVL_01_COST = tonumber(updatedRELOAD_LVL_01_COST)
      currentWeapon.Changed = true
    end

    imgui.new_line()

    -- RELOAD_LVL_02
    RELOAD_LVL_02Changed, updatedRELOAD_LVL_02 = imgui.input_text("RELOAD LVL 02", currentWeapon.RELOAD_LVL_02, 33)
    if RELOAD_LVL_02Changed then
      currentWeapon.RELOAD_LVL_02 = tonumber(updatedRELOAD_LVL_02)
      currentWeapon.Changed = true
    end

    -- RELOAD_LVL_02_INFO
    RELOAD_LVL_02_INFOChanged, updatedRELOAD_LVL_02_INFO = imgui.input_text("RELOAD LVL 02 INFO", currentWeapon.RELOAD_LVL_02_INFO, 32)
    if RELOAD_LVL_02_INFOChanged then
      currentWeapon.RELOAD_LVL_02_INFO = updatedRELOAD_LVL_02_INFO
      currentWeapon.Changed = true
    end

    -- RELOAD_LVL_02_COST
    RELOAD_LVL_02_COSTChanged, updatedRELOAD_LVL_02_COST = imgui.input_text("RELOAD LVL 02 COST", currentWeapon.RELOAD_LVL_02_COST, 33)
    if RELOAD_LVL_02_COSTChanged then
      currentWeapon.RELOAD_LVL_02_COST = tonumber(updatedRELOAD_LVL_02_COST)
      currentWeapon.Changed = true
    end

    imgui.new_line()

    -- RELOAD_LVL_03
    RELOAD_LVL_03Changed, updatedRELOAD_LVL_03 = imgui.input_text("RELOAD LVL 03", currentWeapon.RELOAD_LVL_03, 33)
    if RELOAD_LVL_03Changed then
      currentWeapon.RELOAD_LVL_03 = tonumber(updatedRELOAD_LVL_03)
      currentWeapon.Changed = true
    end

    -- RELOAD_LVL_03_INFO
    RELOAD_LVL_03_INFOChanged, updatedRELOAD_LVL_03_INFO = imgui.input_text("RELOAD LVL 03 INFO", currentWeapon.RELOAD_LVL_03_INFO, 32)
    if RELOAD_LVL_03_INFOChanged then
      currentWeapon.RELOAD_LVL_03_INFO = updatedRELOAD_LVL_03_INFO
      currentWeapon.Changed = true
    end

    -- RELOAD_LVL_03_COST
    RELOAD_LVL_03_COSTChanged, updatedRELOAD_LVL_03_COST = imgui.input_text("RELOAD LVL 03 COST", currentWeapon.RELOAD_LVL_03_COST, 33)
    if RELOAD_LVL_03_COSTChanged then
      currentWeapon.RELOAD_LVL_03_COST = tonumber(updatedRELOAD_LVL_03_COST)
      currentWeapon.Changed = true
    end

    imgui.new_line()

    -- RELOAD_LVL_04
    RELOAD_LVL_04Changed, updatedRELOAD_LVL_04 = imgui.input_text("RELOAD LVL 04", currentWeapon.RELOAD_LVL_04, 33)
    if RELOAD_LVL_04Changed then
      currentWeapon.RELOAD_LVL_04 = tonumber(updatedRELOAD_LVL_04)
      currentWeapon.Changed = true
    end

    -- RELOAD_LVL_04_INFO
    RELOAD_LVL_04_INFOChanged, updatedRELOAD_LVL_04_INFO = imgui.input_text("RELOAD LVL 04 INFO", currentWeapon.RELOAD_LVL_04_INFO, 32)
    if RELOAD_LVL_04_INFOChanged then
      currentWeapon.RELOAD_LVL_04_INFO = updatedRELOAD_LVL_04_INFO
      currentWeapon.Changed = true
    end

    -- RELOAD_LVL_04_COST
    RELOAD_LVL_04_COSTChanged, updatedRELOAD_LVL_04_COST = imgui.input_text("RELOAD LVL 04 COST", currentWeapon.RELOAD_LVL_04_COST, 33)
    if RELOAD_LVL_04_COSTChanged then
      currentWeapon.RELOAD_LVL_04_COST = tonumber(updatedRELOAD_LVL_04_COST)
      currentWeapon.Changed = true
    end

    imgui.new_line()

    -- RELOAD_LVL_05
    RELOAD_LVL_05Changed, updatedRELOAD_LVL_05 = imgui.input_text("RELOAD LVL 05", currentWeapon.RELOAD_LVL_05, 33)
    if RELOAD_LVL_05Changed then
      currentWeapon.RELOAD_LVL_05 = tonumber(updatedRELOAD_LVL_05)
      currentWeapon.Changed = true
    end

    -- RELOAD_LVL_05_INFO
    RELOAD_LVL_05_INFOChanged, updatedRELOAD_LVL_05_INFO = imgui.input_text("RELOAD LVL 05 INFO", currentWeapon.RELOAD_LVL_05_INFO, 32)
    if RELOAD_LVL_05_INFOChanged then
      currentWeapon.RELOAD_LVL_05_INFO = updatedRELOAD_LVL_05_INFO
      currentWeapon.Changed = true
    end

    -- RELOAD_LVL_05_COST
    RELOAD_LVL_05_COSTChanged, updatedRELOAD_LVL_05_COST = imgui.input_text("RELOAD LVL 05 COST", currentWeapon.RELOAD_LVL_05_COST, 33)
    if RELOAD_LVL_05_COSTChanged then
      currentWeapon.RELOAD_LVL_05_COST = tonumber(updatedRELOAD_LVL_05_COST)
      currentWeapon.Changed = true
    end
    imgui.tree_pop()
  end

  if imgui.tree_node("Rate of Fire") then
    -- ShootType
    ShootTypeChanged, updatedShootType = imgui.input_text("Shoot Type", currentWeapon.ShootType, 33)
    if ShootTypeChanged then
      currentWeapon.ShootType = tonumber(updatedShootType)
      currentWeapon.Changed = true
    end

    -- PumpActionFireRate
    PumpActionFireRateChanged, updatedPumpActionFireRate = imgui.input_text("Pump Action Fire Rate", currentWeapon.PumpActionFireRate, 33)
    if PumpActionFireRateChanged then
      currentWeapon.PumpActionFireRate = tonumber(updatedPumpActionFireRate)
      currentWeapon.Changed = true
    end

    -- FireRate
    FireRateChanged, updatedFireRate = imgui.input_text("Fire Rate", currentWeapon.FireRate, 33)
    if FireRateChanged then
      currentWeapon.FireRate = tonumber(updatedFireRate)
      currentWeapon.Changed = true
    end

    -- FireRateFrame
    FireRateFrameChanged, updatedFireRateFrame = imgui.input_text("Fire Rate Frame", currentWeapon.FireRateFrame, 33)
    if FireRateFrameChanged then
      currentWeapon.FireRateFrame = tonumber(updatedFireRateFrame)
      currentWeapon.Changed = true
    end

    imgui.new_line()

    -- ROF_LVL_01
    ROF_LVL_01Changed, updatedROF_LVL_01 = imgui.input_text("ROF LVL 01", currentWeapon.ROF_LVL_01, 33)
    if ROF_LVL_01Changed then
      currentWeapon.ROF_LVL_01 = tonumber(updatedROF_LVL_01)
      currentWeapon.Changed = true
    end

    -- ROF_LVL_01_INFO
    ROF_LVL_01_INFOChanged, updatedROF_LVL_01_INFO = imgui.input_text("ROF LVL 01 INFO", currentWeapon.ROF_LVL_01_INFO, 32)
    if ROF_LVL_01_INFOChanged then
      currentWeapon.ROF_LVL_01_INFO = updatedROF_LVL_01_INFO
      currentWeapon.Changed = true
    end

    -- ROF_LVL_01_COST
    ROF_LVL_01_COSTChanged, updatedROF_LVL_01_COST = imgui.input_text("ROF LVL 01 COST", currentWeapon.ROF_LVL_01_COST, 33)
    if ROF_LVL_01_COSTChanged then
      currentWeapon.ROF_LVL_01_COST = tonumber(updatedROF_LVL_01_COST)
      currentWeapon.Changed = true
    end

    imgui.new_line()

    -- ROF_LVL_02
    ROF_LVL_02Changed, updatedROF_LVL_02 = imgui.input_text("ROF LVL 02", currentWeapon.ROF_LVL_02, 33)
    if ROF_LVL_02Changed then
      currentWeapon.ROF_LVL_02 = tonumber(updatedROF_LVL_02)
      currentWeapon.Changed = true
    end

    -- ROF_LVL_02_INFO
    ROF_LVL_02_INFOChanged, updatedROF_LVL_02_INFO = imgui.input_text("ROF LVL 02 INFO", currentWeapon.ROF_LVL_02_INFO, 32)
    if ROF_LVL_02_INFOChanged then
      currentWeapon.ROF_LVL_02_INFO = updatedROF_LVL_02_INFO
      currentWeapon.Changed = true
    end

    -- ROF_LVL_02_COST
    ROF_LVL_02_COSTChanged, updatedROF_LVL_02_COST = imgui.input_text("ROF LVL 02 COST", currentWeapon.ROF_LVL_02_COST, 33)
    if ROF_LVL_02_COSTChanged then
      currentWeapon.ROF_LVL_02_COST = tonumber(updatedROF_LVL_02_COST)
      currentWeapon.Changed = true
    end

    imgui.new_line()

    -- ROF_LVL_03
    ROF_LVL_03Changed, updatedROF_LVL_03 = imgui.input_text("ROF LVL 03", currentWeapon.ROF_LVL_03, 33)
    if ROF_LVL_03Changed then
      currentWeapon.ROF_LVL_03 = tonumber(updatedROF_LVL_03)
      currentWeapon.Changed = true
    end

    -- ROF_LVL_03_INFO
    ROF_LVL_03_INFOChanged, updatedROF_LVL_03_INFO = imgui.input_text("ROF LVL 03 INFO", currentWeapon.ROF_LVL_03_INFO, 32)
    if ROF_LVL_03_INFOChanged then
      currentWeapon.ROF_LVL_03_INFO = updatedROF_LVL_03_INFO
      currentWeapon.Changed = true
    end

    -- ROF_LVL_03_COST
    ROF_LVL_03_COSTChanged, updatedROF_LVL_03_COST = imgui.input_text("ROF LVL 03 COST", currentWeapon.ROF_LVL_03_COST, 33)
    if ROF_LVL_03_COSTChanged then
      currentWeapon.ROF_LVL_03_COST = tonumber(updatedROF_LVL_03_COST)
      currentWeapon.Changed = true
    end

    imgui.new_line()

    -- ROF_LVL_04
    ROF_LVL_04Changed, updatedROF_LVL_04 = imgui.input_text("ROF LVL 04", currentWeapon.ROF_LVL_04, 33)
    if ROF_LVL_04Changed then
      currentWeapon.ROF_LVL_04 = tonumber(updatedROF_LVL_04)
      currentWeapon.Changed = true
    end

    -- ROF_LVL_04_INFO
    ROF_LVL_04_INFOChanged, updatedROF_LVL_04_INFO = imgui.input_text("ROF LVL 04 INFO", currentWeapon.ROF_LVL_04_INFO, 32)
    if ROF_LVL_04_INFOChanged then
      currentWeapon.ROF_LVL_04_INFO = updatedROF_LVL_04_INFO
      currentWeapon.Changed = true
    end

    -- ROF_LVL_04_COST
    ROF_LVL_04_COSTChanged, updatedROF_LVL_04_COST = imgui.input_text("ROF LVL 04 COST", currentWeapon.ROF_LVL_04_COST, 33)
    if ROF_LVL_04_COSTChanged then
      currentWeapon.ROF_LVL_04_COST = tonumber(updatedROF_LVL_04_COST)
      currentWeapon.Changed = true
    end

    imgui.new_line()

    -- ROF_LVL_05
    ROF_LVL_05Changed, updatedROF_LVL_05 = imgui.input_text("ROF LVL 05", currentWeapon.ROF_LVL_05, 33)
    if ROF_LVL_05Changed then
      currentWeapon.ROF_LVL_05 = tonumber(updatedROF_LVL_05)
      currentWeapon.Changed = true
    end

    -- ROF_LVL_05_INFO
    ROF_LVL_05_INFOChanged, updatedROF_LVL_05_INFO = imgui.input_text("ROF LVL 05 INFO", currentWeapon.ROF_LVL_05_INFO, 32)
    if ROF_LVL_05_INFOChanged then
      currentWeapon.ROF_LVL_05_INFO = updatedROF_LVL_05_INFO
      currentWeapon.Changed = true
    end

    -- ROF_LVL_05_COST
    ROF_LVL_05_COSTChanged, updatedROF_LVL_05_COST = imgui.input_text("ROF LVL 05 COST", currentWeapon.ROF_LVL_05_COST, 33)
    if ROF_LVL_05_COSTChanged then
      currentWeapon.ROF_LVL_05_COST = tonumber(updatedROF_LVL_05_COST)
      currentWeapon.Changed = true
    end
    imgui.tree_pop()
  end
  -- POWER EX
  if currentAWFWeapon.name == "RED9" or currentAWFWeapon.name == "BT" or currentAWFWeapon.name == "BRB" or currentAWFWeapon.name == "BM4" or currentAWFWeapon.name == "TMP" or
    currentAWFWeapon.name == "M1G" or currentAWFWeapon.name == "CQBR" then
    if imgui.tree_node("Exclusive") then
      -- EX_DMG
      EX_DMGChanged, updatedEX_DMG = imgui.input_text("EX_DMG", currentWeapon.EX_DMG, 33)
      if EX_DMGChanged then
        currentWeapon.EX_DMG = tonumber(updatedEX_DMG)
        currentWeapon.Changed = true
      end

      -- EX_WINCE
      EX_WINCEChanged, updatedEX_WINCE = imgui.input_text("EX_WINCE", currentWeapon.EX_WINCE, 33)
      if EX_WINCEChanged then
        currentWeapon.EX_WINCE = tonumber(updatedEX_WINCE)
        currentWeapon.Changed = true
      end

      -- EX_BRK
      EX_BRKChanged, updatedEX_BRK = imgui.input_text("EX_BRK", currentWeapon.EX_BRK, 33)
      if EX_BRKChanged then
        currentWeapon.EX_BRK = tonumber(updatedEX_BRK)
        currentWeapon.Changed = true
      end

      -- EX_STOP
      EX_STOPChanged, updatedEX_STOP = imgui.input_text("EX_STOP", currentWeapon.EX_STOP, 33)
      if EX_STOPChanged then
        currentWeapon.EX_STOP = tonumber(updatedEX_STOP)
        currentWeapon.Changed = true
      end

      -- EX_COST
      EX_COSTChanged, updatedEX_COST = imgui.input_text("EX_COST", currentWeapon.EX_COST, 33)
      if EX_COSTChanged then
        currentWeapon.EX_COST = tonumber(updatedEX_COST)
        currentWeapon.Changed = true
      end
      imgui.tree_pop()
    end
  end

  if currentAWFWeapon.name == "M870" or currentAWFWeapon.name == "SKUL" then
    if imgui.tree_node("Exclusive") then

      -- EX_SG_DMG
      EX_SG_DMGChanged, updatedEX_SG_DMG = imgui.input_text("EX_SG_DMG", currentWeapon.EX_SG_DMG, 33)
      if EX_SG_DMGChanged then
        currentWeapon.EX_SG_DMG = tonumber(updatedEX_SG_DMG)
        currentWeapon.Changed = true
      end

      -- EX_SG_WINCE
      EX_SG_WINCEChanged, updatedEX_SG_WINCE = imgui.input_text("EX_SG_WINCE", currentWeapon.EX_SG_WINCE, 33)
      if EX_SG_WINCEChanged then
        currentWeapon.EX_SG_WINCE = tonumber(updatedEX_SG_WINCE)
        currentWeapon.Changed = true
      end

      -- EX_SG_BRK
      EX_SG_BRKChanged, updatedEX_SG_BRK = imgui.input_text("EX_SG_BRK", currentWeapon.EX_SG_BRK, 33)
      if EX_SG_BRKChanged then
        currentWeapon.EX_SG_BRK = tonumber(updatedEX_SG_BRK)
        currentWeapon.Changed = true
      end

      -- EX_SG_STOP
      EX_SG_STOPChanged, updatedEX_SG_STOP = imgui.input_text("EX_SG_STOP", currentWeapon.EX_SG_STOP, 33)
      if EX_SG_STOPChanged then
        currentWeapon.EX_SG_STOP = tonumber(updatedEX_SG_STOP)
        currentWeapon.Changed = true
      end

      -- EX_COST
      EX_COSTChanged, updatedEX_COST = imgui.input_text("EX_COST", currentWeapon.EX_COST, 33)
      if EX_COSTChanged then
        currentWeapon.EX_COST = tonumber(updatedEX_COST)
        currentWeapon.Changed = true
      end
      imgui.tree_pop()
    end
  end

  -- Crit EX
  if currentAWFWeapon.name == "SEN9" or currentAWFWeapon.name == "SG09R" or currentAWFWeapon.name == "KIL7" then
    if imgui.tree_node("Exclusive") then
      -- EX_CRIT
      EX_CRITChanged, updatedEX_CRIT = imgui.input_text("EX_CRIT", currentWeapon.EX_CRIT, 33)
      if EX_CRITChanged then
        currentWeapon.EX_CRIT = tonumber(updatedEX_CRIT)
        currentWeapon.Changed = true
      end

      -- EX_CRIT_FIT
      EX_CRIT_FITChanged, updatedEX_CRIT_FIT = imgui.input_text("EX_CRIT_FIT", currentWeapon.EX_CRIT_FIT, 33)
      if EX_CRIT_FITChanged then
        currentWeapon.EX_CRIT_FIT = tonumber(updatedEX_CRIT_FIT)
        currentWeapon.Changed = true
      end

      -- EX_COST
      EX_COSTChanged, updatedEX_COST = imgui.input_text("EX_COST", currentWeapon.EX_COST, 33)
      if EX_COSTChanged then
        currentWeapon.EX_COST = tonumber(updatedEX_COST)
        currentWeapon.Changed = true
      end
      imgui.tree_pop()
    end
  end

  -- PENETRATION EX
  if currentAWFWeapon.name == "PUN" or currentAWFWeapon.name == "LE5" then
    if imgui.tree_node("Exclusive") then
      -- EX_PIRC
      EX_PIRCChanged, updatedEX_PIRC = imgui.input_text("EX_PIRC", currentWeapon.EX_PIRC, 33)
      if EX_PIRCChanged then
        currentWeapon.EX_PIRC = tonumber(updatedEX_PIRC)
        currentWeapon.Changed = true
      end

      -- EX_PIRC_FIT
      EX_PIRC_FITChanged, updatedEX_PIRC_FIT = imgui.input_text("EX_PIRC_FIT", currentWeapon.EX_PIRC_FIT, 33)
      if EX_PIRC_FITChanged then
        currentWeapon.EX_PIRC_FIT = tonumber(updatedEX_PIRC_FIT)
        currentWeapon.Changed = true
      end

      -- EX_COST
      EX_COSTChanged, updatedEX_COST = imgui.input_text("EX_COST", currentWeapon.EX_COST, 33)
      if EX_COSTChanged then
        currentWeapon.EX_COST = tonumber(updatedEX_COST)
        currentWeapon.Changed = true
      end

      imgui.tree_pop()
    end
  end

  -- CAPACITY EX
  if currentAWFWeapon.name == "VP70" then
    if imgui.tree_node("Exclusive") then
      -- EX_AMMO
      EX_AMMOChanged, updatedEX_AMMO = imgui.input_text("EX_AMMO", currentWeapon.EX_AMMO, 33)
      if EX_AMMOChanged then
        currentWeapon.EX_AMMO = tonumber(updatedEX_AMMO)
        currentWeapon.Changed = true
      end

      -- EX_COST
      EX_COSTChanged, updatedEX_COST = imgui.input_text("EX_COST", currentWeapon.EX_COST, 33)
      if EX_COSTChanged then
        currentWeapon.EX_COST = tonumber(updatedEX_COST)
        currentWeapon.Changed = true
      end
      imgui.tree_pop()
    end
  end

  -- STRIKER EX
  if currentAWFWeapon.name == "STKR" then
    if imgui.tree_node("Exclusive") then
      -- EX_AMMO
      EX_AMMOChanged, updatedEX_AMMO = imgui.input_text("EX_AMMO", currentWeapon.EX_AMMO, 33)
      if EX_AMMOChanged then
        currentWeapon.EX_AMMO = tonumber(updatedEX_AMMO)
        currentWeapon.Changed = true
      end

      -- EX_SG_RELOAD
      EX_SG_RELOADChanged, updatedEX_SG_RELOAD = imgui.input_text("EX_SG_RELOAD", currentWeapon.EX_SG_RELOAD, 33)
      if EX_SG_RELOADChanged then
        currentWeapon.EX_SG_RELOAD = tonumber(updatedEX_SG_RELOAD)
        currentWeapon.Changed = true
      end

      -- EX_COST
      EX_COSTChanged, updatedEX_COST = imgui.input_text("EX_COST", currentWeapon.EX_COST, 33)
      if EX_COSTChanged then
        currentWeapon.EX_COST = tonumber(updatedEX_COST)
        currentWeapon.Changed = true
      end
      imgui.tree_pop()
    end
  end

  -- INFINITE AMMO EX
  if currentAWFWeapon.name == "HNDC" or currentAWFWeapon.name == "CTW" then
    if imgui.tree_node("Exclusive") then
      -- EX_COST
      EX_COSTChanged, updatedEX_COST = imgui.input_text("EX_COST", currentWeapon.EX_COST, 33)
      if EX_COSTChanged then
        currentWeapon.EX_COST = tonumber(updatedEX_COST)
        currentWeapon.Changed = true
      end

      imgui.tree_pop()
    end
  end

  -- RATE OF FIRE EX
  if currentAWFWeapon.name == "SAR" then
    if imgui.tree_node("Exclusive") then
      -- EX_ROF
      EX_ROFChanged, updatedEX_ROF = imgui.input_text("EX_ROF", currentWeapon.EX_ROF, 33)
      if EX_ROFChanged then
        currentWeapon.EX_ROF = tonumber(updatedEX_ROF)
        currentWeapon.Changed = true
      end

      -- EX_COST
      EX_COSTChanged, updatedEX_COST = imgui.input_text("EX_COST", currentWeapon.EX_COST, 33)
      if EX_COSTChanged then
        currentWeapon.EX_COST = tonumber(updatedEX_COST)
        currentWeapon.Changed = true
      end

      imgui.tree_pop()
    end
  end

  imgui.new_line()

  if imgui.button("Save Changes") then
    local path = Weapon_Vars.Weapon_Profiles[Weapon_Vars.Selected_Profile]
    json.dump_file("DWP\\" .. path .. "\\" .. currentAWFWeapon.name .. ".json", currentWeapon)
  end

  imgui.end_window()
end

local function apply_harpoon_damage()
  local Harpoon_GameObject = scene:call("findGameObject(System.String)", "wp5406")

  if Harpoon_GameObject then
    local Harpoon_Gun = Harpoon_GameObject:call("getComponent(System.Type)", sdk.typeof("chainsaw.Gun"))

    if Harpoon_Gun then
      local Harpoon_Shell = Harpoon_Gun:get_field("<ShellGenerator>k__BackingField")

      if Harpoon_Shell then
        local Harpoon_UserData = Harpoon_Shell:get_field("_UserData")

        if Harpoon_UserData then
          local Harpoon_ShellInfo_UserData = Harpoon_UserData:get_field("_ShellInfoUserData")

          if Harpoon_ShellInfo_UserData then
            local Harpoon_AttackInfo = Harpoon_ShellInfo_UserData:get_field("_AttackInfo")

            if Harpoon_AttackInfo then
              local Harpoon_DamageRate = Harpoon_AttackInfo:get_field("_DamageRate")

              if Harpoon_DamageRate then
                Harpoon_DamageRate._BaseValue = 100.0
              end
            end
          end
        end
      end
    end
  end
end

local function on_inventory_changed()
  -- cache red 9 owner equipment so stock equip change can be detected
  local RED9_GameObject = scene:call("findGameObject(System.String)", "wp4002")
  if RED9_GameObject then
    local RED9_Gun = RED9_GameObject:call("getComponent(System.Type)", sdk.typeof("chainsaw.Gun"))
    if RED9_Gun then
      RED9_OwnerEquipment = RED9_Gun:get_field("<OwnerEquipment>k__BackingField")
    end
  end

  -- cache tmp owner equipment so stock equip change can be detected
  local TMP_GameObject = scene:call("findGameObject(System.String)", "wp4200")
  if TMP_GameObject then
    local TMP_Gun = TMP_GameObject:call("getComponent(System.Type)", sdk.typeof("chainsaw.Gun"))
    if TMP_Gun then
      TMP_OwnerEquipment = TMP_Gun:get_field("<OwnerEquipment>k__BackingField")
    end
  end

  -- cache vp 70 owner equipment so stock equip change can be detected
  local VP70_GameObject = scene:call("findGameObject(System.String)", "wp4004")
  if VP70_GameObject then
    local VP70_Gun = VP70_GameObject:call("getComponent(System.Type)", sdk.typeof("chainsaw.Gun"))
    if VP70_Gun then
      VP70_OwnerEquipment = VP70_Gun:get_field("<OwnerEquipment>k__BackingField")
    end
  end

  -- apply profile to any new weapons that could have been added to the inventory
  apply_changes()
end

local function create_new_weapon_profile()
  if new_profile_name ~= nil and new_profile_name ~= '' then
    -- look for existing files
    local tempSG09R = json.load_file("DWP\\" .. new_profile_name .. "\\SG09R.json")

    -- if an existing profile folder wasn't found, copy None into the new profile folder
    if not tempSG09R then
      local noneSG09R = json.load_file("DWP\\None\\SG09R.json")
      local nonePUN = json.load_file("DWP\\None\\PUN.json")
      local noneRED9 = json.load_file("DWP\\None\\RED9.json")
      local noneBT = json.load_file("DWP\\None\\BT.json")
      local noneVP70 = json.load_file("DWP\\None\\VP70.json")
      local noneSEN9 = json.load_file("DWP\\None\\SEN9.json")
      local noneM870 = json.load_file("DWP\\None\\M870.json")
      local noneBM4 = json.load_file("DWP\\None\\BM4.json")
      local noneSTKR = json.load_file("DWP\\None\\STKR.json")
      local noneSKUL = json.load_file("DWP\\None\\SKUL.json")
      local noneTMP = json.load_file("DWP\\None\\TMP.json")
      local noneCTW = json.load_file("DWP\\None\\CTW.json")
      local noneLE5 = json.load_file("DWP\\None\\LE5.json")
      local noneM1G = json.load_file("DWP\\None\\M1G.json")
      local noneSAR = json.load_file("DWP\\None\\SAR.json")
      local noneCQBR = json.load_file("DWP\\None\\CQBR.json")
      local noneBRB = json.load_file("DWP\\None\\BRB.json")
      local noneKIL7 = json.load_file("DWP\\None\\KIL7.json")
      local noneHNDC = json.load_file("DWP\\None\\HNDC.json")

      json.dump_file("DWP\\" .. new_profile_name .. "\\SG09R.json", noneSG09R)
      json.dump_file("DWP\\" .. new_profile_name .. "\\PUN.json", nonePUN)
      json.dump_file("DWP\\" .. new_profile_name .. "\\RED9.json", noneRED9)
      json.dump_file("DWP\\" .. new_profile_name .. "\\BT.json", noneBT)
      json.dump_file("DWP\\" .. new_profile_name .. "\\VP70.json", noneVP70)
      json.dump_file("DWP\\" .. new_profile_name .. "\\SEN9.json", noneSEN9)
      json.dump_file("DWP\\" .. new_profile_name .. "\\M870.json", noneM870)
      json.dump_file("DWP\\" .. new_profile_name .. "\\BM4.json", noneBM4)
      json.dump_file("DWP\\" .. new_profile_name .. "\\STKR.json", noneSTKR)
      json.dump_file("DWP\\" .. new_profile_name .. "\\SKUL.json", noneSKUL)
      json.dump_file("DWP\\" .. new_profile_name .. "\\TMP.json", noneTMP)
      json.dump_file("DWP\\" .. new_profile_name .. "\\CTW.json", noneCTW)
      json.dump_file("DWP\\" .. new_profile_name .. "\\LE5.json", noneLE5)
      json.dump_file("DWP\\" .. new_profile_name .. "\\M1G.json", noneM1G)
      json.dump_file("DWP\\" .. new_profile_name .. "\\SAR.json", noneSAR)
      json.dump_file("DWP\\" .. new_profile_name .. "\\CQBR.json", noneCQBR)
      json.dump_file("DWP\\" .. new_profile_name .. "\\BRB.json", noneBRB)
      json.dump_file("DWP\\" .. new_profile_name .. "\\KIL7.json", noneKIL7)
      json.dump_file("DWP\\" .. new_profile_name .. "\\HNDC.json", noneHNDC)
    end

    local count = 1
    for _ in pairs(Weapon_Vars.Weapon_Profiles) do
      count = count + 1
    end
    Weapon_Vars.Weapon_Profiles[tostring(count)] = new_profile_name
    new_profile_name = ""
    json.dump_file("DWP\\Saved.json", Weapon_Vars)
  end
end

local function get_player_context()
  local character_manager = sdk.get_managed_singleton(sdk.game_namespace("CharacterManager"))
  local player_context = character_manager and character_manager:call("getPlayerContextRef")
  return player_context
end

-- save the initial values for all guns so they can be reset later
json.dump_file("DWP\\None\\SG09R.json", AWF.WeaponData.SG09R)
json.dump_file("DWP\\None\\PUN.json", AWF.WeaponData.PUN)
json.dump_file("DWP\\None\\RED9.json", AWF.WeaponData.RED9)
json.dump_file("DWP\\None\\BT.json", AWF.WeaponData.BT)
json.dump_file("DWP\\None\\VP70.json", AWF.WeaponData.VP70)
json.dump_file("DWP\\None\\SEN9.json", AWF.WeaponData.SEN9)
json.dump_file("DWP\\None\\M870.json", AWF.WeaponData.M870)
json.dump_file("DWP\\None\\BM4.json", AWF.WeaponData.BM4)
json.dump_file("DWP\\None\\STKR.json", AWF.WeaponData.STKR)
json.dump_file("DWP\\None\\SKUL.json", AWF.WeaponData.SKUL)
json.dump_file("DWP\\None\\TMP.json", AWF.WeaponData.TMP)
json.dump_file("DWP\\None\\CTW.json", AWF.WeaponData.CTW)
json.dump_file("DWP\\None\\LE5.json", AWF.WeaponData.LE5)
json.dump_file("DWP\\None\\M1G.json", AWF.WeaponData.M1G)
json.dump_file("DWP\\None\\SAR.json", AWF.WeaponData.SAR)
json.dump_file("DWP\\None\\CQBR.json", AWF.WeaponData.CQBR)
json.dump_file("DWP\\None\\BRB.json", AWF.WeaponData.BRB)
json.dump_file("DWP\\None\\KIL7.json", AWF.WeaponData.KIL7)
json.dump_file("DWP\\None\\HNDC.json", AWF.WeaponData.HNDC)

-- set the weapon values when the script first runs
SetAWFWeapon_DMGValues()

re.on_draw_ui(function()
  local changed = false
  local was_changed = false

  if imgui.tree_node("Dynamic Weapon Profiles") then
    changed, Weapon_Vars.Selected_Profile = imgui.combo("Weapon Profile", Weapon_Vars.Selected_Profile, Weapon_Vars.Weapon_Profiles)
    was_changed = changed or was_changed

    changed, Weapon_Vars.No_Recoil = imgui.checkbox("No Recoil", Weapon_Vars.No_Recoil)
    was_changed = changed or was_changed

    changed, Weapon_Vars.No_Spread = imgui.checkbox("Perfect Accuracy", Weapon_Vars.No_Spread)
    was_changed = changed or was_changed

    changed, Weapon_Vars.Always_Focus = imgui.checkbox("Perfect Focus", Weapon_Vars.Always_Focus)
    was_changed = changed or was_changed

    changed, Weapon_Vars.No_Ammo_Cost = imgui.checkbox("No Ammo Cost", Weapon_Vars.No_Ammo_Cost)
    was_changed = changed or was_changed

    changed, Weapon_Vars.Extra_Break = imgui.checkbox("Extra Dismemberment", Weapon_Vars.Extra_Break)
    was_changed = changed or was_changed

    changed, Weapon_Vars.Headshots_Kill = imgui.checkbox("Lethal Headshots", Weapon_Vars.Headshots_Kill)
    was_changed = changed or was_changed

    changed, Weapon_Vars.Harpoon_DMG = imgui.checkbox("Del Lago Insta Kill", Weapon_Vars.Harpoon_DMG)
    was_changed = changed or was_changed

    if imgui.tree_node("OG Settings") then
      changed, Weapon_Vars.CTW_DMG = imgui.checkbox("OG Chicago Typewriter", Weapon_Vars.CTW_DMG)
      was_changed = changed or was_changed

      changed, Weapon_Vars.HNDC_DMG = imgui.checkbox("OG Handcannon", Weapon_Vars.HNDC_DMG)
      was_changed = changed or was_changed

      changed, Weapon_Vars.OG_WINCE = imgui.checkbox("OG Stagger", Weapon_Vars.OG_WINCE)
      was_changed = changed or was_changed

      imgui.tree_pop()
    end

    if imgui.tree_node("Shotgun Slug Options - ENABLE WITH DIFFERENT WEAPON EQUIPPED") then
      changed, Weapon_Vars.M870_Slug = imgui.checkbox("W870 Fires Slugs", Weapon_Vars.M870_Slug)
      was_changed = changed or was_changed

      changed, Weapon_Vars.BM4_Slug = imgui.checkbox("Riot Gun Fires Slugs", Weapon_Vars.BM4_Slug)
      was_changed = changed or was_changed

      changed, Weapon_Vars.STKR_Slug = imgui.checkbox("Striker Fires Slugs", Weapon_Vars.STKR_Slug)
      was_changed = changed or was_changed

      changed, Weapon_Vars.SKUL_Slug = imgui.checkbox("Skull Shaker Fires Slugs", Weapon_Vars.SKUL_Slug)
      was_changed = changed or was_changed

      imgui.tree_pop()
    end

    if imgui.tree_node("Misc Options") then
      changed, Weapon_Vars.No_Reticles = imgui.checkbox("No Reticles", Weapon_Vars.No_Reticles)
      was_changed = changed or was_changed

      changed, Weapon_Vars.CQBR_Smg = imgui.checkbox("CQBR Uses SMG Ammo", Weapon_Vars.CQBR_Smg)
      was_changed = changed or was_changed

      changed, Weapon_Vars.BRB_HG = imgui.checkbox("Broken Butterfly Uses HG Ammo", Weapon_Vars.BRB_HG)
      was_changed = changed or was_changed

      changed, Weapon_Vars.Kil7_HG = imgui.checkbox("Killer 7 Uses HG Ammo", Weapon_Vars.Kil7_HG)
      was_changed = changed or was_changed

      changed, Weapon_Vars.HNDC_HG = imgui.checkbox("Handcannon Uses HG Ammo", Weapon_Vars.HNDC_HG)
      was_changed = changed or was_changed

      imgui.tree_pop()
    end

    imgui.tree_pop()
  end

  if was_changed then
    apply_changes()
  end

  if imgui.tree_node("DWP Profile Editing") then
    local editorButtonLabel = "Show Profile Editor"
    if show_profile_editor then
      editorButtonLabel = "Hide Profile Editor"
    end

    if imgui.button(editorButtonLabel) then
      show_profile_editor = not show_profile_editor
    end

    imgui.new_line()

    imgui.text("Enter the folder name of your custom profile to\nadd it to the list of available weapon profiles")

    local profileChanged = false
    local updated_profile_entry = ""
    profileChanged, updated_profile_entry = imgui.input_text("Folder Name", new_profile_name)

    if profileChanged then
      new_profile_name = updated_profile_entry
    end

    if imgui.button("Add Profile") then
      create_new_weapon_profile()
    end
    imgui.new_line()
  end
  imgui.new_line()
end)

re.on_frame(function()
  if show_profile_editor then
    draw_profile_editor_ui()
  end

  if scene_manager then
    scene = sdk.call_native_func(scene_manager, sdk.find_type_definition("via.SceneManager"), "get_CurrentScene")

    if scene then
      local player = get_player_context()

      if player then
        if not CS_Inventory then
          local PlayerInventoryObserver = scene:call("findGameObject(System.String)", "PlayerInventoryObserver")

          if PlayerInventoryObserver then
            local InventoryObserver = PlayerInventoryObserver:call("getComponent(System.Type)", sdk.typeof("chainsaw.PlayerInventoryObserver"))
            if InventoryObserver then
              local Observer = InventoryObserver:get_field("_Observer")
              if Observer then
                local InventoryController = Observer:get_field("_InventoryController")

                if InventoryController then
                  CS_Inventory = InventoryController:get_field("<_CsInventory>k__BackingField")
                end
              end
            end
          end
        else
          local InventoryItems = CS_Inventory:get_field("_InventoryItems")

          if InventoryItems then
            local inventory_items = InventoryItems:get_field("_items")

            local current_inventory_count = 0;

            for i, ItemID in ipairs(inventory_items) do
              local WeaponID = ItemID:call("get_WeaponId")

              if WeaponID then
                current_inventory_count = current_inventory_count + 1
              end
            end

            if last_inventory_count > -1 then
              if current_inventory_count > last_inventory_count then
                log.info("Something was added to the inventory")
                log.info("Current: " .. current_inventory_count .. ", Last: " .. last_inventory_count)
                on_inventory_changed()
              elseif current_inventory_count < last_inventory_count then
                log.info("Something was removed from the inventory")
                log.info("Current: " .. current_inventory_count .. ", Last: " .. last_inventory_count)
                on_inventory_changed()
              end
            end

            last_inventory_count = current_inventory_count
          end
        end

        -- adjust red 9 when the stock is equiped or unquiped
        if RED9_OwnerEquipment then
          local Current_RED9_Stock = RED9_OwnerEquipment:get_IsExistsStock()

          if RED9_Has_Stock ~= Current_RED9_Stock then
            log.info("RED9 stock equip changed")
            AWF.WeaponData.RED9.Changed = true
          end

          RED9_Has_Stock = Current_RED9_Stock
        end

        -- adjust tmp when the stock is equiped or unquiped
        if TMP_OwnerEquipment then
          local Current_TMP_Stock = TMP_OwnerEquipment:get_IsExistsStock()

          if TMP_Has_Stock ~= Current_TMP_Stock then
            log.info("TMP stock equip changed")
            AWF.WeaponData.TMP.Changed = true
          end

          TMP_Has_Stock = Current_TMP_Stock
        end

        -- adjust vp70 when the stock is equiped or unquiped
        if VP70_OwnerEquipment then
          local Current_VP70_Stock = VP70_OwnerEquipment:get_IsExistsStock()

          if VP70_Has_Stock ~= Current_VP70_Stock then
            log.info("VP70 stock equip changed")
            AWF.WeaponData.VP70.Changed = true
          end

          VP70_Has_Stock = Current_VP70_Stock
        end
      end
    end -- end if scene
  end -- end if scene manger

  if Weapon_Vars.Harpoon_DMG then
    apply_harpoon_damage()
  end

  if imgui.is_key_pressed(via.hid.KeyboardKey.Insert) then
    show_profile_editor = false
  end
end)
