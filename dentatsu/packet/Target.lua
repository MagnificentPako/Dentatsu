local class = require "lib.30log"
local Target = class "Target"

function Target:init(channel, isSelf)
  self._channel = channel
  self._isSelf = isSelf
end

function Target:getTarget()
  return self._channel
end

function Target:isSelf()
  return self._isSelf
end

return Target
