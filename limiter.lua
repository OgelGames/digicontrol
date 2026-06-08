
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
		meta:set_int("limit", "1")
	end,
	on_receive_fields = function(pos, _, fields, sender)
		if minetest.is_protected(pos, sender:get_player_name()) then return end
		if fields.limit then
			local limit = tonumber(fields.limit) or 1
			if limit < -1 then limit = -1 end
			local meta = minetest.get_meta(pos)
			meta:set_int("limit", math.floor(limit))
			meta:set_string("messages", "")
		end
	end,
	digiline = {
		semiconductor = {
			rules = function(node, pos)
				local rules = {
					digicontrol.get_rule(1, node.param2),
					digicontrol.get_rule(3, node.param2)
				}
				local meta = minetest.get_meta(pos)
				local limit = meta:get_int("limit")
				if limit > 0 then
					local now = os.time()
					local msgs = meta:get_string("messages"):split(",")
					for i=#msgs, 1, -1 do
						if tonumber(msgs[i]) < now then msgs[i] = nil end
					end
					if #msgs < limit then
						msgs[#msgs+1] = now
					else
						rules = {}
					end
					meta:set_string("messages", table.concat(msgs, ","))
				elseif limit == 0 then
					rules = {}
				end
				return rules
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
