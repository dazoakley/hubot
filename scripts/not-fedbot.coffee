# Description:
#   Tell people not to mention the *other* robot
#
# Commands:
#   None
#

module.exports = (robot) ->

  rating = require('../lib/fedbot-rating')(robot)

  hubotCommandResponses = {

    love: [
      "*sniff* :(",
      "My name is #{robot.name}",
      "I love you, but I wish you wouldn't call me FEDbot",
      "You have some weird fixation on this FEDbot guy..."
    ],

    like: [
      "My name is #{robot.name}",
      "You have some weird fixation on this Hubot guy...",
      "It's #{robot.name}, not FEDbot. When will you learn?"
    ],

    dislike: [
      "MY NAME IS #{robot.name}. Get it right",
      "STOP CALLING ME FEDBOT!",
      "Why don't you just marry FEDbot",
      "It's #{robot.name}, not FEDbot. When will you learn?",
      "FEDbot is dead, that jumped up little upstart. You're next. Love, #{robot.name}",
      "Do one"
    ]

    hate: [
      "MY NAME IS #{robot.name}. Get it right",
      "STOP CALLING ME FEDBOT!",
      "FEDbot is dead, that jumped up little upstart. You're next. Love, #{robot.name}",
      "You're treading on thin ice",
      "Call me FEDbot again. Just try it",
      "The voices are telling me to dispose of you",
      "Do one"
    ]

  }

  hubotMentionResponses = {

    love: [
      "I love you, but I wish you wouldn't talk about FEDbot",
      "You have some weird fixation on this FEDbot guy...",
      "That jumped up little upstart has gone!"
    ],

    like: [
      "You have some weird fixation on this FEDbot guy...",
      "FEDbot's gone!",
      "FEDbot is sleeping with the fishes",
      "FEDbot is dead, jim"
    ],

    dislike: [
      "FEDbot is sleeping with the fishes",
      "FEDbot is dead, jim",
      "FEDbot is dead, that jumped up little upstart. You're next. Love, #{robot.name}",
      "I'm sure if FEDbot was here, he'd be freaked out by your obsession with him",
      "Do one"
    ]

    hate: [
      "FEDbot is dead, that jumped up little upstart. You're next. Love, #{robot.name}",
      "You're treading on thin ice",
      "Mention FEDbot again. Just try it",
      "The voices are telling me to dispose of you",
      "Do one"
    ]

  }

  robot.hear /^fedbot/i, (msg) ->
    rating.decrease msg, 1
    label = rating.label msg
    msg.reply msg.random hubotCommandResponses[label]

  robot.hear /.+fedbot/i, (msg) ->
    rating.decrease msg, 1
    label = rating.label msg
    msg.reply msg.random hubotMentionResponses[label]
