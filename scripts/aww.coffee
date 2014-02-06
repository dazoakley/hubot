# Description:
#   Hubot delivers a pic from Reddit's /r/aww_gifs frontpage
#
# Commands:
#   aww - Display a GIF from /r/aww_gifs
#
# Author:
#   rowanmanning (modified eliperkins script)

module.exports = (robot) ->
  robot.respond /aww/i, (msg) ->
    search = escape(msg.match[1])
    msg.http('http://www.reddit.com/r/aww_gifs.json')
      .get() (err, res, body) ->
        result = JSON.parse(body)

        if result.data.children.count <= 0
          msg.send "Couldn't find anything cute..."
          return

        urls = [ ]
        for child in result.data.children
          if /\.(gif|jpeg|jpg|png)$/.test child.data.url
            urls.push(child.data.url)

        rnd = Math.floor(Math.random()*urls.length)
        msg.send urls[rnd]
