require_relative 'config.rb'
require_relative 'valuefirst.rb'

module Valuefirst

	class BatchSend < Valuefirst

    def send_text_sms file_path
      raise ArgumentError, "File does not exist." unless File.exists? file_path.to_s
      raise ArgumentError, "File is not readable" unless File.readable? file_path.to_s
      payload = XmlPayload::Batchtext.batchtext @config, file_path
      call_api payload, "send"
    end

    def send_unicode_sms
    end

    def send_vcard
    end

    def status_request
    end
	end

end