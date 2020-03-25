module Entities
  class Address
    attr_reader :city,
                :country,
                :id,
                :line_1,
                :line_2,
                :null_object,
                :state,
                :zip_code

    def initialize(args = {})
      @city = args[:city]
      @country = args[:country]
      @id = args[:id]
      @line_1 = args[:line_1]
      @line_2 = args[:line_2]
      @null_object = args[:null_object] || false
      @state = args[:state]
      @zip_code = args[:zip_code]
    end

    def self.null_object
      args = {
          city: "",
          country: "",
          id: nil,
          line_1: "",
          line_2: "",
          null_object: true,
          state: "",
          zip_code: ""
      }

      new(args)
    end

    def null_object?
      @null_object
    end
  end
end

