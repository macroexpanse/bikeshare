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

  describe 'GET /members/:id/current_ride' do
    context 'valid member id' do
      it 'returns success' do
        get "/members/#{member.id}/current_ride"

        expect(last_response.status).to eq(200)
      end

      it 'returns the current ride' do
        current_ride = Rental.create(
          member_id: member.id,
          rent_station_id: Station.create.id
        )

        get "/members/#{member.id}/current_ride"

        expect(parsed_response_body[:current_ride]).to eq(current_ride.values)
      end
    end

    context 'invalid member id' do
      it 'returns not found' do
        get "/members/#{member.id + 1}/current_ride"

        expect(last_response.status).to eq(404)
      end
    end
  end

  describe "PUT /members/:member_id/account/enable" do
    context 'valid member id' do
      def send_request
        put "/members/#{member.id}/account/enable"
      end

      it 'returns success' do
        send_request

        expect(last_response.status).to eq(200)
      end

      it "updates the member's account status" do
        member.update(account: 'disabled')

        send_request

        expect(member.reload.account).to eq('enabled')
      end
    end

    context 'invalid member id' do
      it 'returns not found' do
        put "/members/#{member.id + 1}/account/enable"

        expect(last_response.status).to eq(404)
      end
    end
  end

  describe "PUT /members/:member_id/account/disable" do
    context 'valid member id' do
      def send_request
        put "/members/#{member.id}/account/disable"
      end

      it 'returns success' do
        send_request

        expect(last_response.status).to eq(200)
      end

      it "updates the member's account status" do
        member.update(account: 'enabled')

        send_request

        expect(member.reload.account).to eq('disabled')
      end
    end

    context 'invalid member id' do
      it 'returns not found' do
        put "/members/#{member.id + 1}/account/disable"

        expect(last_response.status).to eq(404)
      end
    end
  end
end
