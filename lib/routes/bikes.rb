module Routing
  module Bikes
    def self.registered(app)
      app.get '/bikes/:id' do
        json Bike.find(id: params[:id])
      end
    end
  end
end
