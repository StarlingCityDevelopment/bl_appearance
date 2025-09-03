--https://github.com/iLLeniumStudios/illenium-appearance/blob/main/shared/config.lua

local stores = {
    {
        type = 'outfits',
        coords = vec4(-173.16, 306.09, 100.92, 357.39),
        jobs = { 'tsubaki' }
    },
--    {
--        type = 'outfits',
--        coords = vector4(-193.72, -1331.31, 31.61, 1.14),
--        jobs = { 'bennys' }
--    },
--    {
--        type = 'outfits',
--        coords = vector4(-193.72, -1331.31, 31.61, 1.14),
--        jobs = { 'bennys' }
--    },
    {
        type = 'clothing',
        coords = vector4(-715.87, -148.15, 37.61, 203.35),
    },
    {
        type = 'clothing',
        coords = vector4(-1188.96, -771.77, 17.33, 51.56),
    },
    {
        type = 'clothing',
        coords = vector4(425.91, -801.03, 29.49, 177.79),
    },
    {
        type = 'clothing',
        coords = vector4(-163.13, -311.11, 39.93, 330.47),
    },
    {
        type = 'clothing',
        coords = vector4(-827.39, -1075.93, 11.33, 294.31),
    },
    {
        type = 'clothing',
        coords = vector4(-1447.67, -230.32, 50.0, 136.37),
    },
    {
        type = 'clothing',
        coords = vector4(-3176.53, 1045.34, 20.86, 248.66),
    },
    {
        type = 'clothing',
        coords = vector4(119.5, -222.82, 54.56, 250.3),
    },
    {
        type = 'barber',
        coords = vector4(-814.22, -183.7, 37.57, 116.91),
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
        coords = vector4(1321.76, -1652.94, 52.28, 305.7),
    },
    {
        type = 'tattoos',
        coords = vector4(-1155.46, -1426.67, 4.95, 308.04),
    },
    {
        type = 'tattoos',
        coords = vector4(324.03, 179.88, 103.59, 86.47),
    },
    {
        type = 'tattoos',
        coords = vector4(-3169.33, 1076.72, 20.83, 148.46),
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
