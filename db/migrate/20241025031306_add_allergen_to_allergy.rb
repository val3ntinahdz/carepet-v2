class AddAllergenToAllergy < ActiveRecord::Migration[7.1]
  def change
    add_reference :allergies, :allergen, null: false, foreign_key: true
  end
end
