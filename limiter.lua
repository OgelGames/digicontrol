
minetest.register_node("digicontrol:limiter", {
	description = "Digilines Limiter",
	inventory_image = "digicontrol_limiter.png",
	tiles = {
		"digicontrol_limiter.png",
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
	on_rotate = digicontrol.on_rotate,
	after_place_node = digilines.update_autoconnect,
	after_destruct = digilines.update_autoconnect,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", "field[limit;Message Limit (messages/second);${limit}]")
		meta:set_string("limit", "1")
	end,
	on_receive_fields = function(pos, _, fields, sender)
		if minetest.is_protected(pos, sender:get_player_name()) then return end
		if fields.limit then
			local limit = tonumber(fields.limit)
			if limit then
				minetest.get_meta(pos):set_string("limit", math.min(limit, 10))
			end
		end
	end,
	digiline = {
		semiconductor = {
			rules = function(node, pos)
				local timer = minetest.get_node_timer(pos)
				local limit = tonumber(minetest.get_meta(pos):get_string("limit"))
				if not limit or limit == 0 or timer:is_started() then return {} end
				if limit > 0 then
					timer:start(1 / limit)
				end
				return {
					digicontrol.get_rule(1, node.param2),
					digicontrol.get_rule(3, node.param2)
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
