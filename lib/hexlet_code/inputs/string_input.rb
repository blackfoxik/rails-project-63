# frozen_string_literal: true

module HexletCode
  module Inputs
    class StringInput < BaseInput
      attr_accessor :value, :attributes

      def initialize(name, value, attributes = {})
        super()
        @name = name
        @value = value
        @attributes = attributes
      end
    end
  end
end
