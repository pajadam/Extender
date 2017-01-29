----------------------------------
-- Some needed stuff -------------
----------------------------------
    RECIPETABS = GLOBAL.RECIPETABS
    Ingredient = GLOBAL.Ingredient
    STRINGS = GLOBAL.STRINGS
    Recipe = GLOBAL.Recipe
    TECH = GLOBAL.TECH
    
    local DLC1 = false -- Reign of Giants
    local DLC2 = false -- Shipwrecked
    
    if GLOBAL.IsDLCEnabled(1) then
        print ("EXTENDER : RoG support enabled")
        DLC1 = true
    else
        print ("EXTENDER : RoG support disabled")
        DLC1 = false
    end

    if GLOBAL.IsDLCEnabled(2) then
        print ("EXTENDER : SW support enabled")
        DLC2 = true
    else
        print ("EXTENDER : SW support disabled")
        DLC2 = false
    end

    local Menu = GLOBAL.require "widgets/menu"
    local ModsScreen = GLOBAL.require "screens/modsscreen"
    local StartWorkshopUpdate = ModsScreen.StartWorkshopUpdate

    local paj_clr = GetModConfigData("paj_bgc")
    local paj_crf = GetModConfigData("paj_craft")
    local paj_bdr = GetModConfigData("paj_bdrop")
    local paj_nmw = GetModConfigData("paj_nomodswarning")
    local paj_nwu = GetModConfigData("paj_noworkshopsync")
	local paj_fling = GetModConfigData("paj_fling")
	local paj_diff = GetModConfigData("paj_diff")
----------------------------------
--	Background Color Override ----
----------------------------------
    local function SBGOverride(self)
        self.bg:SetTint(paj_clr[1],paj_clr[2],paj_clr[3], 1) 
    end
    local function MSOverride(self)
        self.bg:SetTint(paj_clr[1],paj_clr[2],paj_clr[3], 1) 
        self.motd.motdtitle:SetString("Extender")
        self.motd.motdtext:SetString("You're using EXTENDER! Hope you enjoy it!")
        self.motd.button:Hide()
    end
    AddClassPostConstruct("screens/mainscreen",MSOverride)
    AddClassPostConstruct("screens/broadcastingloginscreen",SBGOverride)
    AddClassPostConstruct("screens/broadcastingoptionsscreen",SBGOverride)
    AddClassPostConstruct("screens/controlsscreen",SBGOverride)
    AddClassPostConstruct("screens/scripterrorscreen",SBGOverride)
    AddClassPostConstruct("screens/morguescreen",SBGOverride)
    AddClassPostConstruct("screens/optionsscreen",SBGOverride)
    AddClassPostConstruct("screens/characterselectscreen",SBGOverride)
    AddClassPostConstruct("screens/customizationscreen",SBGOverride)
    AddClassPostConstruct("screens/modsscreen",SBGOverride)
    AddClassPostConstruct("screens/modconfigurationscreen",SBGOverride)
----------------------------------
-- No workshop sync
----------------------------------
if paj_nwu == 0 then
    AddClassPostConstruct("screens/modsscreen", function(self)
        local myself = {}
        self[env] = myself
        myself.secondarymenu = self.root:AddChild(Menu(nil, 0, true))
        myself.secondarymenu:SetPosition( self.mainmenu:GetPosition() + GLOBAL.Vector3(0, -50, 0) )
        myself.syncbutton = myself.secondarymenu:AddItem(
            "Sync Workshop",
            function()
                StartWorkshopUpdate(self)
            end,
            self.applybutton:GetPosition()
        )
        self.applybutton:SetFocusChangeDir(GLOBAL.MOVE_DOWN, myself.syncbutton)
        myself.syncbutton:SetFocusChangeDir(GLOBAL.MOVE_UP, self.applybutton)
        myself.syncbutton:SetScale(.6)
    end)
    ModsScreen.StartWorkshopUpdate = ModsScreen.WorkshopUpdateComplete
end
----------------------------------
-- No mods warning
----------------------------------
    if paj_nmw == 0 then
        GLOBAL.getmetatable(GLOBAL.TheSim).__index.ShouldWarnModsLoaded = function() return false end end
