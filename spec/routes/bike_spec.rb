require_relative '../spec_helper'
require_relative '../../lib/models/bike'
require_relative '../../lib/models/station'

describe 'Bike routes' do
  describe 'GET /bikes/:id' do
    let(:station) { Station.create }
    let(:bike) { Bike.create(station_id: station.id) }

    before do
      get "/bikes/#{bike.id}"
    end

    it 'is successful' do
      expect(last_response.status).to eq(200)
    end

    it 'gets bike by id' do
      expect(JSON.parse(last_response.body)['id']).to eq(bike.id)
    end

    it 'includes station' do
      expect(JSON.parse(last_response.body)['station_id']).to eq(station.id)
    end
  end
end
