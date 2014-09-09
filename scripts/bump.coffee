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
    output = "#{emoji1} #{emoji2} BUMP #{pr} BUMP #{emoji2} #{emoji1}"
    emojiLine = ''
    for num in [0..9]
      emojiLine += "#{emoji1} #{emoji2} "
    msg.send emojiLine, output, emojiLine

  emoji = [
    'star'
    'boom'
    'exclamation'
    'collision'
    'star2'
    'sparkles'
    'sparkling_heart'
    'fire'
    'yellow_heart'
  ]

  randomEmoji = ->
    ":#{randomValue(emoji)}:"
