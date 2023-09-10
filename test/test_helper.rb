# frozen_string_literal: true

$VERBOSE = nil

if ENV['COVERAGE']
  require 'simplecov'
  require 'simplecov-rcov'

  SimpleCov.formatters = SimpleCov::Formatter::MultiFormatter[SimpleCov::Formatter::HTMLFormatter,
                                                              SimpleCov::Formatter::RcovFormatter]

  SimpleCov.start :rails do
    add_filter 'init.rb'
    root File.expand_path "#{File.dirname __FILE__}/.."
  end
end

require File.expand_path "#{File.dirname __FILE__}/../../../test/test_helper"

module RedmineHedgedoc
  module TestHelper
    def prepare_tests
      Role.where(id: [1, 2]).find_each do |r|
        r.permissions << :show_hedgedoc_pads
        r.save
      end

      Project.where(id: [1, 2]).find_each do |project|
        EnabledModule.create project: project, name: 'hedgedoc'
      end
    end
  end

  class ControllerTest < Redmine::ControllerTest
    include RedmineHedgedoc::TestHelper
  end

  class TestCase < ActiveSupport::TestCase
    include RedmineHedgedoc::TestHelper
  end
end
