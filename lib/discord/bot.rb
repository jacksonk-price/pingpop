class Bot
  require 'twilio-ruby'
  require '../lib/discord/listener/voice_state_update'
  require '../lib/discord/listener/bot_command/addme'
  require 'json'

  DATA = JSON.parse(File.read('../config/discord_config.json'))
  def initialize
    @bot = Discordrb::Commands::CommandBot.new(
      token: DATA['pingpop_token'],
      prefix: '!'
    )
    set_listeners
  end

  def run
    @bot.run
  end

  private

  def set_listeners
    set_ready_listener
    set_voice_update_listener
    set_addme_listener
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

  def set_addme_listener
    @bot.command(:addme) do |event|
      Discord::Listener::BotCommand::AddMe.new(event).perform
    end
  end
end

