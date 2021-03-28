# frozen_string_literal: true

require File.expand_path '../test_helper', __dir__

class RoutingTest < Redmine::RoutingTest
  test 'hedgedoc' do
    should_route 'GET /hedgedoc' => 'hedgedocs#show'
    should_route 'GET /projects/foo/hedgedoc' => 'hedgedocs#show', project_id: 'foo'
  end
end
