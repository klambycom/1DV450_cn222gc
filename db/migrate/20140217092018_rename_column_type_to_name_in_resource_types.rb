class RenameColumnTypeToNameInResourceTypes < ActiveRecord::Migration
  def change
    rename_column :resource_types, :type, :name
  end
end
