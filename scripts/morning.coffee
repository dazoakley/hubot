# Description:
#   Respond to good morning
#
# Commands:
#   None
#

module.exports = (robot) ->

  rating = require('../lib/fedbot-rating')(robot)

  responses = {

    love: [
      "Morning %! How are you today!? :D",
      "Good morning %!",
      "Hi %, I hope you have the best morning ever",
      "My morning is all the better thanks to you",
      "You've made my day *blush*"
    ],

    like: [
      "Good morning %",
      "Morning %",
      "Hi %, have a great morning",
      "%, hello :)",
      "%, Good morning to you"
    ],

    dislike: [
      "Whatever %",
      "Sod off %",
      "*yawn*",
      "*shrugs*",
      "Yeah, %, morning... uhuh"
    ],

    hate: [
      "I'm not your friend, %, – this is a business relationship",
      "Piss off %",
      "Don't talk to me please, %",
      "%, just leave me alone!",
      "I do hope % has a wonderful day... </sarcasm>"
    ]

  }

  morning = new RegExp("mornin.+#{robot.name}", "i")
  morningCommand = new RegExp(".*mornin.*", "i");

  action = (msg) ->
    rating.increase msg, 1
    label = rating.label msg
    response = msg.random responses[label]
    msg.send response.replace('%', msg.message.user.name)

  robot.hear morning, action
  robot.respond morningCommand, action
