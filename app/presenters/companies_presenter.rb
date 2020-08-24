class CompaniesPresenter
  include Btspm::Presenters::Presentable

  class Scalar < Btspm::Presenters::ScalarPresenter
    delegate :formatted, to: :address, prefix: true
    delegate :country_alpha2, :name_with_country_code, to: :exchange, prefix: true
    delegate :name_with_code, :name, to: :issuer_type, prefix: true

    def address
      ::AddressesPresenter.present(data_object.address, h)
    end

    def autocomplete_response
      {
        exchange_name_with_country_code: exchange_name_with_country_code,
        id: symbol,
        logo_url: logo_url,
        security_name_with_symbol: _security_name_with_symbol,
        value: _search_display
      }
    end

    def company_executives
      return [] if data_object.company_executives.blank?

      ::CompanyExecutivesPresenter.present(data_object.company_executives, h)
    end

    def employees
      return "N/A" if data_object.employees.blank?

      "~#{h.number_with_delimiter(data_object.employees)}"
    end

    def exchange
      ::ExchangesPresenter.present(data_object.exchange, h)
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

    def select_picker_response
      { id: symbol, text: security_name }
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
    def autocomplete_response
      return [] if data_object.blank?

      map(&:autocomplete_response)
    end

    def issuer_type_allocation_chart_data
      { data: _pie_chart_response(:issuer_type_name), title: 'Issuer Type Allocation' }.to_json
    end

    def sector_allocation_chart_data
      { data: _pie_chart_response(:sector), title: 'Sector Allocation' }.to_json
    end

    def select_picker_response
      return [] if data_object.blank?

      map(&:select_picker_response)
    end

    private

    def _pie_chart_response(key)
      map(&key).tally.sort_by {|k, v| [-v, k] }.to_h.map { |k, v| { name: k, y: v } }
    end
  end
end
