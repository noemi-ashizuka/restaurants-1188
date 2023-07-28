class AddAddressToRestaurants < ActiveRecord::Migration[7.0]
  def change
    add_column :restaurants, :address, :string
    # add_column :restaurants, :address, :string
    # remove_column :restaurants, :address, :string
    # add_reference :restaurants, :user, foreign_key: true
    # remove_reference :restaurants, :user, foreign_key: true
  end
end
