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

    describe "#bulksend_message" do
      let! (:file_path) { File.absolute_path("spec/support/csv_sample.csv") }
      let! (:valuefirst_obj) { Valuefirst::Valuefirst.new(username: "user_name", password: "password", default_sender: "default_sender") }
      let!(:payload) { XmlPayload::Batchtext.batchtext(valuefirst_obj.config, file_path) }
     
      before do
        FileUtils.chmod "-r", "spec/support/non_readable_file"
        allow_any_instance_of(Valuefirst::Valuefirst).to receive(:call_api).with(payload, "send")
        allow(XmlPayload::Batchtext).to receive(:batchtext).with(valuefirst_obj.config, file_path)
          .and_return(payload)
      end
      after do
        FileUtils.chmod "+r", "spec/support/non_readable_file"
      end
      it "raises error when file does not exist" do      
        expect{valuefirst_obj.bulksend_message "non_existent_file_path"}.to raise_error(ArgumentError).with_message("File does not exist.")
      end

      it "raises error when file is not readable" do
        expect{valuefirst_obj.bulksend_message File.absolute_path("spec/support/non_readable_file")}.to raise_error(ArgumentError).with_message("File is not readable.")
      end

      it "makes bulkmessage send request to valuefirst_api" do
        expect(XmlPayload::Batchtext).to receive(:batchtext).with(valuefirst_obj.config, file_path)
        expect_any_instance_of(Valuefirst::Valuefirst).to receive(:call_api).with(payload, "send")
        valuefirst_obj.bulksend_message File.absolute_path(file_path)
      end
    end

    describe "#send_message" do
      let! (:valuefirst_obj) { Valuefirst::Valuefirst.new(username: "user_name", password: "password", default_sender: "default_sender") }
      let!(:payload) { XmlPayload::TextMessage.textmessage(valuefirst_obj.config, "message_content", "phone_number", "sender_id") }
     
      before do
        allow_any_instance_of(Valuefirst::Valuefirst).to receive(:call_api).with(payload, "send")
        allow(XmlPayload::TextMessage).to receive(:textmessage).with(valuefirst_obj.config, "message_content", "phone_number", "sender_id")
          .and_return(payload)
      end

      it "makes message send request to valuefirst_api" do
        expect(XmlPayload::TextMessage).to receive(:textmessage).with(valuefirst_obj.config, "message_content", "phone_number", "sender_id")
        expect_any_instance_of(Valuefirst::Valuefirst).to receive(:call_api).with(payload, "send")
        valuefirst_obj.send_message "message_content", "phone_number", "sender_id"
      end
    end

    describe "#multicast_message" do
      let! (:valuefirst_obj) { Valuefirst::Valuefirst.new(username: "user_name", password: "password", default_sender: "default_sender") }
      let!(:payload) { XmlPayload::MulticastMessage.multicastmessage(valuefirst_obj.config, "message_content", ["XXXXXXXX01", "XXXXXXXX02", "XXXXXXXX03", "XXXXXXXX04"], "sender_id") }
     
      before do
        allow_any_instance_of(Valuefirst::Valuefirst).to receive(:call_api).with(payload, "send")
        allow(XmlPayload::MulticastMessage).to receive(:multicastmessage).with(valuefirst_obj.config, "message_content", ["XXXXXXXX01", "XXXXXXXX02", "XXXXXXXX03", "XXXXXXXX04"], "sender_id")
          .and_return(payload)
      end

      it "makes multicast message send request to valuefirst_api" do
        expect(XmlPayload::MulticastMessage).to receive(:multicastmessage).with(valuefirst_obj.config, "message_content", ["XXXXXXXX01", "XXXXXXXX02", "XXXXXXXX03", "XXXXXXXX04"], "sender_id")
        expect_any_instance_of(Valuefirst::Valuefirst).to receive(:call_api).with(payload, "send")
        valuefirst_obj.multicast_message "message_content", ["XXXXXXXX01", "XXXXXXXX02", "XXXXXXXX03", "XXXXXXXX04"], "sender_id"
      end
    end

    describe "#send_unicode" do
      let! (:valuefirst_obj) { Valuefirst::Valuefirst.new(username: "user_name", password: "password", default_sender: "default_sender") }
      let!(:payload) { XmlPayload::UnicodeMessage.unicodemessage(valuefirst_obj.config, "message_content", "phone_number", "sender_id") }
     
      before do
        allow_any_instance_of(Valuefirst::Valuefirst).to receive(:call_api).with(payload, "send")
        allow(XmlPayload::UnicodeMessage).to receive(:unicodemessage).with(valuefirst_obj.config, "message_content", "phone_number", "sender_id")
          .and_return(payload)
      end

      it "makes unicode message send request to valuefirst_api" do
        expect(XmlPayload::UnicodeMessage).to receive(:unicodemessage).with(valuefirst_obj.config, "message_content", "phone_number", "sender_id")
        expect_any_instance_of(Valuefirst::Valuefirst).to receive(:call_api).with(payload, "send")
        valuefirst_obj.send_unicode "message_content", "phone_number", "sender_id"
      end
    end

    describe "#bulksend_unicode" do
      let! (:file_path) { File.absolute_path("spec/support/csv_sample.csv") }
      let! (:valuefirst_obj) { Valuefirst::Valuefirst.new(username: "user_name", password: "password", default_sender: "default_sender") }
      let!(:payload) { XmlPayload::Batchunicode.batchunicode(valuefirst_obj.config, file_path) }
     
      before do
        FileUtils.chmod "-r", "spec/support/non_readable_file"
        allow_any_instance_of(Valuefirst::Valuefirst).to receive(:call_api).with(payload, "send")
        allow(XmlPayload::Batchunicode).to receive(:batchunicode).with(valuefirst_obj.config, file_path)
          .and_return(payload)
      end
      after do
        FileUtils.chmod "+r", "spec/support/non_readable_file"
      end
      it "raises error when file does not exist" do      
        expect{valuefirst_obj.bulksend_unicode "non_existent_file_path"}.to raise_error(ArgumentError).with_message("File does not exist.")
      end

      it "raises error when file is not readable" do
        expect{valuefirst_obj.bulksend_unicode File.absolute_path("spec/support/non_readable_file")}.to raise_error(ArgumentError).with_message("File is not readable.")
      end

      it "makes bulkunicode send request to valuefirst_api" do
        expect(XmlPayload::Batchunicode).to receive(:batchunicode).with(valuefirst_obj.config, file_path)
        expect_any_instance_of(Valuefirst::Valuefirst).to receive(:call_api).with(payload, "send")
        valuefirst_obj.bulksend_unicode File.absolute_path(file_path)
      end
    end

    describe "#multicast_unicode" do
      let! (:valuefirst_obj) { Valuefirst::Valuefirst.new(username: "user_name", password: "password", default_sender: "default_sender") }
      let!(:payload) { XmlPayload::MulticastUnicode.multicastunicode(valuefirst_obj.config, "message_content", ["XXXXXXXX01", "XXXXXXXX02", "XXXXXXXX03", "XXXXXXXX04"], "sender_id") }
     
      before do
        allow_any_instance_of(Valuefirst::Valuefirst).to receive(:call_api).with(payload, "send")
        allow(XmlPayload::MulticastUnicode).to receive(:multicastunicode).with(valuefirst_obj.config, "message_content", ["XXXXXXXX01", "XXXXXXXX02", "XXXXXXXX03", "XXXXXXXX04"], "sender_id")
          .and_return(payload)
      end

      it "makes multicast unicode send request to valuefirst_api" do
        expect(XmlPayload::MulticastUnicode).to receive(:multicastunicode).with(valuefirst_obj.config, "message_content", ["XXXXXXXX01", "XXXXXXXX02", "XXXXXXXX03", "XXXXXXXX04"], "sender_id")
        expect_any_instance_of(Valuefirst::Valuefirst).to receive(:call_api).with(payload, "send")
        valuefirst_obj.multicast_unicode "message_content", ["XXXXXXXX01", "XXXXXXXX02", "XXXXXXXX03", "XXXXXXXX04"], "sender_id"
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
