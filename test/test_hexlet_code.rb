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
    expected = '<form action="#" method="post"></form>'
    HexletCode.form_for(@user) do |f|
      assert f.tag == expected
    end
  end

  def test_form_by_struct_and_attribute_class
    expected = '<form action="#" method="post" class="hexlet-form"></form>'
    HexletCode.form_for(@user, class: 'hexlet-form') do |f|
      assert f.tag == expected
    end
  end

  def test_form_by_struct_and_attribute_url
    expected = '<form action="/profile" method="post" class="hexlet-form"></form>'
    HexletCode.form_for(@user, url: '/profile', class: 'hexlet-form') do |f|
      assert f.tag == expected
    end
  end
end
