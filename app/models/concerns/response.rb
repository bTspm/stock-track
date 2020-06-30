class Response
  attr_reader :body,
              :headers,
              :status,
              :success

  def initialize(response)
    @body = _build_body(response.body)
    @headers = response.headers
    @status = response.status
    @success = response.success?
  end

  private

  def _build_body(body)
    return body.with_indifferent_access if body.is_a? Hash
    return _handle_array(body) if body.is_a? Array

    body
  end

  def _handle_array(body)
    body.map { |datum| datum.is_a?(Hash) ? datum.with_indifferent_access : datum }
  end
end
