# Description:
#   Delivers a recent devop reaction from devopsreactions.tumblr.com. Uses an API key but does not require full authentication. If you've requested 20 devops reactions then it goes back to the most recent one again.
#
# Commands:
#   Hubot devop me - get a devop reaction
#
# Author:
#   hollsk

module.exports = (robot) ->

  robot.brain.on 'loaded', =>
    robot.brain.data.devop_counter || = 0

  robot.respond /devop me/i, (msg) ->
    msg.http("http://api.tumblr.com/v2/blog/devopsreactions.tumblr.com/posts/?api_key=QnPKLySe5CRuDzp89qYw0XtXVboNo77fHTUituK3vZUKfCUQkY")
      .get() (err, res, body) ->
        result = JSON.parse(body)

        if result.response.posts <= 0
          msg.send "No reactions to display."
          return

        urls = [ ]

        for child in result.response.posts
          if child.title.length > 0 && child.body.length > 0

            # tumblr gives you HTML instead of just an image if it's a text post, so let's split it up 
            bodySrcBits = child.body.split '"'

            # ... then we can look for a gif to add to our message object
            for arrayPiece in bodySrcBits
              imageSrcIndex = arrayPiece.indexOf ".gif", 0
              if imageSrcIndex > 0
                urls.push({name: child.title, image: arrayPiece}) 

        # RESET! RESET!
        if result.response.posts.length == robot.brain.data.devop_counter
          robot.brain.data.devop_counter = 0

        if urls[robot.brain.data.devop_counter].name.length > 0

          # it'd be nice to send this as HTML but Campfire doesn't like that, so.
          msg.send "#{urls[robot.brain.data.devop_counter].image}"
          msg.send "#{urls[robot.brain.data.devop_counter].name}: "
          # fedbot will also send these in reverse order, so the name goes last so that it goes first
          # <myheadisfulloffuck.jpg>

          robot.brain.data.devop_counter += 1
          return

        # go back to the start
        msg.send urls[0].name
        robot.brain.data.devop_counter = 1
