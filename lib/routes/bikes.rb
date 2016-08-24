module Routing
  module Bikes
    def self.registered(app)
      app.get '/bikes/:id' do
        bike = Bike.find(id: params[:id])

        if bike
          json bike
        else
          not_found
        end
      end
    end
  end
end
