class ExchangesPresenter
  include Btspm::Presenters::Presentable

  class Scalar < Btspm::Presenters::ScalarPresenter
    delegate :alpha2, :code, to: :country, prefix: true

    def name_with_country_code
      "#{name} - (#{country_code})"
    end
  end
end
