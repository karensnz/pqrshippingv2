class Pickup < ApplicationRecord
  # Direct associations

  # Indirect associations

  # Validations

  validates :package_destination, :presence => true

  validates :user_id, :presence => true

end
