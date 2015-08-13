class CreateDirectors < ActiveRecord::Migration
  def change
    create_table :directors do |t|
      t.string :lats_name
      t.string :lats_name_case
      t.string :first_name
      t.string :middle_name
      
      t.string :address_street
      t.string :address_house
      t.string :address_town
      t.string :address_index
     
      t.string :rank
      t.string :rank_case
      t.string :position
      t.string :position_case

      t.timestamps null: false
    end
  end
end
