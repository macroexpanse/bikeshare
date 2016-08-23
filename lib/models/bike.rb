require 'sequel'

require_relative './member'

class Bike < Sequel::Model
  set_allowed_columns :available, :last_member_id, :station_id
  many_to_one :station
  many_to_one :last_member, class: Member
end
