minetest.register_abm(
  {nodenames = {"fire:basic_flame"},
  neighbors = {"fire:basic_flame"},
  interval = 1,
  chance = 5,
  action = function(pos, node, active_object_count, active_object_count_wider)
    minetest.add_particle(pos, {x=0,y=1,z=0}, {x=0,y=math.random(10)/10,z=0}, math.random(2,5), math.random(3), false, "particle_smoke.png")
    minetest.add_particle(pos, {x=0,y=0,z=0}, {x=0,y=math.random(5)/10,z=0}, math.random(1,3), math.random(2), false, "particle_flame.png")
  end
})


