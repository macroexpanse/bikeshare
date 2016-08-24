module Routing
  module Rentals
    def self.registered(app)
      app.post '/rentals' do
        bike = Bike.find(id: params[:bike_id])
        member = Member.find(id: params[:member_id])
        station = Station.find(id: params[:station_id])
        return not_found if bike.nil? || member.nil? || station.nil?

        if bike.available === true
          rental = Rental.create(
            bike_id: bike.id,
            member_id: member.id,
            rent_station_id: station.id
          )
          bike.update(available: false, last_member_id: params[:member_id])
          json rental
        else
          json error: 'This bike is not available.'
        end
      end

      app.post '/rentals/:id/return' do
        rental = Rental.find(id: params[:id])
        station = Station.find(id: params[:station_id])
        return not_found if rental.nil? || station.nil?

        if rental.return_station_id
          json error: 'This rental has already been returned.'
        elsif station.bikes.count >= station.max_capacity
          json error: 'This station is at capacity.'
        else
          rental.update(return_station_id: params[:station_id])
          rental.bike.update(available: true, station_id: params[:station_id])
          json rental
        end
      end
    end
  end
end
