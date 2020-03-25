module Exceptions
  module AppExceptions
    class Error < StandardError
      attr_reader :message

      def initialize(message = '')
        @message = message
      end
    end

    class ApiError < Error;
    end
  end
end
