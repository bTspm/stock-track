module Entities
  class Company
    attr_accessor :address,
                  :description,
                  :employees,
                  :exchange,
                  :id,
                  :industry,
                  :issuer_type,
                  :logo_url,
                  :name,
                  :null_object,
                  :sector,
                  :security_name,
                  :sic_code,
                  :symbol,
                  :website

    def initialize(args = {})
      @address = args[:address]
      @description = args[:description]
      @employees = args[:employees]
      @exchange = args[:exchange]
      @id = args[:id]
      @industry = args[:industry]
      @issuer_type = args[:issuer_type]
      @name = args[:name]
      @null_object = args[:null_object]
      @sector = args[:sector]
      @security_name = args[:security_name]
      @sic_code = args[:sic_code]
      @symbol = args[:symbol]
      @website = args[:website]
      @logo_url = args[:logo_url] || _logo_url
    end

    def self.null_object
      args = {null_object: true}
      new(args)
    end

    def null_object?
      @null_object
    end

    def etf?
      issuer_type.code == "ET"
    end

    private

    def _logo_url
      "#{ENV['IEX_SYMBOl_LOGO_PREFIX']}#{@symbol}.png"
    end
  end
end
