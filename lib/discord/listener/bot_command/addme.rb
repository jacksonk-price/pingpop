module Discord
  module Listener
    module BotCommand
      # handle addme command event
      class AddMe
        require File.join(File.dirname(__FILE__), '../../../../db/', 'db_setup.rb')
        require File.join(File.dirname(__FILE__), '../../../../models/', 'users.rb')
        def initialize(event)
          @event = event
          @user = event.user
          @message = event.message.content.split(' ')[1].to_s
        end

        def perform
          if already_added?
            @event.respond('You have already been added to the SMS list.')
          elsif User.create(**args)
            @event.respond('You have been added to the SMS list. Thank you.')
          end
        end

        private

        def already_added?
          User.find_by(discord_id: @user.id)
        end

        def args
          {
            discord_id: @user.id,
            display_name: @user.username,
            phone_number: @message
          }
        end
      end
    end
  end
end