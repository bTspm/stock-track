class CompaniesPresenter
  include Btspm::Presenters::Presentable

  class Scalar < Btspm::Presenters::ScalarPresenter
    include Utils

    delegate :formatted, to: :address, prefix: true
    delegate :name_with_code, :name, to: :issuer_type, prefix: true

    def address
      ::AddressesPresenter.present(data_object_address, h)
    end

    def search_response
      {
        exchange_name: exchange_name,
        id: symbol,
        logo_url: logo_url,
        security_name_with_symbol: _security_name_with_symbol,
        value: _search_display
      }
    end

    def company_executives
      return [] if data_object_company_executives.blank?

      ::CompanyExecutivesPresenter.present(data_object_company_executives, h)
    end

    def employees
      return "N/A" if data_object_employees.blank?

      "~#{h.st_number_with_delimiter(data_object_employees)}"
    end

    def issuer_type
      ::IssuerTypesPresenter.present(data_object_issuer_type, h)
    end

    def logo_url
      "#{ENV['IEX_SYMBOl_LOGO_PREFIX']}#{symbol}.png"
    end

    def stock_info_link_with_name
      h.stock_information_link_with_company_name(self)
    end

    def exchange_name
      exchange.nyse? ? Entities::Exchange::NYSE : Entities::Exchange::NASDAQ
    end

    private

    def _search_display
      [description, name, security_name, symbol].join(" ")
    end

    def _security_name_with_symbol
      "#{security_name} - #{symbol.upcase}"
    end
  end

  class Enum < Btspm::Presenters::EnumPresenter
    def search_response
      return [] if data_object.blank?

      map(&:search_response)
    end
  end
end
