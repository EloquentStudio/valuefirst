module XmlPayload
  class TextMessage
    def self.textmessage vfirst_config, message_content, phone_number, sender_id
      doc = XmlPayload::XmlGenerator.new_doc
      message_tag = XmlPayload::XmlGenerator.create_node("MESSAGE", attributes: {"VER" => XmlPayload::VERSION})
      doc.root = message_tag
      user_tag = XmlPayload::XmlGenerator.user_tag vfirst_config
      doc.root << user_tag
      
      sms_tag = XmlPayload::XmlGenerator.create_node("SMS", attributes: { "UDH"     => "0",
                                                                  "CODING"  => "1",
                                                                  "TEXT"    => message_content.to_s,
                                                                  "PROPERTY" => "0",
                                                                  "ID"      => "1",
                                                                })

      address_tag = XmlPayload::XmlGenerator.create_node("ADDRESS", attributes: { "FROM" => sender_id || vfirst_config.default_sender.to_s,
                                                                                    "TO"   => phone_number.to_s,
                                                                                    "SEQ"  => "",
                                                                                    "TAG"  => "",
                                                                                  })

      sms_tag << address_tag
      doc.root << sms_tag
      doc
    end
  end
end