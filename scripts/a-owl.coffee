# Description:
#   A Owl
#   A Owl?
#   A Owl
#
# Commands:
#   None
#

module.exports = (robot) ->

  robot.hear /a owl/i, (msg) ->
    if /a owl\?/i.test(msg.message.text)
      msg.send "a owl"
    else
      msg.send "a owl?"

  robot.hear /a hour/i, (msg) ->
    if /a hour\?/i.test(msg.message.text)
      msg.send "a hour"
    else
      msg.send "a hour?"
