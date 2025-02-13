# frozen_string_literal: true

module HexletCode
  module FormRenderer
    def self.html_form_by(form)
      attributes = default_form_attributes_with form.form_body[:form_options]
      body = html_body_for(form)

      HexletCode::Tag.build('form', attributes) do
        body
      end
    end

    def self.label(name)
      attributes = { for: name }
      HexletCode::Tag.build('label', attributes) { name.to_s.capitalize }
    end

    def self.html_input_by(input)
      if input.instance_of?(HexletCode::Inputs::StringInput)
        attributes = input_attributes_by(input)
        HexletCode::Tag.build('input', attributes)
      else
        attributes = textarea_attributes_by(input)
        HexletCode::Tag.build('textarea', attributes) { input.value }
      end
    end

    private_class_method def self.html_body_for(form)
      inputs = form.form_body[:inputs]
      body = inputs.reduce('') do |m, input|
        m += label(input.name)
        m += html_input_by(input)
        m
      end
      body += html_submit_by(form) unless form.form_body[:submit][:options].nil?
      body
    end

    private_class_method def self.html_submit_by(form)
      value = form.form_body[:submit][:options][:button_name] ||= 'Save'
      attributes = { type: 'submit', value: value }
      HexletCode::Tag.build(:input, attributes)
    end

    private_class_method def self.default_form_attributes_with(attributes = {})
      action = attributes[:url].nil? ? '#' : attributes[:url]
      default_form_attributes = { action: action, method: 'post' }
      default_form_attributes.merge!(attributes.except(:url))
      default_form_attributes
    end

    private_class_method def self.input_attributes_by(input)
      attributes = {}
      attributes[:name] = input.name
      attributes[:type] = 'text'
      value = input.value
      attributes[:value] = value.nil? ? '' : value
      attributes.merge!(input.attributes.except(:label))
      attributes
    end

    private_class_method def self.textarea_attributes_by(input)
      attributes = {}
      attributes[:name] = input.name
      attributes[:rows] = input.rows
      attributes[:cols] = input.cols
      attributes.merge!(input.attributes.except(:label, :as))
      attributes
    end
  end
end
