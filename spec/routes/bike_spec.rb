require_relative '../spec_helper'
require_relative '../../lib/models/bike'

describe 'Bike routes' do
  describe 'GET /bikes/:id' do
    let(:bike) { Bike.create }

    before do
      get "/bikes/#{bike.id}"
    end

    it 'is successful' do
      expect(last_response.status).to eq(200)
    end

    it 'gets bike by id' do
      expect(JSON.parse(last_response.body)['id']).to eq(bike.id)
    end
  end
end
