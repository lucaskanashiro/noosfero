class FederatedNetworksController < AdminController

  def index
    @networks = FederatedNetwork.all
  end

  def save_networks
    ids = []
    params[:environment][:federated_networks].each do |federated_network_id|
      unless federated_network_id.empty?
        ids << federated_network_id
      end
    end
    environment.federated_networks = ids.map{ |id| FederatedNetwork.find(id) }
    redirect_to :action => :index
    session[:notice] = _('Federated networks updated successfully.')
  end
end
