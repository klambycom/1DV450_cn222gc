class CreateDocs < ActiveRecord::Migration
  def change
    create_table :docs do |t|
      t.string :title, limit: 100, null: false
      t.text :content, null: false
      t.string :method, default: "", limit: 10, null: false

      t.timestamps
    end
  end
end
