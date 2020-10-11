class CreatePlants < ActiveRecord::Migration[6.0]
  def change
    create_table :plants do |t|
      t.text :scientific_name
      t.timestamps
    end
  end
end
