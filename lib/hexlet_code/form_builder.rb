# frozen_string_literal: true

module HexletCode
  autoload :Tag, 'hexlet_code/tag.rb'
  autoload :FormRenderer, 'hexlet_code/form_renderer.rb'
  autoload :Form, 'hexlet_code/form.rb'
  autoload :Inputs, 'hexlet_code/inputs'

  class FormBuilder
    attr_accessor :form

    def initialize(object, attributes = {}, &body_creation_block)
      @form = Form.new(object, attributes)
      body_creation_block.call(@form)
    end
  end
end
