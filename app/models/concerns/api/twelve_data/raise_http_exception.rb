module Api
  module TwelveData
    class RaiseHttpException < ::RaiseHttpException
      SUCCESS_TEXT = "ok".freeze

      def call(env)
        response = super
        response_body = JSON.parse(response.body)
        return response if response_body["status"]&.downcase == SUCCESS_TEXT

        _error_by_status_response(response: response, status: response_body["code"])
      end

      protected

      def _error_message(response)
        response_body = JSON.parse(response.body).with_indifferent_access
        response_body[:message]
      end
    end
  end
end
