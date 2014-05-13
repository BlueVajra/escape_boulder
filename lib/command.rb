# go - east/west
# enter <building>
# exit
# take <object>
# give <object>

require_relative 'locations'

class Command
  def initialize
    @current_location = 0
    @current_building = nil
    @inventory = []
    @quit == false
    @west_min = 0
    @east_max = 3
  end

  def run
    until @quit == true
      puts ">"
      command = gets.chomp

      do_command(command)
    end
  end

  def do_command(command)
    parsed_command = parse_command(command)
    case parsed_command[0]
      when "go"
        case parsed_command[1]
          when "east"
            if @current_location == @east_max
              puts "Trying to leave Boulder already?"
            else
              @current_location += 1
              puts "going east"
              describe_location
            end

          when "west"
            if @current_location == @west_min
              puts "Trying to leave Boulder already?"
            else
              @current_location -= 1
              puts "going west"
              describe_location
            end
          else
            puts "Which direction is that?"
        end

      when "enter"

      when "exit"
        puts "Taking the easy way out huh?"
        @quit = true
      when "look"
        describe_location

    end

  end

  def describe_location
    if @current_building == nil
      current_description = LOCATIONS.select do |location|
        location[:location] == @current_location
      end
      puts current_description[0][:name]
      puts current_description[0][:description]
    else
      #describe location
      puts "you are in a building"
    end
  end

  def parse_command(command)
    command.split(' ')
  end
end

game = Command.new
game.run