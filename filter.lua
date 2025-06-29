
local function match_channel(channel, filter)
	if filter == "" then return true end
	local match_start = filter:sub(-1) == "?"
	local match_end = filter:sub(1, 1) == "?"
	if match_start and match_end then
		return channel:find(filter:sub(2, -2), 1, true)
	elseif match_start then
		return channel:sub(1, #filter-1) == filter:sub(1, -2)
	elseif match_end then
		return channel:sub(-#filter+1) == filter:sub(2)
	end
	return channel == filter
end

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
	on_rotate = digicontrol.on_rotate,
	after_place_node = digilines.update_autoconnect,
	after_destruct = digilines.update_autoconnect,
	on_construct = function(pos)
		minetest.get_meta(pos):set_string("formspec", "field[channel;Channel Filter (empty for any);${channel}]")
	end,
	on_receive_fields = function(pos, _, fields, sender)
		if minetest.is_protected(pos, sender:get_player_name()) then return end
		if fields.channel then
			minetest.get_meta(pos):set_string("channel", fields.channel)
		end
	end,
	digiline = {
		semiconductor = {
			rules = function(node, pos, _, channel)
				local filter = minetest.get_meta(pos):get_string("channel")
				if not match_channel(channel, filter) then return {} end
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
