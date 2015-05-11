require_relative 'config.rb'
require_relative 'valuefirst.rb'

module Valuefirst
  
  class Valuefirst

    VALID_ACTIONS = ["send", "status", "credits"]

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
        return api_reponse.body
      end
    end

  end

end
