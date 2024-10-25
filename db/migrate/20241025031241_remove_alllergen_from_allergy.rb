class RemoveAlllergenFromAllergy < ActiveRecord::Migration[7.1]
  def change
    remove_reference :allergies, :allergen, null: false, foreign_key: true
  end
end
