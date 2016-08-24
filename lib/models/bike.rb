require 'sequel'

require_relative 'member'

class Bike < Sequel::Model
  many_to_one :station
  many_to_one :last_member, class: Member
end
