class ExchangePresenter
  include Btspm::Presenters::Presentable

  class Scalar < Btspm::Presenters::ScalarPresenter
    def name_with_country
      "#{name} (#{country})"
    end
  end
end
