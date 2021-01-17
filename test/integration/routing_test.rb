require File.expand_path '../../test_helper', __FILE__

class RoutingTest < Redmine::RoutingTest
  test 'hedgedoc' do
    should_route 'GET /hedgedoc' => 'hedgedocs#show'
    should_route 'GET /projects/foo/hedgedoc' => 'hedgedocs#show', project_id: 'foo'
  end
end
