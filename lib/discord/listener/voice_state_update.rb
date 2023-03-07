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
        emoji = voice_join? ? "\u{2705}" : "\u{274C}"
        action = voice_join? ? 'joined' : 'left'
        channel = voice_join? ? @event.channel.name : @event.old_channel.name
        user_count = "There are #{users.count} people in this channel.\n"

        text_message = "#{@event.user.username} #{emoji} #{action} the voice channel #{channel}.\n\n#{user_count}"
        text_message += users.map { |user| "\u{2705} #{user}\n" }.join('')
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
