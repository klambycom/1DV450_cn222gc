class CreateLicenses < ActiveRecord::Migration
  def change
    create_table :licenses do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.string :url, null: false

      t.timestamps
    end
  end
end
