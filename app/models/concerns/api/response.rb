module Api
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
      if body.is_a? Hash
        body.with_indifferent_access
      elsif body.is_a? Array
        body.map { |datum| datum.is_a?(Hash) ? datum.with_indifferent_access : datum }
      else
        body
      end
    end
  end
end
