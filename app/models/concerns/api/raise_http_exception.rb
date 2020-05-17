module Api
  class RaiseHttpException < Faraday::Middleware
    def call(env)
      @app.call(env).on_complete do |response|
        case response[:status].to_i
        when 400
          _error_bad_request(response)
        when 401
          _error_unauthorized(response)
        when 402
          _error_premium_data(response)
        when 403
          _error_forbidden(response)
        when 404
          _error_not_found(response)
        when 413, 414
          _error_request_big(response)
        when 429
          _error_too_many_requests(response)
        when 500
          _error_internal_server(response)
        else
          response
        end
      end
    end

    protected

    def _error_bad_request(response)
      raise ApiExceptions::BadRequest, _error_message(response)
    end

    def _error_body(body)
      parsed_body = JSON.parse(body.to_json)
      message = parsed_body[:error] rescue nil
      message || parsed_body || "Something went wrong"
    end

    def _error_forbidden(response)
      raise ApiExceptions::Forbidden, _error_message(response)
    end

    def _error_internal_server(response)
      raise ApiExceptions::InternalServerError, _error_message(response)
    end

    def _error_message(response)
      message = "#{response[:status]}, "
      message += _error_body(response[:body])
      Rails.logger.error("Error: #{response[:url].to_s}: #{message}")
      message
    end

    def _error_not_found(response)
      raise ApiExceptions::NotFound, _error_message(response)
    end

    def _error_premium_data(response)
      raise ApiExceptions::PremiumDataError, _error_message(response)
    end

    def _error_request_big(response)
      raise ApiExceptions::RequestBig, _error_message(response)
    end

    def _error_too_many_requests(response)
      raise ApiExceptions::TooManyRequests, _error_message(response)
    end

    def _error_unauthorized(response)
      raise ApiExceptions::Unauthorized, _error_message(response)
    end
  end
end
