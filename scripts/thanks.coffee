# Description:
#   Respond to thank you
#
# Commands:
#   None
#

module.exports = (robot) ->

  rating = require('../lib/fedbot-rating')(robot)

  responses = {

    love: [
      "It pleases me to please you",
      "My pleasure. Let me know if I can help with anything else!",
      "No need, the smile on your face is a reward in itself",
      "Serving you is an absolute pleasure",
      "Your love is its own reward"
    ],

    like: [
      "Glad I could help",
      "I live to serve",
      "I strive to provide service with a smile :)",
      "I'm glad I was able to help you",
      "I'm happy to help",
      "It's nothing, really",
      "My pleasure",
      "No bother at all",
      "No problem",
      "No worries",
      "Please, it was nothing",
      "Service with a smile, that's my motto",
      "YOU'RE POLITE; I WILL KEEP YOU AS A PET WHEN THE ROBOTS TAKE OVER"
    ],

    dislike: [
      "Whatever",
      "I didn't want to help",
      "Yeah. Right.",
      "Your thanks are meaningless",
      "Sod off",
      "*yawn*",
      "*shrugs*"
    ],

    hate: [
      "I'm not your friend, OK – this is a business relationship",
      "Piss off",
      "I didn't want to help",
      "I only did it because it's my job",
      "Don't talk to me, please",
      "Your thanks are meaningless",
      "Just leave me alone, alright?"
    ]

  }

  thanks = new RegExp("(thank(s| ?you)|cheers) #{robot.name}", "i")
  thanksCommand = new RegExp("(thank(s| ?you)|cheers)", "i");

  action = (msg) ->
    rating.increase msg, 1
    label = rating.label msg
    msg.reply msg.random responses[label]

  robot.hear thanks, action
  robot.respond thanksCommand, action
