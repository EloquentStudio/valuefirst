require 'spec_helper'
require 'valuefirst.rb'

describe "XmlGenerator" do

  describe "::new_doc" do
    it "return an XML::Document object" do
      expect(XmlPayload::XmlGenerator.new_doc.class).to be XML::Document
    end

    describe "::user_tag" do
      it "creates xml USER tag with USERNAME and PASSWORD attributes" do
        expect(XmlPayload::XmlGenerator.user_tag(vfirst_config).to_s).to eq('<USER USERNAME="user_name" PASSWORD="password"/>')
      end
    end

    describe "::create_node" do
      it "creates a valid node" do
        expect(XmlPayload::XmlGenerator.create_node("TESTNODE")).to eq(XML::Node.new("TESTNODE"))
      end
    end

    describe "::add_attributes" do
      node = XmlPayload::XmlGenerator.create_node("TESTNODE")
      it "attributes to node" do
        XmlPayload::XmlGenerator.add_attributes(node, {"ATTR1" => "ATTR1_VAL", "ATTR2" => "ATTR2_VAL"})
        expect(node.attributes.length).to eq(2)
        expect(node.attributes.to_a.first.to_s).to eq("ATTR1 = ATTR1_VAL")
        expect(node.attributes.to_a.last.to_s).to eq("ATTR2 = ATTR2_VAL")
      end
    end

  end
end
