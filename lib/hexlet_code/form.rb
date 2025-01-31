module HexletCode
  class Form
    attr_accessor :model, :fields, :attributes

    def initialize(model)
      @model = model
    end

    def input(field_name, attributes = {})
      value = @model.public_send field_name
      return textarea(field_name, value, attributes) if attributes[:as] == :text

      plain_input(field_name, value)
    end

    def submit(name = nil)
      field_model = Field::SubmitModel.new
      field_model.name = name

      field = Field.new(:submit, field_model)

      @fields ||= []
      @fields.push(field)
      field.tag
    end

    def html_with_labels
      HTMLPresenter.html_form_with_labels_by self
    end

    def html
      HTMLPresenter.html_form_by self
    end

    private

    def plain_input(field_name, value)
      field_model = Field::PlainInputModel.new
      field_model.name = field_name
      field_model.value = value

      field = Field.new(:input, field_model)

      @fields ||= []
      @fields.push(field)
      field.tag
    end

    def textarea(field_name, value, attributes = {})
      field_model = Field::TextareaModel.new
      field_model.name = field_name
      field_model.rows = attributes[:rows].nil? ? 40 : attributes[:rows]
      field_model.cols = attributes[:cols].nil? ? 20 : attributes[:cols]
      field_model.value = value

      field = Field.new(:textarea, field_model)
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
      TextareaModel = Struct.new(:name, :rows, :cols, :value)
      PlainInputModel = Struct.new(:name, :value)
      SubmitModel = Struct.new(:name)

      attr_accessor :type, :model

      def initialize(type, model)
        @type = type
        @model = model
      end

      def tag
        HTMLPresenter.html_by self
      end
    end
  end
end

module HTMLPresenter
  def self.html_form_by(form)
    fields = form.fields.nil? ? [] : form.fields
    HexletCode::Tag.build('form', form.attributes) do
      fields.reduce('') do |m, field|
        m += field.tag
        m
      end
    end
  end

  def self.html_form_with_labels_by(form)
    fields = form.fields.nil? ? [] : form.fields
    HexletCode::Tag.build('form', form.attributes) do
      fields.reduce('') do |m, field|
        m += label(field.model.name) if field.type == :input && field.type != :submit
        m += field.tag
        m
      end
    end
  end

  def self.html_by(field)
    case field.type
    when :textarea
      textarea_html_by field
    when :input
      input_html_by field
    when :submit
      submit_html_by field
    end
  end

  def self.label(name)
    attributes = { for: name }
    HexletCode::Tag.build('label', attributes) { name.to_s.capitalize }
  end

  def self.textarea_html_by(field)
    attributes = {}
    attributes[:name] = field.model.name
    attributes[:rows] = field.model.rows
    attributes[:cols] = field.model.cols
    HexletCode::Tag.build(field.type, attributes) { field.model.value }
  end

  def self.input_html_by(field)
    attributes = {}
    attributes[:name] = field.model.name
    attributes[:type] = 'text'
    value = field.model.value
    attributes[:value] = value.nil? ? '' : value
    HexletCode::Tag.build(field.type, attributes)
  end

  def self.submit_html_by(field)
    name = field.model.name
    value = name.nil? || name.empty? ? 'Save' : name
    attributes = { type: 'submit', value: value }
    HexletCode::Tag.build(:input, attributes)
  end
end
