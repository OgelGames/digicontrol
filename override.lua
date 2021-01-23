
-- Override digilines.transmit and digilines.receptor_send to add more functionality
-- Mostly copied from https://github.com/minetest-mods/digilines/blob/master/internal.lua


local function queue_new()
	return {nextRead = 1, nextWrite = 1}
end

local function queue_empty(queue)
	return queue.nextRead == queue.nextWrite
end

local function queue_enqueue(queue, object)
	local nextWrite = queue.nextWrite
	queue[nextWrite] = object
	queue.nextWrite = nextWrite + 1
end

local function queue_dequeue(queue)
	local nextRead = queue.nextRead
	local object = queue[nextRead]
	queue[nextRead] = nil
	queue.nextRead = nextRead + 1
	return object[1], object[2]
end

function digilines.transmit(pos, channel, msg, checked, origin)
	local checkedID = minetest.hash_node_position(pos)
	if checked[checkedID] or not origin then
		return
	end
	checked[checkedID] = true

	digilines.vm_begin()
	local queue = queue_new()
	queue_enqueue(queue, {pos, origin})
	while not queue_empty(queue) do
		local curPos, fromPos = queue_dequeue(queue)
		local node = digilines.get_node_force(curPos)
		local spec = digilines.getspec(node)
		if spec then
			-- Effector actions --> Receive
			if spec.effector then
				spec.effector.action(curPos, node, channel, msg, fromPos)
			end
			-- Cable actions --> Transmit
			local rules
			-- Custom semiconductor def for digicontrol nodes
			if spec.semiconductor then
				rules = spec.semiconductor.rules(node, curPos, fromPos, channel)
			elseif spec.wire then
				rules = digilines.importrules(spec.wire.rules, node)
			end
			if rules then
				for _, rule in ipairs(rules) do
					local nextPos = digilines.addPosRule(curPos, rule)
					if digilines.rules_link(curPos, nextPos) then
						checkedID = minetest.hash_node_position(nextPos)
						if not checked[checkedID] then
							checked[checkedID] = true
							queue_enqueue(queue, {nextPos, curPos})
						end
					end
				end
			end
		end
	end
	digilines.vm_end()
end


function digilines.receptor_send(pos, rules, channel, msg)
	local checked = {}
	checked[minetest.hash_node_position(pos)] = true -- exclude itself
	for _,rule in ipairs(rules) do
		if digilines.rules_link(pos, digilines.addPosRule(pos, rule)) then
			digilines.transmit(digilines.addPosRule(pos, rule), channel, msg, checked, pos)
		end
	end
end
