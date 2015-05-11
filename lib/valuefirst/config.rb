module Valuefirst
  class Config
    attr_accessor :username, :password, :default_sender, :url
    
    def initialize(opts = {})
      @username = opts[:username]
      @password = opts[:password]
      @default_sender = opts[:default_sender]
      @url      = opts[:url] || "http://api.myvaluefirst.com/psms/servlet/psms.Eservice2"
      @version  = opts[:version] || '1.2'
    end

    def validate
      errors = []
      errors << "Invalid username" if @username.nil?
      errors << "Invalid password" if @password.nil?
      errors << "API version not supported" unless @version == '1.2'
      unless errors.empty?
        raise ArgumentError, "#{errors.join(', ')}"
      end
    end
  end
end