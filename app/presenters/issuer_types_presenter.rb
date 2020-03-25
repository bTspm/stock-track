class IssuerTypesPresenter
  include Btspm::Presenters::Presentable

  class Scalar < Btspm::Presenters::ScalarPresenter
    def name_with_code
      "#{code} (#{name})"
    end
  end
end
