local WeaponDataTables = {}
local WeaponDataTables_2nd = {}
local WeaponStages = {}
local WeaponDetailStages = {}
local PlayerInventory = {}
local CS_Inventory = nil
local OldInventoryCount = -1
local InventoryItemsToUpdate = {}
local WeaponProfile = nil
local WeaponCatalogInitialized = false
local Scene = nil
local RED9OwnerEquipment = nil
local TMPOwnerEquipment = nil
local VP70OwnerEquipment = nil
local RED9_AOOwnerEquipment = nil
local TMP_AOOwnerEquipment = nil

local Weapons = {
	SG09R = { Id = 4000, Name = "SG09R", Type = "HG", Stats = nil },
	PUN = { Id = 4001, Name = "PUN", Type = "HG", Stats = nil },
  RED9 = { Id = 4002, Name = "RED9", Type = "HG", CanEquipStock = true, StockEquipped = false, Stats = nil, StatsWithStock = nil },
  BT = { Id = 4003, Name = "BT", Type = "HG", Stats = nil },
  VP70 = { Id = 4004, Name = "VP70", Type = "HG", CanEquipStock = true, StockEquipped = false, Stats = nil, StatsWithStock = nil },
  M870 = { Id = 4100, Name = "M870", Type = "SG_PUMP", Stats = nil },
  BM4 = { Id = 4101, Name = "BM4", Type = "SG", Stats = nil },
  STKR = { Id = 4102, Name = "STKR", Type = "SG", Stats = nil },
  TMP = { Id = 4200, Name = "TMP", Type = "SMG", CanEquipStock = true, StockEquipped = false, Stats = nil, StatsWithStock = nil },
  CTW = { Id = 4201, Name = "CTW", Type = "SMG", Stats = nil },
  LE5 = { Id = 4202, Name = "LE5", Type = "SMG", Stats = nil },
  M1G = { Id = 4400, Name = "M1G", Type = "SR_PUMP", Stats = nil },
  SAR = { Id = 4401, Name = "SAR", Type = "SR", Stats = nil },
  CQBR = { Id = 4402, Name = "CQBR", Type = "SR", Stats = nil },
  BRB = { Id = 4500, Name = "BRB", Type = "MAG", Stats = nil },
  KIL7 = { Id = 4501, Name = "KIL7", Type = "MAG_SEMI", Stats = nil },
  HNDC = { Id = 4502, Name = "HNDC", Type = "MAG", Stats = nil },
	BOLT = {Id = 4600, Name = "BOLT", Type = "BOLT", Stats = nil},
	CMBT = { Id = 5000, Name = "CMBT", Type = "K", Stats = nil },
	FIGHT = { Id = 5001, Name = "FIGHT", Type = "K", Stats = nil },
	PRIM = { Id = 5006, Name = "PRIM", Type = "K", Stats = nil },
  SEN9 = { Id = 6000, Name = "SEN9", Type = "HG", Stats = nil },
  SKUL = { Id = 6001, Name = "SKUL", Type = "SG", Stats = nil },
  M870_AO = { Id = 6100, Name = "M870_AO", Type = "SG_PUMP", Stats = nil },
  CTW_AO = { Id = 6101, Name = "CTW_AO", Type = "SMG", Stats = nil },
  XBOW_AO = { Id = 6102, Name = "XBOW_AO", Type = "BOW", Stats = nil },
  BT_AO = { Id = 6103, Name = "BT_AO", Type = "HG", Stats = nil },
  TMP_AO = { Id = 6104, Name = "TMP_AO", Type = "SMG", CanEquipStock = true, StockEquipped = false, Stats = nil, StatsWithStock = nil },
  SAR_AO = { Id = 6105, Name = "SAR_AO", Type = "SR", Stats = nil },
  TAC_AO = { Id = 6107, Name = "TAC_AO", Type = "K", Stats = nil },
  ELITE_AO = { Id = 6108, Name = "ELITE_AO", Type = "K", Stats = nil },
  PUN_AO = { Id = 6112, Name = "PUN_AO", Type = "HG", Stats = nil },
  RED9_AO = { Id = 6113, Name = "RED9_AO", Type = "HG", CanEquipStock = true, StockEquipped = false, Stats = nil, StatsWithStock = nil },
  M1G_AO = { Id = 6114, Name = "M1G_AO", Type = "SR_PUMP", Stats = nil },
  M9A3 = { Id = 6300, Name = "M9A3", Type = "HG", Stats = nil },
}

local WeaponIDTypeMap = {
  [4000] = "HG",
  [4001] = "HG",
  [4002] = "HG",
  [4003] = "HG",
  [4004] = "HG",
  [4100] = "SG_PUMP",
  [4101] = "SG",
  [4102] = "SG",
  [4200] = "SMG",
  [4201] = "SMG",
  [4202] = "SMG",
  [4400] = "SR_PUMP",
  [4401] = "SR",
  [4402] = "SR",
  [4500] = "MAG",
  [4501] = "MAG_SEMI",
  [4502] = "MAG",
  [4600] = "BOLT",
  [5000] = "K",
  [5001] = "K",
  [5006] = "K",
  [6000] = "HG",
  [6001] = "SG",
  [6100] = "SG_PUMP",
  [6101] = "SMG",
  [6102] = "BOW",
  [6103] = "HG",
  [6104] = "SMG",
  [6105] = "SR",
  [6107] = "K",
  [6108] = "K",
  [6112] = "HG",
  [6113] = "HG",
  [6114] = "SR_PUMP",
  [6300] = "HG",
}

local Repair_IDs = {
  [276435456] = "5000",
  [276437056] = "5001",
  [276445056] = "5006",
  [278206656] = "6107"
}

local function reset_values()
	WeaponDataTables = {}
  WeaponDataTables_2nd = {}
	WeaponStages = {}
	WeaponDetailStages = {}
	PlayerInventory = {}
	CS_Inventory = nil
	OldInventoryCount = -1
	InventoryItemsToUpdate = {}
	WeaponCatalogInitialized = false
	RED9OwnerEquipment = nil
	TMPOwnerEquipment = nil
	VP70OwnerEquipment = nil
  RED9_AOOwnerEquipment = nil
  TMP_AOOwnerEquipment = nil
end

local function set_weapon_profile(weaponProfile)
	WeaponProfile = weaponProfile
  
	if WeaponProfile then
	  for k, Weapon in pairs(Weapons) do
		log.info("Weapon Service: Loading profile for " .. Weapon.Name)
		local weaponStats = json.load_file("DWP\\" .. WeaponProfile .. "\\" .. Weapon.Name .. ".json")
		Weapon.Stats = weaponStats
  
		-- load defaults from None if not found
		if not Weapon.Stats then
		  weaponStats = json.load_file("DWP\\None\\" .. Weapon.Name .. ".json")
		  Weapon.Stats = weaponStats
		end
  
		if Weapon.CanEquipStock then
		  Weapon.StatsWithStock = json.load_file("DWP\\" .. WeaponProfile .. "\\" .. Weapon.Name .. "Stock.json")
  
		  if not Weapon.StatsWithStock then
			Weapon.StatsWithStock = weaponStats
		  end
		end
	  end
	end
end

local function set_scene(scene)
	Scene = scene
end

local function player_in_scene()
  local character_manager = sdk.get_managed_singleton(sdk.game_namespace("CharacterManager"))
  local player_context = character_manager:call("getPlayerContextRef")
  return player_context ~= nil
end

local function write_valuetype(parent_obj, offset, value)
  for i = 0, value.type:get_valuetype_size() - 1 do
    parent_obj:write_byte(offset + i, value:read_byte(i))
  end
end

