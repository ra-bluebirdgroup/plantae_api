class CreateUserPlantComments < ActiveRecord::Migration[6.0]
  def change
    create_table :user_plant_comments do |t|
      t.integer :user_id
      t.integer :plant_id
      t.text :content

      t.timestamps
    end
  end
end
