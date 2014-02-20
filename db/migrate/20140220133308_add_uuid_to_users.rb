class AddUuidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :uuid, :string, limit: 40
    add_index :users, :uuid
  end
end
