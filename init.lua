minetest.register_chatcommand("bifrost", {
	params = "<X>,<Y>,<Z> | <to_name> | (<name> <X>,<Y>,<Z>) | (<name> <to_name>)",
	description = "Teleport to position or player",
	privs = {teleport=true},
	func = function(name, param)
		-- Returns (pos, true) if found, otherwise (pos, false)
		local function find_free_position_near(pos)
			local tries = {
				{x=1,y=0,z=0},
				{x=-1,y=0,z=0},
				{x=0,y=0,z=1},
				{x=0,y=0,z=-1},
			}
			for _, d in ipairs(tries) do
				local p = {x = pos.x+d.x, y = pos.y+d.y, z = pos.z+d.z}
				local n = minetest.get_node_or_nil(p)
				if n and n.name then
					local def = minetest.registered_nodes[n.name]
					if def and not def.walkable then
						return p, true
					end
				end
			end
			return pos, false
		end

		local teleportee = nil
		local p = {}
		p.x, p.y, p.z = string.match(param, "^([%d.-]+)[, ] *([%d.-]+)[, ] *([%d.-]+)$")
		p.x = tonumber(p.x)
		p.y = tonumber(p.y)
		p.z = tonumber(p.z)
		if p.x and p.y and p.z then
			local lm = 31000
			if p.x < -lm or p.x > lm or p.y < -lm or p.y > lm or p.z < -lm or p.z > lm then
				return false, "Cannot teleport out of map bounds!"
			end
			teleportee = minetest.get_player_by_name(name)
			if teleportee then
				local pos1 = teleportee:get_pos()
				teleportee:set_physics_override({
						gravity=-.5, speed = 0

					})

        minetest.add_particlespawner({
            amount = 3000,
            time = 4,
            minpos = {x=pos1.x+5,y=pos1.y-2,z=pos1.z+5},
            maxpos = {x=pos1.x-5,y=pos1.y+40,z=pos1.z-5},
            minvel = {x = -0, y = 4, z = -0},
            maxvel = {x = 0, y = 6, z = 0},
            minacc = {x = 0, y = 6, z = 0},
            maxacc = {x = 0, y = 6, z = 0},
            minexptime = 7,
            maxexptime = 7,
            minsize = 12,
						vertical = true,
            maxsize = 12,
            texture = "bifrost.png",
            collisiondetection = false
    })
		minetest.add_particlespawner({
				amount = 3000,
				time = 9,
				minpos = {x=p.x+5,y=p.y,z=p.z+5},
				maxpos = {x=p.x-5,y=pos1.y+40,z=p.z-5},
				minvel = {x = 0, y = -4, z = 0},
				maxvel = {x = 0, y = -6, z = 0},
				minacc = {x = 0, y = -6, z = 0},
				maxacc = {x = 0, y = -6, z = 0},
				minexptime = 4,
				maxexptime = 4,
				minsize = 12,
				vertical = true,
				maxsize = 12,
				texture = "bifrost.png",
				collisiondetection = false
})
		minetest.after(4, function()
			teleportee:set_physics_override({
					gravity= 1,})
--We change the gravity back to normal two seconds before teleporting to allow them to slow down - otherwise they fly into the air after being teleported, and will die when they hit the ground (unless there's something above them, or water below.)
				minetest.after(2, function()
					teleportee:set_physics_override({
							speed = 1 })
							teleportee:set_pos(p)

				return true, "Teleporting to "..minetest.pos_to_string(p)
end)
		end)
end
end
		local teleportee = nil
		local p = nil
		local target_name = nil
		target_name = param:match("^([^ ]+)$")
		teleportee = minetest.get_player_by_name(name)
		if target_name then
			local target = minetest.get_player_by_name(target_name)
			if target then
				p = target:get_pos()
			end
		end
		if teleportee and p then
			local pos1 = teleportee:get_pos()
			teleportee:set_physics_override({
					gravity=-.5, speed = 0

				})

			minetest.add_particlespawner({
					amount = 3000,
					time = 4,
					minpos = {x=pos1.x+5,y=pos1.y-2,z=pos1.z+5},
					maxpos = {x=pos1.x-5,y=pos1.y+40,z=pos1.z-5},
					minvel = {x = -0, y = 4, z = -0},
					maxvel = {x = 0, y = 6, z = 0},
					minacc = {x = 0, y = 6, z = 0},
					maxacc = {x = 0, y = 6, z = 0},
					minexptime = 7,
					maxexptime = 7,
					minsize = 12,
					vertical = true,
					maxsize = 12,
					texture = "bifrost.png",
					collisiondetection = false
	})
	minetest.add_particlespawner({
			amount = 3000,
			time = 9,
			minpos = {x=p.x+5,y=p.y,z=p.z+5},
			maxpos = {x=p.x-5,y=pos1.y+40,z=p.z-5},
			minvel = {x = 0, y = -4, z = 0},
			maxvel = {x = 0, y = -6, z = 0},
			minacc = {x = 0, y = -6, z = 0},
			maxacc = {x = 0, y = -6, z = 0},
			minexptime = 4,
			maxexptime = 4,
			minsize = 12,
			vertical = true,
			maxsize = 12,
			texture = "bifrost.png",
			collisiondetection = false
})
	minetest.after(4, function()
		teleportee:set_physics_override({
				gravity= 1,})
--We change the gravity back to normal two seconds before teleporting to allow them to slow down - otherwise they fly into the air after being teleported, and will die when they hit the ground (unless there's something above them, or water below.)
			minetest.after(2, function()
				teleportee:set_physics_override({
						speed = 1 })
						teleportee:set_pos(p)
			return true, "Teleporting to " .. target_name
					.. " at "..minetest.pos_to_string(p)
		end)
	end)
	end
		if not minetest.check_player_privs(name, {bring=true}) then
			return false, "You don't have permission to teleport other players (missing bring privilege)"
		end

		local teleportee = nil
		local p = {}
		local teleportee_name = nil
		teleportee_name, p.x, p.y, p.z = param:match(
				"^([^ ]+) +([%d.-]+)[, ] *([%d.-]+)[, ] *([%d.-]+)$")
		p.x, p.y, p.z = tonumber(p.x), tonumber(p.y), tonumber(p.z)
		if teleportee_name then
			teleportee = minetest.get_player_by_name(teleportee_name)
		end
		if teleportee and p.x and p.y and p.z then
			local pos1 = teleportee:get_pos()
			teleportee:set_physics_override({
					gravity=-.5, speed = 0

				})

			minetest.add_particlespawner({
					amount = 3000,
					time = 4,
					minpos = {x=pos1.x+5,y=pos1.y-2,z=pos1.z+5},
					maxpos = {x=pos1.x-5,y=pos1.y+40,z=pos1.z-5},
					minvel = {x = -0, y = 4, z = -0},
					maxvel = {x = 0, y = 6, z = 0},
					minacc = {x = 0, y = 6, z = 0},
					maxacc = {x = 0, y = 6, z = 0},
					minexptime = 7,
					maxexptime = 7,
					minsize = 12,
					vertical = true,
					maxsize = 12,
					texture = "bifrost.png",
					collisiondetection = false
	})
	minetest.add_particlespawner({
			amount = 3000,
			time = 9,
			minpos = {x=p.x+5,y=p.y,z=p.z+5},
			maxpos = {x=p.x-5,y=pos1.y+40,z=p.z-5},
			minvel = {x = 0, y = -4, z = 0},
			maxvel = {x = 0, y = -6, z = 0},
			minacc = {x = 0, y = -6, z = 0},
			maxacc = {x = 0, y = -6, z = 0},
			minexptime = 4,
			maxexptime = 4,
			minsize = 12,
			vertical = true,
			maxsize = 12,
			texture = "bifrost.png",
			collisiondetection = false
})
	minetest.after(4, function()
		teleportee:set_physics_override({
				gravity= 1,})
--We change the gravity back to normal two seconds before teleporting to allow them to slow down - otherwise they fly into the air after being teleported, and will die when they hit the ground (unless there's something above them, or water below.)
			minetest.after(2, function()
				teleportee:set_physics_override({
						speed = 1 })
						teleportee:set_pos(p)
			return true, "Teleporting " .. teleportee_name
					.. " to " .. minetest.pos_to_string(p)
		end)
	end)
	end
		local teleportee = nil
		local p = nil
		local teleportee_name = nil
		local target_name = nil
		teleportee_name, target_name = string.match(param, "^([^ ]+) +([^ ]+)$")
		if teleportee_name then
			teleportee = minetest.get_player_by_name(teleportee_name)
			if teleportee then
				teleporteepos = teleportee:get_pos()
		end
		if target_name then
			local target = minetest.get_player_by_name(target_name)
			if target then
				p = target:get_pos()

			end
		end
		if teleporteepos and p then
			local node = minetest.get_node(teleporteepos)
			local pos1 = teleportee:get_pos()
			teleportee:set_physics_override({
					gravity=-.5, speed = 0

				})

			minetest.add_particlespawner({
					amount = 3000,
					time = 4,
					minpos = {x=pos1.x+5,y=pos1.y-2,z=pos1.z+5},
					maxpos = {x=pos1.x-5,y=pos1.y+40,z=pos1.z-5},
					minvel = {x = -0, y = 4, z = -0},
					maxvel = {x = 0, y = 6, z = 0},
					minacc = {x = 0, y = 6, z = 0},
					maxacc = {x = 0, y = 6, z = 0},
					minexptime = 7,
					maxexptime = 7,
					minsize = 12,
					vertical = true,
					maxsize = 12,
					texture = "bifrost.png",
					collisiondetection = false
	})
	minetest.add_particlespawner({
			amount = 3000,
			time = 9,
			minpos = {x=p.x+5,y=p.y,z=p.z+5},
			maxpos = {x=p.x-5,y=pos1.y+40,z=p.z-5},
			minvel = {x = 0, y = -4, z = 0},
			maxvel = {x = 0, y = -6, z = 0},
			minacc = {x = 0, y = -6, z = 0},
			maxacc = {x = 0, y = -6, z = 0},
			minexptime = 4,
			maxexptime = 4,
			minsize = 12,
			vertical = true,
			maxsize = 12,
			texture = "bifrost.png",
			collisiondetection = false
})
	minetest.after(4, function()
		teleportee:set_physics_override({
				gravity= 1,})
--We change the gravity back to normal two seconds before teleporting to allow them to slow down - otherwise they fly into the air after being teleported, and will die when they hit the ground (unless there's something above them, or water below.)
			minetest.after(2, function()
				teleportee:set_physics_override({
						speed = 1 })
						teleportee:set_pos(p)

			return true, "Teleporting " .. teleportee_name
					.. " to " .. target_name
					.. " at " .. minetest.pos_to_string(p)
		end)
	end)
end

	end
end


})
