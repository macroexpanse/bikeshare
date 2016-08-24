require 'spec_helper'

require_relative '../../lib/models/member'
require_relative '../../lib/models/rental'

describe 'Member routes' do
  let(:member) { Member.create }

  describe 'GET /members/:id' do
    context 'valid member id' do
      before do
        get "/members/#{member.id}"
      end

      it 'returns success' do
        expect(last_response.status).to eq(200)
      end

      it 'gets a member by id' do
        expect(parsed_response_body).to eq(member.values)
      end
    end

    context 'invalid member id' do
      before do
        get "/members/#{member.id + 1}"
      end

      it 'returns not found' do
        expect(last_response.status).to eq(404)
      end
    end
  end

  describe 'GET /members/:id/rides' do
    context 'valid member id' do
      it 'returns success' do
        get "/members/#{member.id}/rides"

        expect(last_response.status).to eq(200)
      end

      it 'includes number of rides' do
        Rental.create(member_id: member.id, return_station_id: Station.create.id)

        get "/members/#{member.id}/rides"

        expect(parsed_response_body[:rides]).to eq(1)
      end
    end

    context 'invalid member id' do
      before do
        get "/members/#{member.id + 1}/rides"
      end

      it 'returns not found' do
        expect(last_response.status).to eq(404)
      end
    end
  end
end
