module.exports = (robot) ->
  apologies = [
    "I'm sorry.",
    "Please forgive me.",
    "It's not my fault!",
    "Whoops.",
    "I did my best!",
    "You can't win them all..."
  ]
  robot.hear /bad hubot/i, (msg) ->
    msg.reply(msg.random(apologies))
  robot.respond /you'?re drunk/i, (msg) ->
    msg.reply("I would never drink on the job!")

