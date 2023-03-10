module Discord
  module Listener
    module BotCommand
      # handle changeme command event
      class ChangeMe
        require File.join(File.dirname(__FILE__), '../../../../db/', 'db_setup.rb')
        require File.join(File.dirname(__FILE__), '../../../../models/', 'users.rb')
        def initialize(event, user, phone_number)
          @event = event
          @user = user
          @phone_number = phone_number
        end

        def perform
          current_user.update(phone_number: @phone_number)
        end

        private

        def current_user
          User.find_by(discord_id: @user.id)
        end
      end
    end
  end
end
