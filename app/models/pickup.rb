class Pickup < ApplicationRecord
  # Direct associations

  # Indirect associations

  # Validations

  validates :image_upload, :presence => true

  validates :package_destination, :presence => true

  validates :user_id, :presence => true

end
