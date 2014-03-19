class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :firstname, :string, :default => "", :null => false
    add_column :users, :lastname, :string, :default => "", :null => false
  end
end
