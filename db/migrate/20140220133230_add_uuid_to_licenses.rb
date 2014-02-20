class AddUuidToLicenses < ActiveRecord::Migration
  def change
    add_column :licenses, :uuid, :string, limit: 40
    add_index :licenses, :uuid
  end
end
