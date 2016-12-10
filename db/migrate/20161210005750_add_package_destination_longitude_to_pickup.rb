class AddPackageDestinationLongitudeToPickup < ActiveRecord::Migration[5.0]
  def change
    add_column :pickups, :package_destination_longitude, :float
  end
end
