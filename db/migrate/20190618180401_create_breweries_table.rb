class CreateBreweriesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :breweries do |t|
      t.string :name
    end
  end
end
