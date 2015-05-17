module XmlPayload

  class Batchunicode
    
    CSV_CONFIG = {headers: true}
    
    def self.batchunicode vfirst_config, file_path
      doc = XmlPayload::XmlGenerator.new_doc
      message_tag = XmlPayload::XmlGenerator.create_node("MESSAGE", attributes: {"VER" => XmlPayload::VERSION})
      doc.root = message_tag
      user_tag = XmlPayload::XmlGenerator.user_tag vfirst_config
      doc.root << user_tag
      
      CSV.foreach(file_path.to_s, CSV_CONFIG) do |message_record|
        message_content = message_record["message_content"].to_s
        sms_tag = XmlPayload::XmlGenerator.create_node("SMS", attributes: { "UDH"     => "0",
                                                                  "CODING"  => "2",
                                                                  "TEXT"    => message_content.
                                                                    unpack('U'*message_content.length).collect { |x| x.to_s 16 }.join,
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