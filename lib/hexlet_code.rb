# frozen_string_literal: true

module HexletCode
  autoload :Tag, 'hexlet_code/tag.rb'
  autoload :HTMLPresenter, 'hexlet_code/html_presenter.rb'
  autoload :Form, 'hexlet_code/form.rb'
  autoload :Field, 'hexlet_code/field.rb'

  class Error < StandardError; end

  def self.form_for(model, attributes = {})
    form = Form.new(model)
    form.attributes = attributes
    yield form
    form.html_with_labels
  end
end
