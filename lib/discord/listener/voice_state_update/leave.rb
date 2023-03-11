module Discord
  module Listener
    module VoiceStateUpdate
      # handle voice state update leave event
      class Leave

        def initialize(event)
          @event = event
        end

        def perform
          TwilioClient.send_messages(phone_numbers, message)
        end

        private

        def users
          @event.old_channel.users.map(&:username)
        end

        def phone_numbers
          User.all.map(&:phone_number)
        end

        def message
          emoji = "\u{1F44B}"
          connected_emoji = "\u{1F7E2}"
          channel = @event.old_channel.name
          user_count = "There is no one else in this channel.\n"

          text_message = "#{@event.user.username} #{emoji} left the voice channel #{channel}.\n\n#{user_count}"
        end
      end
    end
  end
end