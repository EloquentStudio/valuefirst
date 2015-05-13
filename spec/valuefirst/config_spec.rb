require 'spec_helper'
require 'valuefirst.rb'

describe "Vlauefirst::Config" do

  describe "#initialize" do
    it "it sets required instance variables" do
      config = Valuefirst::Config.new(username: "user_name", password: "password", default_sender: "default_sender")
      expect(config.username).to eq("user_name")
      expect(config.password).to eq("password")
      expect(config.default_sender).to eq("default_sender")
      expect(config.version).to eq("1.2")
      expect(config.url).to eq("http://api.myvaluefirst.com/psms/servlet/psms.Eservice2")
    end
  end

  describe "#validate" do
    it "raises ArgumentError" do
      expect { Valuefirst::Config.new(username: [nil, ""].sample, password: "password", default_sender: "default_sender").validate }.to raise_error(ArgumentError).
      with_message("Invalid username")

      expect { Valuefirst::Config.new(username: "user_name", password: [nil, ""].sample, default_sender: "default_sender").validate }.to raise_error(ArgumentError).
      with_message("Invalid password")

      expect { Valuefirst::Config.new(username: "user_name", password: "password", default_sender: "default_sender", version: "1.3").validate }.to raise_error(ArgumentError).
      with_message("API version not supported")

      expect { Valuefirst::Config.new(username: "", password: nil, default_sender: "default_sender").validate }.to raise_error(ArgumentError).
      with_message("Invalid username, Invalid password")
    end
  end
end
