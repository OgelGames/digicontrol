
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
			"digiline_routing:filter",
			"digiline_routing:splitter",
			"digiline_routing:filter_b",
			"digiline_routing:splitter_b"
		},
		action = function(pos, node)
			local p = (node.param2 + 1) % 4
			-- For some reason the node name will be the aliased one...
			if node.name == "digicontrol:splitter" or node.name == "digicontrol:filter" then
				minetest.swap_node(pos, {name = node.name, param2 = p})
			else
				minetest.swap_node(pos, {name = connector, param2 = p})
			end
		end
	})
end
