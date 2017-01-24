local class = require "lib.30log"
local Transmitter = require "transmitter.Transmitter"
local DummyTransmitter = Transmitter:extend "DummyTransmitter"

function DummyTransmitter:transmit(packet)
  print "TRANSMITTED"
  return true
end

return DummyTransmitter
