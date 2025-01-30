module HexletCode
  class Form
    attr_accessor :model, :fields, :attributes

    def initialize(model)
      @model = model
    end

    def input(field_name, attributes = {})
      value = @model.public_send field_name
      return textarea(field_name, value, attributes) if attributes[:as] == :text

      plain_input(field_name, value, attributes)
    end

    def submit(name = nil)
      value = name.nil? || name.empty? ? 'Save' : name
      attributes = { type: 'submit', value: value }

      field = Field.new(:submit, name, value, attributes)
      @fields ||= []
      @fields.push(field)
      field.tag
    end

    def html_with_labels
      @fields ||= []
      HexletCode::Tag.build('form', attributes) do
        @fields.reduce('') do |m, field|
          m += label(field.name) if field.type == :input && field.type != :submit
          m += field.tag
          m
        end
      end
    end

    def html
      @fields ||= []
      HexletCode::Tag.build('form', attributes) do
        @fields.reduce('') do |m, field|
          m += field.tag
          m
        end
      end
    end

    private

    def label(name)
      attributes = { for: name }
      HexletCode::Tag.build('label', attributes) { name.to_s.capitalize }
    end

    def plain_input(field_name, value, attributes = {})
      attributes[:name] = field_name
      attributes[:type] = 'text'
      attributes[:value] = value.nil? ? '' : value

      field = Field.new(:input, field_name, value, attributes)
      @fields ||= []
      @fields.push(field)
      field.tag
    end

    def textarea(field_name, value, attributes = {})
      attributes[:name] = field_name
      attributes[:rows] ||= 40
      attributes[:cols] ||= 20
      attributes.delete(:as)

      field = Field.new(:textarea, field_name, value, attributes)
      @fields ||= []
      @fields.push(field)
      field.tag
    end
  end

  def self.form_for(model, attributes = {})
    attributes = default_form_attributes_with attributes
    form = Form.new(model)
    form.attributes = attributes
    yield form
    form
  end

  def self.default_form_attributes_with(attributes = {})
    attributes[:action] = attributes.delete(:url) if attributes.key?(:url)
    default_form_attributes = { action: '#', method: 'post' }
    default_form_attributes.merge!(attributes)
    default_form_attributes
  end
end

module HexletCode
  class Form
    class Field
      attr_accessor :type, :name, :value, :attributes

      def initialize(type, name, value, attributes)
        @type = type
        @name = name
        @value = value
        @attributes = attributes
      end

      def tag
        if @type == :textarea
          return HexletCode::Tag.build(@type, attributes) { @value }
        elsif @type == :submit
          return HexletCode::Tag.build('input', attributes)
        end

        HexletCode::Tag.build(@type.to_s, attributes)
      end
    end
  end
end
