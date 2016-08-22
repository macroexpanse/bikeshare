require 'bundler'
require 'sinatra/base'
require 'sinatra/json'
require 'sinatra/namespace'

require_relative './db/tables'
require_relative './models/bike'

ENV['RACK_ENV'] ||= 'development'
Bundler.require :default, ENV['RACK_ENV'].to_sym

class Bikeshare < Sinatra::Base
  register Sinatra::Namespace

  namespace '/bikes' do
    get '/:id' do
      json Bike.find(id: params[:id])
    end
  end
end
