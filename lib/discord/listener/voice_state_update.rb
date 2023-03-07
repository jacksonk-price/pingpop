module Discord
  module Listener
    # handle voice state update event
    class VoiceStateUpdate

      require '../lib/twilio_client'

      def initialize(event)
        @event = event
      end

      def perform
        TwilioClient.send_messages(message)
      end

      private

      def users
        if voice_join?
          @event.channel.users.map(&:username)
        elsif voice_leave?
          @event.old_channel.users.map(&:username)
        end
      end

      def message
        text_message = if voice_join?
                         "#{@event.user.username} \u{2705} joined the voice channel #{@event.channel.name}.\nThere are #{users.count} people in this channel. \n"
                       elsif voice_leave?
                         "#{@event.user.username} \u{274C} left the voice channel #{@event.old_channel.name}.\nThere are #{users.count} people in this channel. \n"
                       end
        users.each do |user|
          text_message += "\u{2705} #{user}\n"
        end
        text_message
      end

      def voice_join?
        @event.old_channel.nil? && !@event.channel.nil?
      end

      def voice_leave?
        !@event.old_channel.nil? && @event.channel.nil?
      end
    end
  end
end
