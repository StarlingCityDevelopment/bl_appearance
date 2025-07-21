--https://github.com/iLLeniumStudios/illenium-appearance/blob/main/shared/config.lua

local stores = {
    {
        type = 'outfits',
        coords = vec4(82.72, -365.3, 41.33, 255.61),
        jobs = { 'police' }
    },
    {
        type = 'outfits',
        coords = vector4(-193.72, -1331.31, 31.61, 1.14),
        jobs = { 'bennys' }
    },
    {
        type = 'outfits',
        coords = vector4(-193.72, -1331.31, 31.61, 1.14),
        jobs = { 'bennys' }
    },
    {
        type = 'clothing',
        coords = vector4(-705.5, -149.22, 37.42, 122),
    },
    {
        type = 'clothing',
        coords = vector4(-1192.61, -768.4, 17.32, 216.6),
    },
    {
        type = 'clothing',
        coords = vector4(425.91, -801.03, 29.49, 177.79),
    },
    {
        type = 'clothing',
        coords = vector4(-168.73, -301.41, 39.73, 238.67),
    },
    {
        type = 'clothing',
        coords = vector4(75.39, -1398.28, 29.38, 6.73),
    },
    {
        type = 'clothing',
        coords = vector4(-827.39, -1075.93, 11.33, 294.31),
    },
    {
        type = 'clothing',
        coords = vector4(-1445.86, -240.78, 49.82, 36.17),
    },
    {
        type = 'clothing',
        coords = vector4(-3171.32, 1043.56, 20.86, 334.3),
    },
    {
        type = 'clothing',
        coords = vector4(-1119.24, -1440.6, 5.23, 300.5),
    },
    {
        type = 'clothing',
        coords = vector4(124.82, -224.36, 54.56, 335.41),
    },
    {
        type = 'barber',
        coords = vector4(-814.22, -183.7, 37.57, 116.91),
    },
    {
        type = 'barber',
        coords = vector4(136.78, -1708.4, 29.29, 144.19),
    },
    {
        type = 'barber',
        coords = vector4(-1282.57, -1116.84, 6.99, 89.25),
    },
    {
        type = 'barber',
        coords = vector4(1212.8, -472.9, 65.2, 60.94),
    },
    {
        type = 'barber',
        coords = vector4(-32.9, -152.3, 56.1, 335.22),
    },
    {
        type = 'tattoos',
        coords = vector4(1322.6, -1651.9, 51.2, 42.47),
    },
    {
        type = 'tattoos',
        coords = vector4(-1154.01, -1425.31, 4.95, 23.21),
    },
    {
        type = 'tattoos',
        coords = vector4(322.62, 180.34, 103.59, 156.2),
    },
    {
        type = 'tattoos',
        coords = vector4(-3169.52, 1074.86, 20.83, 253.29),
    },
}

local currentZone = nil

local function setupZones()
    for id, v in pairs(stores) do
        exports.sleepless_interact:addCoords(vector3(v.coords.x, v.coords.y, v.coords.z), {
            {
                label = (v.type == 'barber' and "Barbier") or (v.type == 'tattoos' and "Tattoueur") or (v.type == 'clothing' and "Magasin de vêtements") or (v.type == 'surgeon' and "Chirurgien") or (v.type =='outfits' and "Vestiaires"),
                icon = "tshirt",
                distance = 5.0,
                onSelect = function()
                    if not currentZone then return end
                    TriggerEvent('bl_appearance:client:useZone', currentZone.type)
                end,
                canInteract = function(entity, distance, coords, name)
                    return distance < 2.5
                end,
                onActive = function()
                    currentZone = v
                end,
                onInactive = function()
                    currentZone = nil
                end,
            }
        })
    end
end

setupZones()

local blips = {}
local function createBlips()
    for _, v in ipairs(stores) do
        if v.type ~= 'appearance' and v.type ~= 'outfits' then
            local spriteId, blipColor, blipname, bliplabel, blipdesc

            if v.type == 'barber' then
                spriteId = 71
                blipColor = 35
                blipname = 'Salon de Coiffure'
                bliplabel = '💈 ' .. blipname
                blipdesc = 'Changez votre apparence avec une nouvelle coupe de cheveux.'
            elseif v.type == 'clothing' then
                spriteId = 73
                blipColor = 48
                blipname = 'Magasin de vêtements'
                bliplabel = '👕 ' .. blipname
                blipdesc = 'Achetez de nouveaux vêtements pour changer votre apparence.'
            elseif v.type == 'tattoos' then
                spriteId = 75
                blipColor = 49
                blipname = 'Salon de Tatouage'
                bliplabel = '💉 ' .. blipname
                blipdesc = 'Changez votre apparence avec de nouveaux tatouages.'
            elseif v.type == 'surgeon' then
                spriteId = 102
                blipColor = 4
                blipname = 'Surgeon'
            end

            if not spriteId then
                return
            end

            blips[#blips + 1] = exports.gs_blips:CreateBlip({
                coords = vector3(v.coords.x, v.coords.y, v.coords.z),
                sprite = spriteId,
                scale = v.type == 'barber' and 0.7 or 0.65,
                color = blipColor,
                label = blipname,
                data = {
                    title = bliplabel,
                    description = blipdesc,
                },
            })
        end
    end
end

createBlips()

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        for _, blip in pairs(blips) do
            RemoveBlip(blip)
        end
    end
end)