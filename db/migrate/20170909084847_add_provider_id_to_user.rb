class AddProviderIdToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :provider_id, :integer
  end
end
