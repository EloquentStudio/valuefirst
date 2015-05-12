require 'spec_helper'
require 'valuefirst.rb'

describe "Batchtext" do

  describe "::batchtext" do
    it "it return a dtd compliant xml document" do
      payload = XmlPayload::Batchtext.batchtext(vfirst_config, "spec/support/csv_sample.csv")
      expect(payload.class).to be XML::Document
      expect(payload.validate(load_dtd_from_file("messagev12"))).to eq true
    end
  end
end