local function build_weapon_catalog()
  local catalogFound = false
	local customCatalogFound = false

	if not WeaponDataTables[1] then
		local WeaponCatalog = Scene:call("findGameObject(System.String)", "WeaponCatalog")

		-- support mercenaries mode
		if not WeaponCatalog then
			WeaponCatalog = Scene:call("findGameObject(System.String)", "WeaponCatalog_MC")
		end

		-- support separate ways
		if not WeaponCatalog then
			WeaponCatalog = Scene:call("findGameObject(System.String)", "WeaponCatalog_AO")
		end

		if WeaponCatalog then
			local WeaponCatalogRegister = WeaponCatalog:call("getComponent(System.Type)", sdk.typeof("chainsaw.WeaponCatalogRegister"))

			if WeaponCatalogRegister then
				local WeaponEquipParamCatalogUserData = WeaponCatalogRegister:call("get_WeaponEquipParamCatalogUserData")

				if WeaponEquipParamCatalogUserData then
					WeaponDataTables = WeaponEquipParamCatalogUserData:get_field("_DataTable")
					WeaponDataTables = WeaponDataTables and WeaponDataTables:get_elements() or {}
					catalogFound = true
				end
			end
		end
	end

  -- support mercenaries mode second catalog
  if not WeaponDataTables_2nd[1] then
		local WeaponCatalog = Scene:call("findGameObject(System.String)", "WeaponCatalog_MC_2nd")

		if WeaponCatalog then
			local WeaponCatalogRegister = WeaponCatalog:call("getComponent(System.Type)", sdk.typeof("chainsaw.WeaponCatalogRegister"))

			if WeaponCatalogRegister then
				local WeaponEquipParamCatalogUserData = WeaponCatalogRegister:call("get_WeaponEquipParamCatalogUserData")

				if WeaponEquipParamCatalogUserData then
					WeaponDataTables_2nd = WeaponEquipParamCatalogUserData:get_field("_DataTable")
					WeaponDataTables_2nd = WeaponDataTables_2nd and WeaponDataTables_2nd:get_elements() or {}
					catalogFound = true
				end
			end
		end
	end

  if not WeaponDetailStages[1] then
		local WeaponCustomCatalog = Scene:call("findGameObject(System.String)", "WeaponCustomCatalog")

		-- support mercenaries mode
		if not WeaponCustomCatalog then
			WeaponCustomCatalog = Scene:call("findGameObject(System.String)", "WeaponCustomCatalog_MC")
		end

		-- support separate ways
		if not WeaponCustomCatalog then
			WeaponCustomCatalog = Scene:call("findGameObject(System.String)", "WeaponCustomCatalog_AO")
		end

		if WeaponCustomCatalog then
			local WeaponCustomCatalogRegister = WeaponCustomCatalog:call("getComponent(System.Type)", sdk.typeof("chainsaw.WeaponCustomCatalogRegister"))

			if WeaponCustomCatalogRegister then
				local WeaponCustomUserdata = WeaponCustomCatalogRegister:call("get_WeaponCustomUserdata")
				local WeaponDetailCustomUserdata = WeaponCustomCatalogRegister:call("get_WeaponDetailCustomUserdata")

				if WeaponCustomUserdata then
					WeaponStages = WeaponCustomUserdata:get_field("_WeaponStages")
					WeaponStages = WeaponStages and WeaponStages:get_elements() or {}
				end

				if WeaponDetailCustomUserdata then
					WeaponDetailStages = WeaponDetailCustomUserdata:get_field("_WeaponDetailStages")
					WeaponDetailStages = WeaponDetailStages and WeaponDetailStages:get_elements() or {}
				end

				customCatalogFound = true
			end
		end
	end

  return catalogFound and customCatalogFound
end

local function apply_weapon_stats(weaponId)
	if PlayerInventory[weaponId] then
		table.insert(InventoryItemsToUpdate, weaponId)
	end
end

local function apply_all_weapon_stats()
	log.info("Weapon Service: Applying all weapon stats...")
	for k,v in pairs(PlayerInventory) do
		if not InventoryItemsToUpdate[k] then
			table.insert(InventoryItemsToUpdate, k)
		end
	end
end

local function update_player_inventory()
  local inventoryChanged = false
	local addedWeaponId = nil

	-- find and cache cs inventory
	if CS_Inventory == nil then
		local PlayerInventoryObserver = Scene:call("findGameObject(System.String)", "PlayerInventoryObserver")

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
	end

	if CS_Inventory then
		local InventoryItems = CS_Inventory:get_field("_InventoryItems")

		if InventoryItems then
			local PlayerItems = InventoryItems:get_field("_items")
			PlayerItems = PlayerItems and PlayerItems:get_elements() or {}
			
			local updatedInventory = {}
			local updatedInventoryCount = 0

			for i, Item in ipairs(PlayerItems) do
				local WeaponId = Item:call("get_WeaponId")

				if WeaponId and WeaponId ~= -1 and WeaponIDTypeMap[WeaponId] ~= nil then
					updatedInventory[WeaponId] = Item
					updatedInventoryCount = updatedInventoryCount + 1

					if PlayerInventory[WeaponId] == nil then
						addedWeaponId = WeaponId
						table.insert(InventoryItemsToUpdate, WeaponId)
						log.info("Weapon Service: Weapon " .. WeaponId .. " added to inventory")
					end
				end
			end

			inventoryChanged = updatedInventoryCount ~= OldInventoryCount

      if inventoryChanged then
        OldInventoryCount = updatedInventoryCount
        PlayerInventory = updatedInventory
      end
		end
	end

  return inventoryChanged, addedWeaponId
end

local function get_weapon(weaponId)
	local Weapon = nil

	for k, v in pairs(Weapons) do
		if v.Id == weaponId then
			Weapon = v
			break
		end
	end

	return Weapon
end

local function get_weapon_custom(weaponId)
  local WeaponCustom = nil

  if WeaponStages[1] and weaponId ~= nil then
    for i, ItemID in ipairs(WeaponStages) do
      local WeaponIDValue = ItemID:call("get_WeaponID")

      if WeaponIDValue == weaponId then
        WeaponCustom = ItemID:get_field("_WeaponCustom")
        break
      end
    end
  end

  return WeaponCustom
end

local function get_weapon_detail_custom(weaponId)
  local WeaponDetailCustom = nil

  if WeaponDetailStages[1] and weaponId ~= nil then
    for i, ItemID in ipairs(WeaponDetailStages) do
      local WeaponIDValue = ItemID:call("get_WeaponID")

      if WeaponIDValue == weaponId then
        WeaponDetailCustom = ItemID:get_field("_WeaponDetailCustom")
        break
      end
    end
  end

  return WeaponDetailCustom
end

local function get_weapon_data_table(weaponId)
  local WeaponDataTable = nil

  if WeaponDataTables[1] and weaponId ~= nil then
    for i, ItemID in ipairs(WeaponDataTables) do
      local WeaponIDValue = ItemID:call("get_WeaponID")

      if WeaponIDValue == weaponId then
        WeaponDataTable = ItemID
        break
      end
    end
  end

  if WeaponDataTable == nil and WeaponDataTables_2nd[1] then
    for i, ItemID in ipairs(WeaponDataTables_2nd) do
      local WeaponIDValue = ItemID:call("get_WeaponID")

      if WeaponIDValue == weaponId then
        WeaponDataTable = ItemID
        break
      end
    end
  end

  return WeaponDataTable
end

local function get_inventory_item(weaponId)
  local InventoryItem = nil

	local weapon = PlayerInventory[weaponId]
	if weapon ~= nil then
		InventoryItem = weapon:get_field("<Item>k__BackingField")
	end

  return InventoryItem
end

