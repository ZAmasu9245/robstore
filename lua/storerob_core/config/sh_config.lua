NPCRobSystem.Config = {}

-- If you run into any issues and the addon throws errors at you, contact me through a support ticket, or add me on steam.

/*
====================================================
This first section is for the core side of the addon
====================================================
*/


-- NPC Model
NPCRobSystem.Config.NPCModel = "models/Humans/Group01/male_07.mdl"


-- NPC Text
NPCRobSystem.Config.NPCText = "Magasin Général"


-- The ULX groups that have access to the "savestorerob" command
NPCRobSystem.Config.SaveComGroup = {
	["superadmin"] = true,
	["admin"] = true
}


-- The prefix in chat for the store actions
NPCRobSystem.Config.StorePrefix = "[NPC Shop]"


-- The color of the prefix in chat for the store actions
NPCRobSystem.Config.StorePrefixColor = Color( 210, 195, 20 )


-- The prefix in chat for the robbery actions
NPCRobSystem.Config.RobPrefix = "[NPC Robbing]"


-- The color of the prefix in chat for the robbery actions
NPCRobSystem.Config.RobPrefixColor = Color( 20, 195, 210 )


-- The font used throughout the addon
NPCRobSystem.Config.Font = "Calibri"


/*
========================================================
This second section is for the robbery side of the addon
========================================================
*/


-- How much does the NPC get robbed for?
-- Advanced forumlas are accepted, for example:
-- 1000 * #player.GetAll() | This times the amout of players by 1,000
-- However static numbers also work
NPCRobSystem.Config.RobAmount = 2000


-- The amount of time it takes to rob the NPC
NPCRobSystem.Config.RobTime = 5


-- The amount of time it takes for the store to be robable again
NPCRobSystem.Config.RobCoodownTime = 90


-- What % of players need to be Government for the store to be robable? (Must be a decimal, e.g: 0.2 would be 20%)
NPCRobSystem.Config.RobGovernmentAmount = 0.2


-- How many players are needed on the server for the store to be robable?
NPCRobSystem.Config.RobPlayerAmount = 20


-- Max distance the robber is allowed away from the NPC while robbing it
NPCRobSystem.Config.RobMaxDistance = 500


-- How often does the npc call for help? Between 1 and x
NPCRobSystem.Config.RobShouttime = 45


-- This is the animation that is used while the NPC is being robbed
-- For a list of all the usable ainimations, go to: https://pastebin.com/7Ezumawk
NPCRobSystem.Config.RobActiveAni = "cower_Idle"


-- Should the NPC play an alarm while being robbed?
NPCRobSystem.Config.RobAlarmActive = true


-- This is the alarm sound that is used while the NPC is being robbed
-- For a list of all the usable sounds, go to: https://maurits.tv/data/garrysmod/wiki/wiki.garrysmod.com/index8f77.html
NPCRobSystem.Config.RobAlarmDir = "ambient/alarms/alarm1.wav"


-- Use the moneybag system? This system drops a money bag instead of giving it straight to the user
NPCRobSystem.Config.RobMoneybagSystem = true


-- The model of the "money bag" that will drop
NPCRobSystem.Config.RobMoneybagModel = "models/freeman/money_sack.mdl"


-- What jobs can Rob the NPC?
NPCRobSystem.Config.CanRobJobs = {
	TEAM_MAYOR,
	TEAM_CHIEF,
	TEAM_POLICE,
	TEAM_CITIZEN
}


-- These are the jobs that are considered Government
NPCRobSystem.Config.ConsideredCops = {
	TEAM_MAYOR,
	TEAM_CHIEF,
	TEAM_POLICE,
	TEAM_CITIZEN
}


/*
====================================================
This third section is for the shop part of the addon
====================================================
*/


-- The color of the buy button IF the player can afford it
NPCRobSystem.Config.ShopBuyColor = Color(0,100,100)


-- The color of the buy button IF the player cannot afford it
NPCRobSystem.Config.ShopBuyDenyColor = Color(200, 60, 60)


-- Should the models rotate?
NPCRobSystem.Config.ShopModelRotate = true


-- This is for restricting items to specific usergroups. List all the groups that will have access the restricted items
NPCRobSystem.Config.RestrictedGroups = { "vip", "superadmin" }


