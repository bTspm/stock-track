class AddressesPresenter
  include Btspm::Presenters::Presentable

  class Scalar < Btspm::Presenters::ScalarPresenter
    def formatted
      return "N/A" if _empty_address?

      address = ""
      address += "#{city}" if city.present?
      address += ", #{state}" if state.present?
      address += ", #{country}" if country.present?
      address += ", #{zip_code}" if zip_code.present?
      address
    end

    private

    def _empty_address?
      city.blank? && state.blank? && country.blank?
    end
  end
end
