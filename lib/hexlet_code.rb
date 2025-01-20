# frozen_string_literal: true

require_relative "hexlet_code/version"

require_relative "hexlet_code/tag"
# autoload HexletCode, "./hexlet_code/tag.rb"

module HexletCode
  #autoload :Tag, "./hexlet_code/tag.rb"
  class Error < StandardError; end
  # Your code goes here...
  puts Tag.build("img", src: "path/to/image")
  puts Tag.build("input", type: "submit", value: "Save")
  puts Tag.build("br")
  puts Tag.build("label", for: "email") { "Email" }
end
