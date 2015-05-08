require_relative 'config.rb'
require_relative 'valuefirst.rb'

module Valuefirst
  
  class Valuefirst
    attr_reader :config
    def initialize(opts = {})
      @config = Config.new(opts)
      yield(@config) if block_given?
      @config.validate
    end

    def status_request
    end

    def credit_request
    end
  end

end
