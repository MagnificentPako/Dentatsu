local class = require "lib.30log"

local ProcessorChain = class "ProcessorChain"

function ProcessorChain:init(list)
  self._processors = list
end

function ProcessorChain:process(pac)
  for k,v in pairs(self._processors) do
    pac = v:process(pac)
  end
  return pac
end

return ProcessorChain
