require 'spec_helper'

require_relative '../../lib/models/station'

describe 'Station routes' do
  let(:station) { Station.create }
  let!(:bikes) { [ Bike.create(station_id: station.id) ] }

  describe 'GET /stations/:id' do
    context 'valid station id' do
      before do
        get "/stations/#{station.id}"
      end

      it 'returns success' do
        expect(last_response.status).to eq(200)
      end

      it 'gets a station by id' do
        expect(parsed_response_body).to eq(station.values)
      end
    end

    context 'invalid station id' do
      before do
        get "/stations/#{station.id + 1}"
      end

      it 'returns not found' do
        expect(last_response.status).to eq(404)
      end
    end
  end

  describe 'GET /station/:id/bikes' do
    context 'valid station id' do
      before do
        get "/stations/#{station.id}/bikes"
      end

      it 'is successful' do
        expect(last_response.status).to eq(200)
      end

      it 'gets a station by id' do
        expect(parsed_response_body[:id]).to eq(station.id)
      end

      it 'includes bike information' do
        expect(parsed_response_body[:bikes]).to eq(bikes.map(&:values))
      end
    end

    context 'invalid station id' do
      before do
        get "/stations/#{station.id + 1}/bikes"
      end

      it 'returns not found' do
        expect(last_response.status).to eq(404)
      end
    end
  end
end
