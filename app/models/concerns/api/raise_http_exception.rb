module Api
  class RaiseHttpException < Faraday::Middleware
    ERROR_STATUS_MAPPING = {
     "400": ApiExceptions::BadRequest,
     "401": ApiExceptions::Unauthorized,
     "402": ApiExceptions::PremiumDataError,
     "403": ApiExceptions::Forbidden,
     "404": ApiExceptions::NotFound,
     "413": ApiExceptions::RequestBig,
     "414": ApiExceptions::RequestBig,
     "429": ApiExceptions::TooManyRequests,
     "500": ApiExceptions::InternalServerError
    }.with_indifferent_access

    def call(env)
      @app.call(env).on_complete do |response|
        status = response[:status].to_s
        if _error_status_codes.include? status
          _error_by_status_response(response: response, status: status)
        else
          response
        end
      end
    end

    protected

    def _error_by_status_response(response:, exception: nil, status: nil)
      return if status.blank? && exception.blank?

      exception ||= _error_exception_mapping[status.to_s]
      raise exception, _error_message(response)
    end

    def _error_body(body)
      parsed_body = JSON.parse(body.to_json)
      message = parsed_body["error"] rescue nil
      message.presence || parsed_body.to_s.presence || "Something went wrong"
    end

    def _error_exception_mapping
      ERROR_STATUS_MAPPING
    end

    def _error_message(response)
      message = "#{response[:status]}, "
      message += _error_body(response[:body])
      Rails.logger.error("Error: #{_response_url(response)}: #{message}")
      message
    end

    def _error_status_codes
      _error_exception_mapping.keys.map(&:to_s)
    end

    private

    def _response_url(response)
      url = response[:url] ||  response.env.url
      url.to_s
    end
  end
end
