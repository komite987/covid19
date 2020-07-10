class AddPhoneAndMobileAndAddressAndPhotoToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :phone, :string
    add_column :users, :mobile, :string
    add_column :users, :address, :string
    add_column :users, :photo, :text
  end
end
