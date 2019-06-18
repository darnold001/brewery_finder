class CreateFavoriteBreweriesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :favorite_breweries do |t|
      t.references :user, foreign_key: true
      t.references :brewery, foreign_key: true
    end
  end
end
