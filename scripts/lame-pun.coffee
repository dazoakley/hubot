# Description:
#   Delivers a pic from Reddit's /r/AdviceAnimals search
#
# Commands:
#   pun - Display a lame pun raccoon from /r/AdviceAnimals
#
# Author:
#   hollsk (modified eliperkins script)

module.exports = (robot) ->

  robot.hear /\b(pun)\b/i, (msg) ->
    search = escape(msg.match[1])
    msg.http('http://www.reddit.com/r/AdviceAnimals/search.json?q=lame+pun+raccoon&sort=new&restrict_sr=on&t=all&limit=50')
      .get() (err, res, body) ->
        result = JSON.parse(body)

        if result.data.children.count <= 0
          msg.send "No terrible puns found..."
          return

        urls = [ ]
        for child in result.data.children
          if /\.(gif|jpeg|jpg|png)$/.test child.data.url
            if child.data.ups > child.data.downs
              urls.push(child.data.url)

        rnd = Math.floor(Math.random()*urls.length)
        msg.send urls[rnd]