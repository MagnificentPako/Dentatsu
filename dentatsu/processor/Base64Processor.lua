local base64 = require "lib.base64"
local class = require "lib.30log"
local Processor = require "processor.Processor"
local Base64Processor = Processor:extend("Base64Processor")

function Base64Processor:process(packet)
  if(packet:getTarget():isSelf()) then
    packet:setContent(base64.decode(packet:getContent()))
  else
    packet:setContent(base64.encode(packet:getContent()))
  end
  return packet
end

return Base64Processor
