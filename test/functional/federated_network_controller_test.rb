require_relative '../test_helper'
require 'federated_networks_controller'
include FederatedNetworkUpdater

class FederatedNetworksControllerTest < ActionController::TestCase
  all_fixtures
  def setup
    @controller = FederatedNetworksController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    FederatedNetwork.destroy_all
    @federated_network = FederatedNetwork.create!(url: 'test.org')
    login_as(create_admin_user(Environment.default))
  end

  should 'list federated networks' do
    get :index
    assert_response :success
    assert_template 'index'
    assert assigns(:networks)
  end

  should 'save federated networks' do
    post :save_networks, environment: { federated_networks: [@federated_network] }
    assert_response 302
    assert_redirected_to controller: 'federated_networks', action: 'index'
    assert Environment.default.federated_networks, @federated_network
    assert_equal 'Federated networks updated successfully.', session[:notice]
  end
end
