module Discord
  module Listener
    module VoiceStateUpdate
      # handle voice state update join event
      class Join

        def initialize(event)
          @event = event
        end

        def perform
          TwilioClient.send_messages(message)
        end

        private

        def users
          @event.channel.users.map(&:username)
        end

        def message
          emoji = "\u{1F91D}"
          connected_emoji = "\u{1F7E2}"
          channel = @event.channel.name
          user_count = "There are #{users.count} people in this channel.\n"

          text_message = "#{@event.user.username} #{emoji} joined the voice channel #{channel}.\n\n#{user_count}"
          text_message += users.map { |user| "#{connected_emoji} #{user}\n" }.join('')
        end
      end
    end
  end
end
