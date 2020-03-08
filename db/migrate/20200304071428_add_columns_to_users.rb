class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :prefecture_code, :string
    add_column :users, :postal_code, :string
    add_column :users, :city, :string
    add_column :users, :building, :string

    add_column :users, :full_address, :string
    add_column :users, :profile_image_id, :string
  end
end
