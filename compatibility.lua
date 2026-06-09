
if not core.get_modpath("digiline_routing") then
	-- Aliases for main nodes
	core.register_alias("digiline_routing:diode", "digicontrol:diode")
	core.register_alias("digiline_routing:filter", "digicontrol:filter")
	core.register_alias("digiline_routing:splitter", "digicontrol:splitter")
	-- Alias for crafting item
	core.register_alias("digiline_routing:connector", "digilines:wire_std_00000000")
	-- LBM to replace nodes
	local connector = core.get_modpath("digistuff") and "digistuff:insulated_straight" or "digicontrol:filter"
	core.register_lbm({
		label = "Digicontrol digiline_routing compatibility",
		name = "digicontrol:routing_compat",
		nodenames = {
			"digiline_routing:filter_b",
			"digiline_routing:splitter_b"
		},
		action = function(pos, node)
			local pos2 = vector.subtract(pos, core.facedir_to_dir(node.param2))
			local node2 = core.get_node(pos2)
			local p = (node.param2 + 1) % 4
			-- Replace invisible node
			core.set_node(pos, {name = connector, param2 = p})
			-- Rotate main node
			core.swap_node(pos2, {name = node2.name, param2 = p})
		end
	})
end
