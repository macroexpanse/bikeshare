require 'sequel'

DB = Sequel.sqlite
Sequel::Model.plugin :json_serializer
Sequel::Model.strict_param_setting = false

DB.create_table :bikes do
  primary_key :id
  TrueClass :available
  Integer :last_member_id
  Integer :station_id
end

DB.create_table :members do
  primary_key :id
end

DB.create_table :rentals do
  primary_key :id
  Integer :bike_id
  Integer :member_id
  Integer :rent_station_id
  Integer :return_station_id
end

DB.create_table :stations do
  primary_key :id
  Integer :capacity, default: 20
end
