module Routing
  module Members
    def self.registered(app)
      app.before '/members/:id/?*' do
        @member = Member.find(id: params[:id])
        not_found if @member.nil?
      end

      app.get '/members/:id' do
        json @member
      end

      app.get '/members/:id/rides' do
        @member.to_json(include: :rides)
      end

      app.get '/members/:id/current_ride' do
        @member.to_json(include: :current_ride)
      end
    end
  end
end
