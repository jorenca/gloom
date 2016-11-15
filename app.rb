require 'sinatra'
require 'rpi_gpio'

set :port, 80
set :bind, '0.0.0.0'

class Io
  def pins
    {
      output: {
        air: 7
      }
    }
  end

  def initialize
    @state = {}
    pins.each do |type, pin_list|
    pin_list.each { |name, pin|
      @state[name] = 0 }
    end
  end
  
  attr_accessor :state

  def set(pin_name, value)
    p 'invoked set for ' + pin_name.to_s
    pin = pins[:output][pin_name]
    @state[pin_name] = value
  end
end


io = Io.new

get '/' do
  io.state.to_s
end

get '/set/:pin/:state' do
  io.set(params['pin'].to_sym, params['state'].to_i > 0)
end
