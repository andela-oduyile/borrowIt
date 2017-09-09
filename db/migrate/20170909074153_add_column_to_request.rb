class AddColumnToRequest < ActiveRecord::Migration[5.1]
  def change
    add_column :requests, :item, :string
    add_column :requests, :return_state, :boolean, :default => false
    add_column :requests, :returned_at, :datetime
    add_column :requests, :owner_comment, :string
  end
end
