require 'spec_helper'

require_relative '../../lib/models/station'

describe 'Station model' do
  let(:station) { Station.create(capacity: 10) }
  let!(:bikes) { [ Bike.create(station_id: station.id) ] }

  it 'has a capacity' do
    expect(station.capacity).to eq(10)
  end

  it 'has a default capacity of 20' do
    expect(Station.create.capacity).to eq(20)
  end

  it 'has bikes' do
    expect(station.bikes).to eq(bikes)
  end
end
