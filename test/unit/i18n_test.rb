# frozen_string_literal: true

require File.expand_path '../test_helper', __dir__

class I18nTest < RedmineHedgedoc::TestCase
  include Redmine::I18n

  def setup
    User.current = nil
  end

  def teardown
    set_language_if_valid 'en'
  end

  def test_valid_languages
    assert_kind_of Array, valid_languages
    assert_kind_of Symbol, valid_languages.first
  end

  def test_locales_validness
    lang_files_count = Rails.root.glob('plugins/redmine_hedgedoc/config/locales/*.yml').size
    assert_equal lang_files_count, 2
    valid_languages.each do |lang|
      assert set_language_if_valid(lang)
      case lang.to_s
      when 'en'
        assert_equal 'New HedgeDoc pad', l(:label_new_hedgedoc_pad)
      when 'de'
        assert_not l(:label_new_hedgedoc_pad) == 'New HedgeDoc pad', lang
      end
    end

    set_language_if_valid 'en'
  end
end
