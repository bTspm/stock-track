module Api
  class BaseClient
    def initialize(&block)
      @conn = if block_given?
                Faraday.new(&block)
              else
                Faraday.new do |conn|
                  conn.request :json
                  # conn.request :url_encoded
                  conn.response :logger
                  conn.use _response_handler
                  conn.adapter _adapter
                end
              end
    end

    def get(url)
      response = @conn.get url
      _parse_response(response)
    end

    protected

    def _adapter
      Faraday.default_adapter
    end

    def _response_handler
      Api::RaiseHttpException
    end

    def _parse_response(response)
      Api::Response.new(response)
    end
  end
end
