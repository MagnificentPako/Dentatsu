local class = require "lib.30log"
local Packet = class "Packet"

function Packet:init(content, target, source)
  self._content = content
  self._target = target
  self._source = source
end

function Packet:getContent()
  return self._content
end

function Packet:getTarget()
  return self._target
end

function Packet:getSource()
  return self._source
end

function Packet:setContent(content)
  self._content = content
end

function Packet:setTarget(target)
  self._target = target
end

function Packet:setSource(source)
  self._source = source
end

return Packet
