require_relative 'config.rb'
require_relative 'valuefirst.rb'

module Valuefirst

  class UniSend < Valuefirst

    def send_text_sms message_content, phone_number, sender_id
      payload = XmlPayload::TextMessage.textmessage @config, message_content, phone_number, sender_id
      call_api payload, "send"
    end

    def send_unicode_sms
    end

    def send_vcard
    end
    
  end
end