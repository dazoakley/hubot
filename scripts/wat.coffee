# Description:
#   Wat
#
# Commands:
#   None
#

module.exports = (robot) ->

  responses = [
    "http://i0.kym-cdn.com/photos/images/newsfeed/000/173/576/Wat8.jpg",
    "http://i0.kym-cdn.com/photos/images/original/000/173/589/RsLid.jpg",
    "http://i2.kym-cdn.com/photos/images/original/000/420/682/42e.jpg",
    "http://i0.kym-cdn.com/photos/images/original/000/250/605/7c6.gif",
    "http://i3.kym-cdn.com/photos/images/original/000/275/923/2f8.gif",
    "http://i0.kym-cdn.com/photos/images/original/000/173/580/Wat.jpg",
    "http://i2.kym-cdn.com/photos/images/original/000/173/583/Waht.jpg",
    "http://i2.kym-cdn.com/photos/images/original/000/195/379/1320452774001.png",
    "http://i1.kym-cdn.com/photos/images/original/000/214/265/1201133266390.jpg",
    "http://i0.kym-cdn.com/photos/images/original/000/173/582/Wat-boxxy.jpg",
    "http://i0.kym-cdn.com/photos/images/original/000/173/575/25810.jpg"
  ]

  robot.hear /\b(wat)\b/i, (msg) ->
    msg.send msg.random responses
