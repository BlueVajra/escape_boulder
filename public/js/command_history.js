var CommandHistory = {
  commands: [],

  currentIndex: -1,

  store: function (command) {
    if (this.commands[this.commands.length -1] != command) {
      this.commands.push(command);
    }
    this.reset();
  },

  previous: function () {
    if(this.currentIndex < this.commands.length - 1) {
      this.currentIndex++;
    }
    return this.commands.slice().reverse()[this.currentIndex];
  },

  next: function () {
    if(this.currentIndex > -1) {
      this.currentIndex--;
    }
    return this.commands.slice().reverse()[this.currentIndex];
  },

  reset: function () {
    this.currentIndex = -1;
  }
};

$(document).on("keydown", "input[data-id=input]", function (e) {
  var UP_ARROW = 38;
  var DOWN_ARROW = 40;
  if (e.which == UP_ARROW) {
    e.preventDefault();
    $(e.target).val(CommandHistory.previous());
  } else if (e.which == DOWN_ARROW) {
    e.preventDefault();
    $(e.target).val(CommandHistory.next());
  }
});
