module Api
  module FinnHub
    class RaiseHttpException < ::RaiseHttpException
      PREMIUM_ERROR_MESSAGE = "You don't have access to this resource.".freeze

      protected

      def _error_message(response)
        response.body
      end

      def _error_by_status_response(response:, exception: nil, status: nil)
        super
      rescue ApiExceptions::Forbidden => e
        raise ApiExceptions::PremiumDataError, e.message if e.message.include? PREMIUM_ERROR_MESSAGE
        raise e
      end
    end
  end
end
