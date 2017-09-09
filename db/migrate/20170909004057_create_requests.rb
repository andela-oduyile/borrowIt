class CreateRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|
      t.references :requestedBy
      t.references :ownedBy
      t.string :status

      t.timestamps
    end
  end
end
