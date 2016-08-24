require_relative '../../lib/models/bike'
require_relative '../../lib/models/member'
require_relative '../../lib/models/rental'
require_relative '../../lib/models/station'

describe 'Rental routes' do
  let(:rent_station) { Station.create }
  let(:member) { Member.create }
  let(:bike) do
    Bike.create(
      available: true,
      station_id: rent_station.id,
      last_member_id: member.id
    )
  end

  describe 'POST /rentals' do
    let(:new_member) { Member.create }

    def send_request(bike_id = bike.id, member_id = new_member.id, rent_station_id = rent_station.id)
      post "/rentals", bike_id: bike_id, member_id: member_id, station_id: rent_station_id
    end

    it 'request is successful' do
      send_request

      expect(last_response.status).to eq(200)
    end

    context 'bike is available' do
      it 'creates a rental' do
        expect { send_request }.to change {
          Rental.where(
            bike_id: bike.id,
            member_id: new_member.id,
            rent_station_id: rent_station.id
          ).count
        }.by(1)
      end

      it 'returns a new rental' do
        send_request

        expect(parsed_response_body).to include(:id)
      end

      it 'makes the bike unavailable' do
        send_request

        expect(bike.reload.available).to be false
      end

      it "sets the new member as the bike's last member" do
        send_request

        expect(bike.reload.last_member_id).to eq(new_member.id)
      end
    end

    context 'bike is not available' do
      before do
        bike.update(available: false)
      end

      it 'returns an error message' do
        send_request

        expect(parsed_response_body).to include(:error)
      end

      it 'does not create rental' do
        expect { send_request }.to change { Rental.count }.by(0)
      end

      it 'does not update bike' do
        send_request

        expect(bike).to eq(bike.reload)
      end
    end

    context 'member account is disabled' do
      before do
        new_member.update(account: 'disabled')
      end

      it 'returns an error message' do
        send_request

        expect(parsed_response_body).to include(:error)
      end

      it 'does not create rental' do
        expect { send_request }.to change { Rental.count }.by(0)
      end

      it 'does not update bike' do
        send_request

        expect(bike).to eq(bike.reload)
      end
    end

    it 'returns not found for invalid bike id' do
      send_request(bike.id + 1)

      expect(last_response.status).to eq(404)
    end

    it 'returns not found for invalid member id' do
      send_request(bike.id, new_member.id + 1)

      expect(last_response.status).to eq(404)
    end

    it 'returns not found for invalid station id' do
      send_request(bike.id, new_member.id, rent_station.id + 1)

      expect(last_response.status).to eq(404)
    end
  end

  describe 'POST /rentals/:id/return' do
    let(:rental) do
      Rental.create(
        bike_id: bike.id,
        member_id: member.id,
        rent_station_id: rent_station.id
      )
    end

    let(:return_station) { Station.create }

    def send_request(rental_id = rental.id, return_station_id = return_station.id)
      post "/rentals/#{rental_id}/return", station_id: return_station_id
    end

    it 'returns success' do
      send_request

      expect(last_response.status).to eq(200)
    end

    context 'rental has not been returned' do
      before do
        bike.update(available: false, last_member_id: member.id)
      end

      it 'sets the return station on the rental' do
        send_request

        expect(rental.reload.return_station).to eq(return_station)
      end

      it 'returns the bike to the station' do
        send_request

        expect(bike.reload.station_id).to eq(return_station.id)
      end

      it 'makes the bike available' do
        send_request

        expect(bike.reload.available).to be(true)
      end

      it 'returns the rental in the response' do
        send_request

        expect(parsed_response_body).to eq(rental.reload.values)
      end
    end

    context 'rental has already been returned' do
      before do
        rental.update(return_station_id: return_station.id)
        bike.update(available: true, last_member_id: member.id)
      end

      it 'returns an error message' do
        send_request

        expect(parsed_response_body).to include(:error)
      end
    end

    context 'station is full' do
      before do
        return_station.update(capacity: 0)
      end

      it 'returns an error message' do
        send_request

        expect(parsed_response_body).to include(:error)
      end

      it 'does not update rental' do
        send_request

        expect(rental).to eq(rental.reload)
      end

      it 'does not update bike' do
        send_request

        expect(bike).to eq(bike.reload)
      end
    end

    it 'returns not found if rental id is invalid' do
      send_request(rental.id + 1)

      expect(last_response.status).to eq(404)
    end

    it 'returns not found if return_station_id id is invalid' do
      send_request(rental.id, return_station.id + 1)

      expect(last_response.status).to eq(404)
    end
  end
end
