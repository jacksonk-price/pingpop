require 'discordrb'
require '../lib/discord/bot'

def start
  bot = Bot.new
  bot.run
end

start
