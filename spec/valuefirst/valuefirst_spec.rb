require 'spec_helper'
require 'valuefirst.rb'

describe "Vlauefirst::Valuefirst" do

  describe "class constants" do 
    it "VALID_ACTIONS constant is set" do
      expect(Valuefirst::Valuefirst::VALID_ACTIONS).to eq(%w(send status credits))
    end
  end

  describe "#initialize" do
    it "it sets @config" do
      valuefirst_obj = Valuefirst::Valuefirst.new(username: "user_name", password: "password") do |config|
        config.default_sender = "default_sender"
      end
      expect(valuefirst_obj.config).to_not be nil
      expect(valuefirst_obj.config.username).to eq("user_name")
      expect(valuefirst_obj.config.password).to eq("password")
      expect(valuefirst_obj.config.default_sender).to eq("default_sender")
      expect(valuefirst_obj.config.version).to eq("1.2")
      expect(valuefirst_obj.config.url).to eq("http://api.myvaluefirst.com/psms/servlet/psms.Eservice2")
    end
  end

  describe "#credit_request" do
    it "does something" do

    end
  end
end
