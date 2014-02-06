# Description:
#   Facepalm
#
# Commands:
#   None
#

module.exports = (robot) ->

  responses = [
    "https://i.chzbgr.com/completestore/12/7/10/jf83SCjk_kKyXehVRZZ8EA2.gif",
    "https://i.chzbgr.com/completestore/12/9/12/fMZy5tmVCkiOPyNd6iObCw2.gif",
    "http://ircz.de/static/pics/2013/04/19_21_30_29/doc11938873_136484953.gif",
    "http://e.asset.soup.io/asset/3147/2254_580c_390.png",
    "http://replygif.net/i/153.gif",
    "http://www.cutecatgifs.com/wp-content/uploads/2013/05/facepalm.gif",
    "http://cdn.gifbay.com/2013/12/cat_facepalm-107822.gif",
    "http://replygif.net/i/639.gif",
    "http://replygif.net/i/792.gif",
    "http://replygif.net/i/661.gif",
    "http://replygif.net/i/586.gif",
    "http://replygif.net/i/837.gif",
    "http://replygif.net/i/1126.gif",
    "http://replygif.net/i/639.gif",
    "http://replygif.net/i/1226.gif",
    "https://i.chzbgr.com/maxW500/8017583104/h7D54A519.gif",
    "http://lolsnaps.com/upload_pic/AlrightinternethereisthePicarddoublefacepalmDoyourthing-93910.gif",
    "http://padrespublic.com/wordpress/wp-content/uploads/2013/04/Mega+Facepalm+Gif.+For+your+reaction+folder+needs_c266b1_3384407.gif",
    "http://likegif.com/wp-content/uploads/2012/10/facepalm-gif-34.gif",
    "http://www.midnightreview.co.uk/wp-content/uploads/2013/07/%D0%B3%D0%B8%D1%84%D0%BA%D0%B8-%D0%A1%D0%B8%D0%BB%D1%8C%D0%B2%D0%B5%D1%81%D1%82%D1%80-%D0%A1%D1%82%D0%B0%D0%BB%D0%BE%D0%BD%D0%B5-%D1%80%D1%83%D0%BA%D0%B0%D0%BB%D0%B8%D1%86%D0%BE-Tango-Cash-324068.gif",
    "http://i.imgur.com/uDNqsKs.gif",
    "http://media2.giphy.com/media/i8tL4unehxmvu/giphy.gif",
    "http://redsarmy.com/wp-content/uploads/2013/01/nicholas.gif",
    "https://puppetlabs.com/sites/default/files/f6due.gif",
    "http://media0.giphy.com/media/10p704gIAGRN7i/giphy.gif"
  ]

  robot.hear /\b(facepalm)\b/i, (msg) ->
    msg.send msg.random responses
