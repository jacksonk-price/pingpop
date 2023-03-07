class Bot
  require 'twilio-ruby'
  require '../lib/discord/listener/voice_state_update.rb'
  require 'json'

  DATA = JSON.parse(File.read('../config/discord_config.json'))
  def initialize
    @bot = Discordrb::Bot.new(token: DATA["pingpop_token"])
    set_listeners
  end

  def run
    @bot.run
  end

  private

  def set_listeners
    set_ready_listener
    set_voice_update_listener
  end

  def set_ready_listener
    @bot.ready do |event|
      puts "Logged in as #{@bot.profile.username} (ID:#{@bot.profile.id}) | #{@bot.servers.size} servers"
    end
  end

  def set_voice_update_listener
    @bot.voice_state_update do |event|
      Discord::Listener::VoiceStateUpdate.new(event).perform
    end
  end
end
