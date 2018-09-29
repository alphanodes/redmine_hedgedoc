require File.expand_path('../../test_helper', __FILE__)

class RoutingTest < Redmine::RoutingTest
  test 'terms' do
    should_route 'GET /codimds' => 'codimds#show'
  end
end
