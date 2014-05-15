require 'sinatra/base'
require_relative 'lib/locations'

class App < Sinatra::Application

  get '/' do
    File.read("public/index.html")
  end

  get '/map/:location_id' do
    generator = MapGenerator.new(locations: LOCATIONS, current_location_id: params[:location_id].to_i)
    generator.generate
  end


end