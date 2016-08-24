require 'sequel'

require_relative 'rental'

class Member < Sequel::Model
  one_to_many :rentals

  def returned_rentals
    Rental.where(member_id: id).exclude(return_station_id: nil)
  end

  def rides
    returned_rentals.count
  end

  def current_ride
    Rental.find(member_id: id, return_station_id: nil)
  end
end