----------------------------------
-- Craftings
----------------------------------
    if paj_crf == 0 then
		---------------------------------
		-- NO DLC NEEDED
		---------------------------------
			-- GEARS ------------------------
			STRINGS.RECIPE_DESC.GEARS = " A useful collection of mechanical...stuff."
			Recipe( "gears", { Ingredient("cutstone", 3), Ingredient("goldnugget", 2), Ingredient("flint", 3) }, RECIPETABS.REFINE, TECH.SCIENCE_TWO )
			-- Cut Reeds
			STRINGS.RECIPE_DESC.CUTREEDS = " Something like a grass, from grass..."
			Recipe( "cutreeds", { Ingredient("cutgrass", 20), Ingredient("rope", 1) }, RECIPETABS.SURVIVAL, TECH.NONE )
			-- Rocks
			STRINGS.RECIPE_DESC.ROCKS = " Some rocks for you"
			Recipe( "rocks", { Ingredient("flint", 2) }, RECIPETABS.REFINE, TECH.SCIENCE_TWO )
			-- Nitre
			STRINGS.RECIPE_DESC.NITRE = " For explosives and summer heat"
			Recipe( "nitre", { Ingredient("ash", 2), Ingredient("rocks", 1) }, RECIPETABS.REFINE, TECH.SCIENCE_TWO )
			-- Logs
			STRINGS.RECIPE_DESC.LOG = " Logs for everyone!"
			Recipe( "log", { Ingredient("twigs", 9), Ingredient("rope", 1) }, RECIPETABS.REFINE, TECH.SCIENCE_TWO, nil, nil, nil, 3 )
			-- Batwing
			STRINGS.RECIPE_DESC.BATWING = " Sadly you can't fly with it. "
			Recipe("batwing", { Ingredient("feather_crow", 1), Ingredient("smallmeat", 1), Ingredient("nightmarefuel", 1)}, RECIPETABS.MAGIC,  TECH.MAGIC_TWO)
			-- Berry Bush =D
			STRINGS.RECIPE_DESC.DUG_BERRYBUSH = " Make your own bush farm "
			Recipe("dug_berrybush", { Ingredient("cutgrass", 4), Ingredient("poop", 2), Ingredient("berries", 2)}, RECIPETABS.FARM,  TECH.SCIENCE_ONE)
			-- Rabbit Man TAAAAILL :D
			STRINGS.RECIPE_DESC.MANRABBIT_TAIL = " So cuddly. "
			Recipe("manrabbit_tail", { Ingredient("rabbit", 4), Ingredient("razor", 1)}, RECIPETABS.MAGIC,  TECH.SCIENCE_TWO)
			-- Butter
			STRINGS.RECIPE_DESC.BUTTER = " Rich in fat. "
			Recipe("butter", { Ingredient("butterflywings", 12), Ingredient("hammer", 1)}, RECIPETABS.FARM,  TECH.SCIENCE_TWO,nil,nil,nil,3)
			-- Grass Dug
			STRINGS.RECIPE_DESC.DUG_GRASS = " Why dig if you can craft? "
			Recipe("dug_grass", { Ingredient("cutgrass", 4), Ingredient("poop", 2), Ingredient("ash", 2)}, RECIPETABS.TOWN,  TECH.SCIENCE_TWO)
			-- Krampus sack
			STRINGS.RECIPE_DESC.KRAMPUS_SACK = " More space for your loot. "
			Recipe("krampus_sack", { Ingredient("gears", 2), Ingredient("tentaclespots", 4), Ingredient("rope", 4)}, RECIPETABS.SURVIVAL,  TECH.MAGIC_TWO)
			-- Light orb		
			STRINGS.RECIPE_DESC.LIGHTBULB = " Shiny orb. "
			Recipe("lightbulb", { Ingredient("wetgoop", 1), Ingredient("torch", 1)}, RECIPETABS.LIGHT,  TECH.SCIENCE_TWO,nil,nil,nil,2)
			-- Marbleeee
			STRINGS.RECIPE_DESC.MARBLE = " Fancy rocks. "
			Recipe("marble", { Ingredient("cutstone", 3), Ingredient("hammer", 1)}, RECIPETABS.REFINE,  TECH.SCIENCE_ONE,nil,nil,nil,3)
			-- Sapling
			STRINGS.RECIPE_DESC.DUG_SAPLING = " They actually never grow into trees. "
			Recipe("dug_sapling", { Ingredient("twigs", 4), Ingredient("poop", 1), Ingredient("ash", 2)}, RECIPETABS.TOWN,  TECH.SCIENCE_TWO)
			-- Slurper
			STRINGS.RECIPE_DESC.SLURPER_PELT = " Kind of itchy. "
			Recipe("slurper_pelt", { Ingredient("pigskin", 1), Ingredient("nightmarefuel", 1), Ingredient("beardhair", 1)}, RECIPETABS.MAGIC,  TECH.MAGIC_THREE)
			-- Spider hat
			Recipe("spiderhat", { Ingredient("strawhat", 1), Ingredient("spidereggsack", 1), Ingredient("monstermeat", 4)}, RECIPETABS.DRESS,  TECH.SCIENCE_TWO)
			--  Walrus hat
			STRINGS.RECIPE_DESC.WALRUSHAT = "  The most civilized of all hats. "
			Recipe("walrushat", { Ingredient("silk", 10), Ingredient("beefalowool", 10), Ingredient("fish", 6)}, RECIPETABS.DRESS,  TECH.SCIENCE_TWO)
			-- Tentacle spike
			STRINGS.RECIPE_DESC.TENTACLESPIKE = " The closest thing to a nail board. "
			Recipe("tentaclespike", { Ingredient("boards", 1), Ingredient("houndstooth", 3)}, RECIPETABS.WAR,  TECH.SCIENCE_TWO)
		---------------------------------
		-- REIGN OF GIANTS NEEDED
		---------------------------------
		if DLC1 == true then
		
		
		---------------------------------
		-- SHIPWRECKED NEEDED
		---------------------------------
		elseif DLC2 == true then
		
		end
    end
