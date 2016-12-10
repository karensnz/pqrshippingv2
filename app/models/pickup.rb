class Pickup < ApplicationRecord
  # Direct associations

  belongs_to :user

  # Indirect associations

  # Validations

  validates :date, :uniqueness => { :scope => [:user_id] }

  validates :date, :presence => true

  validates :image_upload, :presence => true

  validates :package_destination, :presence => true

  validates :user_id, :presence => true

end