local function update_gun(weaponId, weaponType, weaponStats)
	local gunUpdated = false
	local Gun_GameObject = Scene:call("findGameObject(System.String)", "wp" .. tostring(weaponId))

	-- support mercenaries mode
	if not Gun_GameObject then
		Gun_GameObject = Scene:call("findGameObject(System.String)", "wp" .. tostring(weaponId) .. "_MC")
	end

	-- support separate ways
	if not Gun_GameObject then
		Gun_GameObject = Scene:call("findGameObject(System.String)", "wp" .. tostring(weaponId) .. "_AO")
	end	

	if Gun_GameObject then
		local Gun = Gun_GameObject:call("getComponent(System.Type)", sdk.typeof("chainsaw.Gun"))

		if Gun then
			gunUpdated = true
			local Shell = Gun:get_field("<ShellGenerator>k__BackingField")
			local WPstructParams = Gun:get_field("WeaponStructureParam")
			local ThinkPlayerParam = Gun:get_field("<ThinkPlayerParam>k__BackingField")
			local Focus = Gun:get_field("<ReticleFitParam>k__BackingField")

			if Shell then
				local Shell_UserData = Shell:get_field("_UserData")

				if weaponType == "BOLT" or weaponType == "BOW" then
					local Shell_BombSettings = Shell:get_field("_ArrowBombShellGeneratorUserData")

					if Shell_BombSettings then
						Shell_BombSettings._BombStartTime = weaponStats.BOMB_START
						Shell_BombSettings._SensorTime = weaponStats.SENSOR
						Shell_BombSettings._SensorRadius = weaponStats.SENSOR_RAD
					end
				end

				if Shell_UserData then
					local Shell_HG_SMG_SR_MAG = Shell_UserData:get_field("_ShellInfoUserData")
					local ShellSG_CenterUserData = Shell_UserData:get_field("_CenterShellInfoUserData")
					local ShellSG_AroundUserData = Shell_UserData:get_field("_AroundShellInfoUserData")
					local ShellSG_AroundSettings = Shell_UserData:get_field("_AroundShellSetting")
					
					if weaponType == "SG" or weaponType == "SG_PUMP" then
						if ShellSG_CenterUserData then
							local ShellSG_CenterUserData_Life = ShellSG_CenterUserData:get_field("_LifeInfo")
							local ShellSG_CenterUserData_Move = ShellSG_CenterUserData:get_field("_MoveInfo")
							local ShellSG_CenterUserData_Attack = ShellSG_CenterUserData:get_field("_AttackInfo")

							if ShellSG_CenterUserData_Life then
								ShellSG_CenterUserData_Life._Time = weaponStats.SG_CenterLife_Time
								ShellSG_CenterUserData_Life._Distance = weaponStats.SG_CenterLife_Distance
							end

							if ShellSG_CenterUserData_Move then
								ShellSG_CenterUserData_Move._RandomRadius = weaponStats.SG_Center_Random
								ShellSG_CenterUserData_Move._RandomRadius_Fit = weaponStats.SG_Center_RandomFit
								ShellSG_CenterUserData_Move._Speed = weaponStats.SG_CenterMove_Speed
								ShellSG_CenterUserData_Move._Gravity = weaponStats.SG_CenterMove_Gravity
								ShellSG_CenterUserData_Move._IgnoreGravityDistance = weaponStats.SG_CenterMove_IGD
							end

							if ShellSG_CenterUserData_Attack then
								local ShellSG_CenterUserData_Attack_DamgeRate = ShellSG_CenterUserData_Attack:get_field("_DamageRate")
								local ShellSG_CenterUserData_Attack_WinceRate = ShellSG_CenterUserData_Attack:get_field("_WinceRate")
								local ShellSG_CenterUserData_Attack_BreakRate = ShellSG_CenterUserData_Attack:get_field("_BreakRate")
								local ShellSG_CenterUserData_Attack_StopRate = ShellSG_CenterUserData_Attack:get_field("_StoppingRate")

								ShellSG_CenterUserData_Attack._ColliderRadius = weaponStats.SG_Center_BulletCol
								ShellSG_CenterUserData_Attack._CriticalRate = weaponStats.SG_Center_CritRate
								ShellSG_CenterUserData_Attack._CriticalRate_Fit = weaponStats.SG_Center_CritRate_EX

								if ShellSG_CenterUserData_Attack_DamgeRate then
									ShellSG_CenterUserData_Attack_DamgeRate._BaseValue = weaponStats.SG_Center_BaseDMG
								end

								if ShellSG_CenterUserData_Attack_WinceRate then
									ShellSG_CenterUserData_Attack_WinceRate._BaseValue = weaponStats.SG_Center_BaseWINC
								end

								if ShellSG_CenterUserData_Attack_BreakRate then
									ShellSG_CenterUserData_Attack_BreakRate._BaseValue = weaponStats.SG_Center_BaseBRK
								end

								if ShellSG_CenterUserData_Attack_StopRate then
									ShellSG_CenterUserData_Attack_StopRate._BaseValue = weaponStats.SG_Center_BaseSTOP
								end
							end
						else
							gunUpdated = false
						end

						if ShellSG_AroundUserData then
							local ShellSG_AroundUserData_Life = ShellSG_AroundUserData:get_field("_LifeInfo")
							local ShellSG_AroundUserData_Move = ShellSG_AroundUserData:get_field("_MoveInfo")
							local ShellSG_AroundUserData_Attack = ShellSG_AroundUserData:get_field("_AttackInfo")

							if ShellSG_AroundUserData_Life then
								ShellSG_AroundUserData_Life._Time = weaponStats.SG_AroundLife_Time
								ShellSG_AroundUserData_Life._Distance = weaponStats.SG_AroundLife_Distance
							end

							if ShellSG_AroundUserData_Move then
								ShellSG_AroundUserData_Move._RandomRadius = weaponStats.SG_Around_Random
								ShellSG_AroundUserData_Move._RandomRadius_Fit = weaponStats.SG_Around_RandomFit
								ShellSG_AroundUserData_Move._Speed = weaponStats.SG_AroundMove_Speed
								ShellSG_AroundUserData_Move._Gravity = weaponStats.SG_AroundMove_Gravity
								ShellSG_AroundUserData_Move._IgnoreGravityDistance = weaponStats.SG_AroundMove_IGD
							end

							if ShellSG_AroundUserData_Attack then
								local ShellSG_AroundUserData_Attack_DamgeRate = ShellSG_AroundUserData_Attack:get_field("_DamageRate")
								local ShellSG_AroundUserData_Attack_WinceRate = ShellSG_AroundUserData_Attack:get_field("_WinceRate")
								local ShellSG_AroundUserData_Attack_BreakRate = ShellSG_AroundUserData_Attack:get_field("_BreakRate")
								local ShellSG_AroundUserData_Attack_StopRate = ShellSG_AroundUserData_Attack:get_field("_StoppingRate")

								ShellSG_AroundUserData_Attack._ColliderRadius = weaponStats.SG_Around_BulletCol
								ShellSG_AroundUserData_Attack._CriticalRate = weaponStats.SG_Around_CritRate
								ShellSG_AroundUserData_Attack._CriticalRate_Fit = weaponStats.SG_Around_CritRate_EX

								if ShellSG_AroundUserData_Attack_DamgeRate then
									ShellSG_AroundUserData_Attack_DamgeRate._BaseValue = weaponStats.SG_Around_BaseDMG
								end

								if ShellSG_AroundUserData_Attack_WinceRate then
									ShellSG_AroundUserData_Attack_WinceRate._BaseValue = weaponStats.SG_Around_BaseWINC
								end

								if ShellSG_AroundUserData_Attack_BreakRate then
									ShellSG_AroundUserData_Attack_BreakRate._BaseValue = weaponStats.SG_Around_BaseBRK
								end

								if ShellSG_AroundUserData_Attack_StopRate then
									ShellSG_AroundUserData_Attack_StopRate._BaseValue = weaponStats.SG_Around_BaseSTOP
								end
							end
						else
							gunUpdated = false
						end

						if ShellSG_AroundSettings then
							local SG_AroundScatterParam = ShellSG_AroundSettings:get_field("_AroundScatterParam")

							ShellSG_AroundSettings._AroundBulletCount = weaponStats.SG_AroundBulletCount
							ShellSG_AroundSettings._CenterBulletCount = weaponStats.SG_CenterBulletCount
							ShellSG_AroundSettings._InnerRadius = weaponStats.SG_InnerRadius
							ShellSG_AroundSettings._OuterRadius = weaponStats.SG_OuterRadius

							if SG_AroundScatterParam then
								local SG_VertScatterRange = SG_AroundScatterParam:get_field("_VerticalScatterDegreeRange")
								local SG_HorScatterRange = SG_AroundScatterParam:get_field("_HorizontalScatterDegreeRange")

								if SG_VertScatterRange then
									SG_VertScatterRange.s = weaponStats.SG_AroundVertMin
									SG_VertScatterRange.r = weaponStats.SG_AroundVertMax
									write_valuetype(SG_AroundScatterParam, 0x10, SG_VertScatterRange)
								else
									gunUpdated = false
								end

								if SG_HorScatterRange then
									SG_HorScatterRange.s = weaponStats.SG_AroundHorMin
									SG_HorScatterRange.r = weaponStats.SG_AroundHorMax
									write_valuetype(SG_AroundScatterParam, 0x18, SG_HorScatterRange)
								else
									gunUpdated = false
								end
							else
								gunUpdated = false
							end
						else
							gunUpdated = false
						end
					end

					if weaponType ~= "SG" and weaponType ~= "SG_PUMP" then
						if Shell_HG_SMG_SR_MAG then
							local ShellHG_UserData_Life = Shell_HG_SMG_SR_MAG:get_field("_LifeInfo")
							local ShellHG_UserData_Move = Shell_HG_SMG_SR_MAG:get_field("_MoveInfo")
							local ShellHG_UserData_Attack = Shell_HG_SMG_SR_MAG:get_field("_AttackInfo")

							if ShellHG_UserData_Life then
								ShellHG_UserData_Life._Time = weaponStats.HG_Time
								ShellHG_UserData_Life._Distance = weaponStats.HG_Distance
							end

							if ShellHG_UserData_Move then
								ShellHG_UserData_Move._Speed = weaponStats.HG_BulletSpeed
								ShellHG_UserData_Move._Gravity = weaponStats.HG_BulletGravity
								ShellHG_UserData_Move._IgnoreGravityDistance = weaponStats.HG_BulletGravityIgnore
								ShellHG_UserData_Move._RandomRadius = weaponStats.SMG_Random
								ShellHG_UserData_Move._RandomRadius_Fit = weaponStats.SMG_RandomFit
							end

							if ShellHG_UserData_Attack then
								local ShellHG_UserData_Attack_DamageRate = ShellHG_UserData_Attack:get_field("_DamageRate")
								local ShellHG_UserData_Attack_WinceRate = ShellHG_UserData_Attack:get_field("_WinceRate")
								local ShellHG_UserData_Attack_BreakRate = ShellHG_UserData_Attack:get_field("_BreakRate")
								local ShellHG_UserData_Attack_StopRate = ShellHG_UserData_Attack:get_field("_StoppingRate")

								ShellHG_UserData_Attack._ColliderRadius = weaponStats.HG_BulletCol
								ShellHG_UserData_Attack._CriticalRate = weaponStats.HG_CritRate
								ShellHG_UserData_Attack._CriticalRate_Fit = weaponStats.HG_CritRateEX

								if ShellHG_UserData_Attack_DamageRate then
									ShellHG_UserData_Attack_DamageRate._BaseValue = weaponStats.HG_BaseDMG
								end
								if ShellHG_UserData_Attack_WinceRate then
									ShellHG_UserData_Attack_WinceRate._BaseValue = weaponStats.HG_BaseWINC
								end
								if ShellHG_UserData_Attack_BreakRate then
									ShellHG_UserData_Attack_BreakRate._BaseValue = weaponStats.HG_BaseBRK
								end
								if ShellHG_UserData_Attack_StopRate then
									ShellHG_UserData_Attack_StopRate._BaseValue = weaponStats.HG_BaseSTOP
								end
							end
						else
							gunUpdated = false
						end
					end
				else
					gunUpdated = false
				end
			else
				gunUpdated = false
			end

			if WPstructParams then
				WPstructParams.TypeOfReload = weaponStats.ReloadType
				WPstructParams.TypeOfShoot = weaponStats.ShootType
				WPstructParams.ReloadNum = weaponStats.ReloadNum
				WPstructParams._ReloadSpeedRate = weaponStats.ReloadSpeedRate
				WPstructParams._RapidSpeed = weaponStats.FireRate
				WPstructParams._RapidBaseFrame = weaponStats.FireRateFrame
				WPstructParams._PumpActionRapidSpeed = weaponStats.PumpActionFireRate
			end

			if ThinkPlayerParam then
				ThinkPlayerParam.RangeDistance = weaponStats.ThinkRange
			end

			if weaponType ~= "SR" and weaponType ~= "SR_PUMP" then
				if Focus then
					Focus._HoldAddPoint = weaponStats.Focus_HoldAdd
					Focus._MoveSubPoint = weaponStats.Focus_MoveSub
					Focus._CameraSubPoint = weaponStats.Focus_CamSub
					Focus._KeepFitLimitPoint = weaponStats.Focus_Limit
					Focus._ShootSubPoint = weaponStats.Focus_ShootSub
				else
					gunUpdated = false
				end
			end
		end
	end

	return gunUpdated
