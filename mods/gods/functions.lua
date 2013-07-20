function gods.generatePiramid(pos, height, slope)
  local node = "default:sandstonebrick"
  local node_hiro = {"gods:hiro_crops", "gods:hiro_men", "gods:hiro_sun", "gods:hiro_man_right", "gods:hiro_eye", "gods:hiro_man_left"}
  local width = -1
  for i=height, 1, -1 do
    for ii=slope, 0, -1 do
      if (ii > 0) then
        width = width+1
      else
        i=i-1
      end
      for iii=width, -width, -1 do
        if (i < 4) then
          if (iii < -3 or iii > 3) then
            minetest.add_node({x=iii+pos.x, y=pos.y+i, z=width+pos.z}, {name=node})
            minetest.add_node({x=iii+pos.x, y=pos.y+i, z=-width+pos.z}, {name=node})
            minetest.add_node({x=-width+pos.x, y=pos.y+i, z=-iii+pos.z}, {name=node})
            minetest.add_node({x=width+pos.x, y=pos.y+i, z=iii+pos.z}, {name=node})
          else
            if (i==3 and ii==slope) then
              minetest.add_node({x=iii+pos.x, y=pos.y+i, z=width+pos.z}, {name=node_hiro[math.random(6)]})
              minetest.add_node({x=iii+pos.x, y=pos.y+i, z=-width+pos.z}, {name=node_hiro[math.random(6)]})
              minetest.add_node({x=-width+pos.x, y=pos.y+i, z=-iii+pos.z}, {name=node_hiro[math.random(6)]})
              minetest.add_node({x=width+pos.x, y=pos.y+i, z=iii+pos.z}, {name=node_hiro[math.random(6)]})
            end
          end
        else
          minetest.add_node({x=iii+pos.x, y=pos.y+i, z=width+pos.z}, {name=node})
          minetest.add_node({x=iii+pos.x, y=pos.y+i, z=-width+pos.z}, {name=node})
          minetest.add_node({x=-width+pos.x, y=pos.y+i, z=-iii+pos.z}, {name=node})
          minetest.add_node({x=width+pos.x, y=pos.y+i, z=iii+pos.z}, {name=node})
        end
      end
    end
  end
  
  --paths
  for i=width, -width, -1 do
    minetest.add_node({x=pos.x+i, y=pos.y, z=pos.z}, {name=node})
    minetest.add_node({x=pos.x+i, y=pos.y, z=pos.z+1}, {name=node})
    minetest.add_node({x=pos.x+1, y=pos.y, z=pos.z+i}, {name=node})
    minetest.add_node({x=pos.x+i, y=pos.y, z=pos.z-1}, {name=node})
    minetest.add_node({x=pos.x-1, y=pos.y, z=pos.z+i}, {name=node})
    minetest.add_node({x=pos.x, y=pos.y, z=pos.z+i}, {name=node})
  end
end

minetest.register_tool("gods:test", {
	description = "Tester",
	inventory_image = "default_stick.png",
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.under then
			local height = 20
			gods.generatePiramid(pointed_thing.above, height, 1)
		end
	end,
})
