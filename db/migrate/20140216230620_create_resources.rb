class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.belongs_to :resource_type
      t.belongs_to :license
      t.belongs_to :user

      t.string :name, null: false
      t.string :url, default: "", null: false
      t.string :description, default: "", null: false

      t.timestamps
    end
  end
end
