# Description:
#   Eh! Eh! Alright! Alright! Calm down! Calm down!
#
# Commands:
#   None
#

module.exports = (robot) ->

  responses = [
    "Eh! Eh! Alright! Alright! Calm down! Calm down!"
    "Calm down!",
    "Next time you should close your eyes and count to ten",
    "Take a deep breath and relax...",
    "Let it out, let it all out",
    "Don't bottle it up now...",
    "We're all friends here, calm down",
    "Think happy thoughts"
  ]

  robot.hear /shit|crap|rubbish|awful|terrible|fucking|fuck|muppet|bloody|!!+/i, (msg) ->
    msg.send msg.random responses

