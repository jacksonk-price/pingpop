require '../config/initializers/initializer'
require 'discordrb'
require 'bot'

def start
  Bot.new.run
end

start
