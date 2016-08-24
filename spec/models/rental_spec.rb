require 'spec_helper'

require_relative '../../lib/models/bike'
require_relative '../../lib/models/member'
require_relative '../../lib/models/rental'
require_relative '../../lib/models/station'

describe 'Rental model' do
  let(:bike) { Bike.create }
  let(:member) { Member.create }
  let(:rent_station) { Station.create }
  let(:return_station) { Station.create }
  let(:rental) do
    Rental.create(
      bike_id: bike.id,
      member_id: member.id,
      rent_station_id: rent_station.id,
      return_station_id: return_station.id
    )
  end

  it 'has a bike' do
    expect(rental.bike).to eq(bike)
  end

  it 'has a rent_station' do
    expect(rental.rent_station).to eq(rent_station)
  end

  it 'has a return_station' do
    expect(rental.return_station).to eq(return_station)
  end

  it 'has a member' do
    expect(rental.member).to eq(member)
  end
end
