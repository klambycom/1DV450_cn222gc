class AddUuidToResourceTypes < ActiveRecord::Migration
  def change
    add_column :resource_types, :uuid, :string, limit: 40
    add_index :resource_types, :uuid
  end
end
