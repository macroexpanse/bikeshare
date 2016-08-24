require 'sequel'

require_relative 'station'

class Rental < Sequel::Model
  many_to_one :bike
  many_to_one :member
  many_to_one :rent_station, class: Station
  many_to_one :return_station, class: Station
end
