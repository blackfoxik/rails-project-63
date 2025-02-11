# frozen_string_literal: true

module HexletCode
  autoload :Tag, 'hexlet_code/tag.rb'
  autoload :HTMLPresenter, 'hexlet_code/html_presenter.rb'
  autoload :Form, 'hexlet_code/form.rb'
  autoload :Field, 'hexlet_code/field.rb'

  class Error < StandardError; end

  def self.form_for(object, attributes = {})
    form = Form.new(object, attributes)
    yield form
    HTMLPresenter.html_form_with_labels_by form
  end
end