end

local function update_knife(weaponId, weaponStats)
  local knifeUpdated = false
  local RepairSettings = nil
  local RepairSetting = nil

  local InGameShopCatalog = Scene:call("findGameObject(System.String)", "InGameShopCatalog_1st")

  if InGameShopCatalog then
    local CatalogRegister = InGameShopCatalog:call("getComponent(System.Type)", sdk.typeof("chainsaw.InGameShopCatalogRegister"))

    if CatalogRegister then
      log.info("Found CatalogRegister in 1st")

      local InGameShopItemSettingUserdata = CatalogRegister:get_field("_InGameShopItemSettingUserdata")

      if InGameShopItemSettingUserdata then
        log.info("Found InGameShopItemSettingUserdata in 1st")

        RepairSettings = InGameShopItemSettingUserdata:get_field("_RepairSettings")
      end
    end
  end

  if not RepairSettings then
    InGameShopCatalog = Scene:call("findGameObject(System.String)", "InGameShopCatalog_AO")

    if InGameShopCatalog then
      local CatalogRegister = InGameShopCatalog:call("getComponent(System.Type)", sdk.typeof("chainsaw.InGameShopCatalogRegister"))
  
      if CatalogRegister then
        log.info("Found CatalogRegister in AO")
  
        local InGameShopItemSettingUserdata = CatalogRegister:get_field("_InGameShopItemSettingUserdata")
  
        if InGameShopItemSettingUserdata then
          log.info("Found InGameShopItemSettingUserdata in AO")

          RepairSettings = InGameShopItemSettingUserdata:get_field("_RepairSettings")
        end
      end
    end
  end

  if RepairSettings then
    log.info("Found RepairSettings")
    local length = RepairSettings:call("get_Count") - 1

    for i=0,length do
      local SettingItemId = RepairSettings[i]:get_field("_ItemId")

      if SettingItemId then
        if Repair_IDs[SettingItemId] and Repair_IDs[SettingItemId] == tostring(weaponId) then
          RepairSetting = RepairSettings[i]
          break
        end
      end
    end
  end

  if RepairSetting then
    log.info("Found RepairSetting for " .. weaponId)

    local Settings = RepairSetting:get_field("_Settings")

    if Settings then
      log.info("Found Settings for " .. weaponId)

      Settings[0]._Commission = weaponStats.Rank_10_Commission
      Settings[0]._DurabilityCost = weaponStats.Rank_10_DurabilityCost
      Settings[0]._RepairCost = weaponStats.Rank_10_RepairCost

      Settings[1]._Commission = weaponStats.Rank_20_Commission
      Settings[1]._DurabilityCost = weaponStats.Rank_20_DurabilityCost
      Settings[1]._RepairCost = weaponStats.Rank_20_RepairCost

      Settings[2]._Commission = weaponStats.Rank_30_Commission
      Settings[2]._DurabilityCost = weaponStats.Rank_30_DurabilityCost
      Settings[2]._RepairCost = weaponStats.Rank_30_RepairCost

      Settings[3]._Commission = weaponStats.Rank_40_Commission
      Settings[3]._DurabilityCost = weaponStats.Rank_40_DurabilityCost
      Settings[3]._RepairCost = weaponStats.Rank_40_RepairCost

      knifeUpdated = true
    end
  end

  return knifeUpdated
end

