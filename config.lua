-- Configuration principale
Config = {
    Job = "winemaker",
    Locale = "en",
    Webhooks = '',
    Price = {min = 12, max = 30},
}

-- Configuration des blips
Config.Blips = {
    Harvest = {Pos = {x = -1886.0090, y = 2109.2786, z = 136.1772}, BlipName = "Harvest"},
    Pressing = {Pos = {x = -1931.8933, y = 2055.3696, z = 140.7537}, BlipName = "Pressing"},
    Bottle = {Pos = {x = -1864.0856, y = 2066.1736, z = 141.0006}, BlipName = "Filling"},
    Selling = {Pos = {x = -1220.68, y = -910.77, z = 12.07}, BlipName = "Sale"},
}

-- Configuration des zones
Config.zone = {
    Collected ={
        {coords = vec3(-1879.9648, 2109.2786, 136.1772), size = vec3(10, 2, 5), rotation = 166}
    },
    Pressing = {
        {coords =  vec3(-1928.8124, 2059.8079, 140.8171), size = vec3(2, 2, 2), rotation = 166},
    },
    Filling = {
        {coords =  vec3(-1885.9963, 2074.3855, 141.0079), size = vec3(2, 2, 2), rotation = 45},
    },
    Sale= {
        {coords =  vec3(-1887.8644, 2050.7561, 140.9962), size = vec3(2, 2, 2), rotation = 45}
    },
}

-- Configuration des items
Config.redgrapes = "red_grapes"
Config.whitegrapes = "white_grapes"
Config.pinkgrapes = "pink_grapes"

Config.redgrapepressed = "red_grapes_pressed"
Config.whitegrapepressed = "white_grapes_pressed"
Config.pinkgrapepressed = "pink_grapes_pressed"

Config.redwinebottle = "red_wine_bottle"
Config.whitewinebottle = "white_wine_bottle"
Config.pinkwinebottle = "pink_wine_bottle"

Config.emptybottle = "empty_bottle"
Config.emptycan = "empty_wine_can"

-- Fonction pour obtenir le nom complet d'un blip
function GetBlipFullName(category)
    return "Winery - " .. Config.Blips[category].BlipName
end