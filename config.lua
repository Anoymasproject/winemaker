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
        {coords =  vec3(-1932.8898, 2055.5222, 140.8128), size = vec3(2, 2, 2), rotation = 166},
        {coords =  vec3(-1933.3802, 2052.7515, 140.8128), size = vec3(2, 2, 2), rotation = 166},
        {coords =  vec3(-1932.1511, 2058.2229, 140.8128), size = vec3(2, 2, 2), rotation = 166},
    },
    Filling = {
        {coords =  vec3(-1868.5596, 2055.9106, 141.2026), size = vec3(2, 2, 2), rotation = 45},
        {coords =  vec3(-1868.7825, 2058.7241, 141.2026), size = vec3(2, 2, 2), rotation = 45},
    },
    Sale= {
        {coords =  vec3(-1868.5596, 2055.9106, 141.2026), size = vec3(2, 2, 2), rotation = 45}
    },
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