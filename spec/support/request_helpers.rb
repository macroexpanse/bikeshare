module Requests
  module JsonHelpers
    def parsed_response_body
      JSON.parse(last_response.body)
    end
  end
end
