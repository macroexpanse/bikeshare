require 'spec_helper'

require_relative '../../lib/models/station'

describe 'Station model' do
  let(:station) { Station.create(max_capacity: 10) }
  let!(:bikes) { [ Bike.create(station_id: station.id) ] }

  it 'has a max_capacity' do
    expect(station.max_capacity).to eq(10)
  end

  it 'has a default max_capacity of 20' do
    expect(Station.create.max_capacity).to eq(20)
  end

  it 'has bikes' do
    expect(station.bikes).to eq(bikes)
  end
end
