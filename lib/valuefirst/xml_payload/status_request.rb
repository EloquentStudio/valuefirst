module XmlPayload
  class StatusRequest
    def self.statusrequest vfirst_config, guid_seq_hash
      doc = XmlPayload::XmlGenerator.new_doc
      message_tag = XmlPayload::XmlGenerator.create_node("STATUSREQUEST", attributes: {"VER" => XmlPayload::VERSION})
      doc.root = message_tag
      user_tag = XmlPayload::XmlGenerator.user_tag vfirst_config
      doc.root << user_tag

      guid_seq_hash.each do |guid, seq_list|
        doc.root << guid_tag(guid, seq_list)
      end
      doc
    end

    def self.guid_tag guid, seq_list
      guid_tag = XmlPayload::XmlGenerator.create_node("GUID", attributes: {"GUID" => guid })
      if !seq_list.empty?
        seq_list.each do |seq|
          guid_tag << XmlPayload::XmlGenerator.create_node("STATUS", attributes: {"SEQ" => seq.to_s})
        end
      end
      guid_tag
    end
  end
end