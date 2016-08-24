ENV['RACK_ENV'] = 'test'

require_relative '../lib/app'
require_relative './support/request_helpers'

RSpec.configure do |config|
  include Rack::Test::Methods
  include Requests::JsonHelpers

  def app
    Bikeshare
  end
end
