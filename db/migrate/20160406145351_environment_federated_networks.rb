class EnvironmentFederatedNetworks < ActiveRecord::Migration
  def self.up
    create_table :environment_federated_networks do |t|
      t.references :environment, index: true
      t.references :federated_network, index: true
    end
    add_index :environment_federated_networks, 
                [:environment_id, :federated_network_id], 
                :unique => true, :name => 'index_environment_federated_network'
 
  end

  def self.down
    drop_table :environment_federated_networks
  end
end
