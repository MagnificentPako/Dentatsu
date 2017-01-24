local class = require "lib.30log"
local Receiver = require "receiver.Receiver"
local RednetReceiver = Receiver:extend "RednetReceiver"

local Packet = require "packet.Packet"
local Target = require "packet.Target"

function RednetReceiver:receive()
  local evt = {os.pullEvent()}
  while evt[1] ~= "rednet_message" do
    evt = {os.pullEvent()}
  end
  local target = Target(os.getComputerID(), true)
  local source = Target(evt[2], false)
  local packet = Packet(evt[3], target, source)
  return packet
end

return RednetReceiver
