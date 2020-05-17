class CompaniesPresenter
  include Btspm::Presenters::Presentable

  class Scalar < Btspm::Presenters::ScalarPresenter
    def address
      ::AddressesPresenter.present(data_object.address, h)
    end

    def employees
      return "N/A" if data_object.employees.blank?

      "~#{h.number_with_delimiter(data_object.employees)}"
    end

    def exchange
      ::ExchangePresenter.present(data_object.exchange, h)
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
  end
end
