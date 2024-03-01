local setTexture = nil
local display = false

-- NUI display toggle
local function setDisplay(bool)
    display = bool
    SendNUIMessage({
        display = bool
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
    setTexture = nil
    -- show mask selection
    setDisplay(true)
    -- wait till texture is selected
    Wait(500)
    while display do
        Wait(500)
    end
    -- make sure a texture was selected then call the server event to convert
    if setTexture ~= nil then
        TriggerServerEvent('ph_papermask:convert', slot, setTexture)
    else
        -- let the player no something went wrong
        print('no texture selected!')
    end
end)

/**
 * Exports a function to wear or remove a paper mask in the given inventory slot.
 * 
 * @param {object} slot - Object containing slot number of mask item. 
*/
exports('putonmmask', function(slot)
    local playerPed = PlayerPedId()
    local current = GetPedDrawableVariation(playerPed, 1)
    local texture = GetPedTextureVariation(playerPed, 1)
    slotid = slot.slot
    -- call server event to wear/remove mask
    TriggerServerEvent('ph_papermask:wear', slotid, current, texture)
end)



