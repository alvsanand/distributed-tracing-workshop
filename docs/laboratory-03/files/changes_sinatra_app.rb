######################################
# Add this after line "require './mongoid'"
######################################

require 'jaeger/client'
require 'opentracing'
require 'rack/tracer'
######################################

######################################
# Add this after line "  set :port, ENV['APP_PORT']"
######################################

  OpenTracing.global_tracer = Jaeger::Client.build(host: ENV['JAEGER_AGENT_HOST'], port: ENV['JAEGER_AGENT_PORT'].to_i, service_name: 'sinatra-app')
  use Rack::Tracer
######################################