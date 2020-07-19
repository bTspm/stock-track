class CompaniesPresenter
  include Btspm::Presenters::Presentable

  class Scalar < Btspm::Presenters::ScalarPresenter
    delegate :formatted, to: :address, prefix: true
    delegate :country_alpha2, :name_with_country_code, to: :exchange, prefix: true
    delegate :name_with_code, to: :issuer_type, prefix: true

    def address
      ::AddressesPresenter.present(data_object.address, h)
    end

    def search_display
      [description, name, security_name, symbol].join(" ")
    end

    def employees
      return "N/A" if data_object.employees.blank?

      "~#{h.number_with_delimiter(data_object.employees)}"
    end

    def exchange
      ::ExchangesPresenter.present(data_object.exchange, h)
    end

    def executives
      return [] if data_object.executives.blank?

      ::CompanyExecutivesPresenter.present(data_object.executives, h)
    end

    def issuer_type
      ::IssuerTypesPresenter.present(data_object.issuer_type, h)
    end

    def logo_url
      "#{ENV['IEX_SYMBOl_LOGO_PREFIX']}#{symbol}.png"
    end

    def name_with_symbol
      "#{name} - (#{symbol.upcase})"
    end

    def security_name_with_symbol
      "#{security_name} - #{symbol.upcase}"
    end

    def search_response
      {
        exchange_name_with_country_code: exchange_name_with_country_code,
        id: symbol,
        logo_url: logo_url,
        security_name_with_symbol: security_name_with_symbol,
        value: search_display
      }
    end
  end

  class Enum < Btspm::Presenters::EnumPresenter
    def search_response
      map(&:search_response)
    end
  end
end
