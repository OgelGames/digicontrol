
local function get_craftitem(items)
	for _,item in ipairs(items) do
		if minetest.registered_items[item] then
			return item
		end
	end
	return "???"
end

local digiwire = "digilines:wire_std_00000000"

local silicon = get_craftitem({
	"basic_materials:silicon",
	"mesecons_materials:silicon",
	"default:flint"
})

local wire = get_craftitem({
	"basic_materials:steel_wire",
	"default:steel_ingot"
})

local ic = get_craftitem({
	"basic_materials:ic",
	"default:mese_crystal_fragment"
})

minetest.register_craft({
	output = "digicontrol:diode",
	recipe = {
		{"", "", ""},
		{digiwire, silicon, digiwire},
		{"", "", ""},
	},
})

minetest.register_craft({
	output = "digicontrol:splitter",
	recipe = {
		{"", "", digiwire},
		{digiwire, silicon, ""},
		{"", "", digiwire},
	},
})

minetest.register_craft({
	output = "digicontrol:trisplitter",
	recipe = {
		{"", "", digiwire},
		{digiwire, silicon, digiwire},
		{"", "", digiwire},
	},
})

minetest.register_craft({
	output = "digicontrol:limiter",
	recipe = {
		{"", "", ""},
		{digiwire, wire, digiwire},
		{"", "", ""},
	},
})

minetest.register_craft({
	output = "digicontrol:filter",
	recipe = {
		{"", "", ""},
		{digiwire, ic, digiwire},
		{"", "", ""},
	},
})
