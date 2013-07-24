terminal = {}
terminal.allow_mesecons_and_digilines = false

minetest.register_privilege("terminal", "Can use terminal nodes")

minetest.register_node("terminal:client", {
  drawtype = "nodebox",
  tiles = {"terminal_client_side.png", "terminal_client_side.png", "terminal_client_side.png", "terminal_client_side.png", "terminal_client_side.png", "terminal_client_off.png"},
  paramtype = "light",
  paramtype2 = "facedir",
  groups = {dig_immediate=2},
  description="Client",
  on_construct = function(pos)
    local meta = minetest.env:get_meta(pos)
    meta:set_string("infotext", "")
  end,
  on_rightclick = function (pos)
    minetest.sound_play("terminal_on",{pos=pos,gain=0.7,max_hear_distance=32})
    local facing = minetest.env:get_node(pos).param2
    minetest.env:set_node(pos, { name="terminal:client_on", param2=facing })
  end,
  sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("terminal:client_on", {
  drawtype = "nodebox",
  tiles = {"terminal_client_side.png", "terminal_client_side.png", "terminal_client_side.png", "terminal_client_side.png", "terminal_client_side.png", "terminal_client.png"},
  paramtype = "light",
  paramtype2 = "facedir",
  light_source = 3,
  groups = {not_in_creative_inventory=1},
  description = "Client",
  on_construct = function(pos)
    local meta = minetest.env:get_meta(pos)
    meta:set_string("formspec", "field[text;;${command}]")
    meta:set_string("channel-in", "keyboard")
    meta:set_string("channel-out", "terminal")
    meta:set_string("command", "")
  end,
  on_receive_fields = function(pos, formname, fields, sender)
    local meta = minetest.get_meta(pos)
    local command = fields.text
    meta:set_string("command",  command)
    local player = sender:get_player_name()
    local terminal_output = terminal_command(fields.text, player, pos)
    if (terminal_output == "exit") then
      local facing = minetest.env:get_node(pos).param2
      minetest.env:set_node(pos, { name="terminal:client", param2=facing })
    else
      meta:set_string("infotext", command)
      minetest.chat_send_player(player, terminal_output, false)
    end
  end,
  on_punch = function (pos, node, puncher)
    local meta = minetest.env:get_meta(pos)
    local command = meta:get_string("command")
    local player = puncher:get_player_name()
    local terminal_output = terminal_command(command, player, pos)
    minetest.chat_send_player(player, terminal_output, false)
  end,
  mesecons = { effector = {
    action_on = function (pos, node)
      local meta = minetest.env:get_meta(pos)
      local command = meta:get_string("command")
      terminal_command(command, "mesecons", pos)
    end,
  }},
  digiline = { receptor = {},
    effector = {
      action = function(pos, node, channel, msg)
        local meta = minetest.env:get_meta(pos)
        local setchan = meta:get_string("channel-in")
        if setchan ~= channel then return end
        local command = meta:get_string("command")
        terminal_command(msg, "digilines", pos)
      end
    },
  },
})

function terminal_command(command, sender, pos)
  local privs = minetest.get_player_privs(sender)
  if (sender == "mesecons" or sender == "digilines") then
    if (terminal.allow_mesecons_and_digilines == false) then return "Digiline and mesecon triggering disabled" end
  else
    if ( privs == nil or not privs["terminal"] ) then return "Permission denied" end
  end
  print(sender.." executed \""..command.."\" on client at "..minetest.pos_to_string(pos))
  if (command == "exit" or command == "logout") then
    return "exit"
  end
  if (string.sub(command, 1,13) == "digilines -in") then
    local meta = minetest.env:get_meta(pos)
    local channel = string.sub(command,15)
    meta:set_string("channel-in", channel)
    return "> "..command.."\n Terminal channel input has been renamed to "..channel
  end
  if (string.sub(command, 1,14) == "digilines -out") then
    local meta = minetest.env:get_meta(pos)
    local channel = string.sub(command,16)
    meta:set_string("channel-out", channel)
    return "> "..command.."\n Terminal channel out has been renamed to "..channel
  end
  local state = os.execute(command.." > output")
  local f = io.open("output", "r")
  os.execute("rm output")
  if f then
    local contents = f:read("*all")
    print(contents)
    f:close()
    local meta = minetest.env:get_meta(pos)
    local channel = meta:get_string("channel-out")
    digiline:receptor_send(pos, digiline.rules.default, channel, contents)
    if (contents == nil or contents == "" or contents == "\n") then
      return "> "..command
    else
      return "> "..command.."\n"..contents
    end
  end
  minetest.sound_play("terminal_on",{pos=pos,gain=0.7,max_hear_distance=32})
  return "error"
end
