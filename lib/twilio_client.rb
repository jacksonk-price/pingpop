# handle sending SMS through Twilio
module TwilioClient
  require 'twilio-ruby'
  require 'json'

  DATA = JSON.parse(File.read('../config/twilio_config.json'))

  CLIENT = Twilio::REST::Client.new(DATA['twilio_account_sid'], DATA['twilio_auth_token'])

  def self.send_messages(message)
    CLIENT.messages.create(from: DATA['twilio_number'], to: DATA['test_recipient'], body: message)
  end
end
