module AppExceptions
  class RecordInvalid < StandardError
    attr_accessor :error_message, :record

    def initialize(record)
      @record = record
      @error_message = error_message
    end

    def message
      message = record.errors.full_messages.join(", ")
      return message if @error_message.blank?

      "#{@error_message}, #{message}"
    end
  end
end
