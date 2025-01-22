module HexletCode
  class Form
    attr_accessor :tag
  end

  def self.form_for(_object, attributes = {}, &_block)
    attributes[:action] = attributes.delete(:url) if attributes.key?(:url)
    default_form_attributes = { action: '#', method: 'post' }
    default_form_attributes.merge!(attributes)
    form = Form.new
    form.tag = HexletCode::Tag.build('form', default_form_attributes) {}
    yield form
  end
end
