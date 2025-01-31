require_relative 'html_presenter'
require_relative 'field'
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
end
