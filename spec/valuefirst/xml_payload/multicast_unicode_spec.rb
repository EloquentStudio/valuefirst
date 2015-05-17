require 'spec_helper'
require 'valuefirst.rb'

describe "MulticastUnicode" do

  describe "::multicastunicode" do
    it "it return a dtd compliant xml document" do
      payload = XmlPayload::MulticastUnicode.multicastunicode(vfirst_config,
        "Sample mesage", 
        ["XXXXXXXX01", "XXXXXXXX02", "XXXXXXXX03", "XXXXXXXX04"])
      expect(payload.class).to be XML::Document
      expect((payload.find '//ADDRESS').count).to eq(4)
      expect(payload.validate(load_dtd_from_file("messagev12"))).to eq true
    end
  end
end
