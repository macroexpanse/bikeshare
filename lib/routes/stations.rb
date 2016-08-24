module Routing
  module Stations
    def self.registered(app)
      app.before '/stations/:id/?*' do
        @station = Station.find(id: params[:id])
        not_found if @station.nil?
      end

      app.get '/stations/:id'  do
        json @station
      end

      app.get '/stations/:id/bikes'  do
        @station.to_json(include: :bikes)
      end
    end
  end
end
