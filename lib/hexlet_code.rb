# frozen_string_literal: true

# require_relative 'hexlet_code/version'
module HexletCode
  autoload :Tag, 'lib/hexlet_code/tag.rb'
  autoload :HTMLPresenter, 'lib/hexlet_code/html_presenter.rb'
  autoload :Form, 'lib/hexlet_code/form.rb'
  autoload :Field, 'lib/hexlet_code/field.rb'

  class Error < StandardError; end

  def self.form_for(model, attributes = {})
    form = Form.new(model)
    form.attributes = attributes
    yield form
    form
  end
end
