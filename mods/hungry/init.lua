--Simplest hunger mod ever by bas080
local enabled = minetest.setting_getbool("enable_damage")
if enabled then
  local timer = 0
  local distance_interval = 15 --set distance check interval in seconds
  
  local hunger_per_meter = 1/500 --1 hp per 500 meter walk
  local hunger_per_cubic = 1/100 --1 hp per 100 blocks dig
  
  local hunger = 0
  local hunger = 0
  
  local player = nil
  local pos_one
  minetest.register_on_joinplayer(function(joiner)
    minetest.after(0.5, function(param) 
      player = joiner
      pos_one = player:getpos()
    end)
  end)
  
  minetest.register_on_dignode(function(pos, oldnode, player)
    hunger = hunger + hunger_per_cubic
    if hunger >= 0.5 then
      player:set_hp(player:get_hp()-hunger)
    end
  end)
  
  minetest.register_globalstep(function(dtime)
    if player ~= nil then
      timer = timer + dtime
      if timer >= distance_interval then
        timer = 0
        local pos_two = player:getpos()
        hunger = hunger + (math.hypot(pos_one.x-pos_two.x, pos_one.y-pos_two.y)+math.abs(pos_one.y-pos_two.y))*hunger_per_meter
        pos_one = pos_two
        if hunger >=0.5 then
          timer = 0
          player:set_hp(player:get_hp()-hunger)
          hunger=0
          minetest.sound_play({ name="hunger_stomach" }, {
            gain = 1.0;
            max_hear_distance = 16;
          });
        end
      end
    end
  end)
end


