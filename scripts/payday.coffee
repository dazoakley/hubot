# Description:
#  Tells you how many days until payday.
#
# Commands:
#   hubot how many days until payday? - Tells you how many days until payday.
#
# URLS:
#   /hubot/payday
#
# Notes:
#   These commands are grabbed from comment blocks at the top of each file.

paydays = {
  1:"2013/01/31",
  2:"2013/02/28",
  3:"2013/03/28",
  4:"2013/04/30",
  5:"2013/05/31",
  6:"2013/06/28",
  7:"2013/07/31",
  8:"2013/08/30",
  9:"2013/09/30",
  10:"2013/10/31",
  11:"2013/11/29",
  12:"2013/12/20"
}

workingDaysUntil = (startDate, endDate) ->
  if endDate < startDate
    return 0
  millisecondsPerDay = 86400 * 1000
  startDate.setHours(0,0,0,1)
  endDate.setHours(23,59,59,999)
  diff = endDate - startDate
  days = Math.ceil(diff / millisecondsPerDay)

  weeks = Math.floor(days / 7)
  days = days - (weeks * 2)

  startDay = startDate.getDay()
  endDay = endDate.getDay()

  if startDay - endDay > 1
      days = days - 2

  if startDay == 0 && endDay != 6
      days = days - 1

  if endDay == 6 && startDay != 0
      days = days - 1

  current_hour = new Date().getHours()
  if current_hour >= 12
    days = days - 1

  return days

module.exports = (robot) ->
  robot.respond /days until payday/i, (msg) ->
    todays_date = new Date()
    month = todays_date.getMonth() + 1
    payday = new Date(paydays[month] + "Z")
    time_until = (payday - todays_date)
    days_until = Math.round(time_until / (1000*60*60*24))
    msg_str = days_until + " days until payday"
    if days_until == 0
      msg_str = "SPEND ALL YOUR MONIES! (it's payday today)"
    msg.send msg_str

