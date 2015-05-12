require 'spec_helper'
require 'valuefirst.rb'

describe "StatusRequest" do

  describe "::statusrequest" do
    it "it return a dtd compliant xml document" do
      payload = XmlPayload::StatusRequest.statusrequest(vfirst_config, {"guid" => ["1", "2", "3"]})
      expect(payload.class).to be XML::Document
      expect(payload.validate(load_dtd_from_file("requeststatusv12"))).to eq true
    end
  end
end
