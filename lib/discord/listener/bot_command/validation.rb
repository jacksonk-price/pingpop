module Discord
  module Listener
    module BotCommand
      # general validation module for botcommands
      module Validation
        def valid_phone_number?(message)
          phone_regex = /^\+\d{11}$/
          true unless message.match(phone_regex).nil?
        end

        def new_user?(user)
          true unless User.find_by(discord_id: user.id)
        end
      end
    end
  end
end
