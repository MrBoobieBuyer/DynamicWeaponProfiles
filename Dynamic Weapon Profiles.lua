local WeaponService = require("Weapon Service")

local new_profile_name = ""
local show_profile_editor = false

local scene_manager = sdk.get_native_singleton("via.SceneManager")
local scene = nil
local initialized = false

local Weapon_Vars = json.load_file("DWP\\Saved.json") or {
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
  Durable_Knives = false,
  Free_Knife_Repairs = false,
  Weapon_Profiles = {
    ["1"] = "None",
    ["2"] = "Better Weapon Balance"
  }
}

local Selected_Weapon = 1
local Available_Weapons = {
  [1] = "SG-09R",
  [2] = "Punisher",
  [3] = "Red 9",
  [4] = "Blacktail",
  [5] = "Matilda",
  [6] = "Sentinel 9",
  [7] = "W-870",
  [8] = "Riot Gun",
  [9] = "Striker",
  [10] = "Skull Shaker",
  [11] = "TMP",
  [12] = "Chicago Sweeper",
  [13] = "LE5",
  [14] = "SR M1903",
  [15] = "Stingray",
  [16] = "CQBR",
  [17] = "Broken Butterfly",
  [18] = "Killer 7",
  [19] = "Handcannon"
}

local function SetWeapon_DMGValues()
  -- load weapon profile from json files
  local path = Weapon_Vars.Weapon_Profiles[Weapon_Vars.Selected_Profile]
  WeaponService.set_weapon_profile(path)

  -- apply additional custom settings

  -----/// Main Tree ///-----

  if Weapon_Vars.CTW_DMG then
    WeaponService.Weapons.CTW.Stats.ReticleType = 203
    WeaponService.Weapons.CTW.Stats.HG_Distance = 300.0
    WeaponService.Weapons.CTW.Stats.SMG_Random = 0.01
    WeaponService.Weapons.CTW.Stats.SMG_RandomFit = 0.005
    WeaponService.Weapons.CTW.Stats.HG_BaseDMG = 5.0
    WeaponService.Weapons.CTW.Stats.HG_BaseWINC = 2.0
    WeaponService.Weapons.CTW.Stats.Recoil_YawMin = -0.2
    WeaponService.Weapons.CTW.Stats.Recoil_YawMax = 0.4
    WeaponService.Weapons.CTW.Stats.Recoil_PitchMin = -0.3
    WeaponService.Weapons.CTW.Stats.Recoil_PitchMax = 0.8
    WeaponService.Weapons.CTW.Stats.DMG_LVL_01_INFO = "2.00"
    WeaponService.Weapons.CTW.Stats.DMG_LVL_02_INFO = "4.00"
    WeaponService.Weapons.CTW.Stats.DMG_LVL_03_INFO = "6.00"
    WeaponService.Weapons.CTW.Stats.DMG_LVL_04_INFO = "8.00"
    WeaponService.Weapons.CTW.Stats.DMG_LVL_05_INFO = "10.0"
    WeaponService.Weapons.CTW.Stats.DMG_LVL_02 = 10
    WeaponService.Weapons.CTW.Stats.DMG_LVL_03 = 15
    WeaponService.Weapons.CTW.Stats.DMG_LVL_04 = 20
    WeaponService.Weapons.CTW.Stats.DMG_LVL_05 = 25
    WeaponService.Weapons.CTW.Stats.Focus_HoldAdd = 360.0
    WeaponService.Weapons.CTW.Stats.Focus_MoveSub = 370.0
    WeaponService.Weapons.CTW.Stats.Focus_CamSub = 370.0
    WeaponService.Weapons.CTW.Stats.HG_BulletGravityIgnore = 40
  end
  
  if Weapon_Vars.No_Recoil then
    WeaponService.Weapons.SG09R.Stats.Recoil_YawMin = 0.0
    WeaponService.Weapons.SG09R.Stats.Recoil_YawMax = 0.0
    WeaponService.Weapons.SG09R.Stats.Recoil_PitchMin = 0.0
    WeaponService.Weapons.SG09R.Stats.Recoil_PitchMax = 0.0
    WeaponService.Weapons.PUN.Stats.Recoil_YawMin = 0
    WeaponService.Weapons.PUN.Stats.Recoil_YawMax = 0
    WeaponService.Weapons.PUN.Stats.Recoil_PitchMin = 0
    WeaponService.Weapons.PUN.Stats.Recoil_PitchMax = 0

    WeaponService.Weapons.RED9.Stats.Recoil_YawMin = 0
    WeaponService.Weapons.RED9.Stats.Recoil_YawMax = 0
    WeaponService.Weapons.RED9.Stats.Recoil_PitchMin = 0
    WeaponService.Weapons.RED9.Stats.Recoil_PitchMax = 0
    WeaponService.Weapons.RED9.StatsWithStock.Recoil_YawMin = 0
    WeaponService.Weapons.RED9.StatsWithStock.Recoil_YawMax = 0
    WeaponService.Weapons.RED9.StatsWithStock.Recoil_PitchMin = 0
    WeaponService.Weapons.RED9.StatsWithStock.Recoil_PitchMax = 0

    WeaponService.Weapons.BT.Stats.Recoil_YawMin = 0
    WeaponService.Weapons.BT.Stats.Recoil_YawMax = 0
    WeaponService.Weapons.BT.Stats.Recoil_PitchMin = 0
    WeaponService.Weapons.BT.Stats.Recoil_PitchMax = 0
    WeaponService.Weapons.VP70.Stats.Recoil_YawMin = 0
    WeaponService.Weapons.VP70.Stats.Recoil_YawMax = 0
    WeaponService.Weapons.VP70.Stats.Recoil_PitchMin = 0
    WeaponService.Weapons.VP70.Stats.Recoil_PitchMax = 0
    WeaponService.Weapons.SEN9.Stats.Recoil_YawMin = 0
    WeaponService.Weapons.SEN9.Stats.Recoil_YawMax = 0
    WeaponService.Weapons.SEN9.Stats.Recoil_PitchMin = 0
    WeaponService.Weapons.SEN9.Stats.Recoil_PitchMax = 0
    WeaponService.Weapons.M870.Stats.Recoil_YawMin = 0
    WeaponService.Weapons.M870.Stats.Recoil_YawMax = 0
    WeaponService.Weapons.M870.Stats.Recoil_PitchMin = 0
    WeaponService.Weapons.M870.Stats.Recoil_PitchMax = 0
    WeaponService.Weapons.BM4.Stats.Recoil_YawMin = 0
    WeaponService.Weapons.BM4.Stats.Recoil_YawMax = 0
    WeaponService.Weapons.BM4.Stats.Recoil_PitchMin = 0
    WeaponService.Weapons.BM4.Stats.Recoil_PitchMax = 0
    WeaponService.Weapons.STKR.Stats.Recoil_YawMin = 0
    WeaponService.Weapons.STKR.Stats.Recoil_YawMax = 0
    WeaponService.Weapons.STKR.Stats.Recoil_PitchMin = 0
    WeaponService.Weapons.STKR.Stats.Recoil_PitchMax = 0
    WeaponService.Weapons.SKUL.Stats.Recoil_YawMin = 0
    WeaponService.Weapons.SKUL.Stats.Recoil_YawMax = 0
    WeaponService.Weapons.SKUL.Stats.Recoil_PitchMin = 0
    WeaponService.Weapons.SKUL.Stats.Recoil_PitchMax = 0
    WeaponService.Weapons.TMP.Stats.Recoil_YawMin = 0
    WeaponService.Weapons.TMP.Stats.Recoil_YawMax = 0
    WeaponService.Weapons.TMP.Stats.Recoil_PitchMin = 0
    WeaponService.Weapons.TMP.Stats.Recoil_PitchMax = 0
    WeaponService.Weapons.CTW.Stats.Recoil_YawMin = 0
    WeaponService.Weapons.CTW.Stats.Recoil_YawMax = 0
    WeaponService.Weapons.CTW.Stats.Recoil_PitchMin = 0
    WeaponService.Weapons.CTW.Stats.Recoil_PitchMax = 0
    WeaponService.Weapons.LE5.Stats.Recoil_YawMin = 0
    WeaponService.Weapons.LE5.Stats.Recoil_YawMax = 0
    WeaponService.Weapons.LE5.Stats.Recoil_PitchMin = 0
    WeaponService.Weapons.LE5.Stats.Recoil_PitchMax = 0
    WeaponService.Weapons.M1G.Stats.Recoil_YawMin = 0
    WeaponService.Weapons.M1G.Stats.Recoil_YawMax = 0
    WeaponService.Weapons.M1G.Stats.Recoil_PitchMin = 0
    WeaponService.Weapons.M1G.Stats.Recoil_PitchMax = 0
    WeaponService.Weapons.SAR.Stats.Recoil_YawMin = 0
    WeaponService.Weapons.SAR.Stats.Recoil_YawMax = 0
    WeaponService.Weapons.SAR.Stats.Recoil_PitchMin = 0
    WeaponService.Weapons.SAR.Stats.Recoil_PitchMax = 0
    WeaponService.Weapons.CQBR.Stats.Recoil_YawMin = 0
    WeaponService.Weapons.CQBR.Stats.Recoil_YawMax = 0
    WeaponService.Weapons.CQBR.Stats.Recoil_PitchMin = 0
    WeaponService.Weapons.CQBR.Stats.Recoil_PitchMax = 0
    WeaponService.Weapons.BRB.Stats.Recoil_YawMin = 0
    WeaponService.Weapons.BRB.Stats.Recoil_YawMax = 0
    WeaponService.Weapons.BRB.Stats.Recoil_PitchMin = 0
    WeaponService.Weapons.BRB.Stats.Recoil_PitchMax = 0
    WeaponService.Weapons.KIL7.Stats.Recoil_YawMin = 0
    WeaponService.Weapons.KIL7.Stats.Recoil_YawMax = 0
    WeaponService.Weapons.KIL7.Stats.Recoil_PitchMin = 0
    WeaponService.Weapons.KIL7.Stats.Recoil_PitchMax = 0
    WeaponService.Weapons.HNDC.Stats.Recoil_YawMin = 0
    WeaponService.Weapons.HNDC.Stats.Recoil_YawMax = 0
    WeaponService.Weapons.HNDC.Stats.Recoil_PitchMin = 0
    WeaponService.Weapons.HNDC.Stats.Recoil_PitchMax = 0
  end

  if Weapon_Vars.No_Spread then
    WeaponService.Weapons.SG09R.Stats.SMG_Random = 0.0
    WeaponService.Weapons.SG09R.Stats.SMG_RandomFit = 0.0
    WeaponService.Weapons.PUN.Stats.SMG_Random = 0.0
    WeaponService.Weapons.PUN.Stats.SMG_RandomFit = 0.0
    WeaponService.Weapons.RED9.Stats.SMG_Random = 0.0
    WeaponService.Weapons.RED9.Stats.SMG_RandomFit = 0.0
    WeaponService.Weapons.BT.Stats.SMG_Random = 0.0
    WeaponService.Weapons.BT.Stats.SMG_RandomFit = 0.0
    WeaponService.Weapons.VP70.Stats.SMG_Random = 0.0
    WeaponService.Weapons.VP70.Stats.SMG_RandomFit = 0.0
    WeaponService.Weapons.SEN9.Stats.SMG_Random = 0.0
    WeaponService.Weapons.SEN9.Stats.SMG_RandomFit = 0.0
    WeaponService.Weapons.TMP.Stats.SMG_Random = 0.0
    WeaponService.Weapons.TMP.Stats.SMG_RandomFit = 0.0
    WeaponService.Weapons.CTW.Stats.SMG_Random = 0.0
    WeaponService.Weapons.CTW.Stats.SMG_RandomFit = 0.0
    WeaponService.Weapons.LE5.Stats.SMG_Random = 0.0
    WeaponService.Weapons.LE5.Stats.SMG_RandomFit = 0.0
    WeaponService.Weapons.M1G.Stats.SMG_Random = 0.0
    WeaponService.Weapons.M1G.Stats.SMG_RandomFit = 0.0
    WeaponService.Weapons.SAR.Stats.SMG_Random = 0.0
    WeaponService.Weapons.SAR.Stats.SMG_RandomFit = 0.0
    WeaponService.Weapons.CQBR.Stats.SMG_Random = 0.0
    WeaponService.Weapons.CQBR.Stats.SMG_RandomFit = 0.0
    WeaponService.Weapons.BRB.Stats.SMG_Random = 0.0
    WeaponService.Weapons.BRB.Stats.SMG_RandomFit = 0.0
    WeaponService.Weapons.KIL7.Stats.SMG_Random = 0.0
    WeaponService.Weapons.KIL7.Stats.SMG_RandomFit = 0.0
    WeaponService.Weapons.HNDC.Stats.SMG_Random = 0.0
    WeaponService.Weapons.HNDC.Stats.SMG_RandomFit = 0.0
  end

  if Weapon_Vars.Always_Focus then
    WeaponService.Weapons.SG09R.Stats.Focus_Limit = 0.0
    WeaponService.Weapons.SG09R.Stats.Focus_HoldAdd = 1000
    WeaponService.Weapons.PUN.Stats.Focus_Limit = 0.0
    WeaponService.Weapons.PUN.Stats.Focus_HoldAdd = 1000
    WeaponService.Weapons.RED9.Stats.Focus_Limit = 0.0
    WeaponService.Weapons.RED9.Stats.Focus_HoldAdd = 1000
    WeaponService.Weapons.BT.Stats.Focus_Limit = 0.0
    WeaponService.Weapons.BT.Stats.Focus_HoldAdd = 1000
    WeaponService.Weapons.VP70.Stats.Focus_Limit = 0.0
    WeaponService.Weapons.VP70.Stats.Focus_HoldAdd = 1000
    WeaponService.Weapons.SEN9.Stats.Focus_Limit = 0.0
    WeaponService.Weapons.SEN9.Stats.Focus_HoldAdd = 1000
    WeaponService.Weapons.TMP.Stats.Focus_Limit = 0.0
    WeaponService.Weapons.TMP.Stats.Focus_HoldAdd = 1000
    WeaponService.Weapons.CTW.Stats.Focus_Limit = 0.0
    WeaponService.Weapons.CTW.Stats.Focus_HoldAdd = 1000
    WeaponService.Weapons.LE5.Stats.Focus_Limit = 0.0
    WeaponService.Weapons.LE5.Stats.Focus_HoldAdd = 1000
    WeaponService.Weapons.M1G.Stats.Focus_Limit = 0.0
    WeaponService.Weapons.M1G.Stats.Focus_HoldAdd = 1000
    WeaponService.Weapons.SAR.Stats.Focus_Limit = 0.0
    WeaponService.Weapons.SAR.Stats.Focus_HoldAdd = 1000
    WeaponService.Weapons.CQBR.Stats.Focus_Limit = 0.0
    WeaponService.Weapons.CQBR.Stats.Focus_HoldAdd = 1000
    WeaponService.Weapons.BRB.Stats.Focus_Limit = 0.0
    WeaponService.Weapons.BRB.Stats.Focus_HoldAdd = 1000
    WeaponService.Weapons.KIL7.Stats.Focus_Limit = 0.0
    WeaponService.Weapons.KIL7.Stats.Focus_HoldAdd = 1000
    WeaponService.Weapons.HNDC.Stats.Focus_Limit = 0.0
    WeaponService.Weapons.HNDC.Stats.Focus_HoldAdd = 1000
  end

  if Weapon_Vars.No_Ammo_Cost then
    WeaponService.Weapons.SG09R.Stats.BaseAmmoCost = 0
    WeaponService.Weapons.PUN.Stats.BaseAmmoCost = 0
    WeaponService.Weapons.RED9.Stats.BaseAmmoCost = 0
    WeaponService.Weapons.BT.Stats.BaseAmmoCost = 0
    WeaponService.Weapons.VP70.Stats.BaseAmmoCost = 0
    WeaponService.Weapons.SEN9.Stats.BaseAmmoCost = 0
    WeaponService.Weapons.M870.Stats.BaseAmmoCost = 0
    WeaponService.Weapons.BM4.Stats.BaseAmmoCost = 0
    WeaponService.Weapons.STKR.Stats.BaseAmmoCost = 0
    WeaponService.Weapons.SKUL.Stats.BaseAmmoCost = 0
    WeaponService.Weapons.TMP.Stats.BaseAmmoCost = 0
    WeaponService.Weapons.CTW.Stats.BaseAmmoCost = 0
    WeaponService.Weapons.LE5.Stats.BaseAmmoCost = 0
    WeaponService.Weapons.M1G.Stats.BaseAmmoCost = 0
    WeaponService.Weapons.SAR.Stats.BaseAmmoCost = 0
    WeaponService.Weapons.CQBR.Stats.BaseAmmoCost = 0
    WeaponService.Weapons.BRB.Stats.BaseAmmoCost = 0
    WeaponService.Weapons.KIL7.Stats.BaseAmmoCost = 0
    WeaponService.Weapons.HNDC.Stats.BaseAmmoCost = 0
  end

  if Weapon_Vars.Extra_Break then
    WeaponService.Weapons.SG09R.Stats.HG_BaseBRK = 10
    WeaponService.Weapons.SG09R.Stats.BRK_LVL_02 = 10
    WeaponService.Weapons.SG09R.Stats.BRK_LVL_03 = 10
    WeaponService.Weapons.SG09R.Stats.BRK_LVL_04 = 10
    WeaponService.Weapons.SG09R.Stats.BRK_LVL_05 = 10
    WeaponService.Weapons.PUN.Stats.HG_BaseBRK = 10
    WeaponService.Weapons.PUN.Stats.BRK_LVL_02 = 10
    WeaponService.Weapons.PUN.Stats.BRK_LVL_03 = 10
    WeaponService.Weapons.PUN.Stats.BRK_LVL_04 = 10
    WeaponService.Weapons.PUN.Stats.BRK_LVL_05 = 10
    WeaponService.Weapons.RED9.Stats.HG_BaseBRK = 10
    WeaponService.Weapons.RED9.Stats.BRK_LVL_02 = 10
    WeaponService.Weapons.RED9.Stats.BRK_LVL_03 = 10
    WeaponService.Weapons.RED9.Stats.BRK_LVL_04 = 10
    WeaponService.Weapons.RED9.Stats.BRK_LVL_05 = 10
    WeaponService.Weapons.BT.Stats.HG_BaseBRK = 10
    WeaponService.Weapons.BT.Stats.BRK_LVL_02 = 10
    WeaponService.Weapons.BT.Stats.BRK_LVL_03 = 10
    WeaponService.Weapons.BT.Stats.BRK_LVL_04 = 10
    WeaponService.Weapons.BT.Stats.BRK_LVL_05 = 10
    WeaponService.Weapons.VP70.Stats.HG_BaseBRK = 10
    WeaponService.Weapons.VP70.Stats.BRK_LVL_02 = 10
    WeaponService.Weapons.VP70.Stats.BRK_LVL_03 = 10
    WeaponService.Weapons.VP70.Stats.BRK_LVL_04 = 10
    WeaponService.Weapons.VP70.Stats.BRK_LVL_05 = 10
    WeaponService.Weapons.SEN9.Stats.HG_BaseBRK = 10
    WeaponService.Weapons.SEN9.Stats.BRK_LVL_02 = 10
    WeaponService.Weapons.SEN9.Stats.BRK_LVL_03 = 10
    WeaponService.Weapons.SEN9.Stats.BRK_LVL_04 = 10
    WeaponService.Weapons.SEN9.Stats.BRK_LVL_05 = 10
    WeaponService.Weapons.M870.Stats.HG_BaseBRK = 10
    WeaponService.Weapons.M870.Stats.BRK_LVL_02 = 10
    WeaponService.Weapons.M870.Stats.BRK_LVL_03 = 10
    WeaponService.Weapons.M870.Stats.BRK_LVL_04 = 10
    WeaponService.Weapons.M870.Stats.BRK_LVL_05 = 10
    WeaponService.Weapons.BM4.Stats.HG_BaseBRK = 10
    WeaponService.Weapons.BM4.Stats.BRK_LVL_02 = 10
    WeaponService.Weapons.BM4.Stats.BRK_LVL_03 = 10
    WeaponService.Weapons.BM4.Stats.BRK_LVL_04 = 10
    WeaponService.Weapons.BM4.Stats.BRK_LVL_05 = 10
    WeaponService.Weapons.STKR.Stats.HG_BaseBRK = 10
    WeaponService.Weapons.STKR.Stats.BRK_LVL_02 = 10
    WeaponService.Weapons.STKR.Stats.BRK_LVL_03 = 10
    WeaponService.Weapons.STKR.Stats.BRK_LVL_04 = 10
    WeaponService.Weapons.STKR.Stats.BRK_LVL_05 = 10
    WeaponService.Weapons.SKUL.Stats.HG_BaseBRK = 10
    WeaponService.Weapons.SKUL.Stats.BRK_LVL_02 = 10
    WeaponService.Weapons.SKUL.Stats.BRK_LVL_03 = 10
    WeaponService.Weapons.SKUL.Stats.BRK_LVL_04 = 10
    WeaponService.Weapons.SKUL.Stats.BRK_LVL_05 = 10
    WeaponService.Weapons.TMP.Stats.HG_BaseBRK = 10
    WeaponService.Weapons.TMP.Stats.BRK_LVL_02 = 10
    WeaponService.Weapons.TMP.Stats.BRK_LVL_03 = 10
    WeaponService.Weapons.TMP.Stats.BRK_LVL_04 = 10
    WeaponService.Weapons.TMP.Stats.BRK_LVL_05 = 10
    WeaponService.Weapons.CTW.Stats.HG_BaseBRK = 10
    WeaponService.Weapons.CTW.Stats.BRK_LVL_02 = 10
    WeaponService.Weapons.CTW.Stats.BRK_LVL_03 = 10
    WeaponService.Weapons.CTW.Stats.BRK_LVL_04 = 10
    WeaponService.Weapons.CTW.Stats.BRK_LVL_05 = 10
    WeaponService.Weapons.LE5.Stats.HG_BaseBRK = 10
    WeaponService.Weapons.LE5.Stats.BRK_LVL_02 = 10
    WeaponService.Weapons.LE5.Stats.BRK_LVL_03 = 10
    WeaponService.Weapons.LE5.Stats.BRK_LVL_04 = 10
    WeaponService.Weapons.LE5.Stats.BRK_LVL_05 = 10
    WeaponService.Weapons.M1G.Stats.HG_BaseBRK = 10
    WeaponService.Weapons.M1G.Stats.BRK_LVL_02 = 10
    WeaponService.Weapons.M1G.Stats.BRK_LVL_03 = 10
    WeaponService.Weapons.M1G.Stats.BRK_LVL_04 = 10
    WeaponService.Weapons.M1G.Stats.BRK_LVL_05 = 10
    WeaponService.Weapons.SAR.Stats.HG_BaseBRK = 10
    WeaponService.Weapons.SAR.Stats.BRK_LVL_02 = 10
    WeaponService.Weapons.SAR.Stats.BRK_LVL_03 = 10
    WeaponService.Weapons.SAR.Stats.BRK_LVL_04 = 10
    WeaponService.Weapons.SAR.Stats.BRK_LVL_05 = 10
    WeaponService.Weapons.CQBR.Stats.HG_BaseBRK = 10
    WeaponService.Weapons.CQBR.Stats.BRK_LVL_02 = 10
    WeaponService.Weapons.CQBR.Stats.BRK_LVL_03 = 10
    WeaponService.Weapons.CQBR.Stats.BRK_LVL_04 = 10
    WeaponService.Weapons.CQBR.Stats.BRK_LVL_05 = 10
    WeaponService.Weapons.BRB.Stats.HG_BaseBRK = 10
    WeaponService.Weapons.BRB.Stats.BRK_LVL_02 = 10
    WeaponService.Weapons.BRB.Stats.BRK_LVL_03 = 10
    WeaponService.Weapons.BRB.Stats.BRK_LVL_04 = 10
    WeaponService.Weapons.BRB.Stats.BRK_LVL_05 = 10
    WeaponService.Weapons.KIL7.Stats.HG_BaseBRK = 10
    WeaponService.Weapons.KIL7.Stats.BRK_LVL_02 = 10
    WeaponService.Weapons.KIL7.Stats.BRK_LVL_03 = 10
    WeaponService.Weapons.KIL7.Stats.BRK_LVL_04 = 10
    WeaponService.Weapons.KIL7.Stats.BRK_LVL_05 = 10
    WeaponService.Weapons.HNDC.Stats.HG_BaseBRK = 10
    WeaponService.Weapons.HNDC.Stats.BRK_LVL_02 = 10
    WeaponService.Weapons.HNDC.Stats.BRK_LVL_03 = 10
    WeaponService.Weapons.HNDC.Stats.BRK_LVL_04 = 10
    WeaponService.Weapons.HNDC.Stats.BRK_LVL_05 = 10
  end

  if Weapon_Vars.Headshots_Kill then
    WeaponService.Weapons.SG09R.Stats.HG_CritRate = 100
    WeaponService.Weapons.SG09R.Stats.HG_CritRateEX = 100
    WeaponService.Weapons.PUN.Stats.HG_CritRate = 100
    WeaponService.Weapons.PUN.Stats.HG_CritRateEX = 100
    WeaponService.Weapons.RED9.Stats.HG_CritRate = 100
    WeaponService.Weapons.RED9.Stats.HG_CritRateEX = 100
    WeaponService.Weapons.BT.Stats.HG_CritRate = 100
    WeaponService.Weapons.BT.Stats.HG_CritRateEX = 100
    WeaponService.Weapons.VP70.Stats.HG_CritRate = 100
    WeaponService.Weapons.VP70.Stats.HG_CritRateEX = 100
    WeaponService.Weapons.SEN9.Stats.HG_CritRate = 100
    WeaponService.Weapons.SEN9.Stats.HG_CritRateEX = 100
    WeaponService.Weapons.M870.Stats.SG_Center_CritRate = 100
    WeaponService.Weapons.M870.Stats.SG_Center_CritRate_EX = 100
    WeaponService.Weapons.M870.Stats.SG_Around_CritRate = 100
    WeaponService.Weapons.M870.Stats.SG_Around_CritRate_EX = 100
    WeaponService.Weapons.BM4.Stats.SG_Center_CritRate = 100
    WeaponService.Weapons.BM4.Stats.SG_Center_CritRate_EX = 100
    WeaponService.Weapons.BM4.Stats.SG_Around_CritRate = 100
    WeaponService.Weapons.BM4.Stats.SG_Around_CritRate_EX = 100
    WeaponService.Weapons.STKR.Stats.SG_Center_CritRate = 100
    WeaponService.Weapons.STKR.Stats.SG_Center_CritRate_EX = 100
    WeaponService.Weapons.STKR.Stats.SG_Around_CritRate = 100
    WeaponService.Weapons.STKR.Stats.SG_Around_CritRate_EX = 100
    WeaponService.Weapons.SKUL.Stats.SG_Center_CritRate = 100
    WeaponService.Weapons.SKUL.Stats.SG_Center_CritRate_EX = 100
    WeaponService.Weapons.SKUL.Stats.SG_Around_CritRate = 100
    WeaponService.Weapons.SKUL.Stats.SG_Around_CritRate_EX = 100
    WeaponService.Weapons.TMP.Stats.HG_CritRate = 100
    WeaponService.Weapons.TMP.Stats.HG_CritRateEX = 100
    WeaponService.Weapons.CTW.Stats.HG_CritRate = 100
    WeaponService.Weapons.CTW.Stats.HG_CritRateEX = 100
    WeaponService.Weapons.LE5.Stats.HG_CritRate = 100
    WeaponService.Weapons.LE5.Stats.HG_CritRateEX = 100
    WeaponService.Weapons.M1G.Stats.HG_CritRate = 100
    WeaponService.Weapons.M1G.Stats.HG_CritRateEX = 100
    WeaponService.Weapons.SAR.Stats.HG_CritRate = 100
    WeaponService.Weapons.SAR.Stats.HG_CritRateEX = 100
    WeaponService.Weapons.CQBR.Stats.HG_CritRate = 100
    WeaponService.Weapons.CQBR.Stats.HG_CritRateEX = 100
    WeaponService.Weapons.BRB.Stats.HG_CritRate = 100
    WeaponService.Weapons.BRB.Stats.HG_CritRateEX = 100
    WeaponService.Weapons.KIL7.Stats.HG_CritRate = 100
    WeaponService.Weapons.KIL7.Stats.HG_CritRateEX = 100
    WeaponService.Weapons.HNDC.Stats.HG_CritRate = 100
    WeaponService.Weapons.HNDC.Stats.HG_CritRateEX = 100
  end

  ----/// SLUGS TREE ///-----
  if Weapon_Vars.BM4_Slug then
    WeaponService.Weapons.BM4.Stats.ReticleType = 1
    WeaponService.Weapons.BM4.Stats.SG_Center_Random = 0.003
    WeaponService.Weapons.BM4.Stats.SG_Center_RandomFit = 0.003
    WeaponService.Weapons.BM4.Stats.SG_AroundBulletCount = 0
    WeaponService.Weapons.BM4.Stats.SG_CenterLife_Distance = 300
    WeaponService.Weapons.BM4.Stats.SG_Center_BaseDMG = 1.25
    WeaponService.Weapons.BM4.Stats.DMG_LVL_01_INFO = "8.00"
    WeaponService.Weapons.BM4.Stats.DMG_LVL_02_INFO = "9.6"
    WeaponService.Weapons.BM4.Stats.DMG_LVL_03_INFO = "11.2"
    WeaponService.Weapons.BM4.Stats.DMG_LVL_04_INFO = "12.8"
    WeaponService.Weapons.BM4.Stats.DMG_LVL_05_INFO = "14.4"
    WeaponService.Weapons.BM4.Stats.DMG_LVL_02 = 1.5
    WeaponService.Weapons.BM4.Stats.DMG_LVL_03 = 1.75
    WeaponService.Weapons.BM4.Stats.DMG_LVL_04 = 2.0
    WeaponService.Weapons.BM4.Stats.DMG_LVL_05 = 2.25
  end

  if Weapon_Vars.M870_Slug then
    WeaponService.Weapons.M870.Stats.ReticleType = 1
    WeaponService.Weapons.M870.Stats.SG_Center_Random = 0.003
    WeaponService.Weapons.M870.Stats.SG_Center_RandomFit = 0.003
    WeaponService.Weapons.M870.Stats.SG_AroundBulletCount = 0
    WeaponService.Weapons.M870.Stats.SG_CenterLife_Distance = 300
    WeaponService.Weapons.M870.Stats.SG_Center_BaseDMG = 1.25
    WeaponService.Weapons.M870.Stats.DMG_LVL_01_INFO = "7.00"
    WeaponService.Weapons.M870.Stats.DMG_LVL_02_INFO = "8.40"
    WeaponService.Weapons.M870.Stats.DMG_LVL_03_INFO = "9.80"
    WeaponService.Weapons.M870.Stats.DMG_LVL_04_INFO = "11.20"
    WeaponService.Weapons.M870.Stats.DMG_LVL_05_INFO = "12.60"
    WeaponService.Weapons.M870.Stats.DMG_LVL_02 = 1.5
    WeaponService.Weapons.M870.Stats.DMG_LVL_03 = 1.75
    WeaponService.Weapons.M870.Stats.DMG_LVL_04 = 2.0
    WeaponService.Weapons.M870.Stats.DMG_LVL_05 = 2.25
  end

  if Weapon_Vars.SKUL_Slug then
    WeaponService.Weapons.SKUL.Stats.ReticleType = 1
    WeaponService.Weapons.SKUL.Stats.SG_Center_Random = 0.003
    WeaponService.Weapons.SKUL.Stats.SG_Center_RandomFit = 0.003
    WeaponService.Weapons.SKUL.Stats.SG_AroundBulletCount = 0
    WeaponService.Weapons.SKUL.Stats.SG_CenterLife_Distance = 300
    WeaponService.Weapons.SKUL.Stats.SG_Center_BaseDMG = 1.25
    WeaponService.Weapons.SKUL.Stats.DMG_LVL_01_INFO = "6.75"
    WeaponService.Weapons.SKUL.Stats.DMG_LVL_02_INFO = "8.10"
    WeaponService.Weapons.SKUL.Stats.DMG_LVL_03_INFO = "9.45"
    WeaponService.Weapons.SKUL.Stats.DMG_LVL_04_INFO = "10.80"
    WeaponService.Weapons.SKUL.Stats.DMG_LVL_05_INFO = "12.15"
    WeaponService.Weapons.SKUL.Stats.DMG_LVL_02 = 1.5
    WeaponService.Weapons.SKUL.Stats.DMG_LVL_03 = 1.75
    WeaponService.Weapons.SKUL.Stats.DMG_LVL_04 = 2.0
    WeaponService.Weapons.SKUL.Stats.DMG_LVL_05 = 2.25
  end

  if Weapon_Vars.STKR_Slug then
    WeaponService.Weapons.STKR.Stats.ReticleType = 1
    WeaponService.Weapons.STKR.Stats.SG_Center_Random = 0.003
    WeaponService.Weapons.STKR.Stats.SG_Center_RandomFit = 0.003
    WeaponService.Weapons.STKR.Stats.SG_AroundBulletCount = 0
    WeaponService.Weapons.STKR.Stats.SG_CenterLife_Distance = 300
    WeaponService.Weapons.STKR.Stats.SG_Center_BaseDMG = 1.25
    WeaponService.Weapons.STKR.Stats.DMG_LVL_01_INFO = "11.25"
    WeaponService.Weapons.STKR.Stats.DMG_LVL_02_INFO = "13.50"
    WeaponService.Weapons.STKR.Stats.DMG_LVL_03_INFO = "15.75"
    WeaponService.Weapons.STKR.Stats.DMG_LVL_04_INFO = "18.00"
    WeaponService.Weapons.STKR.Stats.DMG_LVL_05_INFO = "20.25"
    WeaponService.Weapons.STKR.Stats.DMG_LVL_02 = 1.5
    WeaponService.Weapons.STKR.Stats.DMG_LVL_03 = 1.75
    WeaponService.Weapons.STKR.Stats.DMG_LVL_04 = 2.0
    WeaponService.Weapons.STKR.Stats.DMG_LVL_05 = 2.25
  end

  -----/// OG Options TREE ///-----
  if Weapon_Vars.HNDC_DMG then
    WeaponService.Weapons.HNDC.Stats.HG_BaseDMG = 2.775
    WeaponService.Weapons.HNDC.Stats.DMG_LVL_02 = 4.166667
    WeaponService.Weapons.HNDC.Stats.DMG_LVL_03 = 5.55
    WeaponService.Weapons.HNDC.Stats.DMG_LVL_04 = 6.9375
    WeaponService.Weapons.HNDC.Stats.DMG_LVL_05 = 8.325
    WeaponService.Weapons.HNDC.Stats.DMG_LVL_01_INFO = "33.3"
    WeaponService.Weapons.HNDC.Stats.DMG_LVL_02_INFO = "50.0"
    WeaponService.Weapons.HNDC.Stats.DMG_LVL_03_INFO = "66.6"
    WeaponService.Weapons.HNDC.Stats.DMG_LVL_04_INFO = "83.25"
    WeaponService.Weapons.HNDC.Stats.DMG_LVL_05_INFO = "99.9"
  end

  if Weapon_Vars.OG_WINCE then
    WeaponService.Weapons.SG09R.Stats.HG_BaseWINC = 10.0
    WeaponService.Weapons.PUN.Stats.HG_BaseWINC = 10.0
    WeaponService.Weapons.RED9.Stats.HG_BaseWINC = 10.0
    WeaponService.Weapons.BT.Stats.HG_BaseWINC = 10.0
    WeaponService.Weapons.VP70.Stats.HG_BaseWINC = 10.0
    WeaponService.Weapons.SEN9.Stats.HG_BaseWINC = 10.0
    WeaponService.Weapons.M870.Stats.HG_BaseWINC = 10.0
    WeaponService.Weapons.BM4.Stats.HG_BaseWINC = 10.0
    WeaponService.Weapons.STKR.Stats.HG_BaseWINC = 10.0
    WeaponService.Weapons.SKUL.Stats.HG_BaseWINC = 10.0
    WeaponService.Weapons.TMP.Stats.HG_BaseWINC = 10.0
    WeaponService.Weapons.CTW.Stats.HG_BaseWINC = 10.0
    WeaponService.Weapons.LE5.Stats.HG_BaseWINC = 10.0
    WeaponService.Weapons.M1G.Stats.HG_BaseWINC = 10.0
    WeaponService.Weapons.SAR.Stats.HG_BaseWINC = 10.0
    WeaponService.Weapons.CQBR.Stats.HG_BaseWINC = 10.0
    WeaponService.Weapons.BRB.Stats.HG_BaseWINC = 10.0
    WeaponService.Weapons.KIL7.Stats.HG_BaseWINC = 10.0
    WeaponService.Weapons.HNDC.Stats.HG_BaseWINC = 10.0
  end

  -----/// MISC TREE ///-----
  if Weapon_Vars.No_Reticles then
    WeaponService.Weapons.SG09R.Stats.ReticleType = 100000
    WeaponService.Weapons.PUN.Stats.ReticleType = 100000
    WeaponService.Weapons.RED9.Stats.ReticleType = 100000
    WeaponService.Weapons.BT.Stats.ReticleType = 100000
    WeaponService.Weapons.VP70.Stats.ReticleType = 100000
    WeaponService.Weapons.SEN9.Stats.ReticleType = 100000
    WeaponService.Weapons.M870.Stats.ReticleType = 100000
    WeaponService.Weapons.BM4.Stats.ReticleType = 100000
    WeaponService.Weapons.STKR.Stats.ReticleType = 100000
    WeaponService.Weapons.SKUL.Stats.ReticleType = 100000
    WeaponService.Weapons.TMP.Stats.ReticleType = 100000
    WeaponService.Weapons.CTW.Stats.ReticleType = 100000
    WeaponService.Weapons.LE5.Stats.ReticleType = 100000
    WeaponService.Weapons.M1G.Stats.ReticleType = 100000
    WeaponService.Weapons.SAR.Stats.ReticleType = 100000
    WeaponService.Weapons.CQBR.Stats.ReticleType = 100000
    WeaponService.Weapons.BRB.Stats.ReticleType = 100000
    WeaponService.Weapons.KIL7.Stats.ReticleType = 100000
    WeaponService.Weapons.HNDC.Stats.ReticleType = 100000
  end

  if Weapon_Vars.CQBR_Smg then
    WeaponService.Weapons.CQBR.Stats.AmmoType = 112806400
  end

  if Weapon_Vars.Kil7_HG then
    WeaponService.Weapons.KIL7.Stats.AmmoType = 112800000
  end

  if Weapon_Vars.BRB_HG then
    WeaponService.Weapons.BRB.Stats.AmmoType = 112800000
  end

  if Weapon_Vars.HNDC_HG then
    WeaponService.Weapons.HNDC.Stats.AmmoType = 112800000
  end

  if Weapon_Vars.Durable_Knives then
    WeaponService.Weapons.CMBT.Stats.DurDEF_Max = 9999
    WeaponService.Weapons.CMBT.Stats.DurSLD_Max = 9999
    WeaponService.Weapons.CMBT.Stats.Dur_LVL_01_MAX = 9999
    WeaponService.Weapons.CMBT.Stats.Dur_LVL_01_MAX_INFO = "9999"
    WeaponService.Weapons.CMBT.Stats.Dur_LVL_02_MAX = 9999
    WeaponService.Weapons.CMBT.Stats.Dur_LVL_02_MAX_INFO  = "9999"
    WeaponService.Weapons.CMBT.Stats.Dur_LVL_03_MAX = 9999
    WeaponService.Weapons.CMBT.Stats.Dur_LVL_03_MAX_INFO = "9999"
    WeaponService.Weapons.CMBT.Stats.Dur_LVL_04_MAX = 9999
    WeaponService.Weapons.CMBT.Stats.Dur_LVL_04_MAX_INFO = "9999"
    WeaponService.Weapons.CMBT.Stats.Dur_LVL_05_MAX = 9999
    WeaponService.Weapons.CMBT.Stats.Dur_LVL_05_MAX_INFO = "9999"

    WeaponService.Weapons.FIGHT.Stats.DurDEF_Max = 9999
    WeaponService.Weapons.FIGHT.Stats.DurSLD_Max = 9999
    WeaponService.Weapons.FIGHT.Stats.Dur_LVL_01_MAX = 9999
    WeaponService.Weapons.FIGHT.Stats.Dur_LVL_01_MAX_INFO = "9999"
    WeaponService.Weapons.FIGHT.Stats.Dur_LVL_02_MAX = 9999
    WeaponService.Weapons.FIGHT.Stats.Dur_LVL_02_MAX_INFO = "9999"
    WeaponService.Weapons.FIGHT.Stats.Dur_LVL_03_MAX = 9999
    WeaponService.Weapons.FIGHT.Stats.Dur_LVL_03_MAX_INFO = "9999"
    WeaponService.Weapons.FIGHT.Stats.Dur_LVL_04_MAX = 9999
    WeaponService.Weapons.FIGHT.Stats.Dur_LVL_04_MAX_INFO = "9999"
    WeaponService.Weapons.FIGHT.Stats.Dur_LVL_05_MAX = 9999
    WeaponService.Weapons.FIGHT.Stats.Dur_LVL_05_MAX_INFO = "9999"

    WeaponService.Weapons.PRIM.Stats.DurDEF_Max = 9999
    WeaponService.Weapons.PRIM.Stats.DurSLD_Max = 9999
    WeaponService.Weapons.PRIM.Stats.Dur_LVL_01_MAX = 9999
    WeaponService.Weapons.PRIM.Stats.Dur_LVL_01_MAX_INFO = "9999"
    WeaponService.Weapons.PRIM.Stats.Dur_LVL_02_MAX = 9999
    WeaponService.Weapons.PRIM.Stats.Dur_LVL_02_MAX_INFO = "9999"
    WeaponService.Weapons.PRIM.Stats.Dur_LVL_03_MAX = 9999
    WeaponService.Weapons.PRIM.Stats.Dur_LVL_03_MAX_INFO = "9999"
    WeaponService.Weapons.PRIM.Stats.Dur_LVL_04_MAX = 9999
    WeaponService.Weapons.PRIM.Stats.Dur_LVL_04_MAX_INFO = "9999"
    WeaponService.Weapons.PRIM.Stats.Dur_LVL_05_MAX = 9999
    WeaponService.Weapons.PRIM.Stats.Dur_LVL_05_MAX_INFO = "9999"
  end

  if Weapon_Vars.Free_Knife_Repairs then
    WeaponService.Weapons.CMBT.Stats.Repair_Cost = 0
    WeaponService.Weapons.CMBT.Stats.Polish_Cost = 0
    WeaponService.Weapons.FIGHT.Stats.Repair_Cost = 0
    WeaponService.Weapons.FIGHT.Stats.Polish_Cost = 0
    WeaponService.Weapons.PRIM.Stats.Repair_Cost = 0
    WeaponService.Weapons.PRIM.Stats.Polish_Cost = 0
  end
