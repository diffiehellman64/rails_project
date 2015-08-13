class CreateChiefs < ActiveRecord::Migration
  def change
    create_table :chiefs do |t|

      t.string :lats_name
      t.string :first_name
      t.string :middle_name

      t.string :rank
      t.string :position

      t.timestamps null: false
    end
  end
end
