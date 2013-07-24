--Simplest hunger mod ever by bas080
local enabled = minetest.setting_getbool("enable_damage")
if enabled then
  local timer = 0
  local hunger_per_meter = 1/500 --1 hp per kilometer
  local distance_interval = 15 --set hunger interval in seconds
  local distance_hunger = 0
  local player = nil
  local pos_one
  minetest.register_on_joinplayer(function(joiner)
    minetest.after(0.5, function(param) 
      player = joiner
      pos_one = player:getpos()
    end)
  end)
  minetest.register_globalstep(function(dtime)
    if player ~= nil then
      timer = timer + dtime
      if timer >= distance_interval then
        timer = 0
        local pos_two = player:getpos()
        distance_hunger = distance_hunger + (math.hypot(pos_one.x-pos_two.x, pos_one.y-pos_two.y)+math.abs(pos_one.y-pos_two.y))*hunger_per_meter
        pos_one = pos_two
        print(distance_hunger)
        if distance_hunger >=0.5 then
          timer = 0
          player:set_hp(player:get_hp()-distance_hunger)
          distance_hunger=0
          minetest.sound_play({ name="hunger_stomach" }, {
            gain = 1.0;
            max_hear_distance = 16;
          });
        end
      end
    end
  end)
end
