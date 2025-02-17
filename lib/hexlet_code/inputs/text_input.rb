# frozen_string_literal: true

module HexletCode
  module Inputs
    class TextInput < BaseInput
      attr_accessor :value, :cols, :rows, :attributes

      DEFAULT_COUNT_OF_ROWS = 40
      DEFAULT_COUNT_OF_COLS = 20
      private_constant :DEFAULT_COUNT_OF_ROWS, :DEFAULT_COUNT_OF_COLS

      def initialize(name, value, attributes = {})
        super()
        @name = name
        @value = value
        @cols = attributes[:cols] ||= DEFAULT_COUNT_OF_COLS
        @rows = attributes[:rows] ||= DEFAULT_COUNT_OF_ROWS
        @attributes = attributes
      end
    end
  end
end
