class CreateFederatedNetwork < ActiveRecord::Migration
  def change
    create_table :federated_networks do |t|
      t.string :name
      t.string :url
      t.string :identifier
      t.string :screenshot
      t.string :thumbnail
    end

    add_index :federated_networks, :url, unique: true
  end
end
