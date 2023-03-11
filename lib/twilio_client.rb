# handle sending SMS through Twilio
module TwilioClient
  require 'twilio-ruby'
  require 'json'
  require '../models/users'
  require '../db/db_setup'

  DATA = JSON.parse(File.read('../config/twilio_config.json'))

  CLIENT = Twilio::REST::Client.new(DATA['twilio_account_sid'], DATA['twilio_auth_token'])

  def self.send_messages(phone_numbers, message)
    return if phone_numbers.nil?

    phone_numbers.each do |phone_number|
      CLIENT.messages.create(from: DATA['twilio_number'], to: phone_number, body: message)
    end
  end
end
