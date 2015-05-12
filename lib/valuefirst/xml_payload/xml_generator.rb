module XmlPayload
  
  class XmlGenerator
    def self.new_doc
      doc = XML::Document.new
      doc.encoding = XML::Encoding::ISO_8859_1
      doc
    end

    def self.add_attributes( node, attributes )
      attributes.each do |name, value|
        XML::Attr.new( node, name, value )
      end
    end

    def self.create_node( name, options = {} )
      node = XML::Node.new( name )
      
      attributes = options.delete( :attributes ) unless options.empty?
      add_attributes( node, attributes ) if attributes
      
      node
    end

    def self.user_tag vfirst_config
      XmlPayload::XmlGenerator.create_node("USER", attributes: {"USERNAME" => vfirst_config.username.to_s, "PASSWORD" => vfirst_config.password.to_s})
    end
  end

end