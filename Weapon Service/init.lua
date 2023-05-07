local WeaponDataTables = {}
local WeaponStages = {}
local WeaponDetailStages = {}
local PlayerInventory = {}
local CS_Inventory = nil
local OldInventoryCount = -1

local function reset_values()
	WeaponDataTables = {}
	WeaponStages = {}
	WeaponDetailStages = {}
	PlayerInventory = {}
	CS_Inventory = nil
	OldInventoryCount = -1
end

local function write_valuetype(parent_obj, offset, value)
  for i = 0, value.type:get_valuetype_size() - 1 do
    parent_obj:write_byte(offset + i, value:read_byte(i))
  end
end

local function build_weapon_catalog(scene)
  local catalogFound = false
	local customCatalogFound = false

	if not WeaponDataTables[1] then
		local WeaponCatalog = scene:call("findGameObject(System.String)", "WeaponCatalog")

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

  if not WeaponDetailStages[1] then
		local WeaponCustomCatalog = scene:call("findGameObject(System.String)", "WeaponCustomCatalog")

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

local function update_player_inventory(scene)
  local inventoryChanged = false
	local addedWeaponId = nil

	-- find and cache cs inventory
	if CS_Inventory == nil then
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
	end

	if CS_Inventory then
		local InventoryItems = CS_Inventory:get_field("_InventoryItems")

		if InventoryItems then
			local PlayerItems = InventoryItems:get_field("_items")
			PlayerItems = PlayerItems and PlayerItems:get_elements() or {}
			
			local updatedInventory = {}
			local updatedInventoryCount = 0

			for i, Item in ipairs(PlayerItems) do
				local WeaponID = Item:call("get_WeaponId")

				if WeaponID and WeaponID ~= -1 then
					updatedInventory[WeaponID] = Item
					updatedInventoryCount = updatedInventoryCount + 1

					if PlayerInventory[WeaponID] == nil and OldInventoryCount ~= -1 then
						addedWeaponId = WeaponID
					end
				end
			end

			inventoryChanged = updatedInventoryCount ~= OldInventoryCount

			OldInventoryCount = updatedInventoryCount
			PlayerInventory = updatedInventory
		end
	end

  return inventoryChanged, addedWeaponId
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

