// Description:
//   Because it's f**king hot in here

'use strict';

module.exports = function(robot) {
  robot.respond(/turn on the aircon/i, function (response) {
    response.send('Air conditioning has been set to -12ºC. :snowflake:');
    response.send('Have a nice day.');
  });

  robot.respond(/turn off the aircon/i, function (response) {
    response.send('I\'m afraid I can\'t let you do that, ' + response.message.user.name + '...');
  });
}
