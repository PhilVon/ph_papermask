--default
local textureid = 1

-- Registers a hook to prevent papermasks from being removed from inventory while worn.
local hookId = exports.ox_inventory:registerHook('swapItems', function(payload)
    print(json.encode(payload, { indent = true }))
    if payload.fromSlot.metadata.worn == true then
        return false
    end
    return true
end, {
    print = false,
    itemFilter = {
        papermask1 = true,
    },
    fromType = 'player'
})

-- Registers a server event handler to convert a paper bag item
-- to a paper mask item. Checks if paper bag is empty first.
-- Sets the mask image texture id and skin metadata.
RegisterNetEvent('ph_papermask:convert', function(slot, setTexture)
    local metadata = {}
    local item = exports.ox_inventory:GetSlot(source, slot)
    local slotid = item.slot
    -- this will only be called by a paperbag so a container can be assumed
    local container = item.metadata.container
    local containeritems = exports.ox_inventory:GetInventoryItems(container)
    local image = Config.imagePrefix
    textureid = setTexture

    -- register a hook to set the metadata
    local hookcreateId = exports.ox_inventory:registerHook('createItem', function(payload)
        print(json.encode(payload, { indent = true }))
        metadata = payload.metadata
        metadata.image = image .. textureid
        metadata.maskskin = textureid
        return metadata
    end, {
        print = false,
        itemFilter = {
            papermask1 = true
        }
    })
    -- check the container is empty
    if not containeritems or #containeritems == 0 then
        
        -- if empty then remove the paperbag and add a mask
        exports.ox_inventory:RemoveItem(source, item.name, 1, _, slotid)
        exports.ox_inventory:AddItem(source, 'papermask1', 1, _, slotid)
    else
        -- if not empty then tell the player to empty the bag
        print("empty the bag!")
    end
    exports.ox_inventory:removeHooks(hookcreateId)
end)

-- Registers a server event handler for the player to wear/remove
-- a paper mask item. Checks if mask matches currently worn mask.
-- Sets ped component variation to wear/remove mask.
RegisterNetEvent('ph_papermask:wear', function(slot, current, currentTexture)
    local slotid = slot
    local currentMask = current
    local currentMaskTexture = currentTexture
    local item = exports.ox_inventory:GetSlot(source, slotid)
    local texture = tonumber(item.metadata.maskskin)
    --print(json.encode(item))
    -- check if player is wearing a mask
    if currentMask == 49 and currentMaskTexture == texture then
        -- if current mask is the same as the one in the inventory, remove it
        -- [[add call to your skin script here to save your outfit]]
        print('removing mask')
        item.metadata.worn = false
        exports.ox_inventory:SetMetadata(source, item.slot, item.metadata)
        SetPedComponentVariation(source, 1, 0, 0, 0)
    elseif currentMask == 0 then
        -- if player is not wearing a mask, wear the mask
        -- [[add call to your skin script here to save your outfit]]
        print('putting on mask')
        if texture ~= nil then
            item.metadata.worn = true
            exports.ox_inventory:SetMetadata(source, item.slot, item.metadata)
            SetPedComponentVariation(source, 1, 49, texture, 0)
        end
    else
        -- if player is wearing a non-paper mask, tell them to remove it
        print('Remove current mask first')
    end
end)