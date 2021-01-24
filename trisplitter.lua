
minetest.register_node("digicontrol:trisplitter", {
	description = "Digilines Tri-Splitter",
	inventory_image = "digicontrol_trisplitter.png",
	tiles = {
		"digicontrol_trisplitter.png",
		"digicontrol_bottom.png",
		"digicontrol_side_port.png",
		"digicontrol_side_port.png",
		"digicontrol_side_port.png",
		"digicontrol_side_port.png"
	},
	drawtype = "nodebox",
	node_box = digicontrol.node_box,
	selection_box = digicontrol.selection_box,
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {digicontrol = 1, dig_immediate = 2},
	on_rotate = digicontrol.on_rotate,
	after_place_node = digilines.update_autoconnect,
	after_destruct = digilines.update_autoconnect,
	digiline = {
		semiconductor = {
			rules = function(node, pos, from)
				local side = digicontrol.get_side(pos, from, node.param2)
				if side == 3 then
					return {
						digicontrol.get_rule(0, node.param2),
						digicontrol.get_rule(1, node.param2),
						digicontrol.get_rule(2, node.param2)
					}
				else
					return {
						digicontrol.get_rule(3, node.param2)
					}
				end
			end
		},
		wire = {
			rules = function(node)
				if node.param2 >= 4 then return {} end
				return digicontrol.all_rules
			end
		}
	}
})
