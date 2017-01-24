local d = {}

d.receiver = {}
d.transmitter = {}
d.processor = {}
d.wrapper = {}

d.receiver.Receiver = require "receiver.Receiver"
d.receiver.Dummy = require "receiver.DummyReceiver"
d.receiver.Rednet = require "receiver.RednetReceiver"

d.transmitter.Transmitter = require "transmitter.Transmitter"
d.transmitter.Dummy = require "transmitter.DummyTransmitter"
d.transmitter.Rednet = require "transmitter.RednetTransmitter"

d.processor.Processor = require "processor.Processor"
d.processor.Base64 = require "processor.Base64Processor"

d.wrapper.Wrapper = require "wrapper.Wrapper"

return d
