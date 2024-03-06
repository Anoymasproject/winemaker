ESX = nil

-- Récupération de l'objet partagé ESX
ESX = exports["es_extended"]:getSharedObject()

-- Enregistrement de la société de vigneron
TriggerEvent('esx_society:registerSociety', 'winemaker', 'Vigneron Astral', 'society_winemaker', 'society_winemaker', 'society_winemaker', { type = 'private' })


-- Liste des objets
local Items = {
    Config.redgrapes,
    Config.whitegrapes,
    Config.pinkgrapes,
}

-- Événement de récolte des raisins
RegisterNetEvent('winemaker:grape')
AddEventHandler('winemaker:grape', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then
        return
    end

    local randomItem = Items[math.random(#Items)]
    local randomNumber = math.random(5, 10)

    if xPlayer.canCarryItem(randomItem, randomNumber) then
        xPlayer.addInventoryItem(randomItem, randomNumber)
    else
        TriggerClientEvent('ox_lib:notify', xPlayer.source, { type = 'error', description = "L'inventaire est plein." })
    end
end)

-- Tableau des événements de pressage de raisins avec leurs configurations correspondantes
local grapePressEvents = {
    { eventName = 'winemaker:redgrape', canType = Config.emptycan, requiredCan = 1, grapeType= Config.redgrapes, requiredAmount = 30,  pressedGrapeType = Config.redgrapepressed,   addedAmount = 1},
    { eventName = 'winemaker:whitegrape', canType = Config.emptycan, requiredCan = 1, grapeType= Config.whitegrapes, requiredAmount = 30,  pressedGrapeType = Config.whitegrapepressed, addedAmount = 1},
    { eventName = 'winemaker:pinkgrape', canType = Config.emptycan, requiredCan = 1, grapeType= Config.pinkgrapes, requiredAmount = 30,  pressedGrapeType = Config.pinkgrapepressed,  addedAmount = 1}
}

-- Enregistrement des événements de pressage de raisins
for _, event in ipairs(grapePressEvents) do
    RegisterNetEvent(event.eventName)
    AddEventHandler(event.eventName, function()
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
       
        xPlayer.removeInventoryItem(event.canType, event.requiredCan)
        xPlayer.removeInventoryItem(event.grapeType, event.requiredAmount)
        xPlayer.addInventoryItem(event.pressedGrapeType, event.addedAmount)
    end)
end


-- Tableau des événements de remplissage de vin avec leurs configurations correspondantes
local wineFillEvents = {
    { eventName = 'winemaker:fillredgrape', pressedGrape = Config.redgrapepressed, emptyBottle = Config.emptybottle, wineBottle = Config.redwinebottle },
    { eventName = 'winemaker:fillwhitegrape', pressedGrape = Config.whitegrapepressed, emptyBottle = Config.emptybottle, wineBottle = Config.whitewinebottle },
    { eventName = 'winemaker:fillpinkgrape', pressedGrape = Config.pinkgrapepressed, emptyBottle = Config.emptybottle, wineBottle = Config.pinkwinebottle }
}

-- Enregistrement des événements de remplissage de vin
for _, event in ipairs(wineFillEvents) do
    RegisterNetEvent(event.eventName)
    AddEventHandler(event.eventName, function()
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
        xPlayer.removeInventoryItem(event.pressedGrape, 1)
        xPlayer.removeInventoryItem(event.emptyBottle, 15)
        xPlayer.addInventoryItem(event.wineBottle, 15)
    end)
end

-- Liste des types de vin à vendre
local wineTypes = {
    { event = 'winemaker:red:sale', itemType = Config.redwinebottle, society = 'society_winemaker' },
    { event = 'winemaker:white:sale', itemType = Config.whitewinebottle, society = 'society_winemaker' },
    { event = 'winemaker:pink:sale', itemType = Config.pinkwinebottle, society = 'society_winemaker' },
}

local function calculatePrice(quantity)
    local totalPrice = 0
    for i = 1, quantity do
        local price = math.random(Config.Price.min, Config.Price.max)
        totalPrice = totalPrice + price
    end
    return totalPrice
end

-- Enregistrement des événements de vente pour chaque type de vin
for _, wineData in pairs(wineTypes) do
    RegisterNetEvent(wineData.event)
    AddEventHandler(wineData.event, function(quantity)
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer and xPlayer.job and xPlayer.job.name == "winemaker" then
            local money = calculatePrice(quantity)

            local playerShare = math.floor(money * 0.4)
            local societyShare = money - playerShare

            xPlayer.removeInventoryItem(wineData.itemType, quantity)

            xPlayer.addMoney(playerShare)

            -- Ajouter l'argent à la caisse de la société
            TriggerEvent('esx_addonaccount:getSharedAccount', 'society_winemaker', function(account)
                account.addMoney(societyShare)
            end)

            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez vendu du vin pour $' .. playerShare)

            local connect = {
                {
                    ["color"] = 9109504,
                    ["title"] = "Vente de vin",
                    ["description"] = "Joueur : " .. GetPlayerName(xPlayer.source) .. "\n ID : " .. xPlayer.source .. " \n Le joueur a reçu : $" .. playerShare .. "\n La société a reçu : $" .. societyShare,
                    ["footer"] = {
                        ["text"] = os.date('%H:%M:%S - %d. %m. %Y', os.time()),
                        ["icon_url"] = "https://cdn.discordapp.com/attachments/897306834925412403/1021263905135272008/logo_astral_blanc.png?ex=65ee7ca1&is=65dc07a1&hm=431b7c291ea5c35cf990bb22a3e935a11bcdd0a02bbc062ed741dbc2eb88c6f6&",
                    },
                }
            }
        
            PerformHttpRequest(Config.webhooks, function(err, text, headers) end, 'POST', json.encode({ username = "Winemaker", embeds = connect }), { ['Content-Type'] = 'application/json' }) 
        end
    end)
end


RegisterNetEvent('winemaker:GetEmptyBottle')
AddEventHandler('winemaker:GetEmptyBottle', function(quantity)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer and xPlayer.job and xPlayer.job.name == "winemaker" then
        xPlayer.addInventoryItem(Config.emptybottle, quantity) 
    end
end)

RegisterNetEvent('winemaker:GetEmptyCan')
AddEventHandler('winemaker:GetEmptyCan', function(quantity)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer and xPlayer.job and xPlayer.job.name == "winemaker" then
        xPlayer.addInventoryItem(Config.emptycan, quantity) 
    end
end)
