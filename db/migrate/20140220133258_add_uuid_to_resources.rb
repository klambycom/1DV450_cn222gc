class AddUuidToResources < ActiveRecord::Migration
  def change
    add_column :resources, :uuid, :string, limit: 40
    add_index :resources, :uuid
  end
end
