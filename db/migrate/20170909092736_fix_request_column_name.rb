class FixRequestColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :requests, :requestedBy_id, :requested_by_id
    rename_column :requests, :ownedBy_id, :owned_by_id
  end
end
