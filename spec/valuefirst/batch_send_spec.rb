require 'spec_helper'
require 'valuefirst.rb'

describe "Valuefirst::BatchSend" do

  describe "#send_text_sms" do
    let! (:file_path) { File.absolute_path("spec/support/csv_sample.csv") }
    let! (:batchsend_obj) { Valuefirst::BatchSend.new(username: "user_name", password: "password", default_sender: "default_sender") }
    let!(:payload) { XmlPayload::Batchtext.batchtext(batchsend_obj.config, file_path) }
   
    before do
      FileUtils.chmod "-r", "spec/support/non_readable_file"
      allow_any_instance_of(Valuefirst::BatchSend).to receive(:call_api).with(payload, "send")
      allow(XmlPayload::Batchtext).to receive(:batchtext).with(batchsend_obj.config, file_path)
        .and_return(payload)
    end
    after do
      FileUtils.chmod "+r", "spec/support/non_readable_file"
    end
    it "raises error when file does not exist" do      
      expect{batchsend_obj.send_text_sms "non_existent_file_path"}.to raise_error(ArgumentError).with_message("File does not exist.")
    end

    it "raises error when file is not readable" do
      expect{batchsend_obj.send_text_sms File.absolute_path("spec/support/non_readable_file")}.to raise_error(ArgumentError).with_message("File is not readable.")
    end

    it "makes message send request to valuefirst_api" do
      expect(XmlPayload::Batchtext).to receive(:batchtext).with(batchsend_obj.config, file_path)
      expect_any_instance_of(Valuefirst::BatchSend).to receive(:call_api).with(payload, "send")
      batchsend_obj.send_text_sms File.absolute_path(file_path)
    end
  end
end
