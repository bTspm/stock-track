module Api
  module FinnHub
    class RaiseHttpException < Api::RaiseHttpException
      PREMIUM_ERROR_MESSAGE = "You don't have access to this resource."

      def call(env)
        response = super
        response_body = JSON.parse(response.body) rescue nil
        return response if response_body

        _error_based_on_response(response)
      end

      protected

      def _error_message(response)
        message = _error_body(response.body)
        Rails.logger.error("Error: #{response.env.url.to_s}: #{message}")
        message
      end

      private

      def _error_based_on_response(response)
        message = _error_body(response.body)
        _error_premium_data(response) if message == PREMIUM_ERROR_MESSAGE
      end
    end
  end
end
