$LOAD_PATH.unshift("lib")
require 'sinatra/base'
require 'json'

require 'map_generator'
require 'locations'
require 'intro'
require 'story'
require 'quests'
require 'items'
require 'buildings'

class App < Sinatra::Application

  get '/' do
    erb :index
  end

  get '/map/:location_id' do
    generator = MapGenerator.new(locations: LOCATIONS, current_location_id: params[:location_id].to_i)
    generator.generate
  end

end