end

local function apply_changes()
  json.dump_file("DWP\\Saved.json", Weapon_Vars)

  SetWeapon_DMGValues()
  WeaponService.apply_all_weapon_stats()
end

local function draw_profile_editor_ui()
  imgui.set_next_window_size({550, 1000}, 8)
  local stayOpen = imgui.begin_window("Profile Editor", show_profile_editor, 0)
  if not stayOpen then
    show_profile_editor = false
  end

  imgui.text("Changing fields provides a live preview. \nSave Changes button saves changes to the selected profile.")

  imgui.new_line()

  selectedProfileChanged, Weapon_Vars.Selected_Profile = imgui.combo("Weapon Profile", Weapon_Vars.Selected_Profile, Weapon_Vars.Weapon_Profiles)
  changed, Selected_Weapon = imgui.combo("Weapon", Selected_Weapon, Available_Weapons)

  if selectedProfileChanged then
    apply_changes()
  end

  local currentWeapon = nil

  if Selected_Weapon == 1 then
    currentWeapon = WeaponService.Weapons.SG09R
  elseif Selected_Weapon == 2 then
    currentWeapon = WeaponService.Weapons.PUN
  elseif Selected_Weapon == 3 then
    currentWeapon = WeaponService.Weapons.RED9
  elseif Selected_Weapon == 4 then
    currentWeapon = WeaponService.Weapons.BT
  elseif Selected_Weapon == 5 then
    currentWeapon = WeaponService.Weapons.VP70
  elseif Selected_Weapon == 6 then
    currentWeapon = WeaponService.Weapons.SEN9
  elseif Selected_Weapon == 7 then
    currentWeapon = WeaponService.Weapons.M870
  elseif Selected_Weapon == 8 then
    currentWeapon = WeaponService.Weapons.BM4
  elseif Selected_Weapon == 9 then
    currentWeapon = WeaponService.Weapons.STKR
  elseif Selected_Weapon == 10 then
    currentWeapon = WeaponService.Weapons.SKUL
  elseif Selected_Weapon == 11 then
    currentWeapon = WeaponService.Weapons.TMP
  elseif Selected_Weapon == 12 then
    currentWeapon = WeaponService.Weapons.CTW
  elseif Selected_Weapon == 13 then
    currentWeapon = WeaponService.Weapons.LE5
  elseif Selected_Weapon == 14 then
    currentWeapon = WeaponService.Weapons.M1G
  elseif Selected_Weapon == 15 then
    currentWeapon = WeaponService.Weapons.SAR
  elseif Selected_Weapon == 16 then
    currentWeapon = WeaponService.Weapons.CQBR
  elseif Selected_Weapon == 17 then
    currentWeapon = WeaponService.Weapons.BRB
  elseif Selected_Weapon == 18 then
    currentWeapon = WeaponService.Weapons.KIL7
  elseif Selected_Weapon == 19 then
    currentWeapon = WeaponService.Weapons.HNDC
  end

  imgui.new_line()

  if imgui.tree_node("General") then
    -- ItemSize
    ItemSizeChanged, updatedItemSize = imgui.input_text("ItemSize", currentWeapon.Stats.ItemSize, 1)
    if ItemSizeChanged then
      currentWeapon.Stats.ItemSize = tonumber(updatedItemSize)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    -- AmmoType
    AmmoTypeChanged, updatedAmmoType = imgui.input_text("Ammo Type", currentWeapon.Stats.AmmoType, 1)
    if AmmoTypeChanged then
      currentWeapon.Stats.AmmoType = tonumber(updatedAmmoType)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    -- ReticleType
    ReticleTypeChanged, updatedReticleType = imgui.input_text("Reticle Type", currentWeapon.Stats.ReticleType, 1)
    if ReticleTypeChanged then
      currentWeapon.Stats.ReticleType = tonumber(updatedReticleType)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end
    imgui.tree_pop()
  end

  if (currentWeapon.Type == "HG") or (currentWeapon.Type== "SMG") or (currentWeapon.Type== "SR") or 
     (currentWeapon.Type== "SR_PUMP") or (currentWeapon.Type== "MAG") or (currentWeapon.Type== "MAG_SEMI") then
    if imgui.tree_node("HG General") then
      -- HG_Distance 
      HG_DistanceChanged, updatedHG_Distance = imgui.input_text("HG Distance", currentWeapon.Stats.HG_Distance, 1)
      if HG_DistanceChanged then
        currentWeapon.Stats.HG_Distance = tonumber(updatedHG_Distance)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      imgui.new_line()

      -- SMG_Random
      SMG_RandomChanged, updatedSMG_Random = imgui.input_text("SMG Random", currentWeapon.Stats.SMG_Random, 1)
      if SMG_RandomChanged then
        currentWeapon.Stats.SMG_Random = tonumber(updatedSMG_Random)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- SMG_RandomFit
      SMG_RandomFitChanged, updatedSMG_RandomFit = imgui.input_text("SMG Random Fit", currentWeapon.Stats.SMG_RandomFit, 1)
      if SMG_RandomFitChanged then
        currentWeapon.Stats.SMG_RandomFit = tonumber(updatedSMG_RandomFit)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      imgui.new_line()

      -- HG_CritRate
      HG_CritRateChanged, updatedHG_CritRate = imgui.input_text("HG Crit Rate", currentWeapon.Stats.HG_CritRate, 1)
      if HG_CritRateChanged then
        currentWeapon.Stats.HG_CritRate = tonumber(updatedHG_CritRate)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- HG_CritRateEX
      HG_CritRateEXChanged, updatedHG_CritRateEX = imgui.input_text("HG Crit Rate EX", currentWeapon.Stats.HG_CritRateEX, 1)
      if HG_CritRateEXChanged then
        currentWeapon.Stats.HG_CritRateEX = tonumber(updatedHG_CritRateEX)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end
      imgui.tree_pop()
    end

    if imgui.tree_node("Focus") then
      -- Focus_HoldAdd
      Focus_HoldAddChanged, updatedFocus_HoldAdd = imgui.input_text("Focus Hold Add", currentWeapon.Stats.Focus_HoldAdd, 1)
      if Focus_HoldAddChanged then
        currentWeapon.Stats.Focus_HoldAdd = tonumber(updatedFocus_HoldAdd)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- Focus_MoveSub
      Focus_MoveSubChanged, updatedFocus_MoveSub = imgui.input_text("Focus Move Sub", currentWeapon.Stats.Focus_MoveSub, 1)
      if Focus_MoveSubChanged then
        currentWeapon.Stats.Focus_MoveSub = tonumber(updatedFocus_MoveSub)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- Focus_CamSub
      Focus_CamSubChanged, updatedFocus_CamSub = imgui.input_text("Focus Cam Sub", currentWeapon.Stats.Focus_CamSub, 1)
      if Focus_CamSubChanged then
        currentWeapon.Stats.Focus_CamSub = tonumber(updatedFocus_CamSub)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- Focus_Limit
      Focus_LimitChanged, updatedFocus_Limit = imgui.input_text("Focus Limit", currentWeapon.Stats.Focus_Limit, 1)
      if Focus_LimitChanged then
        currentWeapon.Stats.Focus_Limit = tonumber(updatedFocus_Limit)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end
      -- Focus_ShootSub
      Focus_ShootSubChanged, updatedFocus_ShootSub = imgui.input_text("Focus Shoot Sub", currentWeapon.Stats.Focus_ShootSub, 1)
      if Focus_ShootSubChanged then
        currentWeapon.Stats.Focus_ShootSub = tonumber(updatedFocus_ShootSub)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end
      imgui.tree_pop()
    end

    if imgui.tree_node("Recoil") then
      -- Recoil_YawMin
      Recoil_YawMinChanged, updatedRecoil_YawMin = imgui.input_text("Recoil Yaw Min", currentWeapon.Stats.Recoil_YawMin, 1)
      if Recoil_YawMinChanged then
        currentWeapon.Stats.Recoil_YawMin = tonumber(updatedRecoil_YawMin)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- Recoil_YawMax
      Recoil_YawMaxChanged, updatedRecoil_YawMax = imgui.input_text("Recoil Yaw Max", currentWeapon.Stats.Recoil_YawMax, 1)
      if Recoil_YawMaxChanged then
        currentWeapon.Stats.Recoil_YawMax = tonumber(updatedRecoil_YawMax)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- Recoil_PitchMin
      Recoil_PitchMinChanged, updatedRecoil_PitchMin = imgui.input_text("Recoil Pitch Min", currentWeapon.Stats.Recoil_PitchMin, 1)
      if Recoil_PitchMinChanged then
        currentWeapon.Stats.Recoil_PitchMin = tonumber(updatedRecoil_PitchMin)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- Recoil_PitchMax
      Recoil_PitchMaxChanged, updatedRecoil_PitchMax = imgui.input_text("Recoil Pitch Max", currentWeapon.Stats.Recoil_PitchMax, 1)
      if Recoil_PitchMaxChanged then
        currentWeapon.Stats.Recoil_PitchMax = tonumber(updatedRecoil_PitchMax)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end
      imgui.tree_pop()
    end
  end

  if (currentWeapon.Type== "SG") or (currentWeapon.Type== "SG_PUMP") then
    if imgui.tree_node("Center Pellet Settings") then
      -- SG_CenterLife_Distance
      SG_CenterLife_DistanceChanged, updatedSG_CenterLife_Distance = imgui.input_text("SG Center Life Distance", currentWeapon.Stats.SG_CenterLife_Distance, 1)
      if SG_CenterLife_DistanceChanged then
        currentWeapon.Stats.SG_CenterLife_Distance = tonumber(updatedSG_CenterLife_Distance)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- SG_CenterMove_Speed
      SG_CenterMove_SpeedChanged, updatedSG_CenterMove_Speed = imgui.input_text("SG Center Move Speed", currentWeapon.Stats.SG_CenterMove_Speed, 1)
      if SG_CenterMove_SpeedChanged then
        currentWeapon.Stats.SG_CenterMove_Speed = tonumber(updatedSG_CenterMove_Speed)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- SG_CenterMove_IGD
      SG_CenterMove_IGDChanged, updatedSG_CenterMove_IGD = imgui.input_text("SG Center Move IGD", currentWeapon.Stats.SG_CenterMove_IGD, 1)
      if SG_CenterMove_IGDChanged then
        currentWeapon.Stats.SG_CenterMove_IGD = tonumber(updatedSG_CenterMove_IGD)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- SG_Center_BulletCol
      SG_Center_BulletColChanged, updatedSG_Center_BulletCol = imgui.input_text("SG Center Bullet Col", currentWeapon.Stats.SG_Center_BulletCol, 1)
      if SG_Center_BulletColChanged then
        currentWeapon.Stats.SG_Center_BulletCol = tonumber(updatedSG_Center_BulletCol)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- SG_Center_Random
      SG_Center_RandomChanged, updatedSG_Center_Random = imgui.input_text("SG Center Random", currentWeapon.Stats.SG_Center_Random, 1)
      if SG_Center_RandomChanged then
        currentWeapon.Stats.SG_Center_Random = tonumber(updatedSG_Center_Random)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- SG_Center_RandomFit
      SG_Center_RandomFitChanged, updatedSG_Center_RandomFit = imgui.input_text("SG Center Random Fit", currentWeapon.Stats.SG_Center_RandomFit, 1)
      if SG_Center_RandomFitChanged then
        currentWeapon.Stats.SG_Center_RandomFit = tonumber(updatedSG_Center_RandomFit)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- SG_Center_CritRate
      SG_Center_CritRateChanged, updatedSG_Center_CritRate = imgui.input_text("SG Center Crit Rate", currentWeapon.Stats.SG_Center_CritRate, 1)
      if SG_Center_CritRateChanged then
        currentWeapon.Stats.SG_Center_CritRate = tonumber(updatedSG_Center_CritRate)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- SG_Center_CritRate_EX
      SG_Center_CritRate_EXChanged, updatedSG_Center_CritRate_EX = imgui.input_text("SG Center Crit Rate EX", currentWeapon.Stats.SG_Center_CritRate_EX, 1)
      if SG_Center_CritRate_EXChanged then
        currentWeapon.Stats.SG_Center_CritRate_EX = tonumber(updatedSG_Center_CritRate_EX)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- SG_Center_BaseDMG
      SG_Center_BaseDMGChanged, updatedSG_Center_BaseDMG = imgui.input_text("SG Center Base DMG", currentWeapon.Stats.SG_Center_BaseDMG, 1)
      if SG_Center_BaseDMGChanged then
        currentWeapon.Stats.SG_Center_BaseDMG = tonumber(updatedSG_Center_BaseDMG)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- SG_Center_BaseWINC
      SG_Center_BaseWINCChanged, updatedSG_Center_BaseWINC = imgui.input_text("SG Center Base WINC", currentWeapon.Stats.SG_Center_BaseWINC, 1)
      if SG_Center_BaseWINCChanged then
        currentWeapon.Stats.SG_Center_BaseWINC = tonumber(updatedSG_Center_BaseWINC)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- SG_Center_BaseBRK
      SG_Center_BaseBRKChanged, updatedSG_Center_BaseBRK = imgui.input_text("SG Center Base BRK", currentWeapon.Stats.SG_Center_BaseBRK, 1)
      if SG_Center_BaseBRKChanged then
        currentWeapon.Stats.SG_Center_BaseBRK = tonumber(updatedSG_Center_BaseBRK)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- SG_Center_BaseSTOP
      SG_Center_BaseSTOPChanged, updatedSG_Center_BaseSTOP = imgui.input_text("SG Center Base STOP", currentWeapon.Stats.SG_Center_BaseSTOP, 1)
      if SG_Center_BaseSTOPChanged then
        currentWeapon.Stats.SG_Center_BaseSTOP = tonumber(updatedSG_Center_BaseSTOP)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end
      imgui.tree_pop()
    end

    if imgui.tree_node("Around Pellet Settings") then
      -- SG_AroundLife_Distance
      SG_AroundLife_DistanceChanged, updatedSG_AroundLife_Distance = imgui.input_text("SG Around Life Distance", currentWeapon.Stats.SG_AroundLife_Distance, 1)
      if SG_AroundLife_DistanceChanged then
        currentWeapon.Stats.SG_AroundLife_Distance = tonumber(updatedSG_AroundLife_Distance)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- SG_AroundMove_Speed
      SG_AroundMove_SpeedChanged, updatedSG_AroundMove_Speed = imgui.input_text("SG Around Move Speed", currentWeapon.Stats.SG_AroundMove_Speed, 1)
      if SG_AroundMove_SpeedChanged then
        currentWeapon.Stats.SG_AroundMove_Speed = tonumber(updatedSG_AroundMove_Speed)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- SG_AroundMove_IGD
      SG_AroundMove_IGDChanged, updatedSG_AroundMove_IGD = imgui.input_text("SG Around Move IGD", currentWeapon.Stats.SG_AroundMove_IGD, 1)
      if SG_AroundMove_IGDChanged then
        currentWeapon.Stats.SG_AroundMove_IGD = tonumber(updatedSG_AroundMove_IGD)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- SG_Around_BulletCol
      SG_Around_BulletColChanged, updatedSG_Around_BulletCol = imgui.input_text("SG Around Bullet Col", currentWeapon.Stats.SG_Around_BulletCol, 1)
      if SG_Around_BulletColChanged then
        currentWeapon.Stats.SG_Around_BulletCol = tonumber(updatedSG_Around_BulletCol)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- SG_Around_Random
      SG_Around_RandomChanged, updatedSG_Around_Random = imgui.input_text("SG Around Random", currentWeapon.Stats.SG_Around_Random, 1)
      if SG_Around_RandomChanged then
        currentWeapon.Stats.SG_Around_Random = tonumber(updatedSG_Around_Random)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- SG_Around_RandomFit
      SG_Around_RandomFitChanged, updatedSG_Around_RandomFit = imgui.input_text("SG Around Random Fit", currentWeapon.Stats.SG_Around_RandomFit, 1)
      if SG_Around_RandomFitChanged then
        currentWeapon.Stats.SG_Around_RandomFit = tonumber(updatedSG_Around_RandomFit)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- SG_Around_CritRate
      SG_Around_CritRateChanged, updatedSG_Around_CritRate = imgui.input_text("SG Around Crit Rate", currentWeapon.Stats.SG_Around_CritRate, 1)
      if SG_Around_CritRateChanged then
        currentWeapon.Stats.SG_Around_CritRate = tonumber(updatedSG_Around_CritRate)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- SG_Around_CritRate_EX
      SG_Around_CritRate_EXChanged, updatedSG_Around_CritRate_EX = imgui.input_text("SG Around Crit Rate EX", currentWeapon.Stats.SG_Around_CritRate_EX, 1)
      if SG_Around_CritRate_EXChanged then
        currentWeapon.Stats.SG_Around_CritRate_EX = tonumber(updatedSG_Around_CritRate_EX)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- SG_Around_BaseDMG
      SG_Around_BaseDMGChanged, updatedSG_Around_BaseDMG = imgui.input_text("SG Around Base DMG", currentWeapon.Stats.SG_Around_BaseDMG, 1)
      if SG_Around_BaseDMGChanged then
        currentWeapon.Stats.SG_Around_BaseDMG = tonumber(updatedSG_Around_BaseDMG)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- SG_Around_BaseWINC
      SG_Around_BaseWINCChanged, updatedSG_Around_BaseWINC = imgui.input_text("SG Around Base WINC", currentWeapon.Stats.SG_Around_BaseWINC, 1)
      if SG_Around_BaseWINCChanged then
        currentWeapon.Stats.SG_Around_BaseWINC = tonumber(updatedSG_Around_BaseWINC)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- SG_Around_BaseBRK
      SG_Around_BaseBRKChanged, updatedSG_Around_BaseBRK = imgui.input_text("SG Around Base BRK", currentWeapon.Stats.SG_Around_BaseBRK, 1)
      if SG_Around_BaseBRKChanged then
        currentWeapon.Stats.SG_Around_BaseBRK = tonumber(updatedSG_Around_BaseBRK)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- SG_Around_BaseSTOP
      SG_Around_BaseSTOPChanged, updatedSG_Around_BaseSTOP = imgui.input_text("SG Around Base STOP", currentWeapon.Stats.SG_Around_BaseSTOP, 1)
      if SG_Around_BaseSTOPChanged then
        currentWeapon.Stats.SG_Around_BaseSTOP = tonumber(updatedSG_Around_BaseSTOP)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- SG_AroundBulletCount
      SG_AroundBulletCountChanged, updatedSG_AroundBulletCount = imgui.input_text("SG Around Bullet Count", currentWeapon.Stats.SG_AroundBulletCount, 1)
      if SG_AroundBulletCountChanged then
        currentWeapon.Stats.SG_AroundBulletCount = tonumber(updatedSG_AroundBulletCount)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- SG_CenterBulletCount
      SG_CenterBulletCountChanged, updatedSG_CenterBulletCount = imgui.input_text("SG Center Bullet Count", currentWeapon.Stats.SG_CenterBulletCount, 1)
      if SG_CenterBulletCountChanged then
        currentWeapon.Stats.SG_CenterBulletCount = tonumber(updatedSG_CenterBulletCount)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- SG_InnerRadius
      SG_InnerRadiusChanged, updatedSG_InnerRadius = imgui.input_text("SG Inner Radius", currentWeapon.Stats.SG_InnerRadius, 1)
      if SG_InnerRadiusChanged then
        currentWeapon.Stats.SG_InnerRadius = tonumber(updatedSG_InnerRadius)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- SG_OuterRadius
      SG_OuterRadiusChanged, updatedSG_OuterRadius = imgui.input_text("SG Outer Radius", currentWeapon.Stats.SG_OuterRadius, 1)
      if SG_OuterRadiusChanged then
        currentWeapon.Stats.SG_OuterRadius = tonumber(updatedSG_OuterRadius)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- SG_AroundVertMin
      SG_AroundVertMinChanged, updatedSG_AroundVertMin = imgui.input_text("SG Around Vert Min", currentWeapon.Stats.SG_AroundVertMin, 1)
      if SG_AroundVertMinChanged then
        currentWeapon.Stats.SG_AroundVertMin = tonumber(updatedSG_AroundVertMin)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- SG_AroundVertMax
      SG_AroundVertMaxChanged, updatedSG_AroundVertMax = imgui.input_text("SG Around Vert Max", currentWeapon.Stats.SG_AroundVertMax, 1)
      if SG_AroundVertMaxChanged then
        currentWeapon.Stats.SG_AroundVertMax = tonumber(updatedSG_AroundVertMax)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- SG_AroundHorMin
      SG_AroundHorMinChanged, updatedSG_AroundHorMin = imgui.input_text("SG Around Hor Min", currentWeapon.Stats.SG_AroundHorMin, 1)
      if SG_AroundHorMinChanged then
        currentWeapon.Stats.SG_AroundHorMin = tonumber(updatedSG_AroundHorMin)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- SG_AroundHorMax
      SG_AroundHorMaxChanged, updatedSG_AroundHorMax = imgui.input_text("SG Around Hor Max", currentWeapon.Stats.SG_AroundHorMax, 1)
      if SG_AroundHorMaxChanged then
        currentWeapon.Stats.SG_AroundHorMax = tonumber(updatedSG_AroundHorMax)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end
      imgui.tree_pop()
    end
  end

  if imgui.tree_node("Damage") then
    -- HG_BaseDMG
    HG_BaseDMGChanged, updatedHG_BaseDMG = imgui.input_text("HG Base DMG", currentWeapon.Stats.HG_BaseDMG, 1)
    if HG_BaseDMGChanged then
      currentWeapon.Stats.HG_BaseDMG = tonumber(updatedHG_BaseDMG)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    imgui.new_line()

    -- DMG_LVL_01_INFO
    DMG_LVL_01_INFOChanged, updatedDMG_LVL_01_INFO = imgui.input_text("DMG LVL 01 Info", currentWeapon.Stats.DMG_LVL_01_INFO, 0)
    if DMG_LVL_01_INFOChanged then
      currentWeapon.Stats.DMG_LVL_01_INFO = updatedDMG_LVL_01_INFO
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    imgui.new_line()

    -- DMG_LVL_02
    DMG_LVL_02Changed, updatedDMG_LVL_02 = imgui.input_text("DMG LVL 02", currentWeapon.Stats.DMG_LVL_02, 1)
    if DMG_LVL_02Changed then
      currentWeapon.Stats.DMG_LVL_02 = tonumber(updatedDMG_LVL_02)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    -- DMG_LVL_02_INFO
    DMG_LVL_02_INFOChanged, updatedDMG_LVL_02_INFO = imgui.input_text("DMG LVL 02 Info", currentWeapon.Stats.DMG_LVL_02_INFO, 0)
    if DMG_LVL_02_INFOChanged then
      currentWeapon.Stats.DMG_LVL_02_INFO = updatedDMG_LVL_02_INFO
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    -- DMG_LVL_02_COST
    DMG_LVL_02_COSTChanged, updatedDMG_LVL_02_COST = imgui.input_text("DMG LVL 02 Cost", currentWeapon.Stats.DMG_LVL_02_COST, 1)
    if DMG_LVL_02_COSTChanged then
      currentWeapon.Stats.DMG_LVL_02_COST = tonumber(updatedDMG_LVL_02_COST)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    imgui.new_line()

    -- DMG_LVL_03
    DMG_LVL_03Changed, updatedDMG_LVL_03 = imgui.input_text("DMG LVL 03", currentWeapon.Stats.DMG_LVL_03, 1)
    if DMG_LVL_03Changed then
      currentWeapon.Stats.DMG_LVL_03 = tonumber(updatedDMG_LVL_03)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    -- DMG_LVL_03_INFO
    DMG_LVL_03_INFOChanged, updatedDMG_LVL_03_INFO = imgui.input_text("DMG LVL 03 Info", currentWeapon.Stats.DMG_LVL_03_INFO, 0)
    if DMG_LVL_03_INFOChanged then
      currentWeapon.Stats.DMG_LVL_03_INFO = updatedDMG_LVL_03_INFO
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    -- DMG_LVL_03_COST
    DMG_LVL_03_COSTChanged, updatedDMG_LVL_03_COST = imgui.input_text("DMG LVL 03 Cost", currentWeapon.Stats.DMG_LVL_03_COST, 1)
    if DMG_LVL_03_COSTChanged then
      currentWeapon.Stats.DMG_LVL_03_COST = tonumber(updatedDMG_LVL_03_COST)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    imgui.new_line()

    -- DMG_LVL_04
    DMG_LVL_04Changed, updatedDMG_LVL_04 = imgui.input_text("DMG LVL 04", currentWeapon.Stats.DMG_LVL_04, 1)
    if DMG_LVL_04Changed then
      currentWeapon.Stats.DMG_LVL_04 = tonumber(updatedDMG_LVL_04)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    -- DMG_LVL_04_INFO
    DMG_LVL_04_INFOChanged, updatedDMG_LVL_04_INFO = imgui.input_text("DMG LVL 04 Info", currentWeapon.Stats.DMG_LVL_04_INFO, 0)
    if DMG_LVL_04_INFOChanged then
      currentWeapon.Stats.DMG_LVL_04_INFO = updatedDMG_LVL_04_INFO
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    -- DMG_LVL_04_COST
    DMG_LVL_04_COSTChanged, updatedDMG_LVL_04_COST = imgui.input_text("DMG LVL 04 Cost", currentWeapon.Stats.DMG_LVL_04_COST, 1)
    if DMG_LVL_04_COSTChanged then
      currentWeapon.Stats.DMG_LVL_04_COST = tonumber(updatedDMG_LVL_04_COST)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    imgui.new_line()

    -- DMG_LVL_05
    DMG_LVL_05Changed, updatedDMG_LVL_05 = imgui.input_text("DMG LVL 05", currentWeapon.Stats.DMG_LVL_05, 1)
    if DMG_LVL_05Changed then
      currentWeapon.Stats.DMG_LVL_05 = tonumber(updatedDMG_LVL_05)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    -- DMG_LVL_05_INFO
    DMG_LVL_05_INFOChanged, updatedDMG_LVL_05_INFO = imgui.input_text("DMG LVL 05 Info", currentWeapon.Stats.DMG_LVL_05_INFO, 0)
    if DMG_LVL_05_INFOChanged then
      currentWeapon.Stats.DMG_LVL_05_INFO = updatedDMG_LVL_05_INFO
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    -- DMG_LVL_05_COST
    DMG_LVL_05_COSTChanged, updatedDMG_LVL_05_COST = imgui.input_text("DMG LVL 05 Cost", currentWeapon.Stats.DMG_LVL_05_COST, 1)
    if DMG_LVL_05_COSTChanged then
      currentWeapon.Stats.DMG_LVL_05_COST = tonumber(updatedDMG_LVL_05_COST)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    if imgui.tree_node("Wince") then
      -- HG_BaseWINC
      HG_BaseWINCChanged, updatedHG_BaseWINC = imgui.input_text("HG Base WINC", currentWeapon.Stats.HG_BaseWINC, 1)
      if HG_BaseWINCChanged then
        currentWeapon.Stats.HG_BaseWINC = tonumber(updatedHG_BaseWINC)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end
      -- WINC_LVL_01
      WINC_LVL_01Changed, updatedWINC_LVL_01 = imgui.input_text("WINC LVL 01", currentWeapon.Stats.WINC_LVL_01, 1)
      if WINC_LVL_01Changed then
        currentWeapon.Stats.WINC_LVL_01 = tonumber(updatedWINC_LVL_01)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- WINC_LVL_02
      WINC_LVL_02Changed, updatedWINC_LVL_02 = imgui.input_text("WINC LVL 02", currentWeapon.Stats.WINC_LVL_02, 1)
      if WINC_LVL_02Changed then
        currentWeapon.Stats.WINC_LVL_02 = tonumber(updatedWINC_LVL_02)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- WINC_LVL_03
      WINC_LVL_03Changed, updatedWINC_LVL_03 = imgui.input_text("WINC LVL 03", currentWeapon.Stats.WINC_LVL_03, 1)
      if WINC_LVL_03Changed then
        currentWeapon.Stats.WINC_LVL_03 = tonumber(updatedWINC_LVL_03)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- WINC_LVL_04
      WINC_LVL_04Changed, updatedWINC_LVL_04 = imgui.input_text("WINC LVL 04", currentWeapon.Stats.WINC_LVL_04, 1)
      if WINC_LVL_04Changed then
        currentWeapon.Stats.WINC_LVL_04 = tonumber(updatedWINC_LVL_04)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- WINC_LVL_05
      WINC_LVL_05Changed, updatedWINC_LVL_05 = imgui.input_text("WINC LVL 05", currentWeapon.Stats.WINC_LVL_05, 1)
      if WINC_LVL_05Changed then
        currentWeapon.Stats.WINC_LVL_05 = tonumber(updatedWINC_LVL_05)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end
      imgui.tree_pop()
    end

    if imgui.tree_node("Break") then
      -- HG_BaseBRK
      HG_BaseBRKChanged, updatedHG_BaseBRK = imgui.input_text("HG Base BRK", currentWeapon.Stats.HG_BaseBRK, 1)
      if HG_BaseBRKChanged then
        currentWeapon.Stats.HG_BaseBRK = tonumber(updatedHG_BaseBRK)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end
      -- BRK_LVL_01
      BRK_LVL_01Changed, updatedBRK_LVL_01 = imgui.input_text("BRK LVL 01", currentWeapon.Stats.BRK_LVL_01, 1)
      if BRK_LVL_01Changed then
        currentWeapon.Stats.BRK_LVL_01 = tonumber(updatedBRK_LVL_01)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- BRK_LVL_02
      BRK_LVL_02Changed, updatedBRK_LVL_02 = imgui.input_text("BRK LVL 02", currentWeapon.Stats.BRK_LVL_02, 1)
      if BRK_LVL_02Changed then
        currentWeapon.Stats.BRK_LVL_02 = tonumber(updatedBRK_LVL_02)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- BRK_LVL_03
      BRK_LVL_03Changed, updatedBRK_LVL_03 = imgui.input_text("BRK LVL 03", currentWeapon.Stats.BRK_LVL_03, 1)
      if BRK_LVL_03Changed then
        currentWeapon.Stats.BRK_LVL_03 = tonumber(updatedBRK_LVL_03)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- BRK_LVL_04
      BRK_LVL_04Changed, updatedBRK_LVL_04 = imgui.input_text("BRK LVL 04", currentWeapon.Stats.BRK_LVL_04, 1)
      if BRK_LVL_04Changed then
        currentWeapon.Stats.BRK_LVL_04 = tonumber(updatedBRK_LVL_04)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- BRK_LVL_05
      BRK_LVL_05Changed, updatedBRK_LVL_05 = imgui.input_text("BRK LVL 05", currentWeapon.Stats.BRK_LVL_05, 1)
      if BRK_LVL_05Changed then
        currentWeapon.Stats.BRK_LVL_05 = tonumber(updatedBRK_LVL_05)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end
      imgui.tree_pop()
    end

    if imgui.tree_node("Stopping Power") then
      -- HG_BaseSTOP
      HG_BaseSTOPChanged, updatedHG_BaseSTOP = imgui.input_text("HG Base STOP", currentWeapon.Stats.HG_BaseSTOP, 1)
      if HG_BaseSTOPChanged then
        currentWeapon.Stats.HG_BaseSTOP = tonumber(updatedHG_BaseSTOP)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- STOP_LVL_01
      STOP_LVL_01Changed, updatedSTOP_LVL_01 = imgui.input_text("STOP LVL 01", currentWeapon.Stats.STOP_LVL_01, 1)
      if STOP_LVL_01Changed then
        currentWeapon.Stats.STOP_LVL_01 = tonumber(updatedSTOP_LVL_01)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- STOP_LVL_02
      STOP_LVL_02Changed, updatedSTOP_LVL_02 = imgui.input_text("STOP LVL 02", currentWeapon.Stats.STOP_LVL_02, 1)
      if STOP_LVL_02Changed then
        currentWeapon.Stats.STOP_LVL_02 = tonumber(updatedSTOP_LVL_02)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- STOP_LVL_03
      STOP_LVL_03Changed, updatedSTOP_LVL_03 = imgui.input_text("STOP LVL 03", currentWeapon.Stats.STOP_LVL_03, 1)
      if STOP_LVL_03Changed then
        currentWeapon.Stats.STOP_LVL_03 = tonumber(updatedSTOP_LVL_03)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- STOP_LVL_04
      STOP_LVL_04Changed, updatedSTOP_LVL_04 = imgui.input_text("STOP LVL 04", currentWeapon.Stats.STOP_LVL_04, 1)
      if STOP_LVL_04Changed then
        currentWeapon.Stats.STOP_LVL_04 = tonumber(updatedSTOP_LVL_04)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- STOP_LVL_05
      STOP_LVL_05Changed, updatedSTOP_LVL_05 = imgui.input_text("STOP LVL 05", currentWeapon.Stats.STOP_LVL_05, 1)
      if STOP_LVL_05Changed then
        currentWeapon.Stats.STOP_LVL_05 = tonumber(updatedSTOP_LVL_05)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end
      imgui.tree_pop()
    end
  end

  if imgui.tree_node("Capacity") then
    -- BaseAmmoNum
    BaseAmmoNumChanged, updatedBaseAmmoNum = imgui.input_text("Base Ammo Num", currentWeapon.Stats.BaseAmmoNum, 1)
    if BaseAmmoNumChanged then
      currentWeapon.Stats.BaseAmmoNum = tonumber(updatedBaseAmmoNum)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    -- BaseAmmoCost
    BaseAmmoCostChanged, updatedBaseAmmoCost = imgui.input_text("Base Ammo Cost", currentWeapon.Stats.BaseAmmoCost, 1)
    if BaseAmmoCostChanged then
      currentWeapon.Stats.BaseAmmoCost = tonumber(updatedBaseAmmoCost)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    imgui.new_line()

    -- AMMO_LVL_01_INFO
    AMMO_LVL_01_INFOChanged, updatedAMMO_LVL_01_INFO = imgui.input_text("AMMO LVL 01 INFO", currentWeapon.Stats.AMMO_LVL_01_INFO, 0)
    if AMMO_LVL_01_INFOChanged then
      currentWeapon.Stats.AMMO_LVL_01_INFO = updatedAMMO_LVL_01_INFO
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    imgui.new_line()

    -- AMMO_LVL_02
    AMMO_LVL_02Changed, updatedAMMO_LVL_02 = imgui.input_text("AMMO LVL 02", currentWeapon.Stats.AMMO_LVL_02, 1)
    if AMMO_LVL_02Changed then
      currentWeapon.Stats.AMMO_LVL_02 = tonumber(updatedAMMO_LVL_02)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    -- AMMO_LVL_02_INFO
    AMMO_LVL_02_INFOChanged, updatedAMMO_LVL_02_INFO = imgui.input_text("AMMO LVL 02 INFO", currentWeapon.Stats.AMMO_LVL_02_INFO, 0)
    if AMMO_LVL_02_INFOChanged then
      currentWeapon.Stats.AMMO_LVL_02_INFO = updatedAMMO_LVL_02_INFO
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    -- AMMO_LVL_02_COST
    AMMO_LVL_02_COSTChanged, updatedAMMO_LVL_02_COST = imgui.input_text("AMMO LVL 02 COST", currentWeapon.Stats.AMMO_LVL_02_COST, 1)
    if AMMO_LVL_02_COSTChanged then
      currentWeapon.Stats.AMMO_LVL_02_COST = tonumber(updatedAMMO_LVL_02_COST)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    imgui.new_line()

    -- AMMO_LVL_03
    AMMO_LVL_03Changed, updatedAMMO_LVL_03 = imgui.input_text("AMMO LVL 03", currentWeapon.Stats.AMMO_LVL_03, 1)
    if AMMO_LVL_03Changed then
      currentWeapon.Stats.AMMO_LVL_03 = tonumber(updatedAMMO_LVL_03)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    -- AMMO_LVL_03_INFO
    AMMO_LVL_03_INFOChanged, updatedAMMO_LVL_03_INFO = imgui.input_text("AMMO LVL 03 INFO", currentWeapon.Stats.AMMO_LVL_03_INFO, 0)
    if AMMO_LVL_03_INFOChanged then
      currentWeapon.Stats.AMMO_LVL_03_INFO = updatedAMMO_LVL_03_INFO
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    -- AMMO_LVL_03_COST
    AMMO_LVL_03_COSTChanged, updatedAMMO_LVL_03_COST = imgui.input_text("AMMO LVL 03 COST", currentWeapon.Stats.AMMO_LVL_03_COST, 1)
    if AMMO_LVL_03_COSTChanged then
      currentWeapon.Stats.AMMO_LVL_03_COST = tonumber(updatedAMMO_LVL_03_COST)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    imgui.new_line()

    -- AMMO_LVL_04
    AMMO_LVL_04Changed, updatedAMMO_LVL_04 = imgui.input_text("AMMO LVL 04", currentWeapon.Stats.AMMO_LVL_04, 1)
    if AMMO_LVL_04Changed then
      currentWeapon.Stats.AMMO_LVL_04 = tonumber(updatedAMMO_LVL_04)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    -- AMMO_LVL_04_INFO
    AMMO_LVL_04_INFOChanged, updatedAMMO_LVL_04_INFO = imgui.input_text("AMMO LVL 04 INFO", currentWeapon.Stats.AMMO_LVL_04_INFO, 0)
    if AMMO_LVL_04_INFOChanged then
      currentWeapon.Stats.AMMO_LVL_04_INFO = updatedAMMO_LVL_04_INFO
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    -- AMMO_LVL_04_COST
    AMMO_LVL_04_COSTChanged, updatedAMMO_LVL_04_COST = imgui.input_text("AMMO LVL 04 COST", currentWeapon.Stats.AMMO_LVL_04_COST, 1)
    if AMMO_LVL_04_COSTChanged then
      currentWeapon.Stats.AMMO_LVL_04_COST = tonumber(updatedAMMO_LVL_04_COST)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    imgui.new_line()

    -- AMMO_LVL_05
    AMMO_LVL_05Changed, updatedAMMO_LVL_05 = imgui.input_text("AMMO LVL 05", currentWeapon.Stats.AMMO_LVL_05, 1)
    if AMMO_LVL_05Changed then
      currentWeapon.Stats.AMMO_LVL_05 = tonumber(updatedAMMO_LVL_05)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    -- AMMO_LVL_05_INFO
    AMMO_LVL_05_INFOChanged, updatedAMMO_LVL_05_INFO = imgui.input_text("AMMO LVL 05 INFO", currentWeapon.Stats.AMMO_LVL_05_INFO, 0)
    if AMMO_LVL_05_INFOChanged then
      currentWeapon.Stats.AMMO_LVL_05_INFO = updatedAMMO_LVL_05_INFO
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    -- AMMO_LVL_05_COST
    AMMO_LVL_05_COSTChanged, updatedAMMO_LVL_05_COST = imgui.input_text("AMMO LVL 05 COST", currentWeapon.Stats.AMMO_LVL_05_COST, 1)
    if AMMO_LVL_05_COSTChanged then
      currentWeapon.Stats.AMMO_LVL_05_COST = tonumber(updatedAMMO_LVL_05_COST)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end
    imgui.tree_pop()
  end

  if imgui.tree_node("Reload Speed") then
    -- ReloadType
    ReloadTypeChanged, updatedReloadType = imgui.input_text("Reload Type", currentWeapon.Stats.ReloadType, 1)
    if ReloadTypeChanged then
      currentWeapon.Stats.ReloadType = tonumber(updatedReloadType)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    -- ReloadNum
    ReloadNumChanged, updatedReloadNum = imgui.input_text("Reload Num", currentWeapon.Stats.ReloadNum, 1)
    if ReloadNumChanged then
      currentWeapon.Stats.ReloadNum = tonumber(updatedReloadNum)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    -- ReloadSpeedRate
    ReloadSpeedRateChanged, updatedReloadSpeedRate = imgui.input_text("Reload Speed Rate", currentWeapon.Stats.ReloadSpeedRate, 1)
    if ReloadSpeedRateChanged then
      currentWeapon.Stats.ReloadSpeedRate = tonumber(updatedReloadSpeedRate)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    imgui.new_line()

    -- RELOAD_LVL_01
    RELOAD_LVL_01Changed, updatedRELOAD_LVL_01 = imgui.input_text("RELOAD LVL 01", currentWeapon.Stats.RELOAD_LVL_01, 1)
    if RELOAD_LVL_01Changed then
      currentWeapon.Stats.RELOAD_LVL_01 = tonumber(updatedRELOAD_LVL_01)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    -- RELOAD_LVL_01_INFO
    RELOAD_LVL_01_INFOChanged, updatedRELOAD_LVL_01_INFO = imgui.input_text("RELOAD LVL 01 INFO", currentWeapon.Stats.RELOAD_LVL_01_INFO, 0)
    if RELOAD_LVL_01_INFOChanged then
      currentWeapon.Stats.RELOAD_LVL_01_INFO = updatedRELOAD_LVL_01_INFO
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    -- RELOAD_LVL_01_COST
    RELOAD_LVL_01_COSTChanged, updatedRELOAD_LVL_01_COST = imgui.input_text("RELOAD LVL 01 COST", currentWeapon.Stats.RELOAD_LVL_01_COST, 1)
    if RELOAD_LVL_01_COSTChanged then
      currentWeapon.Stats.RELOAD_LVL_01_COST = tonumber(updatedRELOAD_LVL_01_COST)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    imgui.new_line()

    -- RELOAD_LVL_02
    RELOAD_LVL_02Changed, updatedRELOAD_LVL_02 = imgui.input_text("RELOAD LVL 02", currentWeapon.Stats.RELOAD_LVL_02, 1)
    if RELOAD_LVL_02Changed then
      currentWeapon.Stats.RELOAD_LVL_02 = tonumber(updatedRELOAD_LVL_02)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    -- RELOAD_LVL_02_INFO
    RELOAD_LVL_02_INFOChanged, updatedRELOAD_LVL_02_INFO = imgui.input_text("RELOAD LVL 02 INFO", currentWeapon.Stats.RELOAD_LVL_02_INFO, 0)
    if RELOAD_LVL_02_INFOChanged then
      currentWeapon.Stats.RELOAD_LVL_02_INFO = updatedRELOAD_LVL_02_INFO
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    -- RELOAD_LVL_02_COST
    RELOAD_LVL_02_COSTChanged, updatedRELOAD_LVL_02_COST = imgui.input_text("RELOAD LVL 02 COST", currentWeapon.Stats.RELOAD_LVL_02_COST, 1)
    if RELOAD_LVL_02_COSTChanged then
      currentWeapon.Stats.RELOAD_LVL_02_COST = tonumber(updatedRELOAD_LVL_02_COST)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    imgui.new_line()

    -- RELOAD_LVL_03
    RELOAD_LVL_03Changed, updatedRELOAD_LVL_03 = imgui.input_text("RELOAD LVL 03", currentWeapon.Stats.RELOAD_LVL_03, 1)
    if RELOAD_LVL_03Changed then
      currentWeapon.Stats.RELOAD_LVL_03 = tonumber(updatedRELOAD_LVL_03)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    -- RELOAD_LVL_03_INFO
    RELOAD_LVL_03_INFOChanged, updatedRELOAD_LVL_03_INFO = imgui.input_text("RELOAD LVL 03 INFO", currentWeapon.Stats.RELOAD_LVL_03_INFO, 0)
    if RELOAD_LVL_03_INFOChanged then
      currentWeapon.Stats.RELOAD_LVL_03_INFO = updatedRELOAD_LVL_03_INFO
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    -- RELOAD_LVL_03_COST
    RELOAD_LVL_03_COSTChanged, updatedRELOAD_LVL_03_COST = imgui.input_text("RELOAD LVL 03 COST", currentWeapon.Stats.RELOAD_LVL_03_COST, 1)
    if RELOAD_LVL_03_COSTChanged then
      currentWeapon.Stats.RELOAD_LVL_03_COST = tonumber(updatedRELOAD_LVL_03_COST)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    imgui.new_line()

    -- RELOAD_LVL_04
    RELOAD_LVL_04Changed, updatedRELOAD_LVL_04 = imgui.input_text("RELOAD LVL 04", currentWeapon.Stats.RELOAD_LVL_04, 1)
    if RELOAD_LVL_04Changed then
      currentWeapon.Stats.RELOAD_LVL_04 = tonumber(updatedRELOAD_LVL_04)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    -- RELOAD_LVL_04_INFO
    RELOAD_LVL_04_INFOChanged, updatedRELOAD_LVL_04_INFO = imgui.input_text("RELOAD LVL 04 INFO", currentWeapon.Stats.RELOAD_LVL_04_INFO, 0)
    if RELOAD_LVL_04_INFOChanged then
      currentWeapon.Stats.RELOAD_LVL_04_INFO = updatedRELOAD_LVL_04_INFO
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    -- RELOAD_LVL_04_COST
    RELOAD_LVL_04_COSTChanged, updatedRELOAD_LVL_04_COST = imgui.input_text("RELOAD LVL 04 COST", currentWeapon.Stats.RELOAD_LVL_04_COST, 1)
    if RELOAD_LVL_04_COSTChanged then
      currentWeapon.Stats.RELOAD_LVL_04_COST = tonumber(updatedRELOAD_LVL_04_COST)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    imgui.new_line()

    -- RELOAD_LVL_05
    RELOAD_LVL_05Changed, updatedRELOAD_LVL_05 = imgui.input_text("RELOAD LVL 05", currentWeapon.Stats.RELOAD_LVL_05, 1)
    if RELOAD_LVL_05Changed then
      currentWeapon.Stats.RELOAD_LVL_05 = tonumber(updatedRELOAD_LVL_05)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    -- RELOAD_LVL_05_INFO
    RELOAD_LVL_05_INFOChanged, updatedRELOAD_LVL_05_INFO = imgui.input_text("RELOAD LVL 05 INFO", currentWeapon.Stats.RELOAD_LVL_05_INFO, 0)
    if RELOAD_LVL_05_INFOChanged then
      currentWeapon.Stats.RELOAD_LVL_05_INFO = updatedRELOAD_LVL_05_INFO
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    -- RELOAD_LVL_05_COST
    RELOAD_LVL_05_COSTChanged, updatedRELOAD_LVL_05_COST = imgui.input_text("RELOAD LVL 05 COST", currentWeapon.Stats.RELOAD_LVL_05_COST, 1)
    if RELOAD_LVL_05_COSTChanged then
      currentWeapon.Stats.RELOAD_LVL_05_COST = tonumber(updatedRELOAD_LVL_05_COST)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end
    imgui.tree_pop()
  end

  if imgui.tree_node("Rate of Fire") then
    -- ShootType
    ShootTypeChanged, updatedShootType = imgui.input_text("Shoot Type", currentWeapon.Stats.ShootType, 1)
    if ShootTypeChanged then
      currentWeapon.Stats.ShootType = tonumber(updatedShootType)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    -- PumpActionFireRate
    PumpActionFireRateChanged, updatedPumpActionFireRate = imgui.input_text("Pump Action Fire Rate", currentWeapon.Stats.PumpActionFireRate, 1)
    if PumpActionFireRateChanged then
      currentWeapon.Stats.PumpActionFireRate = tonumber(updatedPumpActionFireRate)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    -- FireRate
    FireRateChanged, updatedFireRate = imgui.input_text("Fire Rate", currentWeapon.Stats.FireRate, 1)
    if FireRateChanged then
      currentWeapon.Stats.FireRate = tonumber(updatedFireRate)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    -- FireRateFrame
    FireRateFrameChanged, updatedFireRateFrame = imgui.input_text("Fire Rate Frame", currentWeapon.Stats.FireRateFrame, 1)
    if FireRateFrameChanged then
      currentWeapon.Stats.FireRateFrame = tonumber(updatedFireRateFrame)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    imgui.new_line()

    -- ROF_LVL_01
    ROF_LVL_01Changed, updatedROF_LVL_01 = imgui.input_text("ROF LVL 01", currentWeapon.Stats.ROF_LVL_01, 1)
    if ROF_LVL_01Changed then
      currentWeapon.Stats.ROF_LVL_01 = tonumber(updatedROF_LVL_01)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    -- ROF_LVL_01_INFO
    ROF_LVL_01_INFOChanged, updatedROF_LVL_01_INFO = imgui.input_text("ROF LVL 01 INFO", currentWeapon.Stats.ROF_LVL_01_INFO, 0)
    if ROF_LVL_01_INFOChanged then
      currentWeapon.Stats.ROF_LVL_01_INFO = updatedROF_LVL_01_INFO
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    -- ROF_LVL_01_COST
    ROF_LVL_01_COSTChanged, updatedROF_LVL_01_COST = imgui.input_text("ROF LVL 01 COST", currentWeapon.Stats.ROF_LVL_01_COST, 1)
    if ROF_LVL_01_COSTChanged then
      currentWeapon.Stats.ROF_LVL_01_COST = tonumber(updatedROF_LVL_01_COST)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    imgui.new_line()

    -- ROF_LVL_02
    ROF_LVL_02Changed, updatedROF_LVL_02 = imgui.input_text("ROF LVL 02", currentWeapon.Stats.ROF_LVL_02, 1)
    if ROF_LVL_02Changed then
      currentWeapon.Stats.ROF_LVL_02 = tonumber(updatedROF_LVL_02)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    -- ROF_LVL_02_INFO
    ROF_LVL_02_INFOChanged, updatedROF_LVL_02_INFO = imgui.input_text("ROF LVL 02 INFO", currentWeapon.Stats.ROF_LVL_02_INFO, 0)
    if ROF_LVL_02_INFOChanged then
      currentWeapon.Stats.ROF_LVL_02_INFO = updatedROF_LVL_02_INFO
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    -- ROF_LVL_02_COST
    ROF_LVL_02_COSTChanged, updatedROF_LVL_02_COST = imgui.input_text("ROF LVL 02 COST", currentWeapon.Stats.ROF_LVL_02_COST, 1)
    if ROF_LVL_02_COSTChanged then
      currentWeapon.Stats.ROF_LVL_02_COST = tonumber(updatedROF_LVL_02_COST)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    imgui.new_line()

    -- ROF_LVL_03
    ROF_LVL_03Changed, updatedROF_LVL_03 = imgui.input_text("ROF LVL 03", currentWeapon.Stats.ROF_LVL_03, 1)
    if ROF_LVL_03Changed then
      currentWeapon.Stats.ROF_LVL_03 = tonumber(updatedROF_LVL_03)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    -- ROF_LVL_03_INFO
    ROF_LVL_03_INFOChanged, updatedROF_LVL_03_INFO = imgui.input_text("ROF LVL 03 INFO", currentWeapon.Stats.ROF_LVL_03_INFO, 0)
    if ROF_LVL_03_INFOChanged then
      currentWeapon.Stats.ROF_LVL_03_INFO = updatedROF_LVL_03_INFO
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    -- ROF_LVL_03_COST
    ROF_LVL_03_COSTChanged, updatedROF_LVL_03_COST = imgui.input_text("ROF LVL 03 COST", currentWeapon.Stats.ROF_LVL_03_COST, 1)
    if ROF_LVL_03_COSTChanged then
      currentWeapon.Stats.ROF_LVL_03_COST = tonumber(updatedROF_LVL_03_COST)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    imgui.new_line()

    -- ROF_LVL_04
    ROF_LVL_04Changed, updatedROF_LVL_04 = imgui.input_text("ROF LVL 04", currentWeapon.Stats.ROF_LVL_04, 1)
    if ROF_LVL_04Changed then
      currentWeapon.Stats.ROF_LVL_04 = tonumber(updatedROF_LVL_04)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    -- ROF_LVL_04_INFO
    ROF_LVL_04_INFOChanged, updatedROF_LVL_04_INFO = imgui.input_text("ROF LVL 04 INFO", currentWeapon.Stats.ROF_LVL_04_INFO, 0)
    if ROF_LVL_04_INFOChanged then
      currentWeapon.Stats.ROF_LVL_04_INFO = updatedROF_LVL_04_INFO
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    -- ROF_LVL_04_COST
    ROF_LVL_04_COSTChanged, updatedROF_LVL_04_COST = imgui.input_text("ROF LVL 04 COST", currentWeapon.Stats.ROF_LVL_04_COST, 1)
    if ROF_LVL_04_COSTChanged then
      currentWeapon.Stats.ROF_LVL_04_COST = tonumber(updatedROF_LVL_04_COST)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    imgui.new_line()

    -- ROF_LVL_05
    ROF_LVL_05Changed, updatedROF_LVL_05 = imgui.input_text("ROF LVL 05", currentWeapon.Stats.ROF_LVL_05, 1)
    if ROF_LVL_05Changed then
      currentWeapon.Stats.ROF_LVL_05 = tonumber(updatedROF_LVL_05)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    -- ROF_LVL_05_INFO
    ROF_LVL_05_INFOChanged, updatedROF_LVL_05_INFO = imgui.input_text("ROF LVL 05 INFO", currentWeapon.Stats.ROF_LVL_05_INFO, 0)
    if ROF_LVL_05_INFOChanged then
      currentWeapon.Stats.ROF_LVL_05_INFO = updatedROF_LVL_05_INFO
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end

    -- ROF_LVL_05_COST
    ROF_LVL_05_COSTChanged, updatedROF_LVL_05_COST = imgui.input_text("ROF LVL 05 COST", currentWeapon.Stats.ROF_LVL_05_COST, 1)
    if ROF_LVL_05_COSTChanged then
      currentWeapon.Stats.ROF_LVL_05_COST = tonumber(updatedROF_LVL_05_COST)
      WeaponService.apply_weapon_stats(currentWeapon.Id)
    end
    imgui.tree_pop()
  end
  -- POWER EX
  if currentWeapon.Name == "RED9" or currentWeapon.Name== "BT" or currentWeapon.Name== "BRB" or currentWeapon.Name== "BM4" or currentWeapon.Name== "TMP" or
     currentWeapon.Name== "M1G" or currentWeapon.Name== "CQBR" then
    if imgui.tree_node("Exclusive") then
      -- EX_DMG
      EX_DMGChanged, updatedEX_DMG = imgui.input_text("EX_DMG", currentWeapon.Stats.EX_DMG, 1)
      if EX_DMGChanged then
        currentWeapon.Stats.EX_DMG = tonumber(updatedEX_DMG)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- EX_WINCE
      EX_WINCEChanged, updatedEX_WINCE = imgui.input_text("EX_WINCE", currentWeapon.Stats.EX_WINCE, 1)
      if EX_WINCEChanged then
        currentWeapon.Stats.EX_WINCE = tonumber(updatedEX_WINCE)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- EX_BRK
      EX_BRKChanged, updatedEX_BRK = imgui.input_text("EX_BRK", currentWeapon.Stats.EX_BRK, 1)
      if EX_BRKChanged then
        currentWeapon.Stats.EX_BRK = tonumber(updatedEX_BRK)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- EX_STOP
      EX_STOPChanged, updatedEX_STOP = imgui.input_text("EX_STOP", currentWeapon.Stats.EX_STOP, 1)
      if EX_STOPChanged then
        currentWeapon.Stats.EX_STOP = tonumber(updatedEX_STOP)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- EX_COST
      EX_COSTChanged, updatedEX_COST = imgui.input_text("EX_COST", currentWeapon.Stats.EX_COST, 1)
      if EX_COSTChanged then
        currentWeapon.Stats.EX_COST = tonumber(updatedEX_COST)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end
      imgui.tree_pop()
    end
  end

  if currentWeapon.Name== "M870" or currentWeapon.Name== "SKUL" then
    if imgui.tree_node("Exclusive") then

      -- EX_SG_DMG
      EX_SG_DMGChanged, updatedEX_SG_DMG = imgui.input_text("EX_SG_DMG", currentWeapon.Stats.EX_SG_DMG, 1)
      if EX_SG_DMGChanged then
        currentWeapon.Stats.EX_SG_DMG = tonumber(updatedEX_SG_DMG)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- EX_SG_WINCE
      EX_SG_WINCEChanged, updatedEX_SG_WINCE = imgui.input_text("EX_SG_WINCE", currentWeapon.Stats.EX_SG_WINCE, 1)
      if EX_SG_WINCEChanged then
        currentWeapon.Stats.EX_SG_WINCE = tonumber(updatedEX_SG_WINCE)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- EX_SG_BRK
      EX_SG_BRKChanged, updatedEX_SG_BRK = imgui.input_text("EX_SG_BRK", currentWeapon.Stats.EX_SG_BRK, 1)
      if EX_SG_BRKChanged then
        currentWeapon.Stats.EX_SG_BRK = tonumber(updatedEX_SG_BRK)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- EX_SG_STOP
      EX_SG_STOPChanged, updatedEX_SG_STOP = imgui.input_text("EX_SG_STOP", currentWeapon.Stats.EX_SG_STOP, 1)
      if EX_SG_STOPChanged then
        currentWeapon.Stats.EX_SG_STOP = tonumber(updatedEX_SG_STOP)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- EX_COST
      EX_COSTChanged, updatedEX_COST = imgui.input_text("EX_COST", currentWeapon.Stats.EX_COST, 1)
      if EX_COSTChanged then
        currentWeapon.Stats.EX_COST = tonumber(updatedEX_COST)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end
      imgui.tree_pop()
    end
  end

  -- Crit EX
  if currentWeapon.Name== "SEN9" or currentWeapon.Name== "SG09R" or currentWeapon.Name== "KIL7" then
    if imgui.tree_node("Exclusive") then
      -- EX_CRIT
      EX_CRITChanged, updatedEX_CRIT = imgui.input_text("EX_CRIT", currentWeapon.Stats.EX_CRIT, 1)
      if EX_CRITChanged then
        currentWeapon.Stats.EX_CRIT = tonumber(updatedEX_CRIT)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- EX_CRIT_FIT
      EX_CRIT_FITChanged, updatedEX_CRIT_FIT = imgui.input_text("EX_CRIT_FIT", currentWeapon.Stats.EX_CRIT_FIT, 1)
      if EX_CRIT_FITChanged then
        currentWeapon.Stats.EX_CRIT_FIT = tonumber(updatedEX_CRIT_FIT)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- EX_COST
      EX_COSTChanged, updatedEX_COST = imgui.input_text("EX_COST", currentWeapon.Stats.EX_COST, 1)
      if EX_COSTChanged then
        currentWeapon.Stats.EX_COST = tonumber(updatedEX_COST)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end
      imgui.tree_pop()
    end
  end

  -- PENETRATION EX
  if currentWeapon.Name== "PUN" or currentWeapon.Name== "LE5" then
    if imgui.tree_node("Exclusive") then
      -- EX_PIRC
      EX_PIRCChanged, updatedEX_PIRC = imgui.input_text("EX_PIRC", currentWeapon.Stats.EX_PIRC, 1)
      if EX_PIRCChanged then
        currentWeapon.Stats.EX_PIRC = tonumber(updatedEX_PIRC)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- EX_PIRC_FIT
      EX_PIRC_FITChanged, updatedEX_PIRC_FIT = imgui.input_text("EX_PIRC_FIT", currentWeapon.Stats.EX_PIRC_FIT, 1)
      if EX_PIRC_FITChanged then
        currentWeapon.Stats.EX_PIRC_FIT = tonumber(updatedEX_PIRC_FIT)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- EX_COST
      EX_COSTChanged, updatedEX_COST = imgui.input_text("EX_COST", currentWeapon.Stats.EX_COST, 1)
      if EX_COSTChanged then
        currentWeapon.Stats.EX_COST = tonumber(updatedEX_COST)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      imgui.tree_pop()
    end
  end

  -- CAPACITY EX
  if currentWeapon.Name== "VP70" then
    if imgui.tree_node("Exclusive") then
      -- EX_AMMO
      EX_AMMOChanged, updatedEX_AMMO = imgui.input_text("EX_AMMO", currentWeapon.Stats.EX_AMMO, 1)
      if EX_AMMOChanged then
        currentWeapon.Stats.EX_AMMO = tonumber(updatedEX_AMMO)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- EX_COST
      EX_COSTChanged, updatedEX_COST = imgui.input_text("EX_COST", currentWeapon.Stats.EX_COST, 1)
      if EX_COSTChanged then
        currentWeapon.Stats.EX_COST = tonumber(updatedEX_COST)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end
      imgui.tree_pop()
    end
  end

  -- STRIKER EX
  if currentWeapon.Name== "STKR" then
    if imgui.tree_node("Exclusive") then
      -- EX_AMMO
      EX_AMMOChanged, updatedEX_AMMO = imgui.input_text("EX_AMMO", currentWeapon.Stats.EX_AMMO, 1)
      if EX_AMMOChanged then
        currentWeapon.Stats.EX_AMMO = tonumber(updatedEX_AMMO)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- EX_SG_RELOAD
      EX_SG_RELOADChanged, updatedEX_SG_RELOAD = imgui.input_text("EX_SG_RELOAD", currentWeapon.Stats.EX_SG_RELOAD, 1)
      if EX_SG_RELOADChanged then
        currentWeapon.Stats.EX_SG_RELOAD = tonumber(updatedEX_SG_RELOAD)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- EX_COST
      EX_COSTChanged, updatedEX_COST = imgui.input_text("EX_COST", currentWeapon.Stats.EX_COST, 1)
      if EX_COSTChanged then
        currentWeapon.Stats.EX_COST = tonumber(updatedEX_COST)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end
      imgui.tree_pop()
    end
  end

  -- INFINITE AMMO EX
  if currentWeapon.Name== "HNDC" or currentWeapon.Name== "CTW" then
    if imgui.tree_node("Exclusive") then
      -- EX_COST
      EX_COSTChanged, updatedEX_COST = imgui.input_text("EX_COST", currentWeapon.Stats.EX_COST, 1)
      if EX_COSTChanged then
        currentWeapon.Stats.EX_COST = tonumber(updatedEX_COST)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      imgui.tree_pop()
    end
  end

  -- RATE OF FIRE EX
  if currentWeapon.Name== "SAR" then
    if imgui.tree_node("Exclusive") then
      -- EX_ROF
      EX_ROFChanged, updatedEX_ROF = imgui.input_text("EX_ROF", currentWeapon.Stats.EX_ROF, 1)
      if EX_ROFChanged then
        currentWeapon.Stats.EX_ROF = tonumber(updatedEX_ROF)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      -- EX_COST
      EX_COSTChanged, updatedEX_COST = imgui.input_text("EX_COST", currentWeapon.Stats.EX_COST, 1)
      if EX_COSTChanged then
        currentWeapon.Stats.EX_COST = tonumber(updatedEX_COST)
        WeaponService.apply_weapon_stats(currentWeapon.Id)
      end

      imgui.tree_pop()
    end
  end

  imgui.new_line()

  if imgui.button("Save Changes") then
    local path = Weapon_Vars.Weapon_Profiles[Weapon_Vars.Selected_Profile]
    json.dump_file("DWP\\" .. path .. "\\" .. currentWeapon.Name.. ".json", currentWeapon.Stats)
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

