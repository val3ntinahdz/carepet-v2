class AddAddressAndPhoneToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :address, :string
    add_column :users, :phone_number, :text
  end
end
