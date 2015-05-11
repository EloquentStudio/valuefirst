require_relative 'xml_generator.rb'

module XmlPayload
  
  VERSION = "1.2"
  
  class RequestCredit
    def self.requestcredit vfirst_config
      doc = XmlPayload::XmlGenerator.new_doc
      #doc_type  = XmlGenerator.create_node("!DOCTYPE", )
      requestcredit_tag = XmlPayload::XmlGenerator.create_node("REQUESTCREDIT", attributes: {"USERNAME" => vfirst_config.username.to_s, "PASSWORD" => vfirst_config.password.to_s})
      doc.root = requestcredit_tag
      doc
    end
  end

end