-- set the weapon values when the script first runs
SetWeapon_DMGValues()

local function generate_statics(typename)
  local t = sdk.find_type_definition(typename)
  if not t then return {} end

  local fields = t:get_fields()
  local enum = {}
  local enum_string = "\ncase \"" .. typename .. "\":" .. "\n    enum {"
  
  for i, field in ipairs(fields) do
      if field:is_static() then
          local name = field:get_name()
          local raw_value = field:get_data(nil)
          enum_string = enum_string .. "\n        " .. name .. " = " .. tostring(raw_value) .. ","
          enum[name] = raw_value
      end
  end
  
  --log.info(enum_string .. "\n    }" .. typename:gsub("%.", "_") .. ";\n    break;\n") --enums for RSZ template

  return enum
end

local function generate_statics_global(typename)
  local parts = {}
  for part in typename:gmatch("[^%.]+") do
      table.insert(parts, part)
  end
  local global = _G
  for i, part in ipairs(parts) do
      if not global[part] then
          global[part] = {}
      end
      global = global[part]
  end
  if global ~= _G then
      local static_class = generate_statics(typename)

      for k, v in pairs(static_class) do
          global[k] = v
          global[v] = k
      end
  end
  return global
end

generate_statics_global("via.hid.KeyboardKey")

re.on_draw_ui(function()
  local changed = false
  local was_changed = false

  if imgui.tree_node("Dynamic Weapon Profiles") then
    table.sort(Weapon_Vars.Weapon_Profiles)
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

    changed, Weapon_Vars.Durable_Knives = imgui.checkbox("Super Durable Knives", Weapon_Vars.Durable_Knives)
    was_changed = changed or was_changed

    changed, Weapon_Vars.Free_Knife_Repairs = imgui.checkbox("Free Knife Repairs", Weapon_Vars.Free_Knife_Repairs)
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
    if not scene then
      scene = sdk.call_native_func(scene_manager, sdk.find_type_definition("via.SceneManager"), "get_CurrentScene")
    end

    if scene then
      if not initialized then
        WeaponService.set_scene(scene)
        initialized = true
      end

      if Weapon_Vars.Harpoon_DMG then
        apply_harpoon_damage()
      end

      WeaponService.on_frame()
    end
  end

  if imgui.is_key_pressed(via.hid.KeyboardKey.Insert) then
    show_profile_editor = false
  end
end)
