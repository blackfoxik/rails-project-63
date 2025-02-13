# frozen_string_literal: true

module HexletCode
  module Inputs
    class TextInput < BaseInput
      attr_accessor :value, :cols, :rows, :attributes

      def initialize(name, value, attributes = {})
        super()
        @name = name
        @value = value
        @cols = attributes[:cols] ||= 20
        @rows = attributes[:rows] ||= 40
        @attributes = attributes
      end
    end
  end
end
