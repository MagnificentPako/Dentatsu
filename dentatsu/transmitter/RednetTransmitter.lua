local class = require "lib.30log"
local Receiver = require "receiver.Receiver"
local RednetTransmitter = Receiver:extend "RednetTransmitter"

function RednetTransmitter:transmit(packet)
  rednet.send(packet:getTarget():getTarget(), packet:getContent())
end

return RednetTransmitter