----------------------------------
--	Drop Tweaks ------------------
----------------------------------
    local LootD = { 0.20, 0.30, 0.50, 0.60, 0.80 }
    if paj_bdr == 0 then
		-- Difficulty
		if paj_diff == 0 then
			LootD = { 0.20, 0.30, 0.50, 0.60, 0.80 } -- EZ
		elseif paj_diff == 1 then
			LootD = { 0.10, 0.20, 0.35, 0.45, 0.60 } -- MEDIUM
		else 
			LootD = { 0.05, 0.10, 0.25, 0.30, 0.40 } -- HARD
		end
		-- Warrior Spiders
			function spider_warriorpostinit(inst)
				inst.components.lootdropper:SetLoot(nil)
				inst.components.lootdropper:AddRandomLoot("monstermeat", LootD[3])
				inst.components.lootdropper:AddRandomLoot("silk", LootD[3])
				inst.components.lootdropper:AddRandomLoot("spidergland", LootD[2])
				inst.components.lootdropper:AddRandomLoot("spiderhat", LootD[1])
				inst.components.lootdropper.numrandomloot = 3
			end
		-- Normal Pigs
			GLOBAL.SetSharedLootTable( 'pigman',
			{
				{"meat", 1.00},
				{"meat", 1.00},
				{"pigskin", (LootD[3])},
			})
			function pigmanpostinit(inst)
				inst.components.lootdropper:SetChanceLootTable('pigman')
				inst.components.lootdropper.numrandomloot = 0
			end
		-- Guardian Pigs
			GLOBAL.SetSharedLootTable ( 'pigguard',
			{
				{"meat", 1.00},
				{"meat", 1.00},
				{"pigskin", LootD[3]},
			})
			function pigguardpostinit(inst)
				inst.components.lootdropper:SetChanceLootTable('pigguard')
				inst.components.lootdropper.numrandomloot = 0
			end
		-- Volt Goats
			GLOBAL.SetSharedLootTable ( 'lightninggoat1',
			{
				{"meat", 1.00},
				{"meat", 1.00},
				{"meat", 1.00},
				{"lightninggoathorn", LootD[1]},
				{"goatmilk", LootD[2]},
				{"transistor", 0.10},
			})
			function lightninggoatpostinit(inst)
				inst.components.lootdropper:SetChanceLootTable('lightninggoat1')
				inst.components.lootdropper.numrandomloot = 0
			end
		-- Adult Beefalos 
			GLOBAL.SetSharedLootTable ( 'beefalo',
			{
				{"meat", 1.00},
				{"meat", 1.00},
				{"meat", 1.00},
				{"meat", 1.00},
				{"meat", 1.00},
				{"beefalowool", 1.00},
				{"beefalowool", 1.00},
				{"beefalowool", 1.00},
				{"beefalowool", 1.00},
				{"horn", LootD[1]},
			})
			function beefalopostinit(inst)
				inst.components.lootdropper:SetChanceLootTable('beefalo')
				inst.components.lootdropper.numrandomloot = 0
			end
		-- Normal Hounds
			GLOBAL.SetSharedLootTable ( 'normalhound',
			{
				{"monstermeat", 1.00},
				{"houndstooth", LootD[3]},
				{"meat", LootD[1]},
			})
			function houndpostinit(inst)
				inst.components.lootdropper:SetChanceLootTable('normalhound')
				inst.components.lootdropper.numrandomloot = 0
			end
		-- Fire Hounds
			GLOBAL.SetSharedLootTable ( 'hound_fire',
			{
				{"monstermeat", 1.00},
				{"houndstooth", 1.00},
				{"houndstooth", 0.20},
				{"houndfire", 1.00},
				{"houndfire", 1.00},
				{"redgem", LootD[1]},
				{"firestaff", 0.10},
				{"meat", LootD[1]},
			})
			function firehoundpostinit(inst)
				inst.components.lootdropper:SetChanceLootTable('hound_fire')
				inst.components.lootdropper.numrandomloot = 0
			end
		-- Ice Hounds
			GLOBAL.SetSharedLootTable ( 'hound_ice',
			{
				{"monstermeat", 1.00},
				{"houndstooth", 1.00},
				{"houndstooth", 0.20},
				{"bluegem", LootD[1]},
				{"icestaff", 0.10},
				{"ice", 1.00},
				{"ice", 1.00},
				{"meat", LootD[1]},
			})
			function icehoundpostinit(inst)
				inst.components.lootdropper:SetChanceLootTable('hound_ice')
				inst.components.lootdropper.numrandomloot = 0
			end
		-- Butterflies
			GLOBAL.SetSharedLootTable ( 'butterflies',
			{
				{"butterflywings", LootD[3]},
				{"butter", LootD[1]},
			})
			function butterflypostinit(inst)
				inst.components.lootdropper:SetChanceLootTable('butterflies')
				inst.components.lootdropper.numrandomloot = 0
			end
		-- Normal Bees
			function beepostinit(inst)
				inst.components.lootdropper:SetLoot(nil)
				inst.components.lootdropper:AddRandomLoot("honey", LootD[2])
				inst.components.lootdropper:AddRandomLoot("stinger", LootD[3])
				inst.components.lootdropper:AddRandomLoot("honeycomb", 0.30)
				inst.components.lootdropper.numrandomloot = 1
			end
		-- Killer Bees
			function killerbeepostinit(inst)
				inst.components.lootdropper:SetLoot(nil)
				inst.components.lootdropper:AddRandomLoot("honey", LootD[3])
				inst.components.lootdropper:AddRandomLoot("stinger", LootD[4])
				inst.components.lootdropper.numrandomloot = 1
			end
		-- Clockwork Bishops
			function bishoppostinit(inst)
				inst.components.lootdropper:SetLoot({"gears"})
				inst.components.lootdropper.numrandomloot = 0
			end
		-- Clockwork Knights
			function knightpostinit(inst)
				inst.components.lootdropper:SetLoot({"gears"})
				inst.components.lootdropper.numrandomloot = 0
			end
		-- Clockwork Rooks
			function rookpostinit(inst)
				inst.components.lootdropper:SetLoot({"gears", "gears"})
				inst.components.lootdropper.numrandomloot = 0
			end
		-- Ghosts
			function ghostpostinit(inst)
				inst:AddComponent("lootdropper")
				inst.components.lootdropper:SetLoot({"nightmarefuel"})
				inst.components.lootdropper.numrandomloot = 0
			end
		-- Walrus
			GLOBAL.SetSharedLootTable ('mac',
			{
				{"meat", 1.00},
				{"meat", LootD[1]},
				{"blowdart_pipe", 1.00},
				{"walrushat", LootD[1]},
				{"walrus_tusk", LootD[1]},
			})
			function walruspostinit(inst)
				inst.components.lootdropper:SetChanceLootTable('mac')
				inst.components.lootdropper.numrandomloot = 0
			end
		-- Little Walrus
			GLOBAL.SetSharedLootTable ('little mac',
			{
				{"meat", 1.00},
				{"meat", LootD[1]},
				{"walrus_tusk", 0.30},
			})

			function little_walruspostinit(inst)
				inst.components.lootdropper:SetChanceLootTable('little mac')
				inst.components.lootdropper.numrandomloot = 0
			end
		-- Normal Tentacles
			GLOBAL.SetSharedLootTable ('tentacles',
			{
				{"monstermeat", 1.00},
				{"monstermeat", 1.00},
				{"tentaclespike", LootD[1]},
				{"tentaclespots", LootD[1]},
			})
			function tentaclepostinit(inst)
				inst.components.lootdropper:SetChanceLootTable('tentacles')
				inst.components.lootdropper.numrandomloot = 0
			end
		-- Crows
			GLOBAL.SetSharedLootTable( 'crows',
			{
				{"smallmeat", 1.00},
				{"feather_crow", 1.00},
				{"seeds", 1.00},
			})
			function crowpostinit(inst)
				inst.components.lootdropper:SetChanceLootTable('crows')
				inst.components.lootdropper.numrandomloot = 0
			end
		-- Redbirds
			GLOBAL.SetSharedLootTable ( 'redbird',
			{
				{"smallmeat", 1.00},
				{"feather_robin", 1.00},
				{"seeds", 1.00},
			})
			function robinpostinit(inst)
				inst.components.lootdropper:SetChanceLootTable('redbird')
				inst.components.lootdropper.numrandomloot = 0
			end
		-- Bluebirds
			GLOBAL.SetSharedLootTable ( 'bluebird',
			{
				{"smallmeat", 1.00},
				{"feather_robin_winter", 1.00},
				{"seeds", 1.00},
			})

			function robin_winterpostinit(inst)
				inst.components.lootdropper:SetChanceLootTable('bluebird')
				inst.components.lootdropper.numrandomloot = 0
			end

		-- Pengulls
			GLOBAL.SetSharedLootTable ( 'pengulls',
			{
				{"feather_crow", 1.00},
				{"smallmeat", 0.50},
				{"drumstick", 0.50},
			})
			function penguinpostinit(inst)
				inst.components.lootdropper:SetChanceLootTable('pengulls')
				inst.components.lootdropper.numrandomloot = 0
			end
		-- Gobblers (Turkey)
			GLOBAL.SetSharedLootTable ( 'turkey',
			{
				{"drumstick", 1.00},
				{"drumstick", LootD[1]},
			})
			function perdpostinit(inst)
				inst.components.lootdropper:SetChanceLootTable('turkey')
				inst.components.lootdropper.numrandomloot = 0
			end
			
		-- AddPrefabPostInit
		
		---------------------------------
		-- NO DLC NEEDED
		---------------------------------
		
		AddPrefabPostInit("spider", spiderpostinit)
		AddPrefabPostInit("spider_warrior", spider_warriorpostinit)
		AddPrefabPostInit("pigman", pigmanpostinit)
		AddPrefabPostInit("hound", houndpostinit)
		AddPrefabPostInit("firehound", firehoundpostinit)
		AddPrefabPostInit("icehound", icehoundpostinit)
		AddPrefabPostInit("pigguard", pigguardpostinit)
		AddPrefabPostInit("beefalo", beefalopostinit)
		AddPrefabPostInit("bee", beepostinit)
		AddPrefabPostInit("killerbee", killerbeepostinit)
		AddPrefabPostInit("bishop", bishoppostinit)
		AddPrefabPostInit("butterfly", butterflypostinit)
		AddPrefabPostInit("knight", knightpostinit)
		AddPrefabPostInit("rook", rookpostinit)
		AddPrefabPostInit("ghost", ghostpostinit)
		AddPrefabPostInit("walrus", walruspostinit)
		AddPrefabPostInit("little_walrus", little_walruspostinit)
		AddPrefabPostInit("crow", crowpostinit)
		AddPrefabPostInit("tentacle", tentaclepostinit)
		AddPrefabPostInit("robin", robinpostinit)
		AddPrefabPostInit("robin_winter", robin_winterpostinit)
		AddPrefabPostInit("penguin", penguinpostinit)
		AddPrefabPostInit("perd", perdpostinit)
		
		---------------------------------
		-- REIGN OF GIANTS NEEDED
		---------------------------------
		if DLC1 == true then
		
			AddPrefabPostInit("lightninggoat", lightninggoatpostinit)
			
		---------------------------------
		-- SHIPWRECKED NEEDED
		---------------------------------
		elseif DLC2 == true then
		
		end			
    end
	
----------------------------------
--	More Tweaks! -----------------
----------------------------------
	-- Flingomatic tweak - don't touch campfires!
	if DLC1 == true then 
		if paj_fling == 0 then
			print( "EXTENDER : Friendly Flingomatics!" )
			AddPrefabPostInit("firesuppressor", function(inst)
			table.insert(inst.components.firedetector.NOTAGS, "campfire")end)
		else
			print( "EXTENDER : No friendly Flingomatics :C" )
		end
	end
	-- Flingomatic tweak - don't touch campfires!