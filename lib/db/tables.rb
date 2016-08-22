require 'sequel'

DB = Sequel.sqlite
Sequel::Model.plugin :json_serializer

DB.create_table :bikes do
  primary_key :id
  TrueClass :available
  Integer :station_id
end

DB.create_table :stations do
  primary_key :id
end
