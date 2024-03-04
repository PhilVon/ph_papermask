local setTexture = nil
local display = false

-- NUI display toggle
local function setDisplay(bool)
    display = bool
    SendNUIMessage({
        display = bool,
        colors = {
            cImgCnt = Config.colorImgContainer,
            cBtnCnt = Config.colorBtnContainer,
            cBtnTxt = Config.colorBtnText,
            cBtnBg = Config.colorBtn,
            cBtnHvr = Config.colorbtnHover,
            cScrTrk = Config.colorScrollTrack,
            cScrThm = Config.colorScrollThumb,
            cScrThmHvr = Config.colorScrollThumbHover
        }
    })
    SetNuiFocus(
        bool,
        bool
    )
end

-- NUI close ui callback
RegisterNUICallback('closeGUI', function(data)
    setTexture = nil
    setDisplay(false)
end)

-- NUI texture selection callback
RegisterNUICallback('setTexture', function(data, cb)
    setTexture = data.texture
    setDisplay(false)
end)

-- NUI error call back
RegisterNUICallback('error', function(data)
    print(data.error)
    setDisplay(false)
end)

/**
 * Exports a function to convert a paper bag in the player's inventory 
 * to a wearable mask by prompting them to select a texture from NUI.
 *
 * @param {number} slot - Inventory slot number of paper bag to convert.
*/
exports('convert', function(slot)
    local pencount = exports.ox_inventory:Search('count', Config.penItem)
    setTexture = nil
    if not Config.penNeeded or pencount > 0 then
        -- show mask selection
        setDisplay(true)
        -- close player inventory
        exports.ox_inventory:closeInventory()
        -- wait till texture is selected
        Wait(500)
        while display do
            Wait(500)
        end
        -- make sure a texture was selected then call the server event to convert
        if setTexture ~= nil then
            TriggerServerEvent('ph_papermask:convert', slot, setTexture)
        else
            -- let the player know something went wrong
            print('no texture selected!')
        end
    else
        print('Pen needed!')
    end
end)

/**
 * Exports a function to wear or remove a paper mask in the given inventory slot.
 * 
 * @param {object} slot - Object containing slot number of mask item. 
*/
exports('putonmmask', function(data, slot)
    local playerPed = PlayerPedId()
    local current = GetPedDrawableVariation(playerPed, 1)
    local texture = GetPedTextureVariation(playerPed, 1)
    local itemtexture = slot.metadata.maskskin
    -- check if player is wearing a mask
    if current == 49 and texture == itemtexture then
        -- call server event to wear mask
        exports.ox_inventory:useItem(slot, function(data)
            if data then
                TriggerServerEvent('ph_papermask:wear', slot, false)
            end
        end)
    elseif current == 0 then
        -- call server event to remove mask
        exports.ox_inventory:useItem(slot, function(data)
            if data then
                TriggerServerEvent('ph_papermask:wear', slot, true)
            end
        end)
    else
        print('Remove current mask first')
    end
end)



