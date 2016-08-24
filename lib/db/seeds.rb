require 'faker'

require_relative '../models/bike'
require_relative '../models/member'
require_relative '../models/rental'
require_relative '../models/station'

1000.times do
  Member.create(name: Faker::GameOfThrones.character)
end

stations = []
20.times do
  stations << Station.create(name: Faker::GameOfThrones.city)
end

200.times do
  Bike.create(station_id: stations.sample.id)
end
