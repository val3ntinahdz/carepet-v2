class CreateAppointments < ActiveRecord::Migration[7.1]
  def change
    create_table :appointments do |t|
      t.date :date
      t.time :time
      t.string :reason
      t.string :comments
      t.references :pet, null: false, foreign_key: true
      t.references :service, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
