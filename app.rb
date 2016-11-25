require 'sinatra'
require 'rpi_gpio'
require 'logger'

log_file = File.new(
  Time.new.strftime('logs/%Y-%m-%d %H-%M-%S.log'),
  'w'
)
log_file.sync = true

logger = Logger.new(
  log_file,
  10, # aged files
  1_024_000 # 1Mb each
)
logger.level = Logger::INFO

set :port, 80
set :bind, '0.0.0.0'

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


io = Io.new(logger)
logger.info('Initialized at ' + Time.now.to_s)

get '/' do
  io.state.to_s
end

get '/set/:pin/:state' do
  io.set(params['pin'].to_sym, params['state'].to_i > 0)
end