local function update_weapon_custom(weaponId, weaponStats)
	local weaponCustomUpdated = false
	local WeaponCustom = get_weapon_custom(weaponId)

	if WeaponCustom then
		weaponCustomUpdated = true
		local Custom_Commons = WeaponCustom:get_field("_Commons")
		local Custom_Commons = Custom_Commons and Custom_Commons:get_elements() or {}

		local Custom_Individuals = WeaponCustom:get_field("_Individuals")
		local Custom_Individuals = Custom_Individuals and Custom_Individuals:get_elements() or {}

		local Custom_LimitBreak = WeaponCustom:get_field("_LimitBreak")
		local Custom_LimitBreak = Custom_LimitBreak and Custom_LimitBreak:get_elements() or {}

		if Custom_Commons then
			for i, CommonCategories in ipairs(Custom_Commons) do
				local Custom_CategoryID = CommonCategories:call("get_CommonCustomCategory")

				if Custom_CategoryID == 0 or Custom_CategoryID == "0" then
					local Custom_CustomAttackUp = CommonCategories:get_field("_CustomAttackUp")

					if Custom_CustomAttackUp then
						local Custom_CustomAttackUp_Stages = Custom_CustomAttackUp:get_field("_AttackUpCustomStages")
						local Custom_CustomAttackUp_Stages = Custom_CustomAttackUp_Stages and Custom_CustomAttackUp_Stages:get_elements() or {}

						if Custom_CustomAttackUp_Stages then
							Custom_CustomAttackUp_Stages[1]._Info = weaponStats.DMG_LVL_01_INFO
							Custom_CustomAttackUp_Stages[2]._Info = weaponStats.DMG_LVL_02_INFO
							Custom_CustomAttackUp_Stages[3]._Info = weaponStats.DMG_LVL_03_INFO
							Custom_CustomAttackUp_Stages[4]._Info = weaponStats.DMG_LVL_04_INFO
							Custom_CustomAttackUp_Stages[5]._Info = weaponStats.DMG_LVL_05_INFO

							Custom_CustomAttackUp_Stages[1]._Cost = weaponStats.DMG_LVL_01_COST
							Custom_CustomAttackUp_Stages[2]._Cost = weaponStats.DMG_LVL_02_COST
							Custom_CustomAttackUp_Stages[3]._Cost = weaponStats.DMG_LVL_03_COST
							Custom_CustomAttackUp_Stages[4]._Cost = weaponStats.DMG_LVL_04_COST
							Custom_CustomAttackUp_Stages[5]._Cost = weaponStats.DMG_LVL_05_COST
						else
							weaponCustomUpdated = false
						end
					else
						weaponCustomUpdated = false
					end
				end

				if Custom_CategoryID and (Custom_CategoryID == 2 or Custom_CategoryID == "2") then
					local Custom_CustomAmmoMaxUp = CommonCategories:get_field("_CustomAmmoMaxUp")

					if Custom_CustomAmmoMaxUp then
						local Custom_CustomAmmoMaxUp_Stages = Custom_CustomAmmoMaxUp:get_field("_AmmoMaxUpCustomStages")
						local Custom_CustomAmmoMaxUp_Stages = Custom_CustomAmmoMaxUp_Stages and Custom_CustomAmmoMaxUp_Stages:get_elements() or {}

						if Custom_CustomAmmoMaxUp_Stages then
							Custom_CustomAmmoMaxUp_Stages[1]._Info = weaponStats.AMMO_LVL_01_INFO
							Custom_CustomAmmoMaxUp_Stages[2]._Info = weaponStats.AMMO_LVL_02_INFO
							Custom_CustomAmmoMaxUp_Stages[3]._Info = weaponStats.AMMO_LVL_03_INFO
							Custom_CustomAmmoMaxUp_Stages[4]._Info = weaponStats.AMMO_LVL_04_INFO
							Custom_CustomAmmoMaxUp_Stages[5]._Info = weaponStats.AMMO_LVL_05_INFO

							Custom_CustomAmmoMaxUp_Stages[1]._Cost = weaponStats.AMMO_LVL_01_COST
							Custom_CustomAmmoMaxUp_Stages[2]._Cost = weaponStats.AMMO_LVL_02_COST
							Custom_CustomAmmoMaxUp_Stages[3]._Cost = weaponStats.AMMO_LVL_03_COST
							Custom_CustomAmmoMaxUp_Stages[4]._Cost = weaponStats.AMMO_LVL_04_COST
							Custom_CustomAmmoMaxUp_Stages[5]._Cost = weaponStats.AMMO_LVL_05_COST
						else
							weaponCustomUpdated = false
						end
					else
						weaponCustomUpdated = false
					end
				end
			end
		end

		if Custom_Individuals then
			for i, IndividualCategories in ipairs(Custom_Individuals) do
				local Custom_CategoryID = IndividualCategories:call("get_IndividualCustomCategory")

				if Custom_CategoryID == 4 then
					local Custom_Repair = IndividualCategories:get_field("_CustomRepair")

					if Custom_Repair then
						local Custom_RepairStages = Custom_Repair:get_field("_RepairCustomStages")

						if Custom_RepairStages then
							Custom_RepairStages[0]._Cost = weaponStats.Repair_Cost
						end
					end
				end

				if Custom_CategoryID == 5 then
					local Custom_Polish = IndividualCategories:get_field("_CustomPolish")
					
					if Custom_Polish then
						local Custom_PolishStages = Custom_Polish:get_field("_PolishCustomStages")

						if Custom_PolishStages then
							Custom_PolishStages[0]._Cost = weaponStats.Polish_Cost
						end
					end
				end

				if Custom_CategoryID == 6 then
					local Custom_Strength = IndividualCategories:get_field("_CustomStrength")

					if Custom_Strength then
						local Custom_StrengthStages = Custom_Strength:get_field("_StrengthCustomStages")

						if Custom_StrengthStages then
							Custom_StrengthStages[0]._Info = weaponStats.Dur_LVL_01_MAX_INFO
							Custom_StrengthStages[1]._Info = weaponStats.Dur_LVL_02_MAX_INFO
							Custom_StrengthStages[2]._Info = weaponStats.Dur_LVL_03_MAX_INFO
							Custom_StrengthStages[3]._Info = weaponStats.Dur_LVL_04_MAX_INFO
							Custom_StrengthStages[4]._Info = weaponStats.Dur_LVL_05_MAX_INFO

							Custom_StrengthStages[0]._Cost = weaponStats.Dur_LVL_01_COST
							Custom_StrengthStages[1]._Cost = weaponStats.Dur_LVL_02_COST
							Custom_StrengthStages[2]._Cost = weaponStats.Dur_LVL_03_COST
							Custom_StrengthStages[3]._Cost = weaponStats.Dur_LVL_04_COST
							Custom_StrengthStages[4]._Cost = weaponStats.Dur_LVL_05_COST
						end
					end
				end

				if Custom_CategoryID == 7 then
					local Custom_CustomReloadSpeed = IndividualCategories:get_field("_CustomReloadSpeed")

					if Custom_CustomReloadSpeed then
						local Custom_CustomReloadSpeed_Stages = Custom_CustomReloadSpeed:get_field("_ReloadSpeedCustomStages")
						local Custom_CustomReloadSpeed_Stages = Custom_CustomReloadSpeed_Stages and Custom_CustomReloadSpeed_Stages:get_elements() or {}

						if Custom_CustomReloadSpeed_Stages then
							Custom_CustomReloadSpeed_Stages[1]._Info = weaponStats.RELOAD_LVL_01_INFO
							Custom_CustomReloadSpeed_Stages[2]._Info = weaponStats.RELOAD_LVL_02_INFO
							Custom_CustomReloadSpeed_Stages[3]._Info = weaponStats.RELOAD_LVL_03_INFO
							Custom_CustomReloadSpeed_Stages[4]._Info = weaponStats.RELOAD_LVL_04_INFO
							Custom_CustomReloadSpeed_Stages[5]._Info = weaponStats.RELOAD_LVL_05_INFO

							Custom_CustomReloadSpeed_Stages[1]._Cost = weaponStats.RELOAD_LVL_01_COST
							Custom_CustomReloadSpeed_Stages[2]._Cost = weaponStats.RELOAD_LVL_02_COST
							Custom_CustomReloadSpeed_Stages[3]._Cost = weaponStats.RELOAD_LVL_03_COST
							Custom_CustomReloadSpeed_Stages[4]._Cost = weaponStats.RELOAD_LVL_04_COST
							Custom_CustomReloadSpeed_Stages[5]._Cost = weaponStats.RELOAD_LVL_05_COST
						else
							weaponCustomUpdated = false
						end
					else
						weaponCustomUpdated = false
					end
				end

				if Custom_CategoryID == 8 then
					local Custom_CustomRapid = IndividualCategories:get_field("_CustomRapid")

					if Custom_CustomRapid then
						local Custom_CustomRapid_Stages = Custom_CustomRapid:get_field("_RapidCustomStages")
						local Custom_CustomRapid_Stages = Custom_CustomRapid_Stages and Custom_CustomRapid_Stages:get_elements() or {}

						if Custom_CustomRapid_Stages then
							Custom_CustomRapid_Stages[1]._Info = weaponStats.ROF_LVL_01_INFO
							Custom_CustomRapid_Stages[2]._Info = weaponStats.ROF_LVL_02_INFO
							Custom_CustomRapid_Stages[3]._Info = weaponStats.ROF_LVL_03_INFO
							Custom_CustomRapid_Stages[4]._Info = weaponStats.ROF_LVL_04_INFO
							Custom_CustomRapid_Stages[5]._Info = weaponStats.ROF_LVL_05_INFO

							Custom_CustomRapid_Stages[1]._Cost = weaponStats.ROF_LVL_01_COST
							Custom_CustomRapid_Stages[2]._Cost = weaponStats.ROF_LVL_02_COST
							Custom_CustomRapid_Stages[3]._Cost = weaponStats.ROF_LVL_03_COST
							Custom_CustomRapid_Stages[4]._Cost = weaponStats.ROF_LVL_04_COST
							Custom_CustomRapid_Stages[5]._Cost = weaponStats.ROF_LVL_05_COST
						else
							weaponCustomUpdated = false
						end
					else
						weaponCustomUpdated = false
					end
				end
			end
		end

		if Custom_LimitBreak then
			for i, LimitBreakCategories in ipairs(Custom_LimitBreak) do
				local Custom_CustomLimitBreak = LimitBreakCategories:get_field("_CustomLimitBreak")

				if Custom_CustomLimitBreak then
					local Custom_CustomLimitBreak_Stages = Custom_CustomLimitBreak:get_field("_LimitBreakCustomStages")
					local Custom_CustomLimitBreak_Stages = Custom_CustomLimitBreak_Stages and Custom_CustomLimitBreak_Stages:get_elements() or {}

					if Custom_CustomLimitBreak_Stages then
						Custom_CustomLimitBreak_Stages[1]._Cost = weaponStats.EX_COST
					end
				end
			end
		end
	end

	return weaponCustomUpdated
end

