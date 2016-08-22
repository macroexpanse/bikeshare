require 'sequel'

DB = Sequel.sqlite
Sequel::Model.plugin :json_serializer

DB.create_table :bikes do
  primary_key :id
end
