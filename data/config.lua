Config = {
    locale = 'fr',
    openControl = 'E',
    previousClothing = 'illenium', -- 'illenium' | 'qb' | 'esx' | 'fivem-appearance'
    textUi = true, -- if true, uses textUI | if false, uses sprite
    outfitItem = 'clothes_outfits', -- Item given to the player when they want to make outfit an item to use
    outfitCost = 150, -- Cost to save an outfit as an item
}

exports('config', function()
    return Config
end)

---@param state boolean If true, hides the HUD. If false, shows the HUD.
exports('hideHud', function(state)
    DisplayRadar(state)
end)