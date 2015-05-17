
require 'spec_helper'
require 'valuefirst.rb'

describe "UnicodeMessage" do

  describe "::unicodemessage" do
    it "it return a dtd compliant xml document" do
      payload = XmlPayload::UnicodeMessage.unicodemessage(vfirst_config, "This a test message", "phone_number", "sender_id")
      expect(payload.class).to be XML::Document
      expect((payload.find '//SMS').first.attributes["TEXT"]).to eq("5468697320612074657374206d657373616765")
      expect(payload.validate(load_dtd_from_file("messagev12"))).to eq true
    end
  end
end
