require 'spec_helper'
require 'valuefirst.rb'

describe "TextMessage" do

  describe "::textmessage" do
    it "it return a dtd compliant xml document" do
      payload = XmlPayload::TextMessage.textmessage(vfirst_config, "This a test message", "phone_number", "sender_id")
      expect(payload.class).to be XML::Document
      expect(payload.validate(load_dtd_from_file("messagev12"))).to eq true
    end
  end
end
