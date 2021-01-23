
minetest.register_node("digicontrol:filter", {
	description = "Digilines Filter",
	inventory_image = "digicontrol_filter.png",
	tiles = {
		"digicontrol_filter.png",
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
			rules = function(node, pos, from, channel)
				local setchannel = minetest.get_meta(pos):get_string("channel")
				if channel ~= setchannel then return {} end
				local side = digicontrol.get_side(pos, from, node.param2)
				if side == 3 then
					return {
						digicontrol.get_rule(1, node.param2)
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
				return {
					digicontrol.get_rule(1, node.param2),
					digicontrol.get_rule(3, node.param2)
				}
			end
		}
	}
})
