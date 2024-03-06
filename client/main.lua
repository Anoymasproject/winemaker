local TSE = TriggerServerEvent
local PlayerData, Blips = {}, {}
local WinemakerBlips = {}

ESX = nil
ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer  
    blips()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
    delBlips()
    blips()
end)

CreateThread(function()
    for k, v in pairs(Config.Collectedzone) do
        exports.ox_target:addBoxZone({
        coords = v,
        size = vec3(10, 2, 5),
        rotation = 166,
        debug = false,
        options = {
            {
                name = 'collected',
                event = "winemaker:collected",
                icon = "fa-sharp fa-solid fa-wine-bottle",
                label = TranslateCap('picking_grape_menu'),
                distance = 2,
                groups = Config.Job,
                canInteract = function(entity)
                    if IsEntityPlayingAnim(PlayerPedId(), 'mp_ped_interaction', 'handshake_guy_b', 3) then return false end
                    return true
                end,
                onSelect = function()
                    if lib.progressBar({
                        duration = 3000,
                        label = TranslateCap('picking_grape_prog'),
                        useWhileDead = false,
                        canCancel = true,
                        disable = {
                            move = true,
                            car = true,
                            combat = true,
                            mouse = false
                        },
                        anim = {
                            dict = 'mp_ped_interaction',
                            clip = 'handshake_guy_b' 
                        },
                    }) then TSE('winemaker:grape') end
                end
            }
        }
    })
    end

    for k, v in pairs(Config.Pressingzone) do
        exports.ox_target:addBoxZone({ 
        coords = v,
        size = vec3(2, 2, 2),
        rotation = 166,
        debug = false,
        options = {
            {
                name = 'pressing',
                event = "winemaker:pressing",
                icon = "fa-sharp fa-solid fa-wine-bottle",
                label = TranslateCap('pressing_grape_menu'),
                distance = 2,
                groups = Config.Job,
                canInteract = function(entity)
                    if IsEntityPlayingAnim(PlayerPedId(), 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', 'machinic_loop_mechandplayer', 3) then return false end
                    return true
                end,
            }
        }
    })
    end

    for k, v in pairs(Config.Fillingzone) do
        exports.ox_target:addBoxZone({ 
        coords = v,
        size = vec3(2, 2, 2),
        rotation = 45,
        debug = false,
        options = {
            {
                name = 'filling',
                event = "winemaker:filling",
                icon = "fa-sharp fa-solid fa-wine-bottle",
                label = TranslateCap('filling_bottles'),
                distance = 2,
                groups = Config.Job,
                canInteract = function(entity)
                    if IsEntityPlayingAnim(PlayerPedId(), 'creatures@rottweiler@tricks@', 'petting_franklin', 3) then return false end
                    return true
                end,
            }
        }
    })
    end

    for k, v in pairs(Config.Salezone) do
        exports.ox_target:addBoxZone({
        coords = v,
        size = vec3(2, 2, 2),
        rotation = 45,
        debug = false,
        options = {
            {
                name = 'sale',
                event = "winemaker:sale",
                icon = "fa-sharp fa-solid fa-wine-bottle",
                label = TranslateCap('sale_of_wine'),
                distance = 2,
                groups = Config.Job,
            }
        }
    })
    end

    lib.zones.box({
    	name = "Actionwinemaker",
    	coords = vec3(-1911.3553, 2074.4978, 140.3960),
    	size = vec3(3, 4.0, 2),
    	rotation = 50.0,
        onEnter = function ()
            if not ESX.PlayerData.dead and ESX.PlayerData.job and ESX.PlayerData.job.name == 'winemaker' and ESX.PlayerData.job.grade_name == 2 or ESX.PlayerData.job.grade == 3 or ESX.PlayerData.job.grade == 4 then
                allow = true
                lib.showTextUI('[E] - Action winemaker')
            else 
                allow = false
            end
        end,
        onExit = function ()
            lib.hideTextUI()
        end,
        inside = function()
            if IsControlJustPressed(0, 38) and allow then
                OpenWinemakerActionsMenu()
                lib.hideTextUI()
            end
        end
    })

end)


function OpenWinemakerActionsMenu()
local elements = {}

    if  ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' or ESX.PlayerData.job.grade_name == 'owner' then
        elements[#elements+1] = {
            title = TranslateCap('boss_actions'),
            icon = "fas fa-wallet",
            onSelect = function()
                TriggerEvent('esx_society:openBossMenu', 'winemaker')
            end,
        }
    end

    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 2 or ESX.PlayerData.job.grade == 3 or ESX.PlayerData.job.grade == 4 then
        elements[#elements+1] = {
            title = "Magasin de vehicle Entreprise",
            icon = "car",
            onSelect = function()
                TriggerEvent("Astral:client:shopmenu")
            end,
        }
    end

    lib.registerContext({
        id = 'WinemakerActionsMenu',
        title = 'Winemaker',
        options = elements
    })
    lib.showContext('WinemakerActionsMenu')
end



RegisterNetEvent('winemaker:pressing', function()
    lib.registerContext({
        id = 'grapes_pressing',
        title = TranslateCap('pressing_grape_menu'),
        options = {
            {
                title = TranslateCap('press_red_grape'),
                description = TranslateCap('red_grape_need'),
                onSelect = function()
                    if exports.ox_inventory:Search('count', Config.redgrapes) >= 30 then
                        if lib.progressBar({
                            duration = 30000,
                            label = TranslateCap('press_red_grape'),
                            useWhileDead = false,
                            canCancel = true,
                            disable = {
                                move = true,
                                car = true,
                                combat = true,
                                mouse = false
                            },
                            anim = {
                                dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
                                clip = 'machinic_loop_mechandplayer' 
                            },
                        }) then TSE('winemaker:redgrape') end
                    else
                        lib.notify({type = 'error', description = 'You need at least 30 red grapes.'})
                    end
                end
            },
            {
                title = TranslateCap('press_white_grape'),
                description = TranslateCap('white_grape_need'),
                onSelect = function()
                    if exports.ox_inventory:Search('count', Config.whitegrapes) >= 30 then
                        if lib.progressBar({
                            duration = 30000,
                            label = TranslateCap('press_white_grape'),
                            useWhileDead = false,
                            canCancel = true,
                            disable = {
                                move = true,
                                car = true,
                                combat = true,
                                mouse = false
                            },
                            anim = {
                                dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
                                clip = 'machinic_loop_mechandplayer' 
                            },
                        }) then TSE('winemaker:whitegrape') end
                    else
                        lib.notify({type = 'error', description = 'You need at least 30 white grapes.'})
                    end
                end
            },
            {
                title = TranslateCap('press_pink_grape'),
                description = TranslateCap('pink_grape_need'),
                onSelect = function()
                    if exports.ox_inventory:Search('count', Config.pinkgrapes) >= 30 then
                        if lib.progressBar({
                            duration = 30000,
                            label = TranslateCap('press_pink_grape'),
                            useWhileDead = false,
                            canCancel = true,
                            disable = {
                                move = true,
                                car = true,
                                combat = true,
                                mouse = false
                            },
                            anim = {
                                dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
                                clip = 'machinic_loop_mechandplayer' 
                            },
                        }) then TSE('winemaker:pinkgrape') end
                    else
                        lib.notify({type = 'error', description = 'You need at least 30 white grapes.'})
                    end
                end
            },
        },
    })
    lib.showContext('grapes_pressing')
end)


RegisterNetEvent('winemaker:filling', function()
    lib.registerContext({
        id = 'filling_bottles',
        title = TranslateCap('filling_bottles'),
        options = {
            {
                title = TranslateCap('red_wine'),
                description = TranslateCap('red_wine_need'),
                onSelect = function()
                    if exports.ox_inventory:Search('count', Config.redgrapepressed) >= 1 and exports.ox_inventory:Search('count', Config.emptybottle) > 14  then
                        if lib.progressBar({
                            duration = 30000,
                            label = TranslateCap('fill_the_bottle'),
                            useWhileDead = false,
                            canCancel = true,
                            disable = {
                                move = true,
                                car = true,
                                combat = true,
                                mouse = false
                            },
                            anim = {
                                dict = 'creatures@rottweiler@tricks@',
                                clip = 'petting_franklin' 
                            },
                        }) then TSE('winemaker:filling_redbottles') end
                    else
                        lib.notify({type = 'error', description = 'You do not have all the necessary elements to prepare.'})
                    end
                end
            },
            {
                title = TranslateCap('white_wine'),
                description = TranslateCap('white_wine_need'),
                onSelect = function()
                    if exports.ox_inventory:Search('count', Config.whitegrapepressed) >= 1 and exports.ox_inventory:Search('count', Config.emptybottle) > 14  then
                        if lib.progressBar({
                            duration = 30000,
                            label = TranslateCap('fill_the_bottle'),
                            useWhileDead = false,
                            canCancel = true,
                            disable = {
                                move = true,
                                car = true,
                                combat = true,
                                mouse = false
                            },
                            anim = {
                                dict = 'creatures@rottweiler@tricks@',
                                clip = 'petting_franklin' 
                            },
                        }) then TSE('winemaker:filling_whitebottles') end
                    else
                        lib.notify({type = 'error', description = 'You do not have all the necessary elements to prepare.'})
                    end
                end
            },
            {
                title = TranslateCap('pink_wine'),
                description = TranslateCap('pink_wine_need'),
                onSelect = function()
                    if exports.ox_inventory:Search('count', Config.pinkgrapepressed) >= 1 and exports.ox_inventory:Search('count', Config.emptybottle) > 14  then
                        if lib.progressBar({
                            duration = 30000,
                            label = TranslateCap('fill_the_bottle'),
                            useWhileDead = false,
                            canCancel = true,
                            disable = {
                                move = true,
                                car = true,
                                combat = true,
                                mouse = false
                            },
                            anim = {
                                dict = 'creatures@rottweiler@tricks@',
                                clip = 'petting_franklin' 
                            },
                        }) then TSE('winemaker:filling_pinkbottles') end
                    else
                        lib.notify({type = 'error', description = 'You do not have all the necessary elements to prepare.'})
                    end
                end
            },
        },
    })
    lib.showContext('filling_bottles')
end)



RegisterNetEvent('winemaker:sale', function()
    lib.registerContext({
        id = 'sale_of_wine',
        title = TranslateCap('sale_of_wine'),
        options = {
            {
                title = TranslateCap('sell_red_wine'),
                description = TranslateCap('sell_red_wine_need'),
                onSelect = function()
                    local max = exports.ox_inventory:Search('count', Config.redwinebottle)
                    local quantity = lib.inputDialog('Quantiter', {
                        {type = 'number', label = 'How much?', description = 'you currently have '..max..' bottles of red wine', icon = 'hashtag',min = 1,max = max},
                      })
                      if quantity[1] then
                        if lib.progressBar({
                            duration = 10000,
                            label = TranslateCap('give_red_wine'),
                            useWhileDead = false,
                            canCancel = true,
                            anim = {
                                scenario = "WORLD_HUMAN_CLIPBOARD"
                            },
                            disable = {
                                move = true,
                                car = true,
                                combat = true,
                                mouse = false
                            },
    
                            }) then
                            TriggerServerEvent('winemaker:red:sale', quantity[1])
                        end
                    end
                end,
            },
            {
                title = TranslateCap('sell_white_wine'),
                description = TranslateCap('sell_white_wine_need'),
                onSelect = function()
                    local max = exports.ox_inventory:Search('count', Config.whitewinebottle)
                    local quantity = lib.inputDialog('Quantiter', {
                        {type = 'number', label = 'How much?', description = 'you currently have '..max..' bottles of white wine', icon = 'hashtag',min = 1,max = max},
                      })
                      if quantity[1] then
                        if lib.progressBar({
                            duration = 10000,
                            label = TranslateCap('give_red_wine'),
                            useWhileDead = false,
                            canCancel = true,
                            anim = {
                                scenario = "WORLD_HUMAN_CLIPBOARD"
                            },
                            disable = {
                                move = true,
                                car = true,
                                combat = true,
                                mouse = false
                            },
    
                        }) then
                            TriggerServerEvent('winemaker:white:sale', quantity[1])
                        end
                    end
                end,
            },
            {
                title = TranslateCap('sell_pink_wine'),
                description = TranslateCap('sell_pink_wine_need'),
                onSelect = function()
                    local max = exports.ox_inventory:Search('count', Config.pinkwinebottle)
                    local quantity = lib.inputDialog('Quantiter', {
                        {type = 'number', label = 'How much?', description = 'you currently have '..max..' rose wine bottles', icon = 'hashtag',min = 1,max = max},
                      })
                      if quantity[1] then
                        if lib.progressBar({
                            duration = 10000,
                            label = TranslateCap('give_red_wine'),
                            useWhileDead = false,
                            canCancel = true,
                            anim = {
                                scenario = "WORLD_HUMAN_CLIPBOARD"
                            },
                            disable = {
                                move = true,
                                car = true,
                                combat = true,
                                mouse = false
                            },
    
                        }) then
                            TriggerServerEvent('winemaker:pink:sale', quantity[1])
                        end
                    end
                end,
            },
            {
                title = TranslateCap('get_empty_bootle'),
                description = TranslateCap('get_empty_bootle_need'),
                onSelect = function()
                    local quantity = lib.inputDialog('Quantiter', {
                        {type = 'number', label = 'How much?', icon = 'hashtag', min = 1},
                      })
                      if quantity[1] then
                        if lib.progressBar({
                            duration = 10000,
                            label = 'You will receive the bottles.',
                            useWhileDead = false,
                            canCancel = true,
                            anim = {
                                scenario = "WORLD_HUMAN_CLIPBOARD"
                            },
                            disable = {
                                move = true,
                                car = true,
                                combat = true,
                                mouse = false
                            },
    
                        }) then
                            TriggerServerEvent('winemaker:GetEmptyBottle', quantity[1])
                        end
                    end
                end,
            },
            {
                title = TranslateCap('get_empty_can'),
                description = TranslateCap('get_empty_can_need'),
                onSelect = function()
                    local quantity = lib.inputDialog('Quantiter', {
                        {type = 'number', label = 'How much?', icon = 'hashtag', min = 1},
                      })
                      if quantity[1] then
                        if lib.progressBar({
                            duration = 10000,
                            label = 'You will receive the carafes.',
                            useWhileDead = false,
                            canCancel = true,
                            anim = {
                                scenario = "WORLD_HUMAN_CLIPBOARD"
                            },
                            disable = {
                                move = true,
                                car = true,
                                combat = true,
                                mouse = false
                            },
    
                        }) then
                            TriggerServerEvent('winemaker:GetEmptyCan', quantity[1])
                        end
                    end
                end,
            },
        },
    })
    lib.showContext('sale_of_wine')
end)

function blips()
    if PlayerData.job ~= nil and PlayerData.job.name == 'winemaker' then
        for k, v in pairs(Config.Blips) do
            local blipCoord = AddBlipForCoord(v.Pos.x, v.Pos.y, v.Pos.z)

            SetBlipSprite(blipCoord, 93)
            SetBlipDisplay(blipCoord, 4)
            SetBlipScale(blipCoord, 0.8)
            SetBlipColour(blipCoord, 7)
            SetBlipAsShortRange(blipCoord, true)

            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(v.BlipName)
            EndTextCommandSetBlipName(blipCoord)

            table.insert(WinemakerBlips, blipCoord) -- Stocker le blip dans la table
        end
    end
end

function delBlips()
    if WinemakerBlips[1] ~= nil then
        for i = 1, #WinemakerBlips do
            RemoveBlip(WinemakerBlips[i])
            WinemakerBlips[i] = nil
        end
    end
end
  