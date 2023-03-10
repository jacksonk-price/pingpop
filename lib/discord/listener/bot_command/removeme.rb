module Discord
  module Listener
    module BotCommand
      # handle removeme command event
      class RemoveMe
        require File.join(File.dirname(__FILE__), '../../../../db/', 'db_setup.rb')
        require File.join(File.dirname(__FILE__), '../../../../models/', 'users.rb')
        def initialize(event, user)
          @event = event
          @user = user
        end

        def perform
          current_user.destroy
        end

        private

        def current_user
          User.find_by(discord_id: @user.id)
        end
      end
    end
  end
end
