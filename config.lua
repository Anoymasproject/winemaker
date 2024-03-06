-- Configuration principale
Config = {
    Job = "winemaker",
    Locale = "en",
    Webhooks = '',
    Price = {min = 12, max = 30},
}

-- Configuration des blips
Config.Blips = {
    Harvest = {Pos = {x = -1886.0090, y = 2221.3091, z = 90.4437}, BlipName = "Harvest"},
    Pressing = {Pos = {x = -1931.8933, y = 2055.3696, z = 140.7537}, BlipName = "Pressing"},
    Bottle = {Pos = {x = -1864.0856, y = 2066.1736, z = 141.0006}, BlipName = "Filling"},
    Selling = {Pos = {x = -1220.68, y = -910.77, z = 12.07}, BlipName = "Sale"},
}

-- Configuration des zones
Config.Zones = {
    Collected = vec3(-1879.9648, 2109.2786, 136.1772),
    Pressing = vec3(-1928.7947, 2059.8057, 140.8171),
    Filling = vec3(-1893.5272, 2075.5396, 141.0082),
    Sale = vec3(-1887.8220, 2050.9001, 140.9968),
}

-- Configuration des items
Config.Items = {
    Grapes = {Red = "red_grapes", White = "white_grapes", Pink = "pink_grapes"},
    PressedGrapes = {Red = "red_grapes_pressed", White = "white_grapes_pressed", Pink = "pink_grapes_pressed"},
    WineBottle = {Red = "red_wine_bottle", White = "white_wine_bottle", Pink = "pink_wine_bottle"},
    EmptyBottle = "empty_wine_bottle",
    EmptyCan = "empty_wine_can",
}

-- Fonction pour obtenir le nom complet d'un blip
function GetBlipFullName(category)
    return "Winery - " .. Config.Blips[category].BlipName
end