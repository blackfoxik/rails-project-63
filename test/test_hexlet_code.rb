# frozen_string_literal: true

require 'test_helper'

class TestHexletCode < Minitest::Test
  User = Struct.new(:name, :job, keyword_init: true)
  def setup
    @user = User.new name: 'rob'
  end

  def test_that_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  def test_form_by_struct
    file_name = "#{__method__}.html"
    expected = File.read(File.join(__dir__, file_name))
    res = HexletCode.form_for(@user) {}

    assert res == expected
  end

  def test_form_by_struct_and_attribute_class
    file_name = "#{__method__}.html"
    expected = File.read(File.join(__dir__, file_name))
    res = HexletCode.form_for(@user, class: 'hexlet-form') {}

    assert res == expected
  end

  def test_form_by_struct_and_attribute_url
    file_name = "#{__method__}.html"
    expected = File.read(File.join(__dir__, file_name))
    res = HexletCode.form_for(@user, url: '/profile', class: 'hexlet-form') {}

    assert res == expected
  end

  def test_object_has_input
    file_name = "#{__method__}.html"
    expected = File.read(File.join(__dir__, file_name))

    res = HexletCode.form_for(@user) do |f|
      f.input :name
    end

    assert res == expected
  end

  def test_object_has_textarea
    file_name = "#{__method__}.html"
    expected = File.read(File.join(__dir__, file_name))
    res = HexletCode.form_for(@user) do |f|
      assert(f.input(:job, as: :text))
    end

    assert res == expected
  end

  def test_object_has_textarea_with_overriden_attributes
    file_name = "#{__method__}.html"
    expected = File.read(File.join(__dir__, file_name))
    res = HexletCode.form_for(@user) do |f|
      f.input(:job, as: :text, rows: 50, cols: 50)
    end

    assert res == expected
  end

  def test_object_has_not_field
    HexletCode.form_for(@user) do |_f|
      # assert(f.input :age).class == NoMethodError
      # TODO: - need to reimplement with NoMethodError
      # f.input(:age)
      assert(true)
      # assert true
    end
  end
end
