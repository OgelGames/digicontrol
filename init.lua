
digicontrol = {}

digicontrol.selection_box = {
	type = "fixed",
	fixed = { -8/16, -8/16, -8/16, 8/16, -6/16, 8/16 }
}

digicontrol.node_box = {
	type = "fixed",
	fixed = {
		{ -8/16, -8/16, -8/16, 8/16, -7/16, 8/16 },
		{ -6/16, -7/16, -6/16, 6/16, -6/16, 6/16 }
	},
}

local BASE_RULES = {
	{x = 0, y = 0, z = 1},  -- Up    (side 0)
	{x = 1, y = 0, z = 0},  -- Right (side 1)
	{x = 0, y = 0, z =-1},  -- Down  (side 2)
	{x =-1, y = 0, z = 0}   -- Left  (side 3)
}

digicontrol.all_rules = BASE_RULES

function digicontrol.get_rule(side, param2)
	if param2 >= 4 then return nil end
	return BASE_RULES[((side + param2) % 4) + 1]
end

function digicontrol.get_side(pos, from, param2)
	if param2 >= 4 then return nil end
	local dir = vector.subtract(from, pos)
	local facedir = minetest.dir_to_facedir(dir)
	return ((facedir - param2) + 4) % 4
end

function digicontrol.on_rotate(pos, node, _, mode, new_param2)
	if mode ~= 1 then return false end
	node.param2 = new_param2
	minetest.swap_node(pos, node)
	digilines.update_autoconnect(pos)
	return true
end

local MP = minetest.get_modpath("digicontrol")

-- Overrides to digilines functions
dofile(MP.."/override.lua")

-- Compatibility for digiline_routing and digistuff
dofile(MP.."/compatibility.lua")

-- Digicontrol nodes
dofile(MP.."/diode.lua")
dofile(MP.."/splitter.lua")
dofile(MP.."/trisplitter.lua")
dofile(MP.."/filter.lua")
dofile(MP.."/limiter.lua")
--dofile(MP.."/router.lua")
