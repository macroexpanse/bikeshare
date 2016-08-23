require_relative '../spec_helper'
require_relative '../../lib/models/bike'
require_relative '../../lib/models/member'
require_relative '../../lib/models/station'

describe 'Bike model' do
  let(:station) { Station.create }
  let(:member) { Member.create }
  let(:bike) do
    Bike.create(
      available: true,
      station_id: station.id,
      last_member_id: member.id
    )
  end

  it 'is available' do
    expect(bike.available).to eq(true)
  end

  it 'has a station' do
    expect(bike.station.id).to eq(station.id)
  end

  it 'has a last member' do
    expect(bike.last_member.id).to eq(member.id)
  end
end
