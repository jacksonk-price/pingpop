module Discord
  module Listener
    module VoiceStateUpdate
      # general helper methods for voice state update events
      module Utils
        def voice_join?(event)
          event.old_channel.nil? && !event.channel.nil?
        end

        def voice_leave?(event)
          !event.old_channel.nil? && event.channel.nil?
        end

        def no_users?(event)
          true if event.old_channel.users.empty?
        end
      end
    end
  end
end
