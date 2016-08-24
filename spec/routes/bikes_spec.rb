require_relative '../spec_helper'
require_relative '../../lib/models/bike'
require_relative '../../lib/models/station'

describe 'Bike routes' do
  let(:station) { Station.create }
  let(:member) { Member.create }
  let(:bike) do
    Bike.create(
      available: true,
      station_id: station.id,
      last_member_id: member.id
    )
  end

  describe 'GET /bikes/:id' do
    before do
      get "/bikes/#{bike.id}"
    end

    it 'is successful' do
      expect(last_response.status).to eq(200)
    end

    it 'gets bike by id' do
      expect(parsed_response_body['id']).to eq(bike.id)
    end

    it 'includes station' do
      expect(parsed_response_body['station_id']).to eq(station.id)
    end

    it 'includes last member' do
      expect(parsed_response_body['last_member_id']).to eq(member.id)
    end
  end
end
