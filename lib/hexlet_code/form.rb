# frozen_string_literal: true

require 'active_support/inflector'

module HexletCode
  class Form
    attr_accessor :object, :form_body

    def initialize(object, attributes = {})
      @object = object
      @form_body = {
        inputs: [],
        submit: { options: nil },
        form_options: attributes
      }
    end

    def input(field_name, attributes = {})
      value = @object.public_send field_name
      input_type = attributes[:as] || 'string'
      klass_name = "HexletCode::Inputs::#{input_type.capitalize}Input"
      input = klass_name.constantize.new(field_name, value, attributes)
      @form_body[:inputs].push(input)

      FormRenderer.html_input_by(input)
    end

    def submit(button_name = nil)
      @form_body[:submit][:options] = { button_name: button_name }
    end
  end
end
