module AppExceptions
  class RecordInvalid < StandardError
    attr_accessor :error_message, :record

    def initialize(record, error_message="")
      @record = record
      @error_message = error_message
    end

    def error_messages
      record.errors.full_messages
    end

    def message
      message = error_messages.join(", ")
      return message if @error_message.blank?

      "#{@error_message}, #{message}"
    end
  end
end
