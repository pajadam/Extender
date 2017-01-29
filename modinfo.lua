name = "Extender"
description = "More recipes, more drop, some utility, MORE FUN!"
author = "pajadam"
version = "0.3"
forumthread = ""

api_version = 6
dont_starve_compatible = true
reign_of_giants_compatible = true
shipwrecked_compatible = true

icon_atlas = "modicon.xml"
icon = "modicon.tex"

priority = 0

configuration_options =
{
	{
		name    = "paj_fling",
		label   = "Friendly Flingomatics:",
		options =
		{
			{description = "Enabled",  data = 0},
			{description = "Disabled", data = 1},
		},
		default = 0,
	},
	{
		name    = "paj_craft",
		label   = "More crafting recipes:",
		options =
		{
			{description = "Enabled",  data = 0},
			{description = "Disabled", data = 1},
		},
		default = 0,
	},
	{
		name    = "paj_bdrop",
		label   = "Loot drop tweaks:",
		options =
		{
			{description = "Enabled",  data = 0},
			{description = "Disabled", data = 1},
		},
		default = 0,
	},
	{
		name    = "paj_diff",
		label   = "Loot Difficulty:",
		options =
		{
			{description = "Hard", data = 2},
			{description = "Medium", data = 1},
			{description = "Easy",  data = 0},
		},
		default = 1,
	},
	{
		name    = "paj_bgc",
		label   = "Background Color:",
		options =
		{
			{description = "Poison Green",   	data = {50/255,235/255,100/255}},
			{description = "Default Red", 		data = {255/255, 89/255, 46/255}},
			{description = "RoG Purple", 		data = {202/255, 48/255, 209/255}},
			{description = "Together Gray",  	data = {255/255,255/255,255/255}},
			{description = "Orphaned Yellow",	data = {255/255, 196/255, 45/255}},
			{description = "Sky Blue", 	  		data = {0/255,235/255,245/255}},
			{description = "Coffee Brown", 		data = {140/255,95/255,15/255}},
			{description = "Creepy Blue",		data = {65/255,25/255,175/255}},
		},
		default = {50/255,235/255,100/255},
	},
    {
        name  = "paj_nomodswarning",
        label = "Mods warning:",
        options =
        {
            {description = "Disabled", data = 0},
            {description = "Enabled", data = 1},
        },
        default = 0,
    },
    {
        name  = "paj_noworkshopsync",
        label = "Auto Workshop Sync:",
        options =
        {
            {description = "Disabled", data = 0},
            {description = "Enabled", data = 1},
        },
        default = 0,
    }
	
}