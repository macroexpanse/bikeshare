require 'bundler'
require 'sinatra/base'
require 'sinatra/json'

require_relative 'db/tables'
require_relative 'models/bike'
require_relative 'models/member'
require_relative 'models/rental'
require_relative 'models/station'
require_relative 'routes/bikes'
require_relative 'routes/rentals'
require_relative 'routes/stations'

ENV['RACK_ENV'] ||= 'development'
Bundler.require :default, ENV['RACK_ENV'].to_sym

class Bikeshare < Sinatra::Application
  register Routing::Bikes
  register Routing::Rentals
  register Routing::Stations
end
