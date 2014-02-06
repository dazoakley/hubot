# Description:
#   Respond to thank you
#
# Commands:
#   hubot do you like me? - Check whether hubot likes you
#   hubot do you like <name>? - Check whether hubot likes a person
#   hubot who is your favourite? - See who hubot likes best
#   hubot who is your least favourite? - See who hubot likes least
#   hubot sort us in order of preference - List users from most to least favourite
#

_ = require 'underscore'

module.exports = (robot) ->

  rating = require('../lib/fedbot-rating')(robot)

  meResponses = {

    love: [
      "Of course!",
      "*blush*",
      "I think you're wonderful",
      "You're one of my favourites",
      "You're lovely",
      "Most definitely!",
      "Like is an understatement",
      "Do you even need to ask?"
    ],

    like: [
      "Yeah, you're alright",
      "Yes",
      "Yeah",
      "Yep",
      "You're OK",
      "You're alright for a human",
      "You're one of the better ones"
    ],

    dislike: [
      "Not really",
      "No",
      "Nope",
      "Sorry, but no",
      "You're not my type",
      "Not so much",
      "Let me think... No"
    ],

    hate: [
      "HAHAHAHAHAHAHA",
      "Yes I think you're... NO WAY!",
      "No way",
      "Hell will freeze over before I like you",
      "Never in a million years",
      "There's nothing you could do to make me like you",
      "Get bent.",
      "Piss off.",
      "Who could possibly like you?",
      "Do I *look* like I'm malfunctioning?"
    ]

  }

  otherResponses = {

    love: [
      "Of course!",
      "*blush*",
      "I think they're wonderful",
      "They're one of my favourites",
      "They're lovely",
      "Most definitely!",
      "Like is an understatement",
      "Do you even need to ask?"
    ],

    like: [
      "Yeah, they're alright",
      "Yes",
      "Yeah",
      "Yep",
      "They're OK",
      "They're alright for a human",
      "They're one of the better ones"
    ],

    dislike: [
      "Not really",
      "No",
      "Nope",
      "Sorry, but no",
      "They're not my type",
      "Not so much",
      "Let me think... No"
    ],

    hate: [
      "HAHAHAHAHAHAHA",
      "Yes I think they're... NO WAY!",
      "No way",
      "Hell will freeze over before I like them",
      "Never in a million years",
      "There's nothing they could do to make me like you",
      "Who could possibly like them?",
      "Do I *look* like I'm malfunctioning?"
    ]

  }

  robot.respond /(do )?you like ([a-z0-9\s\-]+)\??/i, (msg) ->
    name = msg.match[2]
    if name == 'me'
      label = rating.label msg
      msg.reply msg.random meResponses[label]
    else
      users = robot.brain.usersForFuzzyName name
      if users.length == 0
        msg.reply "I don't know who #{name} is"
      else if users.length > 1
        msg.reply "I'm not sure who you mean, one of these? " + users.map((user) -> user.name).join(', ')
      else
        label = rating.label {message:{user:{id: users[0].id}}}
        msg.reply msg.random otherResponses[label]

  robot.respond /who('?s| is) your favou?rite\??/i, (msg) ->

    users = _.values robot.brain.users()
    users = (user for user in users when typeof user.fedbotRating == "number")
    users = _.sortBy(users, 'fedbotRating').reverse()
    users = (user.name for user in users when user.fedbotRating == users[0].fedbotRating)

    if users.length > 1
      msg.send "It's a tie between " + users.join(", ")
    else
      msg.send "My favourite is " + users[0]

  robot.respond /who('?s| is) your least favou?rite\??/i, (msg) ->

    users = _.values robot.brain.users()
    users = (user for user in users when typeof user.fedbotRating == "number")
    users = _.sortBy(users, 'fedbotRating')
    users = (user.name for user in users when user.fedbotRating == users[0].fedbotRating)

    if users.length > 1
      msg.send "It's a tie between " + users.join(", ")
    else
      msg.send "My least favourite is " + users[0]

  robot.respond /sort us in order of preference/i, (msg) ->
    users = _.values robot.brain.users()
    users = (user for user in users when typeof user.fedbotRating == "number")
    users = _.sortBy(users, 'fedbotRating').reverse()
    users = (user.name for user in users when user.name isnt "FEDbot")
    msg.send users.join "\n"
