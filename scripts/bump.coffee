# Description:
#   Bump a PR
#
# Commands:
#   hubot bump me <pr> - Bump a pull request
#

randomValue = require('../lib/random').randomValue

module.exports = (robot) ->

  robot.respond /bump me (.+)$/i, (msg) ->
    pr = msg.match[1]
    emoji1 = randomEmoji()
    emoji2 = randomEmoji()
    output = "#{emoji2} #{emoji1} BUMP #{pr} BUMP #{emoji2} #{emoji1}"
    emojiLine = ''
    for num in [0..9]
      emojiLine += "#{emoji1} #{emoji2} "
    msg.send emojiLine, output, emojiLine

  emoji = [
    '+1'
    'balloon'
    'beer'
    'blue_heart'
    'bomb'
    'boom'
    'bulb'
    'cake'
    'cherry_blossom'
    'collision'
    'cyclone'
    'exclamation'
    'fire'
    'four_leaf_clover'
    'gem'
    'gift'
    'kiss'
    'love_letter'
    'octocat'
    'ok_hand'
    'poop'
    'skull'
    'sparkles'
    'sparkling_heart'
    'star'
    'star2'
    'sunny'
    'trophy'
    'warning'
    'yellow_heart'
    'zap'
  ]

  randomEmoji = ->
    ":#{randomValue(emoji)}:"
