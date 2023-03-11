module Discord
  module Listener
    module VoiceStateUpdate
      # handle voice state update join event
      class Join

        def initialize(event)
          @event = event
        end

        def perform
          TwilioClient.send_messages(phone_numbers, message)
        end

        private

        def users
          @event.channel.users
        end

        def user_ids
          users.map(&:id)
        end

        def phone_numbers
          # only want numbers for users not currently in the voice channel
          User.where.not(discord_id: user_ids).map(&:phone_number)
        end

        def message
          emoji = "\u{1F91D}"
          connected_emoji = "\u{1F7E2}"
          channel = @event.channel.name
          user_count = "There are #{users.count} people in this channel.\n"

          text_message = "#{@event.user.username} #{emoji} joined the voice channel #{channel}.\n\n#{user_count}"
          text_message += users.map { |user| "#{connected_emoji} #{user.username}\n" }.join('')
        end
      end
    end
  end
end
2