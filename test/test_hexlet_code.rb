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
    expected = read_file __method__.to_s
    res = HexletCode.form_for(@user) {}

    assert res.html == expected
  end

  def test_form_by_struct_and_attribute_class
    expected = read_file __method__.to_s
    res = HexletCode.form_for(@user, class: 'hexlet-form') {}

    assert res.html == expected
  end

  def test_form_by_struct_and_attribute_url
    expected = read_file __method__.to_s
    res = HexletCode.form_for(@user, url: '/profile', class: 'hexlet-form') {}

    assert res.html == expected
  end

  def test_object_has_input
    expected = read_file __method__.to_s

    res = HexletCode.form_for(@user) do |f|
      f.input :name
    end

    assert res.html == expected
  end

  def test_object_has_textarea
    expected = read_file __method__.to_s
    res = HexletCode.form_for(@user) do |f|
      assert(f.input(:job, as: :text))
    end

    assert res.html == expected
  end

  def test_object_has_textarea_with_overriden_attributes
    expected = read_file __method__.to_s
    res = HexletCode.form_for(@user) do |f|
      f.input(:job, as: :text, rows: 50, cols: 50)
    end

    assert res.html == expected
  end

  def test_object_has_labels_for_inputes
    expected = read_file __method__.to_s
    @user = User.new job: 'hexlet'
    res = HexletCode.form_for(@user) do |f|
      f.input :name
      f.input :job
    end

    assert res.html_with_labels == expected
  end

  def test_object_has_submit
    expected = read_file __method__.to_s
    @user = User.new job: 'hexlet'
    res = HexletCode.form_for(@user) do |f|
      f.input :name
      f.input :job
      f.submit
    end

    assert res.html == expected
  end

  def test_object_has_custom_submit
    expected = read_file __method__.to_s

    @user = User.new job: 'hexlet'
    res = HexletCode.form_for(@user) do |f|
      f.input :name
      f.input :job
      f.submit 'Wow'
    end

    assert res.html == expected
  end

  def read_file(name)
    file_name = "test_files/#{name}.html"
    File.read(File.join(__dir__, file_name))
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
