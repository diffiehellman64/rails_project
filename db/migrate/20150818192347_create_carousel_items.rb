class CreateCarouselItems < ActiveRecord::Migration
  def change
    create_table :carousel_items do |t|
      t.references :carouselable, polymorphic: true, index: true
      t.belongs_to :user
      t.text       :description
      t.boolean    :active
      t.integer    :carouselable_id
      t.string     :carouselable_type

      t.timestamps null: false
    end
  end

  def up
    add_attachment :carousel_items, :piture
  end

  def down
    remove_attachment :carousel_items, :picture
  end

end
