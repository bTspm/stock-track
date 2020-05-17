module Api
  class Response

    attr_reader :body,
                :headers,
                :status,
                :success

    def initialize(response)
      @response = response
      @body = _build_body
      @headers = response.headers
      @status = response.status
      @success = response.success?
    end

    private

    def _build_body
      body = JSON.parse(@response.body)
      if body.is_a? Hash
        body.with_indifferent_access
      elsif body.is_a? Array
        body.map(&:with_indifferent_access)
      else
        body
      end
    end
  end
end
