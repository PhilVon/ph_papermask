--default
local textureid = 1

-- Registers a server event handler to convert a paper bag item
-- to a paper mask item. Checks if paper bag is empty first.
-- Sets the mask image texture id and skin metadata.
RegisterNetEvent('ph_papermask:convert', function(slot, setTexture)
    local item = exports.ox_inventory:GetSlot(source, slot)
    local slotid = item.slot
    -- this will only be called by a paperbag so a container can be assumed
    local container = item.metadata.container
    local containeritems = exports.ox_inventory:GetInventoryItems(container)
    local image = "papermask"
    textureid = setTexture

    -- check the container is empty
    if not containeritems or #containeritems == 0 then
        -- if empty then remove the paperbag and add a mask
        exports.ox_inventory:RemoveItem(source, item.name, 1, _, slotid)
        exports.ox_inventory:AddItem(source, 'papermask1', 1, _, slotid)
        item = exports.ox_inventory:GetSlot(source, slotid)
        -- set the metadata for the mask
        item.metadata.image = image .. textureid
        item.metadata.maskskin = textureid
        exports.ox_inventory:SetMetadata(source, slotid, item.metadata)
    else
        -- if not empty then tell the player to empty the bag
        print("empty the bag!")
    end
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

    -- check if player is wearing a mask
    if currentMask == 49 and currentMaskTexture == texture then
        -- if current mask is the same as the one in the inventory, remove it
        print('removing mask')
        SetPedComponentVariation(source, 1, 0, 0, 0)
    elseif currentMask == 0 then
        -- if player is not wearing a mask, wear the mask
        print('putting on mask')
        if texture ~= nil then
            SetPedComponentVariation(source, 1, 49, texture, 0)
        end
    else
        -- if player is wearing a non-paper mask, tell them to remove it
        print('Remove current mask first')
    end
end)
