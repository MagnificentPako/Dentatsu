local class = require "lib.30log"
local Receiver = require "receiver.Receiver"
local DummyReceiver = Receiver:extend "DummyReceiver"

local Packet = require "packet.Packet"
local Target = require "packet.Target"

function DummyReceiver:receive()
  sleep(5)
  local target = Target(1,true)
  local source = Target(2,false)
  local packet = Packet("VEhJUyBJUyBBIFBBQ0tFVA==", target, source)
  return packet
end

return DummyReceiver
