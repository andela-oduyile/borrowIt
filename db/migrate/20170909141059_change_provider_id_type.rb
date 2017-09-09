class ChangeProviderIdType < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :provider_id, :string
  end
end
