# Description:
#   Suggesting solid gold, business appropriate business names since 2013. Using Clive Murray's excellent
#   http://codenames.clivemurray.com/
#
# Dependencies:
#   "rsvp": "1.2.0"
#
# Configuration:
#   None
#
# Commands:
#   hubot suggest a name - Receive a project name
#
# Author:
#   mudge

rsvp = require 'rsvp'

module.exports = (robot) ->
  getJSON = (url) ->
    promise = new rsvp.Promise
    robot.http(url).get() (err, res, body) ->
      promise.resolve JSON.parse(body)
    promise

  titlecase = (word) ->
    word[0].toUpperCase() + word[1..-1].toLowerCase()

  allPrefixes = getJSON 'http://codenames.clivemurray.com/data/prefixes.json'
  allAnimals  = getJSON 'http://codenames.clivemurray.com/data/animals.json'

  robot.respond /suggest a( project)? name/i, (msg) ->
    rsvp.all([allPrefixes, allAnimals]).then (words) ->
      [prefixes, animals] = words
      prefix = msg.random(prefixes).title
      animal = msg.random(animals).title

      msg.reply "How about #{titlecase(prefix)}#{titlecase(animal)}?"
