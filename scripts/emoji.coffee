# Description:
#   Get a random emoji
#
# Commands:
#   hubot emoji me - Get a random emoji
#   hubot emoji bomb N - Get N random emoji
#   hubot all the emoji - Get all the emoji
#

_ = require 'underscore'
emoji = require('../data/emoji.json')
randomValue = require('../lib/random').randomValue

module.exports = (robot) ->

  getRandomEmoji = ->
    ":#{randomValue emoji}:"

  robot.respond /emoji me\b/i, (msg) ->
    msg.send getRandomEmoji()

  robot.respond /emoji bomb( (\d+))?/i, (msg) ->
    count = msg.match[2] || 5
    bomb = _.sample emoji, count
    msg.send (":#{em}:" for em in bomb).join(' ')

  robot.respond /all the emoji\b/i, (msg) ->
    msg.send (":#{e}:" for e in emoji).join(' ')
