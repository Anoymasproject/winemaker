ESX = nil

-- Retrieving the ESX shared object
ESX = exports["es_extended"]:getSharedObject()

-- Registration of the winegrower company
TriggerEvent('esx_society:registerSociety', 'winemaker', 'Winemaker', 'society_winemaker', 'society_winemaker', 'society_winemaker', { type = 'private' })


-- List of objects
local Items = {
    Config.redgrapes,
    Config.whitegrapes,
    Config.pinkgrapes,
}

-- Grape harvest event
RegisterNetEvent('winemaker:grape')
AddEventHandler('winemaker:grape', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then
        return
    end
    if xPlayer and xPlayer.job and xPlayer.job.name == "winemaker" then

        local randomItem = Items[math.random(#Items)]
        local randomNumber = math.random(5, 10)

        if xPlayer.canCarryItem(randomItem, randomNumber) then
            xPlayer.addInventoryItem(randomItem, randomNumber)
        else
            TriggerClientEvent('ox_lib:notify', xPlayer.source, { type = 'error', description = "Inventory is full." })
        end
    end
end)

-- Table of grape pressing events with their corresponding configurations
local grapeTypes = {
    { name = 'redgrape', grapeType = Config.redgrapes, pressedGrapeType = Config.redgrapepressed },
    { name = 'whitegrape', grapeType = Config.whitegrapes, pressedGrapeType = Config.whitegrapepressed },
    { name = 'pinkgrape', grapeType = Config.pinkgrapes, pressedGrapeType = Config.pinkgrapepressed }
}

local grapePressEvents = {}

for _, grape in ipairs(grapeTypes) do
    local eventName = 'winemaker:' .. grape.name
    local event = {
        eventName = eventName,
        grapeType = grape.grapeType,
        requiredAmount = 30,
        pressedGrapeType = grape.pressedGrapeType,
        addedAmount = 1
    }
    table.insert(grapePressEvents, event)

    RegisterNetEvent(eventName)
    AddEventHandler(eventName, function()
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)

        if xPlayer and xPlayer.job and xPlayer.job.name == "winemaker" then
            xPlayer.removeInventoryItem(event.grapeType, event.requiredAmount)
            xPlayer.addInventoryItem(event.pressedGrapeType, event.addedAmount)
        end
    end)
end


-- Table of wine filling events with their corresponding configurations
local wineFillEvents = {
    { name = 'red', pressedGrape = Config.redgrapepressed, emptyBottle = Config.emptybottle, wineBottle = Config.redwinebottle },
    { name = 'white', pressedGrape = Config.whitegrapepressed, emptyBottle = Config.emptybottle, wineBottle = Config.whitewinebottle },
    { name = 'pink', pressedGrape = Config.pinkgrapepressed, emptyBottle = Config.emptybottle, wineBottle = Config.pinkwinebottle }
}

-- Recording wine filling events
for _, event in ipairs(wineFillEvents) do
    local eventName = 'winemaker:filling_' .. event.name .. 'bottles'
    RegisterNetEvent(eventName)

    AddEventHandler(eventName, function()
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)

        if xPlayer and xPlayer.job and xPlayer.job.name == "winemaker" then
            local requiredAmount = 15
            xPlayer.removeInventoryItem(event.pressedGrape, 1)
            xPlayer.removeInventoryItem(event.emptyBottle, requiredAmount)
            xPlayer.addInventoryItem(event.wineBottle, requiredAmount)
        end
    end)
end

-- List of types of wine for sale
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

-- Recording of sales events for each type of wine
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

            -- Add the money to the company cash register
            TriggerEvent('esx_addonaccount:getSharedAccount', 'society_winemaker', function(account)
                account.addMoney(societyShare)
            end)

            TriggerClientEvent('esx:showNotification', xPlayer.source, 'You sold wine for $' .. playerShare)

            local connect = {
                {
                    ["color"] = 9109504,
                    ["title"] = "Wine sale",
                    ["description"] = "Player : " .. GetPlayerName(xPlayer.source) .. "\n ID : " .. xPlayer.source .. " \n The player received : $" .. playerShare .. "\n The company received : $" .. societyShare,
                    ["footer"] = {
                        ["text"] = os.date('%H:%M:%S - %d. %m. %Y', os.time()),
                        ["icon_url"] = "",
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
