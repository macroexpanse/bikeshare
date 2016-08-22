require_relative '../spec_helper'
require_relative '../../lib/models/bike'
require_relative '../../lib/models/station'

describe 'Bike model' do
  let(:station) { Station.create }
  let(:bike) { Bike.create(available: true, station_id: station.id) }

  it 'is available' do
    expect(bike.available).to eq(true)
  end

  it 'has a station' do
    expect(bike.station.id).to eq(station.id)
  end
end
