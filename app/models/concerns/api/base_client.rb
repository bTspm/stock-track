module Api
  class BaseClient
    def initialize(&block)
      @conn = if block_given?
                Faraday.new(&block)
              else
                Faraday.new do |conn|
                  conn.request :json
                  conn.request :url_encoded
                  conn.response :json
                  conn.response :logger
                  conn.adapter _adapter
                  conn.use _error_handler
                end
              end
    end

    def get(url)
      _parse_response(@conn.get url)
    end

    protected

    def _adapter
      Faraday.default_adapter
    end

    def _error_handler
      Api::Iex::RaiseHttpException
    end

    def _parse_response(response)
      Api::Response.new(response)
    end
  end
end
