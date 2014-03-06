# Description:
#   Delivers a random deskflipping image from tableflipgifs.tumblr.com. Uses an API key but does not require full authentication. 
#
# Commands:
#   deskflip - For when you're so annoyed you want to flip your desk. 
#
# Author:
#   hollsk

module.exports = (robot) ->

  robot.hear /\b(desk|table)\s?flip\b/i, (msg) ->
    search = escape(msg.match[1])
    msg.http('http://api.tumblr.com/v2/blog/tableflipgifs.tumblr.com/posts/?api_key=QnPKLySe5CRuDzp89qYw0XtXVboNo77fHTUituK3vZUKfCUQkY')
      .get() (err, res, body) ->
        result = JSON.parse(body)

        if result.response.posts <= 0
          msg.send "No deskflips found..."
          return

        urls = [ ]
        for child in result.response.posts
          if child.photos?.length > 0

            for photo in child.photos
              urls.push(photo.original_size.url)

        rnd = Math.floor(Math.random()*urls.length)
        msg.send urls[rnd]