class CreateDevelopers < ActiveRecord::Migration
  def change
    create_table :developers do |t|
      # Why 254? http://www.rfc-editor.org/errata_search.php?rfc=3696&eid=1690
      t.string "email", limit: 254, null: false
      t.string "password_digest", null: false

      t.timestamps
    end
  end
end
