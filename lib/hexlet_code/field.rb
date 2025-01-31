module HexletCode
  class Form
    class Field
      TextareaModel = Struct.new(:name, :rows, :cols, :value)
      PlainInputModel = Struct.new(:name, :value)
      SubmitModel = Struct.new(:name)

      attr_accessor :type, :model

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
