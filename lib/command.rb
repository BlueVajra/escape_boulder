# go - east/west
# enter <building>
# exit
# take <object>
# give <object>

class Command
  def initialize
    @current_location = 0
    @current_building = nil
    @inventory = []
    @quit == false
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
            puts "going east"
          when "west"
            puts "going west"
          else
            puts "Which direction is that?"
        end

      when "enter"

      when "exit"

    end

  end

  def parse_command(command)
    command.split(' ')
  end
end

game = Command.new
game.run