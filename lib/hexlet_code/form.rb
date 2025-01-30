module HexletCode
  class Form
    attr_accessor :tag, :object, :fields

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

      field = Field.new(:submit, name, value, attributes)
      @fields ||= []
      @fields.push(field)
      field.tag
    end

    def label(name)
      attributes = { for: name }
      HexletCode::Tag.build('label', attributes) { name.to_s.capitalize }
    end

    private

    def plain_input(field_name, value, attributes = {})
      attributes[:name] = field_name
      attributes[:type] = 'text'
      attributes[:value] = value.nil? ? '' : value

      field = Field.new(:input, field_name, value, attributes)
      @fields ||= []
      @fields.push(field)
      field.tag
    end

    # TODO: -move to separate class and form will contains them
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

  def self.form_for(object, attributes = {})
    need_labels = attributes[:need_labels]
    attributes = default_attributes_for attributes
    form = Form.new(object)
    yield form
    # TODO: -move to separate class and it will generate html if needed
    form.fields ||= []
    HexletCode::Tag.build('form', attributes) do
      form.fields.reduce('') do |m, field|
        m += form.label(field.name) if field.type == :input && need_labels && field.type != :submit
        m += field.tag
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
