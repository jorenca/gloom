
require 'rpi_gpio'

class Io
  RPi::GPIO.set_numbering :board

  def pins
    {
      output: {
        air: 7
      }
    }
  end

  def initialize(logger)
    @state = {}
    @logger = logger
    pins.each do |type, pin_list|
      pin_list.each do |name, pin|
        @state[name] = 0
        RPi::GPIO.setup(pin, as: type)
        RPi::GPIO.set_low(pin)
      end
    end
  end

  attr_accessor :state

  def set(pin_name, value)
    @logger.info('GPIO') { 'invoked set for ' + pin_name.to_s + ' to ' + value.to_s }
    pin = pins[:output][pin_name]
    @state[pin_name] = value
    value ? RPi::GPIO.set_high(pin) : RPi::GPIO.set_low(pin)
  end
end