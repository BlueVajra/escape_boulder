require 'rspec'
require 'map_generator'

describe MapGenerator do

  it 'generates a map for a single street' do
    expected = <<MAP.chomp
 9th 
  |  
-----
  |  
MAP
    locations = [
      {location: 1, cross_street: "9th"}
    ]
    expect(MapGenerator.new(locations: locations).generate).to eq(expected)
  end

  it 'puts an x in the current location' do
    expected = <<MAP.chomp
 9th 
  |  
--X--
  |  
MAP
    locations = [
      {location: 56, cross_street: "9th"}
    ]
    expect(MapGenerator.new(locations: locations, current_location_id: 56).generate).to eq(expected)
  end

  it 'generates a map for two streets' do
    expected = <<MAP.chomp
 9th            10th 
  |              |   
---------------------
  |              |   
MAP
    locations = [
      {location: 1, cross_street: "9th"},
      {location: 2, cross_street: "10th"}
    ]
    expect(MapGenerator.new(locations: locations).generate).to eq(expected)
  end

  it 'generates a map for streets with long names' do
    expected = <<MAP.chomp
 even streets            odd streets 
      |                       |      
-------------------------------------
      |                       |      
MAP
    locations = [
      {location: 1, cross_street: "even streets"},
      {location: 2, cross_street: "odd streets"}
    ]
    expect(MapGenerator.new(locations: locations).generate).to eq(expected)
  end

end