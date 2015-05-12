require 'spec_helper'
require 'valuefirst.rb'

describe "RequestCredit" do

  describe "::requestcredit" do
    it "it return a dtd compliant xml document" do
      payload = XmlPayload::RequestCredit.requestcredit(vfirst_config)
      expect(payload.class).to be XML::Document
      expect(payload.validate(load_dtd_from_file("requestcredit"))).to eq true
    end
  end
end
