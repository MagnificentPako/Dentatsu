local class = require "lib.30log"
local ProcessorChain = require "processor.ProcessorChain"

local Packet = require "packet.Packet"

local Wrapper = class "Wrapper"

local function dcopy(t)
  if(type(t) ~= "table") then return t end
  local tt = {}
  for k,v in pairs(t) do tt[dcopy(k)] = dcopy(v) end
  tt = setmetatable(tt, dcopy(getmetatable(t)))
  return tt
end

function Wrapper:init(receiver, transmitter, inProcessors, outProcessors)
  self._receiver = receiver
  self._transmitter = transmitter
  self._inProcessors = ProcessorChain(inProcessors)
  self._outProcessors = ProcessorChain(outProcessors)
  self._packetQueue = {}
  self._receiveQueue = {}
  self._sendQueue = {}
  self._handlers = {}
end

function Wrapper:addHandler(func)
  table.insert(self._handlers, func)
end

function Wrapper:send(packet)
  table.insert(self._packetQueue, packet)
end

function Wrapper:run()
  parallel.waitForAny(
    --# Function handling the receiving part
    function()
      while true do
        local msg = self._receiver:receive()
        if(msg ~= nil) then
          table.insert(self._packetQueue, msg)
        end
        sleep(0)
      end
    end,
    --# Function handling the "processor" part
    function()
      while true do
        local toRemove = {}
        for k,v in pairs(self._packetQueue) do
          if(v:getTarget():isSelf()) then
            v = self._inProcessors:process(v)
            table.insert(self._receiveQueue, v)
          else
            v = self._outProcessors:process(v)
            table.insert(self._sendQueue, v)
          end
        end
        self._packetQueue = {}
        sleep(0)
      end
    end,
    --# function which handles the sending part
    function()
      while true do
        if(#self._sendQueue > 0) then
          for k,v in pairs(self._sendQueue) do
            self._transmitter:transmit(v)
          end
          self._sendQueue = {}
        end
        sleep(0)
      end
    end,
    --# function which delivers the received
    --# and processed messages to the handlers
    function()
      while true do
        if(#self._receiveQueue > 0) then
          for k,v in pairs(self._receiveQueue) do
            for i,j in pairs(self._handlers) do
              j(v, function(content)
                self:send(
                  Packet(
                    content,
                    v:getSource(),
                    v:getTarget()
                  )
                )
              end)
            end
          end
          self._receiveQueue = {}
        end
        sleep(0)
      end
    end
  )
end

return Wrapper
