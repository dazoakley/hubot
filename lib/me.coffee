
_ = require 'underscore'

module.exports = (robot, name, images) ->

  meRegExp = new RegExp "#{name} me", 'i'
  bombRegExp = new RegExp "#{name} bomb( (\\d+))?", 'i'

  robot.respond meRegExp, (msg) ->
    msg.send msg.random images

  robot.respond bombRegExp, (msg) ->
    count = msg.match[2] || 5
    bomb = _.sample images, count
    msg.send image for image in bomb
