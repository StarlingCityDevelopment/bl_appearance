local menus = {
	admin = {
		tabs = { "heritage", "hair", "clothes", "accessories", "face", "makeup", "outfits", "tattoos" },
		allowExit = true,
	},

	appearance = {
		tabs = { "heritage", "hair", "clothes", "accessories", "face", "makeup", "tattoos" },
		allowExit = true,
	},

	clothing = {
		tabs = { "clothes", "accessories"},
		allowExit = true,
	},

	barber = {
		tabs =  { "hair", "face", "makeup" },
		allowExit = true,
	},

	surgeon = {
		tabs =  { "heritage", "face"},
		allowExit = true,
	},

	tattoos = {
		tabs = {"tattoos"},
		allowExit = true,
	},

	outfits = {
		tabs = { "outfits" },
		allowExit = true,
	},
}

exports("menus", function()
	return menus
end)
