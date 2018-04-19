class Profile < ApplicationRecord
  belongs_to :user
  validates(
    :first_name, 
    :last_name,
    :street_address,
    :city,
    :state,
    :postcode,
    :country_code,
    presence: true)

  geocoded_by :full_address
  after_validation :geocode

  def full_address
    # e.g. "120 Spencer st, Melbourne, Victoria, 3000, AU"
    "#{street_address}, #{city}, #{state}, #{postcode}, #{country_code}"
  end

  def full_name
    "#{first_name} #{last_name}"
  end

end