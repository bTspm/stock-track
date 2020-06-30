class BaseClient
  def initialize
    @conn = Faraday.new do |builder|
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
