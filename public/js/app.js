window.current_location = 0;
window.current_building = null;
window.inventory = [];
window.quit = false;
window.west_min = 0;
window.east_max = 5;
window.current_quest = 0;

function scroll(){
  $("html, body").animate({ scrollTop: $("body").height() }, 0);
}

function puts(str) {
  var placeholder = 'game';
  $("div[data-placeholder=" + placeholder + "]").append($("<p>").append(str));
  scroll();
}

function describe_quest() {
  puts("");
  puts("**********************");
  puts("* YOUR CURRENT QUEST *");
  puts("**********************");
  puts(quests[current_quest]['description']);
  puts("'please just bring me one of the following', Feld says.")
  $.each(quests[current_quest]['item'], function (i, item) {
    puts("- " + item);
  });
}

function enter_building(building) {
  if (get_local_buildings().indexOf(building) > -1) {
    puts("Entering " + building);
    window.current_building = building;
    describe_location()
  } else {
    puts("I don't see that... type 'look' to see what is there");
  }
}

function finish_quest() {
  puts("!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
  puts("Nice Job! You won!");
  puts("");
  puts("Now go fuck yourself");
  puts("");
  puts("!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
  window.quit = true;
}

function parse_command(command) {
  return command.split(' ');
}

function describe_location() {
  puts("-----------------");
  if (!window.current_building) {
    var current_description = $.grep(window.locations, function (location) {
      return location['location'] == window.current_location;
    });
    puts(current_description[0]['name']);
    puts(current_description[0]['description']);
    puts("----------------");
    var local_buildings = get_local_buildings();
    puts("You see the following buildings");
    puts(local_buildings.join(', '));
  } else {
    // describe location
    puts("you are in " + window.current_building);
    puts(window.buildings[window.current_location][window.current_building]['description']);
    puts("you see the following items");
    $.each(window.items[window.current_building], function (i, item) {
      puts("- " + item);
    });
  }
  puts("-----------------");
  puts("");
}

function list_inventory() {
  puts("You have the following items:");
  puts(window.inventory.join(', '));
  puts("-----------------");
}

function check_quest(item) {
  puts("Why Thank You!");
  if (window.quests[window.current_quest]['item'].indexOf(item) > -1) {
    puts("!!!!!!!!!!!!!!!!!!!!");
    puts("!!! AWESOME SAUCE !!");
    puts("!!!!!!!!!!!!!!!!!!!!");
    window.current_quest++;
    if (window.current_quest == 5) {
      finish_quest();
    } else {
      describe_quest();
    }

  } else {
    puts("thanks, but this is not going to help you get out of Boulder!");
  }
}


function give_item(item) {
  if (window.current_building || window.current_location != 0) {
    puts("The only person you can give items to is on 9th and Pearl");
  } else if (window.inventory.indexOf(item) == -1) {
    puts("You don't have that to give.");
  } else {
    var the_index = window.inventory.indexOf(item);
    window.inventory.splice(the_index, 1);
    check_quest(item);
  }
}

function take_item(item) {
  if (!window.current_building) {
    puts("there are no item outside to take");
  } else {
    if (window.items[window.current_building].indexOf(item) > -1) {
      window.inventory.push(item);
      var the_index = window.items[window.current_building].indexOf(item);
      window.items[window.current_building].splice(the_index, 1);
      list_inventory();
    } else {
      puts("I don't see that here...");
    }
  }
}

function describe_quest_brief() {
  puts("????????????????????????????");
  puts("Do you have anything for me?");
}

function get_local_buildings() {
  var building_array = [];
  $.each(window.buildings[window.current_location], function (key, value) {
    building_array.push(key);
  });
  return building_array;
}

function doCommand(command) {
  parsed_command = parse_command(command);
  switch (parsed_command[0]) {
    case "east":
      if (!window.current_building) {
        if (window.current_location == window.east_max) {
          puts("Trying to leave Boulder already?");
        } else {
          window.current_location++;
          puts("going east");
          describe_location()
        }
      } else {
        puts("you are in a building... try exiting first");
      }
      break;

    case "west":
      if (!window.current_building) {
        if (window.current_location == window.west_min) {
          puts("Trying to leave Boulder already?");
        } else {
          window.current_location--;
          puts("going west");
          describe_location();
          if (window.current_location == 0) {
            describe_quest_brief()
          }
        }
      } else {
        puts("you are in a building... try exiting first");
      }
      break;

    case "d":
      if (!window.current_building) {
        if (window.current_location == window.east_max) {
          puts("Trying to leave Boulder already?");
        } else {
          window.current_location++;
          puts("going east");
          describe_location()
        }
      } else {
        puts("you are in a building... try exiting first");
      }
      break;

    case "a":
      if (!window.current_building) {
        if (window.current_location == window.west_min) {
          puts("Trying to leave Boulder already?");
        } else {
          window.current_location--;
          puts("going west");
          describe_location();
          if (window.current_location == 0) {
            describe_quest_brief();
          }
        }
      } else {
        puts("you are in a building... try exiting first");
      }
      break;

    case "take":
      parsed_command.shift();
      take_item(parsed_command.join(' '));
      break;

    case "give":
      parsed_command.shift();
      give_item(parsed_command.join(' '));
      break;

    case "enter":
      parsed_command.shift();
      enter_building(parsed_command.join(' '));
      break;

    case "exit":
      if (!window.current_building) {
        puts("You are not in a building... ");
      } else {
        window.current_building = null;
        describe_location();
      }
      break;

    case "quit":
      puts("Taking the easy way out huh?");
      window.quit = true;
      break;

    case "look":
      describe_location();
      break;

    case "inventory":
      list_inventory();
      break;

    case "map":
      $.get("/map/" + window.current_location, function (art) {
        var $placeholder = $("div[data-placeholder=game]");
        $placeholder.append($("<p>").append($("<pre>").append(art)));
        $placeholder.append($("<p>&nbsp;</p>"));
        $placeholder.append($("<p>&nbsp;</p>"));
        scroll();
      });
      break;

    case "quest":
      describe_quest();
      break;

    case "help":
      puts("You have the following commands");
      puts("help, east, west, map, look, enter [building], exit, take [item], give [item], quest, inventory, quit");
      break;

    default:
      puts("3 hours of programming doesn't leave much room for other commands");

  }
}

$(document).on("submit", "form", function (e) {
  e.stopPropagation();
  e.preventDefault();
  var $input = $("input[data-id=input]");
  var command = $input.val();
  $input.val("");
  CommandHistory.store(command);
  doCommand(command);
  return false;
});

$(function () {
  setTimeout(
    function () {
      $("div[data-placeholder=intro]").show();
      setTimeout(
        function () {
          $("p[data-id=story]").show();
          describe_quest();
        },
        300
      );
    },
    300);
});