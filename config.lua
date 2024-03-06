Config = {}

Config.Job = "winemaker" 

Config.Locale = "en"

Config.webhooks = ''

Config.Blips = {
    Harvest = {
      Pos     = {x = -1886.0090, y = 2221.3091, z = 90.4437},
	  BlipName = "Harvest",	
    },
	Pressing = {
		Pos     = {x = -1931.8933, y =2055.3696, z = 140.7537}, 
		BlipName = "Pressing",	
	},
	Bottle = {
	    Pos     = {x = -1864.0856, y = 2066.1736, z = 141.0006},
	    BlipName = "Filling",
	},
    Selling = {
        Pos     = {x = -1220.68, y = -910.77, z = 12.07},
        BlipName = "Sale",
    }
}

Config.Price = {
    min = 12,
    max = 30
}

Config.Collectedzone = {
    vec3(-1879.9648, 2109.2786, 136.1772)
}

Config.Pressingzone = {
    vec3(-1928.7947, 2059.8057, 140.8171),
}

Config.Fillingzone = {
    vec3(-1893.5272, 2075.5396, 141.0082),
}

Config.Salezone = {
    vec3(-1887.8220, 2050.9001, 140.9968)
}

-- items
Config.redgrapes = "red_grapes"
Config.whitegrapes = "white_grapes"
Config.pinkgrapes = "pink_grapes"

Config.redgrapepressed = "red_grapes_pressed"
Config.whitegrapepressed = "white_grapes_pressed"
Config.pinkgrapepressed = "pink_grapes_pressed"

Config.redwinebottle = "red_wine_bottle"
Config.whitewinebottle = "white_wine_bottle"
Config.pinkwinebottle = "pink_wine_bottle"

Config.emptybottle = "empty_wine_bottle"
Config.emptycan = "empty_wine_can"