-- These are the tabs that are used in the below table
NPCRobSystem.Config.ShopTabs = {
	[1] = {	display = "Armes",			tabcolor = Color(140,100,0)	},
	[2] = {	display = "Munitions",		tabcolor = Color(0,130,70)	},
	[3] = {	display = "Nourriture",		tabcolor = Color(200,130,70)	},
}


-- name, this is the display name for the item
-- desc, this is the short description for the item
-- ent, this is the actual entity that will be spawned
-- price, this is the price for the item
-- model, this is the display model for the item
-- tabs, this is the tab the item will be under, use the tabs you defined above!
-- restricted, is the item restricted to the usergroupds stated above?
NPCRobSystem.Config.ShopContent = {
	[1]	= {	name = "Batte de BaseBall",					desc = "Faites des partis de baseball avec votre amis",				ent = "tfa_nmrih_bat",			price = 150,		model = "models/weapons/tfa_nmrih/w_me_bat_metal.mdl",		tab = "Armes",	restrict = false	},
	[2]	= {	name = "Marteau",				desc = "Fabriquez vos propres meubles",				ent = "tfa_nmrih_bcd",				price = 50,		model = "models/weapons/tfa_nmrih/w_tool_barricade.mdl",			tab = "Armes",	restrict = false	},
	[3]	= {	name = "Clé à molette",			desc = "Réparez une fuite d'eau dans votre maison",					ent = "tfa_nmrih_wrench",		price = 30,		model = "models/weapons/tfa_nmrih/w_me_wrench.mdl",	tab = "Armes",		restrict = false	},
	[4]	= {	name = "Munitions Pistolet",			desc = "Munitions de Pistolet",			ent = "tfa_ammo_pistol",			price = 150,		model = "models/mark2580/gtav/mp_office_03c/boss_zone/safe/box_ammo02a.mdl",		tab = "Munitions",		restrict = false	},
	[5]	= {	name = "Munitions Fusil D'assaut",				desc = "Munitions de fusil d'assaut",				ent = "tfa_ammo_ar2",				price = 150,	model = "models/mark2580/gtav/mp_office_03c/boss_zone/safe/box_ammo02a.mdl",		tab = "Munitions",		restrict = false		},
	[6]	= {	name = "Munitions Fusil À Pompe",				desc = "Munitions de fusil à pompe",				ent = "tfa_ammo_buckshot",				price = 150,	model = "models/mark2580/gtav/mp_office_03c/boss_zone/safe/box_ammo02a.mdl",		tab = "Munitions",		restrict = false		},
	[6]	= {	name = "Munitions Sniper",				desc = "Munitions de sniper",				ent = "tfa_ammo_sniper_rounds",				price = 150,	model = "models/mark2580/gtav/mp_office_03c/boss_zone/safe/box_ammo02a.mdl",		tab = "Munitions",		restrict = false		},
	[7]	= {	name = "Munitions SMG",				desc = "Munitions de SMG",				ent = "tfa_ammo_smg",				price = 150,	model = "models/mark2580/gtav/mp_office_03c/boss_zone/safe/box_ammo02a.mdl",		tab = "Munitions",		restrict = false		},
	[8]	= {	name = "Pomme",				desc = "Pomme",				ent = "fruitapple",				price = 5,	model = "models/foodnhouseholditems/apple.mdl",		tab = "Nourriture",		restrict = false		},
	[9]	= {	name = "Pomme",				desc = "Pomme",				ent = "fruitapple1",				price = 5,	model = "models/foodnhouseholditems/apple1.mdl",		tab = "Nourriture",		restrict = false		},
	[10]	= {	name = "Pomme",				desc = "Pomme",				ent = "fruitapple2",				price = 5,	model = "fruitapple2",		tab = "Nourriture",		restrict = false		},
	[11]	= {	name = "Jus de pomme",				desc = "Jus de pomme",				ent = "applejuice",				price = 15,	model = "models/foodnhouseholditems/juicesmall.mdl",		tab = "Nourriture",		restrict = false		},
	[12]	= {	name = "Jus de pomme",				desc = "Jus de pomme",				ent = "applejuice3",				price = 15,	model = "models/foodnhouseholditems/juicesmall.mdl",		tab = "Nourriture",		restrict = false		},
	[13]	= {	name = "Jus de pomme",				desc = "Jus de pomme",				ent = "applejuice2",				price = 15,	model = "models/foodnhouseholditems/juice2.mdl",		tab = "Nourriture",		restrict = false		},
	[14]	= {	name = "Donut's",				desc = "Donut's",				ent = "bagel3",				price = 10,	model = "models/foodnhouseholditems/bagel3.mdl",		tab = "Nourriture",		restrict = false		},
	[15]	= {	name = "Donut's",				desc = "Donut's",				ent = "bagel2",				price = 10,	model = "models/foodnhouseholditems/bagel2.mdl",		tab = "Nourriture",		restrict = false		},
	[16]	= {	name = "Donut's",				desc = "Donut's",				ent = "bagel1",				price = 10,	model = "models/foodnhouseholditems/bagel1.mdl",		tab = "Nourriture",		restrict = false		},
	[17]	= {	name = "Baguette de pain",				desc = "Baguette de pain",				ent = "bagette",				price = 5,	model = "models/foodnhouseholditems/bagette.mdl",		tab = "Nourriture",		restrict = false		},
	[18]	= {	name = "Banane",				desc = "Banane",				ent = "fruitbanana",				price = 5,	model = "models/foodnhouseholditems/bananna.mdl",		tab = "Nourriture",		restrict = false		},
	[19]	= {	name = "Bière (Duff)",				desc = "Bière",				ent = "beercan1",				price = 15,	model = "models/foodnhouseholditems/beercan01.mdl",		tab = "Nourriture",		restrict = false		},
	[20]	= {	name = "Bière (Hop Knot)",				desc = "Bière",				ent = "beercan3",				price = 20,	model = "models/foodnhouseholditems/beercan03.mdl",		tab = "Nourriture",		restrict = false		},
	[21]	= {	name = "Bière (Master)",				desc = "Bière",				ent = "beer1",				price = 30,	model = "models/foodnhouseholditems/beer_master.mdl",		tab = "Nourriture",		restrict = false		},
	[22]	= {	name = "Bière (Stoltz)",				desc = "Bière",				ent = "beer2",				price = 30,	model = "models/foodnhouseholditems/beer_stoltz.mdl",		tab = "Nourriture",		restrict = false		},
	[23]	= {	name = "Pain",				desc = "Pain",				ent = "bread2",				price = 5,	model = "models/foodnhouseholditems/bread-2.mdl",		tab = "Nourriture",		restrict = false		},
	[24]	= {	name = "Pain",				desc = "Pain",				ent = "bread2",				price = 5,	model = "models/foodnhouseholditems/bread-2.mdl",		tab = "Nourriture",		restrict = false		},
	[25]	= {	name = "Champagne",				desc = "Champagne",				ent = "champagne3",				price = 30,	model = "models/foodnhouseholditems/champagne2.mdl",		tab = "Nourriture",		restrict = false		},
	[26]	= {	name = "Chips (Cassava)",				desc = "Chips",				ent = "chipsbag1",				price = 5,	model = "models/foodnhouseholditems/chipsbag1.mdl",		tab = "Nourriture",		restrict = false		},
	[27]	= {	name = "Chips (Cheez It)",				desc = "Chips",				ent = "chipscheezit",				price = 5,	model = "models/foodnhouseholditems/chipscheezit.mdl",		tab = "Nourriture",		restrict = false		},
	[28]	= {	name = "Chips (Crunch Tators)",				desc = "Chips",				ent = "chipsbag2",				price = 5,	model = "models/foodnhouseholditems/chipsbag2.mdl",		tab = "Nourriture",		restrict = false		},
	[29]	= {	name = "Chips (Doritos)",				desc = "Chips",				ent = "chipsdoritos",				price = 5,	model = "models/foodnhouseholditems/chipsdoritos.mdl",		tab = "Nourriture",		restrict = false		},
	[30]	= {	name = "Chips (Lays)",				desc = "Chips",				ent = "chipslays",				price = 5,	model = "models/foodnhouseholditems/chipslays.mdl",		tab = "Nourriture",		restrict = false		},
}	