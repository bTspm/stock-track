module Api
  module FinnHub
    class RaiseHttpException < Api::RaiseHttpException
      PREMIUM_ERROR_MESSAGE = "You don't have access to this resource.".freeze

      def call(env)
        response = super
        response_body = begin
                          JSON.parse(response.body)
                        rescue
                          nil
                        end
        return response if response_body

        _error_based_on_response(response)
      end

      protected

      def _error_message(response)
        message = response.body
        Rails.logger.error("Error: #{_response_url(response)}: #{message}")
        message
      end

      private

      def _error_based_on_response(response)
        message = _error_body(response.body)
        if message == PREMIUM_ERROR_MESSAGE
          _error_by_status_response(response: response, exception: ApiExceptions::PremiumDataError)
        end
      end
    end
  end
end
