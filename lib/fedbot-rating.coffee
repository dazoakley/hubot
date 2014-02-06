
module.exports = (robot) ->

  getUser = (msg) ->
    user = robot.brain.userForId msg.message.user.id
    if typeof user.fedbotRating != 'number'
      user.fedbotRating = 0
    user

  get = (msg) ->
    getUser(msg).fedbotRating

  label = (msg) ->
    rating = getUser(msg).fedbotRating
    if rating <= -8
      "hate"
    else if rating >= 8
      "love"
    else if rating < 0
      "dislike"
    else if rating >= 0
      "like"

  decrease = (msg, amount = 1) ->
    getUser(msg).fedbotRating -= amount

  increase = (msg, amount = 1) ->
    getUser(msg).fedbotRating += amount

  {get, label, decrease, increase}
