# frozen_string_literal: true

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
      return textarea(field_name, value, attributes) if attributes[:as] == :text

      plain_input(field_name, value, attributes)
    end

    def submit(button_name = nil)
      @form_body[:submit][:options] = { button_name: button_name }
    end

    private

    def plain_input(field_name, value, attributes = {})
      input = Inputs::StringInput.new(field_name, value, attributes)
      @form_body[:inputs].push(input)
      FormRenderer.html_input_by(input)
    end

    def textarea(field_name, value, attributes = {})
      input = Inputs::TextInput.new(field_name, value, attributes)
      @form_body[:inputs].push(input)
      FormRenderer.html_input_by(input)
    end
  end
end
