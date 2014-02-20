class AddUuidToTags < ActiveRecord::Migration
  def change
    add_column :tags, :uuid, :string, limit: 40
    add_index :tags, :uuid
  end
end
