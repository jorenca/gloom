require 'sinatra'

set :port, 80
set :bind, '0.0.0.0'

set :run, true

Dir.glob('./app/**/*.rb').each { |file| require file }