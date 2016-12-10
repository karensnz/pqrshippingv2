class AddPackageDestinationFormattedAddressToPickup < ActiveRecord::Migration[5.0]
  def change
    add_column :pickups, :package_destination_formatted_address, :string
  end
end
