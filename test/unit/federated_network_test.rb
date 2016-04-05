require_relative '../test_helper'

include FederatedNetworkUpdater

class FederatedNetworkTest < ActiveSupport::TestCase
  def setup
    FederatedNetwork.destroy_all
  end

  should 'federated network should have unique url' do
    f1 = FederatedNetwork.create(url: 'http://www.test.com')
    assert(f1.valid?, 'not a valid federated network on f1')

    f2 = FederatedNetwork.create(url: f1.url)
    assert_not(f2.valid?, 'f2 should not be a valid federated network')
  end

  should 'validades presence of url on federated network' do
    f = FederatedNetwork.create(name: 'testname')
    assert_not(f.valid?, 'should not be a valid federated network')
  end
end
