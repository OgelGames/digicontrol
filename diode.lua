
minetest.register_node("digicontrol:diode", {
	description = "Digilines Diode",
	inventory_image = "digicontrol_diode.png",
	tiles = {
		"digicontrol_diode.png",
		"digicontrol_bottom.png",
		"digicontrol_side_port.png",
		"digicontrol_side_port.png",
		"digicontrol_side.png",
		"digicontrol_side.png"
	},
	drawtype = "nodebox",
	node_box = digicontrol.node_box,
	selection_box = digicontrol.selection_box,
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {digicontrol = 1, dig_immediate = 2},
	digiline = {
		semiconductor = {
			rules = function(node)
				return {
					digicontrol.get_rule(1, node.param2)
				}
			end
		},
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
