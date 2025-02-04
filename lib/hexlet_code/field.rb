# frozen_string_literal: true

module HexletCode
  class Form
    class Field
      TextareaModel = Struct.new(:name, :rows, :cols, :value, :class_attribute)
      PlainInputModel = Struct.new(:name, :value, :class_attribute)
      SubmitModel = Struct.new(:name)

      attr_accessor :type, :model, :need_label

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
