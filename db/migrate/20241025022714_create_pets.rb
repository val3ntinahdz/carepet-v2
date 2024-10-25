class CreatePets < ActiveRecord::Migration[7.1]
  def change
    create_table :pets do |t|
      t.string :name
      t.string :pet_type
      t.string :breed
      t.date :birthday_date
      t.string :gender
      t.string :color
      t.integer :weight
      t.integer :height
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
