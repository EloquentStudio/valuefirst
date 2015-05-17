require_relative 'config.rb'
require_relative 'valuefirst.rb'

module Valuefirst
  
  class Valuefirst

    VALID_ACTIONS = %w(send status credits)

    attr_reader :config

    def initialize(opts = {})
      @config = Config.new(opts)
      yield(@config) if block_given?
      @config.validate
    end

    def credit_request
      payload = XmlPayload::RequestCredit.requestcredit @config
      call_api payload, "credits"
    end

    def status_request guid_seq_hash
      payload = XmlPayload::StatusRequest.statusrequest @config, guid_seq_hash
      call_api payload, "status"
    end

    def send_message message_content, phone_number, sender_id
      payload = XmlPayload::TextMessage.textmessage @config, message_content, phone_number, sender_id
      call_api payload, "send"
    end

    def bulksend_message file_path
      raise ArgumentError, "File does not exist." unless File.exists? file_path.to_s
      raise ArgumentError, "File is not readable." unless File.readable? file_path.to_s
      payload = XmlPayload::Batchtext.batchtext @config, file_path
      call_api payload, "send"
    end

    private

    def call_api payload, action
      raise ArgumentError, "Invalid action" unless VALID_ACTIONS.include? action
      params = {data: payload, action: action}
      api_reponse = Net::HTTP.post_form(
        URI.parse(@config.url), 
        params
        )

      case api_reponse
      when Net::HTTPSuccess, Net::HTTPRedirection
        return HappyMapper.parse(api_reponse.body.downcase)
      else
        return api_reponse
      end
    end

  end

end
