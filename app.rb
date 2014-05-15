require 'sinatra/base'
require_relative 'lib/locations'

class App < Sinatra::Application

  get '/' do
    File.read("public/index.html")
  end

  get '/map' do
    street_names = LOCATIONS.map { |location| location[:cross_street] }
    generator = MapGenerator.new(streets: street_names)
    generator.generate
  end

end