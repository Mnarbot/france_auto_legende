class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.string :brand
      t.string :model
      t.integer :year
      t.string :photo
      t.text :description

      t.timestamps null: false
    end
  end
end
