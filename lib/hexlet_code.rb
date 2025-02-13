# frozen_string_literal: true

module HexletCode
  autoload :FormBuilder, 'hexlet_code/form_builder.rb'

  class Error < StandardError; end

  def self.form_for(object, attributes = {}, &)
    form_builder = FormBuilder.new(object, attributes, &)
    FormRenderer.html_form_by(form_builder.form)
  end
end
