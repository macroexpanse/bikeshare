require 'sequel'

class Station < Sequel::Model
  one_to_many :bikes
end
