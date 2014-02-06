/* Description:
 *   Suggesting solid gold, business appropriate business names since 2013. Using Clive Murray's excellent
 *   http://codenames.clivemurray.com/
 *
 * Dependencies:
 *   "pacta": "0.0.1"
 *
 * Configuration:
 *   None
 *
 * Commands:
 *   hubot suggest a name - Receive a project name
 *
 * Author:
 *   mudge
 */
var Promise = require('pacta').Promise;

module.exports = function (robot) {
  var getJSON = function (url) {
    var promise = new Promise();
    robot.http(url).get()(function (err, res, body) {
      promise.resolve(JSON.parse(body));
    });

    return promise;
  };

  var titleCase = function (word) {
    return word[0].toUpperCase() + word.slice(1).toLowerCase();
  };

  var allPrefixes = getJSON('http://codenames.clivemurray.com/data/prefixes.json'),
      allAnimals  = getJSON('http://codenames.clivemurray.com/data/animals.json');

  robot.respond(/suggest a( project)? name/i, function (msg) {
    allPrefixes.concat(allAnimals).map(function (prefixes, animals) {
      var prefix = msg.random(prefixes).title,
          animal = msg.random(animals).title;

      msg.reply('How about ' + titleCase(prefix) + titleCase(animal) + '?');
    });
  });
};

