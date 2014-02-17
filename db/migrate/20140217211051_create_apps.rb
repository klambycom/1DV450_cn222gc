class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.string :name, limit: 50, null: false
      t.string :url, default: "", null: false
      t.string :description, default: "", null: false
      t.boolean :public, default: false
      t.string :access_token, null: false

      t.timestamps
    end
  end
end
