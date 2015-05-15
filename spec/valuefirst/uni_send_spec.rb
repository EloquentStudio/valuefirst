require 'spec_helper'
require 'valuefirst.rb'

describe "Valuefirst::BatchSend" do

  describe "#send_text_sms" do
    let! (:unisend_obj) { Valuefirst::UniSend.new(username: "user_name", password: "password", default_sender: "default_sender") }
    let!(:payload) { XmlPayload::TextMessage.textmessage(unisend_obj.config, "message_content", "phone_number", "sender_id") }
   
    before do
      allow_any_instance_of(Valuefirst::UniSend).to receive(:call_api).with(payload, "send")
      allow(XmlPayload::TextMessage).to receive(:textmessage).with(unisend_obj.config, "message_content", "phone_number", "sender_id")
        .and_return(payload)
    end

    it "makes message send request to valuefirst_api" do
      expect(XmlPayload::TextMessage).to receive(:textmessage).with(unisend_obj.config, "message_content", "phone_number", "sender_id")
      expect_any_instance_of(Valuefirst::UniSend).to receive(:call_api).with(payload, "send")
      unisend_obj.send_text_sms "message_content", "phone_number", "sender_id"
    end
  end
end
