ENV['RACK_ENV'] = 'test'

require_relative '../lib/app'

RSpec.configure do |config|
  include Rack::Test::Methods

  def app
    Bikeshare
  end
end
