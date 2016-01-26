class AddSaleToCars < ActiveRecord::Migration
  def change
    add_column :cars, :sale, :boolean, default: false
  end
end
