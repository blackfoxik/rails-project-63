module HexletCode
  def self.form_for(object, attributes = {})
    attributes[:action] = attributes.delete(:url) if attributes.key?(:url)
    default_form_attributes = { action: '#', method: 'post' }
    default_form_attributes.merge!(attributes)
    HexletCode::Tag.build("form", default_form_attributes) + '</form>'
  end
end
