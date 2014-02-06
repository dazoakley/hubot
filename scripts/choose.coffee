# Description:
#   Make a choice
#
# Commands:
#   hubot choose <options> - make a choice
#

module.exports = (robot) ->

  formats = [
    "I think \"%\" is the best choice",
    "I've decided on \"%\"",
    "Definitely \"%\"",
    "\"%\" would be best",
    "After much deliberation, \"%\"",
    "I reckon \"%\"",
    "I choose \"%\""
  ]

  robot.respond /(choose|pick) (.+)/i, (msg) ->
    options = msg.match[2].split(/\s*[,;]\s*|\sor\s/i)
    choice = msg.random options
    format = msg.random formats
    msg.send format.replace "%", choice

