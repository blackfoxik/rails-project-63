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

    def submit(name = nil)
      value = name.nil? || name.empty? ? 'Save' : name
      attributes = { type: 'submit', value: value }
      tag = HexletCode::Tag.build('input', attributes)
      @fields ||= {}
      @fields['submit'] = { type: :input, attr: attributes, tag: tag }
      tag
    end

    def label(name)
      attributes = { for: name }
      HexletCode::Tag.build('label', attributes) { name.to_s.capitalize }
    end

    private

    def plain_input(field_name, value, attributes = {})
      attributes[:name] = field_name
      attributes[:type] = 'text'
      attributes[:value] = value
      @fields ||= {}
      tag = HexletCode::Tag.build('input', attributes)
      @fields[field_name] = { type: :input, attr: attributes, tag: tag }
      tag
    end

    # TODO: -move to separate class and form will contains them
    def textarea(field_name, value, attributes = {})
      attributes[:name] = field_name
      attributes[:rows] ||= 40
      attributes[:cols] ||= 20
      attributes.delete(:as)
      @fields ||= {}
      tag = HexletCode::Tag.build('textarea', attributes) { value }
      @fields[field_name] = { type: :textarea, attr: attributes, tag: tag }
      tag
    end
  end

  def self.form_for(object, attributes = {})
    need_labels = attributes[:need_labels]
    attributes = default_attributes_for attributes
    form = Form.new(object)
    yield form
    # TODO: -move to separate class and it will generate html if needed
    form.fields ||= {}
    HexletCode::Tag.build('form', attributes) do
      form.fields.reduce('') do |m, (k, v)|
        m += form.label(k) if v[:type] == :input && need_labels && k != 'submit'
        m += v[:tag].to_s
        m
      end
    end
  end

  def self.default_attributes_for(attributes = {})
    attributes[:action] = attributes.delete(:url) if attributes.key?(:url)
    attributes.delete(:need_labels)
    default_form_attributes = { action: '#', method: 'post' }
    default_form_attributes.merge!(attributes)
    default_form_attributes
  end
end
