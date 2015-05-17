require 'spec_helper'
require 'valuefirst.rb'

describe "Batchunicode" do

  describe "::batchunicode" do
    it "it return a dtd compliant xml document" do
      payload = XmlPayload::Batchunicode.batchunicode(vfirst_config, "spec/support/csv_sample.csv")
      expect(payload.class).to be XML::Document
      expect((payload.find '//SMS').count).to eq(2)
      expect(payload.validate(load_dtd_from_file("messagev12"))).to eq true
    end
  end
end
