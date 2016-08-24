require 'spec_helper'

require_relative '../../lib/models/member'
require_relative '../../lib/models/rental'

describe 'Member model' do
  let(:member) { Member.create(name: 'Testy Testerson') }

  it 'has rentals' do
    rental = Rental.create(member_id: member.id)

    expect(member.rentals).to eq([rental])
  end

  it 'has returned rentals' do
    rental = Rental.create(member_id: member.id)
    returned_rental = Rental.create(member_id: member.id, return_station_id: Station.create.id)

    expect(member.returned_rentals.all).to eq([returned_rental])
  end

  it 'has an account status defaulted to enabled' do
    expect(member.account).to eq('enabled')
  end

  it 'has a name' do
    expect(member.name).to eq('Testy Testerson')
  end

  describe '#rides' do
    it 'has 0 if there are no rentals' do
      expect(member.rides).to eq(0)
    end

    it 'has 0 if the only rental has not been returned' do
      Rental.create(member_id: member.id)

      expect(member.rides).to eq(0)
    end

    it 'counts number of returned rentals' do
      station = Station.create
      2.times do
        Rental.create(member_id: member.id, return_station_id: station.id)
      end
      Rental.create(member_id: member.id)

      expect(member.rides).to eq(2)
    end
  end

  describe "#current_ride" do
    it 'has a current ride if a rental has not been returned' do
      current_ride = Rental.create(member_id: member.id, rent_station_id: Station.create.id)

      expect(member.current_ride).to eq(current_ride)
    end

    it 'does not have a current ride if no rentals' do
      expect(member.current_ride).to eq(nil)
    end

    it 'does not have a current ride if all rentals have been returned' do
      station = Station.create
      current_ride = Rental.create(
        member_id: member.id,
        rent_station_id: station.id,
        return_station_id: station.id
      )

      expect(member.current_ride).to eq(nil)
    end
  end
end