local function update_weapon(scene, weaponId, weaponType, weaponStats)
  local updatedSuccessfully = false

  local WeaponCustom = get_weapon_custom(weaponId)
  local WeaponDetailCustom = get_weapon_detail_custom(weaponId)
  local WeaponDataTable = get_weapon_data_table(weaponId)
  local InventoryItem = get_inventory_item(weaponId)
  local Gun_GameObject = scene:call("findGameObject(System.String)", "wp" .. tostring(weaponId))

	if Gun_GameObject then
		local Gun = Gun_GameObject:call("getComponent(System.Type)", sdk.typeof("chainsaw.Gun"))

		if Gun and sdk.is_managed_object(Gun) then
			local Shell = Gun:get_field("<ShellGenerator>k__BackingField")
			local WPstructParams = Gun:get_field("WeaponStructureParam")
			local ThinkPlayerParam = Gun:get_field("<ThinkPlayerParam>k__BackingField")
			local Focus = Gun:get_field("<ReticleFitParam>k__BackingField")

			if Shell then
				local Shell_UserData = Shell:get_field("_UserData")

				if Shell_UserData then
					local Shell_HG_SMG_SR_MAG = Shell_UserData:get_field("_ShellInfoUserData")
					local ShellSG_CenterUserData = Shell_UserData:get_field("_CenterShellInfoUserData")
					local ShellSG_AroundUserData = Shell_UserData:get_field("_AroundShellInfoUserData")
					local ShellSG_AroundSettings = Shell_UserData:get_field("_AroundShellSetting")

					-- TODO: Figure out specific weapon type properties (might not be needed...)
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
								end

								if SG_HorScatterRange then
									SG_HorScatterRange.s = weaponStats.SG_AroundHorMin
									SG_HorScatterRange.r = weaponStats.SG_AroundHorMax
									write_valuetype(SG_AroundScatterParam, 0x18, SG_HorScatterRange)
								end
							end
						end
					end

					-- TODO: Figure out specific weapon type properties (might not be needed...)
					if weaponType == "HG" or weaponType == "SMG" or weaponType == "SR" or weaponType == "SR_PUMP" or weaponType == "MAG" or weaponType == "MAG_SEMI" then
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
						end
					end
				end
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

			if Focus then
				Focus._HoldAddPoint = weaponStats.Focus_HoldAdd
				Focus._MoveSubPoint = weaponStats.Focus_MoveSub
				Focus._CameraSubPoint = weaponStats.Focus_CamSub
				Focus._KeepFitLimitPoint = weaponStats.Focus_Limit
				Focus._ShootSubPoint = weaponStats.Focus_ShootSub
			end
		end

		if WeaponCustom then
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
							end
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
							end
						end
					end
				end
			end

			if Custom_Individuals then
				for i, IndividualCategories in ipairs(Custom_Individuals) do
					local Custom_CategoryID = IndividualCategories:call("get_IndividualCustomCategory")

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
							end
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
							end
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

		if WeaponDetailCustom then
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
						end
					end
				end
			end

			if Custom_IndividualCustoms then
				for i, IndividualCategories in ipairs(Custom_IndividualCustoms) do
					local Custom_CategoryID = IndividualCategories:call("get_IndividualCustomCategory")

					if Custom_CategoryID == 7 then
						local Custom_ReloadSpeed = IndividualCategories:get_field("_ReloadSpeed")

						if Custom_ReloadSpeed then
							-- TODO: Figure out specific weapon type properties (might not be needed...)
							if weaponType == "HG" or weaponType == "SMG" or weaponType == "SR" or weaponType == "MAG_SEMI" then
                Custom_ReloadSpeed._ReloadSpeedRates[0] = weaponStats.RELOAD_LVL_01
								Custom_ReloadSpeed._ReloadSpeedRates[1] = weaponStats.RELOAD_LVL_02
								Custom_ReloadSpeed._ReloadSpeedRates[2] = weaponStats.RELOAD_LVL_03
								Custom_ReloadSpeed._ReloadSpeedRates[3] = weaponStats.RELOAD_LVL_04
								Custom_ReloadSpeed._ReloadSpeedRates[4] = weaponStats.RELOAD_LVL_05
							end

							-- TODO: Figure out specific weapon type properties (might not be needed...)
							if weaponType == "SG" or weaponType == "SG_PUMP" or weaponType == "SR_PUMP" or weaponType == "MAG" then
								Custom_ReloadSpeed._ReloadNums[0] = weaponStats.RELOAD_LVL_01
								Custom_ReloadSpeed._ReloadNums[1] = weaponStats.RELOAD_LVL_02
								Custom_ReloadSpeed._ReloadNums[2] = weaponStats.RELOAD_LVL_03
								Custom_ReloadSpeed._ReloadNums[3] = weaponStats.RELOAD_LVL_04
								Custom_ReloadSpeed._ReloadNums[4] = weaponStats.RELOAD_LVL_05
							end
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

							-- TODO: Figure out specific weapon type properties (might not be needed...)
							if weaponType == "SG_PUMP" or weaponType == "SR_PUMP" then
								Custom_RateOfFire._PumpActionRapidSpeed[0] = weaponStats.PUMP_LVL_01
								Custom_RateOfFire._PumpActionRapidSpeed[1] = weaponStats.PUMP_LVL_02
								Custom_RateOfFire._PumpActionRapidSpeed[2] = weaponStats.PUMP_LVL_03
								Custom_RateOfFire._PumpActionRapidSpeed[3] = weaponStats.PUMP_LVL_04
								Custom_RateOfFire._PumpActionRapidSpeed[4] = weaponStats.PUMP_LVL_05
							end
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
						end
					end

					if Custom_CategoryID == 2 or Custom_CategoryID == "2" then
						local Custom_SGAttackUpEX = LimitBreakCategories:get_field("_LimitBreakShotGunAroundAttackUp")

						if Custom_SGAttackUpEX then
							Custom_SGAttackUpEX._DamageRateScale = weaponStats.EX_SG_DMG
							Custom_SGAttackUpEX._WinceRateScale = weaponStats.EX_SG_WINCE
							Custom_SGAttackUpEX._BreakRateScale = weaponStats.EX_SG_BRK
							Custom_SGAttackUpEX._StoppingRateScale = weaponStats.EX_SG_STOP
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
				end
			end
		end

		if InventoryItem then
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
			end
		end

		updatedSuccessfully = true
	end

	return updatedSuccessfully
end

return {
  build_weapon_catalog = build_weapon_catalog,
  update_player_inventory = update_player_inventory,
  update_weapon = update_weapon,
	reset_values = reset_values
}
