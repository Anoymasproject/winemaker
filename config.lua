Config = {}

Config.Job = "winemaker" 

Config.Locale = "fr"

Config.webhooks = 'https://discord.com/api/webhooks/1065340918254809230/4NdMGQbJ8_MO1jvNswECTIy1yH6owQqrf2ryRu9GdARrBd3dpUgYCvQqxW8n17KbBxy2'

Config.Blips = {
    Harvest = {
      Pos     = {x = -1886.0090, y = 2221.3091, z = 90.4437},
	  BlipName = "récolte",	
    },
	Pressing = {
		Pos     = {x = -1931.8933, y =2055.3696, z = 140.7537},
		BlipName = "Pressage",	
	},
	Bottle = {
	    Pos     = {x = -1864.0856, y = 2066.1736, z = 141.0006},
	    BlipName = "Remplissage",
	},
    Selling = {
        Pos     = {x = -1220.68, y = -910.77, z = 12.07},
        BlipName = "Vente",
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
    vec3(-1932.8898, 2055.5222, 140.8128),
    vec3(-1933.3802, 2052.7515, 140.8128),
    vec3(-1932.1511, 2058.2229, 140.8128)
}

Config.Fillingzone = {
    vec3(-1868.5596, 2055.9106, 141.2026),
    vec3(-1868.7825, 2058.7241, 141.2026)
}

Config.Salezone = {
    vec3(-1880.9333, 2070.0037, 141.0059)
}

Config.PedGarage = "a_m_m_farmer_01"

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