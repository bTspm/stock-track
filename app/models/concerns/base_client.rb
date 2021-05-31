class BaseClient
  BEARER = "Bearer"

  def initialize(options = {})
    @conn = Faraday.new do |builder|
      if options[:auth]
        builder.authorization options.dig(:auth, :type), options.dig(:auth, :token)
      end
      if options[:headers]
        builder.headers[options.dig(:headers, :type)] = options.dig(:headers, :value)
      end
      builder.request :json
      builder.response :json, content_type: /\bjson$/
      builder.request :url_encoded
      builder.response :logger
      builder.use _response_handler
      builder.adapter _adapter
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
    ::RaiseHttpException
  end

  def _parse_response(response)
    Response.new(response)
  end
end
