module Discord
  module Listener
    module BotCommand
      # handle addme command event
      class AddMe
        require File.join(File.dirname(__FILE__), '../../../../db/', 'db_setup.rb')
        require File.join(File.dirname(__FILE__), '../../../../models/', 'users.rb')
        def initialize(event, user, phone_number)
          @event = event
          @user = user
          @phone_number = phone_number
        end

        def perform
          User.create(**args)
        end

        private

        def args
          {
            discord_id: @user.id,
            display_name: @user.username,
            phone_number: @phone_number
          }
        end
      end
    end
  end
end
