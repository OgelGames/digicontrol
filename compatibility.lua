
if not minetest.get_modpath("digiline_routing") then
	-- Aliases for main nodes
	minetest.register_alias("digiline_routing:diode", "digicontrol:diode")
	minetest.register_alias("digiline_routing:filter", "digicontrol:filter")
	minetest.register_alias("digiline_routing:splitter", "digicontrol:splitter")
	-- Alias for crafting item
	minetest.register_alias("digiline_routing:connector", "digilines:wire_std_00000000")
	-- LBM to replace nodes
	local connector = minetest.get_modpath("digistuff") and "digistuff:insulated_straight" or "digicontrol:filter"
	minetest.register_lbm({
		label = "Digicontrol digiline_routing compatibility",
		name = "digicontrol:routing_compat",
		nodenames = {
			"digiline_routing:filter_b",
			"digiline_routing:splitter_b"
		},
		action = function(pos, node)
			local pos2 = vector.subtract(pos, minetest.facedir_to_dir(node.param2))
			local node2 = minetest.get_node(pos2)
			local p = (node.param2 + 1) % 4
			-- Replace invisible node
			minetest.set_node(pos, {name = connector, param2 = p})
			-- Rotate main node
			minetest.swap_node(pos2, {name = node2.name, param2 = p})
		end
	})
end