local function update_weapon_detail_custom(weaponId, weaponType, weaponStats)
	local weaponDetailCustomUpdated = false
  local WeaponDetailCustom = get_weapon_detail_custom(weaponId)

	if WeaponDetailCustom then
		weaponDetailCustomUpdated = true
		local Custom_CommonCustoms = WeaponDetailCustom:get_field("_CommonCustoms")
		Custom_CommonCustoms = Custom_CommonCustoms and Custom_CommonCustoms:get_elements() or {}

		local Custom_IndividualCustoms = WeaponDetailCustom:get_field("_IndividualCustoms")
		Custom_IndividualCustoms = Custom_IndividualCustoms and Custom_IndividualCustoms:get_elements() or {}

		local Custom_LimitBreakCustoms = WeaponDetailCustom:get_field("_LimitBreakCustoms")
		Custom_LimitBreakCustoms = Custom_LimitBreakCustoms and Custom_LimitBreakCustoms:get_elements() or {}

		local Custom_AttachmentCustoms = WeaponDetailCustom:get_field("_AttachmentCustoms")
		Custom_AttachmentCustoms = Custom_AttachmentCustoms and Custom_AttachmentCustoms:get_elements() or {}

		if Custom_CommonCustoms then
			for i, CommonCategories in ipairs(Custom_CommonCustoms) do
				local Custom_CategoryID = CommonCategories:call("get_CommonCustomCategory")

				if Custom_CategoryID == 0 or Custom_CategoryID == "0" then
					local Custom_AttackUp = CommonCategories:get_field("_AttackUp")

					if Custom_AttackUp then
						local Custom_DamageRate = Custom_AttackUp:get_field("_DamageRates")
						Custom_DamageRate = Custom_DamageRate and Custom_DamageRate:get_elements() or {}

						local Custom_WinceRate = Custom_AttackUp:get_field("_WinceRates")
						Custom_WinceRate = Custom_WinceRate and Custom_WinceRate:get_elements() or {}

						local Custom_BreakRate = Custom_AttackUp:get_field("_BreakRates")
						Custom_BreakRate = Custom_BreakRate and Custom_BreakRate:get_elements() or {}

						local Custom_StoppingRate = Custom_AttackUp:get_field("_StoppingRates")
						Custom_StoppingRate = Custom_StoppingRate and Custom_StoppingRate:get_elements() or {}

            local Custom_ExplosionRadiusScale = Custom_AttackUp:get_field("_ExplosionRadiusScale")
						Custom_ExplosionRadiusScale = Custom_ExplosionRadiusScale and Custom_ExplosionRadiusScale:get_elements() or {}

						if Custom_DamageRate and Custom_DamageRate[5] then
							Custom_DamageRate[1]:set_field("_BaseValue", weaponStats.DMG_LVL_01)
							Custom_DamageRate[2]:set_field("_BaseValue", weaponStats.DMG_LVL_02)
							Custom_DamageRate[3]:set_field("_BaseValue", weaponStats.DMG_LVL_03)
							Custom_DamageRate[4]:set_field("_BaseValue", weaponStats.DMG_LVL_04)
							Custom_DamageRate[5]:set_field("_BaseValue", weaponStats.DMG_LVL_05)
						end

						if Custom_WinceRate and Custom_WinceRate[5] then
							Custom_WinceRate[1]:set_field("_BaseValue", weaponStats.WINC_LVL_01)
							Custom_WinceRate[2]:set_field("_BaseValue", weaponStats.WINC_LVL_02)
							Custom_WinceRate[3]:set_field("_BaseValue", weaponStats.WINC_LVL_03)
							Custom_WinceRate[4]:set_field("_BaseValue", weaponStats.WINC_LVL_04)
							Custom_WinceRate[5]:set_field("_BaseValue", weaponStats.WINC_LVL_05)
						end

						if Custom_BreakRate and Custom_BreakRate[5] then
							Custom_BreakRate[1]:set_field("_BaseValue", weaponStats.BRK_LVL_01)
							Custom_BreakRate[2]:set_field("_BaseValue", weaponStats.BRK_LVL_02)
							Custom_BreakRate[3]:set_field("_BaseValue", weaponStats.BRK_LVL_03)
							Custom_BreakRate[4]:set_field("_BaseValue", weaponStats.BRK_LVL_04)
							Custom_BreakRate[5]:set_field("_BaseValue", weaponStats.BRK_LVL_05)
						end

						if Custom_StoppingRate and Custom_StoppingRate[5] then
							Custom_StoppingRate[1]:set_field("_BaseValue", weaponStats.STOP_LVL_01)
							Custom_StoppingRate[2]:set_field("_BaseValue", weaponStats.STOP_LVL_02)
							Custom_StoppingRate[3]:set_field("_BaseValue", weaponStats.STOP_LVL_03)
							Custom_StoppingRate[4]:set_field("_BaseValue", weaponStats.STOP_LVL_04)
							Custom_StoppingRate[5]:set_field("_BaseValue", weaponStats.STOP_LVL_05)
						end

            if weaponType == "BOW" then
              Custom_AttackUp._ExplosionRadiusScale[0] = weaponStats.EXP_RAD_LVL_01
              Custom_AttackUp._ExplosionRadiusScale[1] = weaponStats.EXP_RAD_LVL_02
              Custom_AttackUp._ExplosionRadiusScale[2] = weaponStats.EXP_RAD_LVL_03
              Custom_AttackUp._ExplosionRadiusScale[3] = weaponStats.EXP_RAD_LVL_04
              Custom_AttackUp._ExplosionRadiusScale[4] = weaponStats.EXP_RAD_LVL_05
            end
					else
						weaponDetailCustomUpdated = false
					end
				end

				if Custom_CategoryID == 2 then
					local Custom_AmmoMaxUp = CommonCategories:get_field("_AmmoMaxUp")

					if Custom_AmmoMaxUp then
						Custom_AmmoMaxUp._AmmoMaxs[0] = weaponStats.AMMO_LVL_01
						Custom_AmmoMaxUp._AmmoMaxs[1] = weaponStats.AMMO_LVL_02
						Custom_AmmoMaxUp._AmmoMaxs[2] = weaponStats.AMMO_LVL_03
						Custom_AmmoMaxUp._AmmoMaxs[3] = weaponStats.AMMO_LVL_04
						Custom_AmmoMaxUp._AmmoMaxs[4] = weaponStats.AMMO_LVL_05
					else
						weaponDetailCustomUpdated = false
					end
				end
			end
		else
			weaponDetailCustomUpdated = false
		end

		if Custom_IndividualCustoms then
			for i, IndividualCategories in ipairs(Custom_IndividualCustoms) do
				local Custom_CategoryID = IndividualCategories:call("get_IndividualCustomCategory")

				
				if Custom_CategoryID == 6 and weaponType == "K" then
					local Custom_Strength = IndividualCategories:get_field("_Strength")

					if Custom_Strength then
						Custom_Strength._DurabilityMaxes[0] = weaponStats.Dur_LVL_01_MAX
						Custom_Strength._DurabilityMaxes[1] = weaponStats.Dur_LVL_02_MAX
						Custom_Strength._DurabilityMaxes[2] = weaponStats.Dur_LVL_03_MAX
						Custom_Strength._DurabilityMaxes[3] = weaponStats.Dur_LVL_04_MAX
						Custom_Strength._DurabilityMaxes[4] = weaponStats.Dur_LVL_05_MAX
					end
				end

				if Custom_CategoryID == 7 then
					local Custom_ReloadSpeed = IndividualCategories:get_field("_ReloadSpeed")

					if Custom_ReloadSpeed then
						if weaponType == "HG" or weaponType == "SMG" or weaponType == "SR" or weaponType == "MAG_SEMI" or weaponType == "BOW" then
							Custom_ReloadSpeed._ReloadSpeedRates[0] = weaponStats.RELOAD_LVL_01
							Custom_ReloadSpeed._ReloadSpeedRates[1] = weaponStats.RELOAD_LVL_02
							Custom_ReloadSpeed._ReloadSpeedRates[2] = weaponStats.RELOAD_LVL_03
							Custom_ReloadSpeed._ReloadSpeedRates[3] = weaponStats.RELOAD_LVL_04
							Custom_ReloadSpeed._ReloadSpeedRates[4] = weaponStats.RELOAD_LVL_05
						end

						if weaponType == "SG" or weaponType == "SG_PUMP" or weaponType == "SR_PUMP" or weaponType == "MAG" or weaponType == "BOLT" then
							Custom_ReloadSpeed._ReloadNums[0] = weaponStats.RELOAD_LVL_01
							Custom_ReloadSpeed._ReloadNums[1] = weaponStats.RELOAD_LVL_02
							Custom_ReloadSpeed._ReloadNums[2] = weaponStats.RELOAD_LVL_03
							Custom_ReloadSpeed._ReloadNums[3] = weaponStats.RELOAD_LVL_04
							Custom_ReloadSpeed._ReloadNums[4] = weaponStats.RELOAD_LVL_05
						end
					else
						weaponDetailCustomUpdated = false
					end
				end

				if Custom_CategoryID == 8 then
					local Custom_RateOfFire = IndividualCategories:get_field("_Rapid")

					if Custom_RateOfFire then
						Custom_RateOfFire._RapidSpeed[0] = weaponStats.ROF_LVL_01
						Custom_RateOfFire._RapidSpeed[1] = weaponStats.ROF_LVL_02
						Custom_RateOfFire._RapidSpeed[2] = weaponStats.ROF_LVL_03
						Custom_RateOfFire._RapidSpeed[3] = weaponStats.ROF_LVL_04
						Custom_RateOfFire._RapidSpeed[4] = weaponStats.ROF_LVL_05

						if weaponType == "SG_PUMP" or weaponType == "SR_PUMP" or weaponType == "BOLT" then
							Custom_RateOfFire._PumpActionRapidSpeed[0] = weaponStats.PUMP_LVL_01
							Custom_RateOfFire._PumpActionRapidSpeed[1] = weaponStats.PUMP_LVL_02
							Custom_RateOfFire._PumpActionRapidSpeed[2] = weaponStats.PUMP_LVL_03
							Custom_RateOfFire._PumpActionRapidSpeed[3] = weaponStats.PUMP_LVL_04
							Custom_RateOfFire._PumpActionRapidSpeed[4] = weaponStats.PUMP_LVL_05
						end
					else
						weaponDetailCustomUpdated = false
					end
				end
			end
		end

		if Custom_LimitBreakCustoms then
			for i, LimitBreakCategories in ipairs(Custom_LimitBreakCustoms) do
				local Custom_CategoryID = LimitBreakCategories:call("get_LimitBreakCustomCategory")

				if Custom_CategoryID == 0 or Custom_CategoryID == "0" then
					local Custom_CriticalRateEX = LimitBreakCategories:get_field("_LimitBreakCriticalRate")

					if Custom_CriticalRateEX then
						Custom_CriticalRateEX._CriticalRateNormalScale = weaponStats.EX_CRIT
						Custom_CriticalRateEX._CriticalRateFitScale = weaponStats.EX_CRIT_FIT
					end
				end

				if Custom_CategoryID == 1 or Custom_CategoryID == "1" then
					local Custom_AttackUpEX = LimitBreakCategories:get_field("_LimitBreakAttackUp")

					if Custom_AttackUpEX then
						Custom_AttackUpEX._DamageRateScale = weaponStats.EX_DMG
						Custom_AttackUpEX._WinceRateScale = weaponStats.EX_WINCE
						Custom_AttackUpEX._BreakRateScale = weaponStats.EX_BRK
						Custom_AttackUpEX._StoppingRateScale = weaponStats.EX_STOP
					else
						weaponDetailCustomUpdated = false
					end
				end

				if Custom_CategoryID == 2 or Custom_CategoryID == "2" then
					local Custom_SGAttackUpEX = LimitBreakCategories:get_field("_LimitBreakShotGunAroundAttackUp")

					if Custom_SGAttackUpEX then
						Custom_SGAttackUpEX._DamageRateScale = weaponStats.EX_SG_DMG
						Custom_SGAttackUpEX._WinceRateScale = weaponStats.EX_SG_WINCE
						Custom_SGAttackUpEX._BreakRateScale = weaponStats.EX_SG_BRK
						Custom_SGAttackUpEX._StoppingRateScale = weaponStats.EX_SG_STOP
					else
						weaponDetailCustomUpdated = false
					end
				end

				if Custom_CategoryID == 3 or Custom_CategoryID == "3" then
					local Custom_ThroughNumEX = LimitBreakCategories:get_field("_LimitBreakThroughNum")

					if Custom_ThroughNumEX then
						Custom_ThroughNumEX._ThroughNumNormal = weaponStats.EX_PIRC
						Custom_ThroughNumEX._ThroughNumFit = weaponStats.EX_PIRC_FIT
					end
				end

				if Custom_CategoryID == 4 or Custom_CategoryID == "4" then
					local Custom_AmmoMaxUpEX = LimitBreakCategories:get_field("_LimitBreakAmmoMaxUp")

					if Custom_AmmoMaxUpEX then
						Custom_AmmoMaxUpEX._AmmoMaxScale = weaponStats.EX_AMMO
						Custom_AmmoMaxUpEX._ReloadNumScale = weaponStats.EX_SG_RELOAD
					end
				end

				if Custom_CategoryID == 5 or Custom_CategoryID == "5" then
					local Custom_RapidEX = LimitBreakCategories:get_field("_LimitBreakRapid")

					if Custom_RapidEX then
						Custom_RapidEX._RapidSpeedScale = weaponStats.EX_ROF
					end
				end

				if Custom_CategoryID == 6 or Custom_CategoryID == "6" then
					local Custom_StrengthEX = LimitBreakCategories:get_field("_LimitBreakStrength")

					if Custom_StrengthEX then
						Custom_StrengthEX._DurabilityMaxScale = weaponStats.EX_DUR
					end
				end

				if Custom_CategoryID == 7 or Custom_CategoryID == "7" then
					local Custom_OKEX = LimitBreakCategories:get_field("_LimitBreakOKReload")

					if Custom_OKEX then
						Custom_OKEX._IsOKReload = weaponStats.EX_OK
					end
				end

				if Custom_CategoryID == 8 or Custom_CategoryID == "8" then
					local Custom_CombatSpeedEX = LimitBreakCategories:get_field("_LimitBreakCombatSpeed")

					if Custom_CombatSpeedEX then
						Custom_CombatSpeedEX._CombatSpeed = weaponStats.EX_SPEED
					end
				end

				if Custom_CategoryID == 9 or Custom_CategoryID == "9" then
					local Custom_UnbreakableEX = LimitBreakCategories:get_field("_LimitBreakUnbreakable")
				
					if Custom_UnbreakableEX then
						Custom_UnbreakableEX._IsUnbreakable = weaponStats.EX_UNBRK
					end
				end

        if Custom_CategoryID == 10 or Custom_CategoryID == "10" then
					local Custom_BlastRange = LimitBreakCategories:get_field("_LimitBreakBlastRange_1011")
				
					if Custom_BlastRange then
						Custom_BlastRange._BlastRangeScale = weaponStats.EX_BLAST_RANGE
					end
				end
			end
		end

		if Custom_AttachmentCustoms then
			for i, AttachmentCategories in ipairs(Custom_AttachmentCustoms) do
				local Attachment_Params = AttachmentCategories:call("get_AttachmentParams")

				if Attachment_Params then
					local reticleIndex = 2
					local recoilIndex = 4

					if weaponType == "SMG" then
						reticleIndex = 3
						recoilIndex = 5
					end

					if Attachment_Params[reticleIndex] then
						Attachment_Params[reticleIndex]._ReticleGuiType = weaponStats.ReticleTypeStock
					end

					if Attachment_Params[recoilIndex] then
						local Attachment_CameraRecoilParam = Attachment_Params[recoilIndex]:get_field("_CameraRecoilParam")

						if Attachment_CameraRecoilParam then
							local YawRangeDegStock = Attachment_CameraRecoilParam:get_field("_YawRangeDeg")
							local PitchRangeDegStock = Attachment_CameraRecoilParam:get_field("_PitchRangeDeg")
							
							if YawRangeDegStock then
								YawRangeDegStock.s = weaponStats.Recoil_YawMin_Stock
								YawRangeDegStock.r = weaponStats.Recoil_YawMax_Stock
								write_valuetype(Attachment_CameraRecoilParam, 0x18, YawRangeDegStock)
							end
				
							if PitchRangeDegStock then
								PitchRangeDegStock.s = weaponStats.Recoil_PitchMin_Stock
								PitchRangeDegStock.r = weaponStats.Recoil_PitchMax_Stock
								write_valuetype(Attachment_CameraRecoilParam, 0x20, PitchRangeDegStock)
							end
						end
					end
				end
			end
		end
	end

	return weaponDetailCustomUpdated
