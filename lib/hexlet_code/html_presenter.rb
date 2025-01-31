module HTMLPresenter
  def self.html_form_by(form)
    fields = form.fields.nil? ? [] : form.fields
    attributes = default_form_attributes_with form.attributes
    HexletCode::Tag.build('form', attributes) do
      fields.reduce('') do |m, field|
        m += field.tag
        m
      end
    end
  end

  def self.html_form_with_labels_by(form)
    fields = form.fields.nil? ? [] : form.fields
    attributes = default_form_attributes_with form.attributes
    HexletCode::Tag.build('form', attributes) do
      fields.reduce('') do |m, field|
        m += label(field.model.name) if field.type == :input && field.type != :submit
        m += field.tag
        m
      end
    end
  end

  def self.default_form_attributes_with(attributes = {})
    action = attributes[:url].nil? ? '#' : attributes[:url]
    default_form_attributes = { action: action, method: 'post' }
    default_form_attributes.merge!(attributes)
    default_form_attributes.delete(:url) if default_form_attributes.key?(:url)
    default_form_attributes
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
