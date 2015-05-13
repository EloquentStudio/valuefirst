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

  context "#methods" do
    let!(:valuefirst_obj) {
                              Valuefirst::Valuefirst.new(username: "user_name", password: "password") do |config|
                                config.default_sender = "default_sender"
                              end
                            }

    describe "#credit_request" do
      let!(:payload) { XmlPayload::RequestCredit.requestcredit(vfirst_config) }
      before do
        allow_any_instance_of(Valuefirst::Valuefirst).to receive(:call_api).with(payload, "credits")
        allow(XmlPayload::RequestCredit).to receive(:requestcredit).with(valuefirst_obj.config)
          .and_return(payload)
      end

      it "makes credits request to valuefirst_api" do
        expect(XmlPayload::RequestCredit).to receive(:requestcredit).with(valuefirst_obj.config)
        expect_any_instance_of(Valuefirst::Valuefirst).to receive(:call_api).with(payload, "credits")
        valuefirst_obj.credit_request
      end
    end

    describe "#status_request" do
      let!(:payload) { XmlPayload::StatusRequest.statusrequest(vfirst_config, guid_seq_hash) }
      let!(:guid_seq_hash) { {"guid"=> ["1", "2"]} }
      before do
        allow_any_instance_of(Valuefirst::Valuefirst).to receive(:call_api).with(payload, "status")
        allow(XmlPayload::StatusRequest).to receive(:statusrequest).with(valuefirst_obj.config, guid_seq_hash)
          .and_return(payload)
      end

      it "makes status request to valuefirst_api" do
        expect(XmlPayload::StatusRequest).to receive(:statusrequest).with(valuefirst_obj.config, guid_seq_hash)
        expect_any_instance_of(Valuefirst::Valuefirst).to receive(:call_api).with(payload, "status")
        valuefirst_obj.status_request guid_seq_hash
      end
    end

    describe "#api_call" do
      it "raises ArgumentError when called with invalid action" do
        expect{ valuefirst_obj.send(:call_api, "payload", "invalidStatus") }.to raise_error(ArgumentError)
      end

      it "does not raises ArgumentError when called with valid action" do
        expect{ valuefirst_obj.send(:call_api, "payload", Valuefirst::Valuefirst::VALID_ACTIONS.sample) }.not_to raise_error
      end
    end
  end
end
