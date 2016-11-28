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

io = Io.new(logger)

set :io, io

get '/' do
  @io = io
  erb :main
end

get '/set/:pin/:state' do
  io.set(params['pin'].to_sym, params['state'].to_i > 0)
end
