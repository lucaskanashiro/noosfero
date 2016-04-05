class FederatedNetwork < ActiveRecord::Base
  validates_presence_of :url
  validates_uniqueness_of :url

  attr_accessible :name, :url, :thumbnail, :screenshot, :identifier

  has_many :environment_federated_networks, :dependent => :destroy
  has_many :environments, :through => :environment_federated_networks
end
