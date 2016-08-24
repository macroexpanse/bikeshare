module Requests
  module JsonHelpers
    def parsed_response_body
      JSON.parse(last_response.body, symbolize_names: true)
    end
  end
end
