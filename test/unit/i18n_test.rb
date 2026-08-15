# frozen_string_literal: true

require File.expand_path '../../test_helper', __FILE__

class I18nTest < RedmineHedgedoc::TestCase
  Additionals.define_i18n_tests self,
                                plugin: 'redmine_hedgedoc',
                                control_string: :label_new_hedgedoc_pad,
                                control_english: 'New HedgeDoc pad'
end
