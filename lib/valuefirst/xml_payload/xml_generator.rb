module XmlPayload
  
  class XmlGenerator
    def self.new_doc
      doc = XML::Document.new
      doc.encoding = XML::Encoding::ISO_8859_1
      doc
    end

    def add_namespaces( node, namespaces )
      #pass nil as the prefix to create a default node
      default = namespaces.delete( "default" )
      node.namespaces.namespace = XML::Namespace.new( node, nil, default )
      namespaces.each do |prefix, prefix_uri|
        XML::Namespace.new( node, prefix, prefix_uri )
      end
    end

    def self.add_attributes( node, attributes )
      attributes.each do |name, value|
        XML::Attr.new( node, name, value )
      end
    end

    def self.create_node( name, options )
      node = XML::Node.new( name )
      
      namespaces = options.delete( :namespaces )
      add_namespaces( node, namespaces ) if namespaces
      
      attributes = options.delete( :attributes )
      add_attributes( node, attributes ) if attributes
      
      node
    end
  end

end