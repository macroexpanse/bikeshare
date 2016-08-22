require 'sequel'

class Bike < Sequel::Model
  set_allowed_columns :available
end
