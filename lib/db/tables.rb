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

DB.create_table :stations do
  primary_key :id
end