end

local function update_weapon_data_table(weaponId, weaponStats)
	local weaponDataTableUpdated = false
	local WeaponDataTable = get_weapon_data_table(weaponId)

	if WeaponDataTable then
		weaponDataTableUpdated = true
		local RecoilParam = WeaponDataTable:get_field("_CameraRecoilParam")
		local ReticleParam = WeaponDataTable:get_field("_ReticleFitParamTable")
		local HandShakeParam = WeaponDataTable:get_field("_HandShakeParam")
		local KnifeCombatSpeedParam = WeaponDataTable:get_field("_knifeCombatSpeedParam")
		
		if RecoilParam then
			local YawRangeDeg = RecoilParam:get_field("_YawRangeDeg")
			local PitchRangeDeg = RecoilParam:get_field("_PitchRangeDeg")

			if YawRangeDeg then
				YawRangeDeg.s = weaponStats.Recoil_YawMin
				YawRangeDeg.r = weaponStats.Recoil_YawMax
				write_valuetype(RecoilParam, 0x18, YawRangeDeg)
			else
				weaponDataTableUpdated = false
			end

			if PitchRangeDeg then
				PitchRangeDeg.s = weaponStats.Recoil_PitchMin
				PitchRangeDeg.r = weaponStats.Recoil_PitchMax
				write_valuetype(RecoilParam, 0x20, PitchRangeDeg)
			else
				weaponDataTableUpdated = false
			end
		end

		if ReticleParam then
			ReticleParam._ReticleShape = weaponStats.ReticleType
		end
		
		if HandShakeParam then
			HandShakeParam.Time = weaponStats.HandShake_Time
			HandShakeParam.RStickOffset = weaponStats.HandShake_Offset
		end

		if KnifeCombatSpeedParam then
			KnifeCombatSpeedParam._KnifeCombatSpeed = weaponStats.Knife_Speed
		end
	end

	return weaponDataTableUpdated
