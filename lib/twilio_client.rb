# handle sending SMS through Twilio
module TwilioClient
  require 'twilio-ruby'
  require 'json'

  DATA = JSON.parse(File.read('../config/config.json'))

  CLIENT = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])

  def self.send_messages(message)
    from = DATA['twilio_number']
    CLIENT.messages.create(from:, to: DATA['test_recipient'], body: message)
  end
end
