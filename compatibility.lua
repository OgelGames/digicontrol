
if not minetest.get_modpath("digiline_routing") then
	-- Aliases for main nodes
	minetest.register_alias("digiline_routing:diode", "digicontrol:diode")
	minetest.register_alias("digiline_routing:filter", "digicontrol:filter")
	minetest.register_alias("digiline_routing:splitter", "digicontrol:splitter")
	-- Alias for crafting item
	minetest.register_alias("digiline_routing:connector", "digilines:wire_std_00000000")
	-- LBM to replace nodes
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
				minetest.swap_node(pos, {name = "digistuff:insulated_straight", param2 = p})
			end
		end
	})
end

if minetest.get_modpath("digistuff") then
	-- Use digicontrol on_rotate
	for _,n in pairs({"insulated_straight", "insulated_tjunction", "insulated_corner"}) do
		minetest.override_item("digistuff:"..n, {
			on_rotate = digicontrol.on_rotate
		})
	end
else
	-- Register digistuff's insulated wires
	minetest.register_node(":digistuff:insulated_straight", {
		description = "Insulated Digiline (straight)",
		tiles = {
			"digistuff_insulated_full.png",
			"digistuff_insulated_full.png",
			"digistuff_insulated_edge.png",
			"digistuff_insulated_edge.png",
			"digistuff_insulated_full.png",
			"digistuff_insulated_full.png"
		},
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = {dig_immediate = 3},
		walkable = false,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5,-0.5,-0.1,0.5,-0.4,0.1}
			}
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5,-0.5,-0.15,0.5,-0.35,0.15}
			}
		},
		on_rotate = digicontrol.on_rotate,
		after_place_node = digilines.update_autoconnect,
		after_destruct = digilines.update_autoconnect,
		digiline = {
			wire = {
				rules = function(node)
					return {
						digicontrol.get_rule(1, node.param2),
						digicontrol.get_rule(3, node.param2)
					}
				end
			}
		}
	})
	minetest.register_node(":digistuff:insulated_tjunction", {
		description = "Insulated Digiline (T junction)",
		tiles = {
			"digistuff_insulated_full.png",
			"digistuff_insulated_full.png",
			"digistuff_insulated_edge.png",
			"digistuff_insulated_edge.png",
			"digistuff_insulated_full.png",
			"digistuff_insulated_edge.png"
		},
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = {dig_immediate = 3},
		walkable = false,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5,-0.5,-0.1,0.5,-0.4,0.1},
				{-0.1,-0.5,-0.5,0.1,-0.4,-0.1}
			}
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5,-0.5,-0.5,0.5,-0.35,0.15}
			}
		},
		on_rotate = digicontrol.on_rotate,
		after_place_node = digilines.update_autoconnect,
		after_destruct = digilines.update_autoconnect,
		digiline = {
			receptor = {},
			wire = {
				rules = function(node)
					return {
						digicontrol.get_rule(1, node.param2),
						digicontrol.get_rule(2, node.param2),
						digicontrol.get_rule(3, node.param2)
					}
				end
			}
		}
	})
	minetest.register_node(":digistuff:insulated_corner", {
		description = "Insulated Digiline (corner)",
		tiles = {
			"digistuff_insulated_full.png",
			"digistuff_insulated_full.png",
			"digistuff_insulated_full.png",
			"digistuff_insulated_edge.png",
			"digistuff_insulated_full.png",
			"digistuff_insulated_edge.png"
		},
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = {dig_immediate = 3},
		walkable = false,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.1,-0.5,-0.5,0.1,-0.4,0.1},
				{-0.5,-0.5,-0.1,0.1,-0.4,0.1}
			}
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5,-0.5,-0.5,0.15,-0.35,0.15}
			}
		},
		on_rotate = digicontrol.on_rotate,
		after_place_node = digilines.update_autoconnect,
		after_destruct = digilines.update_autoconnect,
		digiline = {
			receptor = {},
			wire = {
				rules = function(node)
					return {
						digicontrol.get_rule(2, node.param2),
						digicontrol.get_rule(3, node.param2)
					}
				end
			}
		}
	})
	minetest.register_node(":digistuff:insulated_fourway", {
		description = "Insulated Digiline (four-way junction)",
		tiles = {
			"digistuff_insulated_full.png",
			"digistuff_insulated_full.png",
			"digistuff_insulated_edge.png",
			"digistuff_insulated_edge.png",
			"digistuff_insulated_edge.png",
			"digistuff_insulated_edge.png"
		},
		paramtype = "light",
		is_ground_content = false,
		groups = {dig_immediate = 3},
		walkable = false,
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5,-0.5,-0.1,0.5,-0.4,0.1},
				{-0.1,-0.5,-0.5,0.1,-0.4,-0.1},
				{-0.1,-0.5,0.1,0.1,-0.4,0.5}
			}
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5,-0.5,-0.5,0.5,-0.35,0.5}
			}
		},
		after_place_node = digilines.update_autoconnect,
		after_destruct = digilines.update_autoconnect,
		digiline = {
			wire = {
				rules = digicontrol.all_rules
			}
		}
	})
end
