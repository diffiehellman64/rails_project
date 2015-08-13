class CreateLetters < ActiveRecord::Migration
  def change
    create_table :letters do |t|
      t.text :text
      t.attachment :incomming_letter
      t.string :number_outgoing_out
      t.string :number_incomming_out
      t.string :number_outgoing
      t.string :number_incomming
      t.date   :date_incomming_out
      t.date   :date_outgoing_out
      t.date   :date_incomming
      t.date   :date_outgoing
      t.belongs_to :deirector      
 
      t.timestamps null: false
    end

  end
end