end

local function update_inventory_item(weaponId, weaponStats)
	local inventoryItemUpdated = false
	local InventoryItem = get_inventory_item(weaponId)

	if InventoryItem then
		inventoryItemUpdated = true
		InventoryItem._CurrentAmmo = weaponStats.AmmoType

		local ItemDEF = InventoryItem:get_field("<_DefaultWeaponDefine>k__BackingField")

		if ItemDEF then
			ItemDEF._AmmoMax = weaponStats.BaseAmmoNum
			ItemDEF._AmmoCost = weaponStats.BaseAmmoCost
			ItemDEF._ItemSize = weaponStats.ItemSize
			ItemDEF.DefaultDurabilityMaxValue = weaponStats.DurDEF_Max
			ItemDEF._SliderDurabilityMaxValue = weaponStats.DurSLD_Max
			ItemDEF._DefaultDurabilityMax = weaponStats.DurDEF_Max
			ItemDEF._StackMax = weaponStats.ItemStack
		else
			inventoryItemUpdated = false
		end
	else
		inventoryItemUpdated = false
	end

	return inventoryItemUpdated
end

local function update_weapon(weaponId, weaponStats)
  local weaponType = WeaponIDTypeMap[weaponId]
	local weaponUpdated = false

	-- skip gun updates for knives
	if weaponType == "K" then
		weaponUpdated = update_knife(weaponId, weaponStats)
	else
		weaponUpdated = update_gun(weaponId, weaponType, weaponStats)
	end

	local weaponCustomUpdated = update_weapon_custom(weaponId, weaponStats)
	local weaponDetailCustomUpdated = update_weapon_detail_custom(weaponId, weaponType, weaponStats)
	local weaponDataTableUpdated = update_weapon_data_table(weaponId, weaponStats)
	local inventoryItemUpdated = update_inventory_item(weaponId, weaponStats)
	
	return weaponUpdated and weaponCustomUpdated and weaponDetailCustomUpdated and weaponDataTableUpdated and inventoryItemUpdated
end

local function cache_owner_equipment(weaponId)
	local foundOwnerEquipment = false

	if (weaponId == Weapons.RED9.Id and (not RED9OwnerEquipment)) or (weaponId == Weapons.TMP.Id and (not TMPOwnerEquipment)) or (weaponId == Weapons.VP70.Id and (not VP70OwnerEquipment)) then
		local GameObject = Scene:call("findGameObject(System.String)", "wp" .. tostring(weaponId))

		-- support mercenaries mode
		if not GameObject then
			GameObject = Scene:call("findGameObject(System.String)", "wp" .. tostring(weaponId) .. "_MC")
		end

		-- support separate ways
		if not GameObject then
			GameObject = Scene:call("findGameObject(System.String)", "wp" .. tostring(weaponId) .. "_AO")
		end

		if GameObject then
			local Gun = GameObject:call("getComponent(System.Type)", sdk.typeof("chainsaw.Gun"))
			if Gun then
				local OwnerEquipment = Gun:get_field("<OwnerEquipment>k__BackingField")
				if OwnerEquipment then
					if weaponId == Weapons.RED9.Id then
						RED9OwnerEquipment = OwnerEquipment
						Weapons.RED9.StockEquipped = OwnerEquipment:get_IsExistsStock()
					elseif weaponId == Weapons.TMP.Id then
						TMPOwnerEquipment = OwnerEquipment
						Weapons.TMP.StockEquipped = OwnerEquipment:get_IsExistsStock()
					elseif weaponId == Weapons.VP70.Id then
						VP70OwnerEquipment = OwnerEquipment
						Weapons.VP70.StockEquipped = OwnerEquipment:get_IsExistsStock()
					elseif weaponId == Weapons.RED9_AO.Id then
						RED9_AOOwnerEquipment = OwnerEquipment
						Weapons.RED9_AO.StockEquipped = OwnerEquipment:get_IsExistsStock()
					elseif weaponId == Weapons.TMP_AO.Id then
						TMP_AOOwnerEquipment = OwnerEquipment
						Weapons.TMP_AO.StockEquipped = OwnerEquipment:get_IsExistsStock()
					end
					log.info("Weapon Service: Found owner equipment for " .. tostring(weaponId))
					foundOwnerEquipment = true
				end
			end
		end
	else
		foundOwnerEquipment = true
	end

	return foundOwnerEquipment
end

local function process_inventory_item_updates()
	local updateCount = #InventoryItemsToUpdate

	for i=1,updateCount do
		local weaponId = InventoryItemsToUpdate[i]

		if weaponId ~= nil then
			local weapon = get_weapon(weaponId)
			local foundOwnerEquipment = cache_owner_equipment(weaponId)

			if weapon and foundOwnerEquipment then
				local weaponStats = nil
				log.info("Weapon Service: Processing stats for " .. weapon.Id .. ":" .. weapon.Name)

				if weapon.StockEquipped and weapon.StatsWithStock then
					weaponStats = weapon.StatsWithStock
				else
					weaponStats = weapon.Stats
				end

				if weaponStats then
					local weaponUpdated = update_weapon(weaponId, weaponStats)

					if weaponUpdated then
						log.info("Weapon Service: Stats successfully applied for " .. weapon.Id .. " - " .. weapon.Name)
						table.remove(InventoryItemsToUpdate, i)
					end
				end
			end
		end
  end
end

local function on_frame()
	local playerIsInScene = false

	if Scene then
		playerIsInScene = player_in_scene()

		if not playerIsInScene then
			reset_values();
		end
	end

	if playerIsInScene then
		if not WeaponCatalogInitialized then
			WeaponCatalogInitialized = build_weapon_catalog()
		end

		update_player_inventory()

		-- adjust red 9 when the stock is equiped or unquiped
		if RED9OwnerEquipment then
			local red9StockEquipped = RED9OwnerEquipment:get_IsExistsStock()
			if Weapons.RED9.StockEquipped ~= red9StockEquipped then
				log.info("Weapon Service: RED9 stock equip changed")
				Weapons.RED9.StockEquipped = red9StockEquipped
				apply_weapon_stats(Weapons.RED9.Id)
			end
		end

		-- adjust tmp when the stock is equiped or unquiped
		if TMPOwnerEquipment then
			local tmpStockEquipped = TMPOwnerEquipment:get_IsExistsStock()
			if Weapons.TMP.StockEquipped ~= tmpStockEquipped then
				log.info("Weapon Service: TMP stock equip changed")
				Weapons.TMP.StockEquipped = tmpStockEquipped
				apply_weapon_stats(Weapons.TMP.Id)
			end
		end

		-- adjust vp70 when the stock is equiped or unquiped
		if VP70OwnerEquipment then
			local vp70StockEquipped = VP70OwnerEquipment:get_IsExistsStock()
			if Weapons.VP70.StockEquipped ~= vp70StockEquipped then
				log.info("VP70 stock equip changed")
				Weapons.VP70.StockEquipped = vp70StockEquipped
				apply_weapon_stats(Weapons.VP70.Id)
			end
		end

		-- adjust red 9 when the stock is equiped or unquiped
		if RED9_AOOwnerEquipment then
			local red9_AOStockEquipped = RED9_AOOwnerEquipment:get_IsExistsStock()
			if Weapons.RED9_AO.StockEquipped ~= red9_AOStockEquipped then
				log.info("Weapon Service: RED9_AO stock equip changed")
				Weapons.RED9_AO.StockEquipped = red9_AOStockEquipped
				apply_weapon_stats(Weapons.RED9_AO.Id)
			end
		end

		-- adjust tmp when the stock is equiped or unquiped
		if TMP_AOOwnerEquipment then
			local tmp_AOStockEquipped = TMP_AOOwnerEquipment:get_IsExistsStock()
			if Weapons.TMP_AO.StockEquipped ~= tmp_AOStockEquipped then
				log.info("Weapon Service: TMP_AO stock equip changed")
				Weapons.TMP_AO.StockEquipped = tmp_AOStockEquipped
				apply_weapon_stats(Weapons.TMP_AO.Id)
			end
		end

		process_inventory_item_updates()
	end
end

return {
	set_weapon_profile = set_weapon_profile,
	set_scene = set_scene,
	on_frame = on_frame,
	apply_weapon_stats = apply_weapon_stats,
	apply_all_weapon_stats = apply_all_weapon_stats,
	Weapons = Weapons
}
