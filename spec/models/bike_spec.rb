require_relative '../spec_helper'
require_relative '../../lib/models/bike'
require_relative '../../lib/models/member'
require_relative '../../lib/models/station'

describe 'Bike model' do
  let(:station) { Station.create }
  let(:member) { Member.create }
  let(:bike) do
    Bike.create(
      station_id: station.id,
      last_member_id: member.id
    )
  end

  it 'is available by default' do
    expect(bike.available).to eq(true)
  end

  it 'has a station' do
    expect(bike.station).to eq(station)
  end

  it 'has a last member' do
    expect(bike.last_member).to eq(member)
  end
end
