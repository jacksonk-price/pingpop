class Bot
  require_relative '../twilio_client'
  require 'addme'
  require 'removeme'
  require 'changeme'
  require 'validation'
  require 'utils'
  require 'join'
  require 'leave'
  require 'json'

  include Discord::Listener::BotCommand::Validation
  include Discord::Listener::VoiceStateUpdate::Utils

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
    set_removeme_listener
    set_changeme_listener
  end

  def set_ready_listener
    @bot.ready do |event|
      puts "Logged in as #{@bot.profile.username} (ID:#{@bot.profile.id}) | #{@bot.servers.size} servers"
    end
  end

  def set_voice_update_listener
    @bot.voice_state_update do |event|
      if voice_join?(event)
        Discord::Listener::VoiceStateUpdate::Join.new(event).perform
      elsif voice_leave?(event) && no_users?(event)
        Discord::Listener::VoiceStateUpdate::Leave.new(event).perform
      end
    end
  end

  def set_addme_listener
    @bot.command(:addme) do |event|
      command_content = event.message.content.split(' ')[1].to_s
      return event.respond("#{event.user.mention} Your command does not contain a valid phone number. Please put it in this format 'xxxxxxxxxx'") unless valid_phone_number?(command_content)

      if new_user?(event.user)
        if Discord::Listener::BotCommand::AddMe.new(event, event.user, command_content).perform
          event.respond("#{event.user.mention} You have been added to the messaging list.")
        end
      else
        event.respond("#{event.user.mention} You are already active on the messaging list. Please use the '!changeme xxxxxxxxxx' command if you would like to update your number.")
      end
    end
  end

  def set_removeme_listener
    @bot.command(:removeme) do |event|
      if new_user?(event.user)
        event.respond("#{event.user.mention} You are not currently added to the messaging list, so you cannot be removed.")
      elsif Discord::Listener::BotCommand::RemoveMe.new(event, event.user).perform
        event.respond("#{event.user.mention} You have been succesfully removed from the messaging list.")
      end
    end
  end

  def set_changeme_listener
    @bot.command(:changeme) do |event|
      command_content = event.message.content.split(' ')[1].to_s
      return event.respond("#{event.user.mention} Your command does not contain a valid phone number. Please put it in this format 'xxxxxxxxxx'") unless valid_phone_number?(command_content)

      if new_user?(event.user)
        event.respond("#{event.user.mention} You are not currently added to the messaging list, so your phone number cannot be changed.")
      elsif Discord::Listener::BotCommand::ChangeMe.new(event, event.user, command_content)
        event.respond("#{event.user.mention} Your number has been updated.")
      end
    end
  end
end

