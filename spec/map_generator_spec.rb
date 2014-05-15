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
    expect(MapGenerator.new(streets: ["9th"]).generate).to eq(expected)
  end

  it 'generates a map for two streets' do
    expected = <<MAP.chomp
 9th            10th 
  |              |   
---------------------
  |              |   
MAP
    expect(MapGenerator.new(streets: ["9th", "10th"]).generate).to eq(expected)
  end

  it 'generates a map for streets with long names' do
    expected = <<MAP.chomp
 even streets            odd streets 
      |                       |      
-------------------------------------
      |                       |      
MAP
    expect(MapGenerator.new(streets: ["even streets", "odd streets"]).generate).to eq(expected)
  end

end