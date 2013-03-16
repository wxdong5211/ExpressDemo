square = (x) -> x * x
cube   = (x) -> square(x) * x
fill = (container, liquid = "coffee") ->
  "Filling the #{container} with #{liquid}..."
song = ["do", "re", "mi", "fa", "so"]
singers = {Jagger: "Rock", Elvis: "Roll"}
bitlist = [
  1, 0, 1
  0, 0, 1
  1, 1, 0
]
kids =
  brother:
    name: "Max"
    age:  11
  sister:
    name: "Ida"
    age:  9
$('.account').attr class: 'active'
log object.class
outer = 1
changeNumbers = ->
  inner = -1
  outer = 10
inner = changeNumbers()
mood = greatlyImproved if singing
if happy and knowsIt
  clapsHands()
  chaChaCha()
else
  showIt()
date = if friday then sue else jill
gold = silver = rest = "unknown"
awardMedals = (first, second, others...) ->
  gold   = first
  silver = second
  rest   = others
contenders = [
  "Michael Phelps"
  "Liu Xiang"
  "Yao Ming"
  "Allyson Felix"
  "Shawn Johnson"
  "Roman Sebrle"
  "Guo Jingjing"
  "Tyson Gay"
  "Asafa Powell"
  "Usain Bolt"
]
awardMedals contenders...
alert "Gold: " + gold
alert "Silver: " + silver
alert "The Field: " + rest
eat food for food in ['toast', 'cheese', 'wine']
courses = ['greens', 'caviar', 'truffles', 'roast', 'cake']
menu i + 1, dish for dish, i in courses
foods = ['broccoli', 'spinach', 'chocolate']
eat food for food in foods when food isnt 'chocolate'
countdown = (num for num in [10..1])
yearsOld = max: 10, ida: 9, tim: 11
ages = for child, age of yearsOld
  "#{child} is #{age}"
if this.studyingEconomics
  buy()  while supply > demand
  sell() until supply > demand
num = 6
lyrics = while num -= 1
  "#{num} little monkeys, jumping on the bed.
    One fell out and bumped his head."
for filename in list
  do (filename) ->
    fs.readFile filename, (err, contents) ->
      compile filename, contents.toString()
numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]
start   = numbers[0..2]
middle  = numbers[3...6]
end     = numbers[6..]
#copy    = numbers[..]
numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
numbers[3..6] = [-3, -4, -5, -6]
grade = (student) ->
  if student.excellentWork
    "A+"
  else if student.okayStuff
    if student.triedHard then "B" else "B-"
  else
    "C"
eldest = if 24 > 21 then "Liz" else "Ike"
six = (one = 1) + (two = 2) + (three = 3)
globals = (name for name of window)[0...10]
alert(
  try
    nonexistent / undefined
  catch error
    "And the error is ... #{error}"
)
launch() if ignition is on
volume = 10 if band isnt SpinalTap
letTheWildRumpusBegin() unless answer is no
if car.speed < limit then accelerate()
winner = yes if pick in [47, 92, 13]
print inspect "My name is #{@name}"
solipsism = true if mind? and not world?
speed = 0
speed ?= 15
footprints = yeti ? "bear"
zip = lottery.drawWinner?().address?.zipcode
class Animal
  constructor: (@name) ->
  move: (meters) ->
    alert @name + " moved #{meters}m."
  @ss:(x)->x*x
class Snake extends Animal
  move: ->
    alert "Slithering..."
    super 5
class Horse extends Animal
  move: ->
    alert "Galloping..."
    super 45
sam = new Snake "Sammy the Python"
tom = new Horse "Tommy the Palomino"
sam.move()
tom.move()
theBait   = 1000
theSwitch = 0
[theBait, theSwitch] = [theSwitch, theBait]
weatherReport = (location) ->
  # Make an Ajax request to fetch the weather...
  [location, 72, "Mostly Sunny"]
[city, temp, forecast] = weatherReport "Berkeley, CA"
futurists =
  sculptor: "Umberto Boccioni"
  painter:  "Vladimir Burliuk"
  poet:
    name:   "F.T. Marinetti"
    address: [
      "Via Roma 42R"
      "Bellagio, Italy 22021"
    ]
{poet: {name, address: [street, city]}} = futurists
tag = "<impossible>"
[open, contents..., close] = tag.split("")
Account = (customer, cart) ->
  @customer = customer
  @cart = cart
  $('.shopping_cart').bind 'click', (event) =>
    @customer.purchase @cart
hi = `function() {
  return [document.title, "Hello JavaScript"].join(": ");
}`
switch day
  when "Mon" then go work
  when "Tue" then go relax
  when "Thu" then go iceFishing
  when "Fri", "Sat"
    if day is bingoDay
      go bingo
      go dancing
  when "Sun" then go church
  else go work
try
  allHellBreaksLoose()
  catsAndDogsLivingTogether()
catch error
  print error
finally
  cleanUp()
cholesterol = 127
healthy = 200 > cholesterol > 60
author = "Wittgenstein"
quote  = "A picture is a fact. -- #{ author }"
sentence = "#{ 22 / 7 } is a decent approximation of π"
mobyDick = "Call me Ishmael. Some years ago --
 never mind how long precisely -- having little
 or no money in my purse, and nothing particular
 to interest me on shore, I thought I would sail
 about a little and see the watery part of the
 world..."
html = """
       <strong>
       cup of coffeescript
       </strong>
       """
###
CoffeeScript Compiler v1.4.0
Released under the MIT License
###
OPERATOR = /// ^ (
  ?: [-=]>             # function
   | [-+*/%<>&|^!?=]=  # compound assign / compare
   | >>>=?             # zero-fill right shift
   | ([-+:])\1         # doubles
   | ([&|<>])\2=?      # logic / shift
   | \?\.              # soak access
   | \.{2,3}           # range or splat
) ///
fs = require 'fs'
option '-o', '--output [DIR]', 'directory for compiled code'
task 'build:parser', 'rebuild the Jison parser', (options) ->
  require 'jison'
#  code = require('./lib/grammar').parser.generate()
  dir  = options.output or 'lib'
  fs.writeFile "#{dir}/parser.js", code