require 'sequel'

class Bike < Sequel::Model
  set_allowed_columns :available, :station_id
  many_to_one :station
end
