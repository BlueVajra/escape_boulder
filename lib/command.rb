# go - east/west
# enter <building>
# exit
# take <object>
# give <object>

require_relative 'locations'
require_relative 'buildings'
require_relative 'items'
require_relative 'intro'
require_relative 'quests'
require_relative 'story'
require_relative 'map_generator'


class Command
  def initialize
    @current_location = 0
    @current_building = nil
    @inventory = []
    @quit == false
    @west_min = 0
    @east_max = 5
    @items = ITEMS
    @buildings = BUILDINGS
    @locations = LOCATIONS
    @quests = QUESTS
    @current_quest=0
  end

  def run
    puts TITLE
    sleep(2)
    puts STORY
    sleep(2)
    describe_quest

    until @quit == true
      puts ">"
      command = gets.chomp
      do_command(command)
    end
  end

  def do_command(command)
    parsed_command = parse_command(command)
    case parsed_command[0]
      when "east"
        if @current_building == nil
          if @current_location == @east_max
            puts "Trying to leave Boulder already?"
          else
            @current_location += 1
            puts "going east"
            describe_location
          end
        else
          puts "you are in a building... try exiting first"
        end


      when "west"
        if @current_building == nil
          if @current_location == @west_min
            puts "Trying to leave Boulder already?"
          else
            @current_location -= 1
            puts "going west"
            describe_location
            if @current_location == 0
              describe_quest_brief
            end
          end
        else
          puts "you are in a building... try exiting first"
        end

      when "d"
        if @current_building == nil
          if @current_location == @east_max
            puts "Trying to leave Boulder already?"
          else
            @current_location += 1
            puts "going east"
            describe_location
          end
        else
          puts "you are in a building... try exiting first"
        end

      when "a"
        if @current_building == nil
          if @current_location == @west_min
            puts "Trying to leave Boulder already?"
          else
            @current_location -= 1
            puts "going west"
            describe_location
            if @current_location == 0
              describe_quest_brief
            end
          end
        else
          puts "you are in a building... try exiting first"
        end
      when "take"
        parsed_command.shift
        take_item(parsed_command.join(' '))
      when "give"
        parsed_command.shift
        give_item(parsed_command.join(' '))
      when "enter"
        parsed_command.shift
        enter_building(parsed_command.join(' '))
      when "exit"
        if @current_building == nil
          puts "You are not in a building... "
        else
          @current_building = nil
          describe_location
        end
      when "quit"
        puts "Taking the easy way out huh?"
        @quit = true
      when "look"
        describe_location
      when "map"
        generator = MapGenerator.new(locations: LOCATIONS, current_location_id: @current_location)
        puts
        puts generator.generate
        puts
      when "inventory"
        list_inventory
      when "quest"
        describe_quest
      when "help"
        puts "You have the following commands"
        puts "help, east, west, map, look, enter <building>, exit, take <item>, give <item>, quest, inventory, quit"
      else
        puts "3 hours of programming doesn't leave much room for other commands"

    end

  end

  def take_item(item)
    if @current_building == nil
      puts "there are no item outside to take"
    else
      if @items[@current_building].include?(item)

        @inventory << item
        the_index = @items[@current_building].index(item)
        @items[@current_building].delete_at(the_index)
        list_inventory
      else
        puts "I don't see that here..."
      end
    end
  end

  def give_item(item)
    if @current_building != nil || @current_location != 0
      puts "The only person you can give items to is on 9th and Pearl"
    elsif !@inventory.include?(item)
      puts "You don't have that to give."
    else
      the_index = @inventory.index(item)
      @inventory.delete_at(the_index)
      check_quest(item)
    end
  end

  def check_quest(item)
    puts "Why Thank You!"
    if @quests[@current_quest][:item].include?(item)
      puts "!!!!!!!!!!!!!!!!!!!!"
      puts "!!! AWESOME SAUCE !!"
      puts "!!!!!!!!!!!!!!!!!!!!"

      @current_quest += 1
      if @current_quest == 5
        finish_quest
      else
        describe_quest
      end

    else
      puts "thanks, but this is not going to help you get out of Boulder!"
    end
  end

  def describe_quest
    puts ""
    puts "**********************"
    puts "* YOUR CURRENT QUEST *"
    puts "**********************"
    puts @quests[@current_quest][:description]
    puts "'please just bring me one of the following', Feld says."
    @quests[@current_quest][:item].each do |item|
      puts "- #{item}"
    end
  end

  def describe_quest_brief
    puts "????????????????????????????"
    puts "Do you have anything for me?"
  end

  def list_inventory
    puts "You have the following items:"
    puts @inventory.join(', ')
    puts "-----------------"
  end

  def describe_location
    puts "-----------------"
    if @current_building == nil
      current_description = @locations.select do |location|
        location[:location] == @current_location
      end
      puts current_description[0][:name]
      puts current_description[0][:description]
      puts "----------------"
      #local_buildings = BUILDINGS[@current_location]
      local_buildings = get_local_buildings
      puts "You see the following buildings"
      puts local_buildings.join(', ')
    else
      #describe location
      puts "you are in #{@current_building}"
      puts @buildings[@current_location][@current_building][:description]
      puts "you see the following items"
      @items[@current_building].each do |item|
        puts "- #{item}"
      end
    end
    puts "-----------------"
    puts ""
  end

  def get_local_buildings
    building_array = []
    @buildings[@current_location].each do |k, v|
      building_array << k
    end
    building_array
  end

  def enter_building(building)
    if get_local_buildings.include?(building)
      puts "Entering #{building}"
      @current_building = building
      describe_location
    else
      puts "I don't see that... type 'look' to see what is there"
    end
  end

  def finish_quest
    puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    puts "Nice Job! You won!"
    puts ""
    puts "Now go fuck yourself"
    puts ""
    puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    @quit = true
  end

  def parse_command(command)
    command.split(' ')
  end
end

game = Command.new
game.run