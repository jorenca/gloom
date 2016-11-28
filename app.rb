require 'sinatra'

set :port, 80
set :bind, '0.0.0.0'

set :root, './app'

set :run, true

Dir.glob('./app/**/*.rb').each { |file| require file }