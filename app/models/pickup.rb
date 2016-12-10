class Pickup < ApplicationRecord
  before_save :geocode_package_destination

  def geocode_package_destination
    if self.package_destination.present?
      url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{URI.encode(self.package_destination)}"

      raw_data = open(url).read

      parsed_data = JSON.parse(raw_data)

      if parsed_data["results"].present?
        self.package_destination_latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]

        self.package_destination_longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

        self.package_destination_formatted_address = parsed_data["results"][0]["formatted_address"]
      end
    end
  end
  mount_uploader :image_upload, ImageUploadUploader

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
