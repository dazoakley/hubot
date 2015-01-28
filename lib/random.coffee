
randomBetween = (min, max) ->
  Math.floor(Math.random() * (max - min + 1)) + min

randomValue = (arr) ->
  arr[randomBetween(0, arr.length - 1)]

module.exports = {
  randomBetween
  randomValue
}
