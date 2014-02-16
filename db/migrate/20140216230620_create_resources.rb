class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.references :resource_type
      t.references :license
      t.references :user

      t.string :name, null: false
      t.string :url, default: "", null: false
      t.string :description, default: "", null: false

      t.timestamps
    end
  end
end
