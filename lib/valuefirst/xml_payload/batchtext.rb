module XmlPayload

  class Batchtext
    
    CSV_CONFIG = {headers: true}
    
    def self.batchtext vfirst_config, file_path
      doc = XmlPayload::XmlGenerator.new_doc
      message_tag = XmlPayload::XmlGenerator.create_node("MESSAGE", attributes: {"VER" => XmlPayload::VERSION})
      doc.root = message_tag
      user_tag = XmlPayload::XmlGenerator.user_tag vfirst_config
      doc.root << user_tag
      
      CSV.foreach(file_path.to_s, CSV_CONFIG) do |message_record|
        sms_tag = XmlPayload::XmlGenerator.create_node("SMS", attributes: { "UDH"     => "0",
                                                                  "CODING"  => "1",
                                                                  "TEXT"    => message_record["message_content"].to_s,
                                                                  "PROPERTY" => "0",
                                                                  "ID"      => "1",
                                                                })

        address_tag = XmlPayload::XmlGenerator.create_node("ADDRESS", attributes: { "FROM" => message_record["sender"] || vfirst_config.default_sender.to_s,
                                                                                    "TO"   => message_record["phone_number"].to_s,
                                                                                    "SEQ"  => "",
                                                                                    "TAG"  => "",
                                                                                  })

        sms_tag << address_tag
        doc.root << sms_tag
      end
      doc
    end
  end

end