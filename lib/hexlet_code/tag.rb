module HexletCode
  class Tag
    def self.build(tag_name, attributes = {}, &block)
      return build_double_tag(tag_name, attributes, yield.to_s) unless block.nil?

      build_single_tag(tag_name, attributes)
    end

    def self.build_double_tag(tag_name, attributes = {}, body)
      single_tag = build_single_tag(tag_name, attributes)
      closed_tag = build_closed_tag(tag_name)
      single_tag + body + closed_tag
    end

    def self.build_closed_tag(tag_name)
      "</#{tag_name}>"
    end

    def self.build_single_tag(tag_name, attributes = {})
      attributes = attributes.reduce("") do |m, (k, v)|
        m += " #{k}=\"#{v}\""
        m
      end
      "<#{tag_name}#{attributes}>"
    end
  end
end
