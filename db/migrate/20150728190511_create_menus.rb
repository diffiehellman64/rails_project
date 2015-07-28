class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string   :name
      t.string   :title
      t.string   :url
      t.integer  :paret_id
      t.integer  :weight
      t.boolean  :active
      t.timestamps null: false
    end
  end
end
