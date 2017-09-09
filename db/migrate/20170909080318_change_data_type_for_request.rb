class ChangeDataTypeForRequest < ActiveRecord::Migration[5.1]
  def change
    change_column :requests, :status, 'integer USING CAST(status AS integer)', :default => 0
  end
end
