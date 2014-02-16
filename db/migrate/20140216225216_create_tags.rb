class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :tag, limit: 50, null: false

      t.timestamps
    end
  end
end
