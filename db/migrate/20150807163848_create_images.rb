class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.belongs_to :gallery
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end
