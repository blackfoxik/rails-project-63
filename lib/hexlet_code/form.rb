module HexletCode
  class Form
    attr_accessor :tag, :object, :fields

    def initialize(object)
      @object = object
    end

    def input(field_name, attributes = {})
      value = @object.public_send field_name
      return textarea(field_name, value, attributes) if attributes[:as] == :text

      plain_input(field_name, value, attributes)
    end

    private

    def plain_input(field_name, value, attributes = {})
      attributes[:name] = field_name
      attributes[:type] = 'text'
      attributes[:value] = value
      @fields ||= {}
      @fields[field_name] = HexletCode::Tag.build('input', attributes)
      HexletCode::Tag.build('input', attributes)
    end

    def textarea(field_name, value, attributes = {})
      attributes[:name] = field_name
      attributes[:rows] ||= 40
      attributes[:cols] ||= 20
      attributes.delete(:as)
      @fields ||= {}
      @fields[field_name] = HexletCode::Tag.build('textarea', attributes) { value }
      HexletCode::Tag.build('textarea', attributes) { value }
    end
  end

  def self.form_for(object, attributes = {})
    attributes = default_attributes_for attributes
    form = Form.new(object)
    yield form
    form.fields ||= {}
    HexletCode::Tag.build('form', attributes) do
      form.fields.reduce('') do |m, (_k, v)|
        m += v.to_s
        m
      end
    end
  end

  def self.default_attributes_for(attributes = {})
    attributes[:action] = attributes.delete(:url) if attributes.key?(:url)
    default_form_attributes = { action: '#', method: 'post' }
    default_form_attributes.merge!(attributes)
    default_form_attributes
  end
end
