lib.addCommand('appearance', {
    help = 'Ouvrir le menu d\'apparence',
    params = {
        {
            name = 'target',
            type = 'playerId',
            help = 'ID du serveur du joueur cible',
            optional = true,
        },
        {
            name = 'type',
            type = 'string',
            help = 'appearance | outfits | tattoos | clothes | accessories | face | makeup | heritage',
            optional = true
        }
    },
    restricted = 'group.helper'
}, function(source, args, raw)
    local target = args.target or source
    local type = args.type or 'admin'
    TriggerClientEvent('bl_appearance:client:open', target, type)
end)