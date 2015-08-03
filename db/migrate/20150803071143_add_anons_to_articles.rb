class AddAnonsToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :anons, :text
  end
end
