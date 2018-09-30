require File.expand_path('../../test_helper', __FILE__)

class RoutingTest < Redmine::RoutingTest
  test 'codimd' do
    should_route 'GET /codimd' => 'codimds#show'
    should_route 'GET /projects/foo/codimd' => 'codimds#show', project_id: 'foo'
  end
end
