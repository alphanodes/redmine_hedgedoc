$VERBOSE = nil

if ENV['COVERAGE']
  require 'simplecov'
  require 'simplecov-rcov'

  SimpleCov.formatters = SimpleCov::Formatter::MultiFormatter[SimpleCov::Formatter::HTMLFormatter,
                                                              SimpleCov::Formatter::RcovFormatter]

  SimpleCov.start :rails do
    add_filter 'init.rb'
    root File.expand_path(File.dirname(__FILE__) + '/..')
  end
end

require File.expand_path(File.dirname(__FILE__) + '/../../../test/test_helper')

module RedmineCodimd
  module TestHelper
    def prepare_tests
      Role.where(id: [1, 2]).each do |r|
        r.permissions << :show_codimd_pads
        r.save
      end

      Project.where(id: [1, 2]).each do |project|
        EnabledModule.create(project: project, name: 'codimd')
      end
    end
  end

  class ControllerTest < Redmine::ControllerTest
    include RedmineCodimd::TestHelper
  end

  class TestCase < ActiveSupport::TestCase
    include RedmineCodimd::TestHelper
  end
end
