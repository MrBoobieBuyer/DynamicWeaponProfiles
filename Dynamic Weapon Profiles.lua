local AWF = require("AWF Core")

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
  Headshots_Kill 	= false,
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

  if Weapon_Vars.No_Recoil then                       -----/// Main Tree ///-----
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

  if Weapon_Vars.BM4_Slug then                              ----/// SLUGS TREE ///-----
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

  if Weapon_Vars.HNDC_DMG then                      -----/// OG Options TREE ///-----
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

  if Weapon_Vars.No_Reticles then                   -----/// MISC TREE ///-----
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

    changed, Weapon_Vars.No_Ammo_Cost = imgui.checkbox("No Ammo Cost",  Weapon_Vars.No_Ammo_Cost)
    was_changed = changed or was_changed

    changed, Weapon_Vars.Extra_Break = imgui.checkbox("Extra Dismemberment",  Weapon_Vars.Extra_Break)
    was_changed = changed or was_changed

    changed, Weapon_Vars.Headshots_Kill = imgui.checkbox("Lethal Headshots",  Weapon_Vars.Headshots_Kill)
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

      imgui.tree_pop()
    end

    imgui.tree_pop()
  end

  if was_changed then
    apply_changes()
  end
end)

local scene_manager = sdk.get_native_singleton("via.SceneManager")
local scene = nil
local CS_Inventory = nil
local last_inventory_count = -1
local RED9_Has_Stock = false
local TMP_Has_Stock = false
local VP70_Has_Stock = false

re.on_frame(function()
    if scene_manager then 
        scene = sdk.call_native_func(scene_manager, sdk.find_type_definition("via.SceneManager"), "get_CurrentScene")

		if scene then
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
                            apply_changes()

					    elseif current_inventory_count < last_inventory_count then
						    log.info("Something was removed from the inventory")
						    log.info("Current: " .. current_inventory_count .. ", Last: " .. last_inventory_count)
                			apply_changes()
					    end
                    end

					last_inventory_count = current_inventory_count
				end
			end

            -- adjust red 9 when the stock is equiped or unquiped
            local RED9_GameObject = scene:call("findGameObject(System.String)", "wp4002")

            if RED9_GameObject then
                local RED9_Gun = RED9_GameObject:call("getComponent(System.Type)", sdk.typeof("chainsaw.Gun"))

                if RED9_Gun then
                    local RED9_OwnerEquipment = RED9_Gun:get_field("<OwnerEquipment>k__BackingField")

                    if RED9_OwnerEquipment then
                        local Current_RED9_Stock = RED9_OwnerEquipment:get_IsExistsStock()

                        if RED9_Has_Stock ~= Current_RED9_Stock then
                            log.info("RED9 stock equip changed")
                            AWF.WeaponData.RED9.Changed = true
                        end

                        RED9_Has_Stock = Current_RED9_Stock
                    end
                end
            end

            -- adjust tmp when the stock is equiped or unquiped
            local TMP_GameObject = scene:call("findGameObject(System.String)", "wp4200")

            if TMP_GameObject then
                local TMP_Gun = TMP_GameObject:call("getComponent(System.Type)", sdk.typeof("chainsaw.Gun"))

                if TMP_Gun then
                    local TMP_OwnerEquipment = TMP_Gun:get_field("<OwnerEquipment>k__BackingField")

                    if TMP_OwnerEquipment then
                        local Current_TMP_Stock = TMP_OwnerEquipment:get_IsExistsStock()

                        if TMP_Has_Stock ~= Current_TMP_Stock then
                            log.info("TMP stock equip changed")
                            AWF.WeaponData.TMP.Changed = true
                        end

                        TMP_Has_Stock = Current_TMP_Stock
                    end
                end
            end

            -- adjust vp70 when the stock is equiped or unquiped
            local VP70_GameObject = scene:call("findGameObject(System.String)", "wp4004")

            if VP70_GameObject then
                local VP70_Gun = VP70_GameObject:call("getComponent(System.Type)", sdk.typeof("chainsaw.Gun"))

                if VP70_Gun then
                    local VP70_OwnerEquipment = VP70_Gun:get_field("<OwnerEquipment>k__BackingField")

                    if VP70_OwnerEquipment then
                        local Current_VP70_Stock = VP70_OwnerEquipment:get_IsExistsStock()

                        if VP70_Has_Stock ~= Current_VP70_Stock then
                            log.info("VP70 stock equip changed")
                            AWF.WeaponData.VP70.Changed = true
                        end

                        VP70_Has_Stock = Current_VP70_Stock
                    end
                end
            end

		end -- end if scene
	end -- end if scene manger
end)
