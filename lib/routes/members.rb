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

      app.put '/members/:id/account/enable' do
        json @member.update(account: 'enabled')
      end

      app.put '/members/:id/account/disable' do
        json @member.update(account: 'disabled')
      end
    end
  end
end
