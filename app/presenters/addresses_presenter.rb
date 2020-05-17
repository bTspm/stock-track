class AddressesPresenter
  include Btspm::Presenters::Presentable

  class Scalar < Btspm::Presenters::ScalarPresenter
    def formatted
      return "N/A" if data_object.blank?

      text = ""
      text += h.content_tag(:div, line_1) if line_1.present?
      text += h.content_tag(:div, line_2) if line_2.present?
      text += h.content_tag(:div, _city_state_country_and_zip) if _city_state_country_and_zip
      text.html_safe
    end

    private

    def _city_state_country_and_zip
      return if state.blank? && country.blank? && zip_code.blank?

      address = ""
      address += "#{city}" if city.present?
      address += ", #{state}" if state.present?
      address += ", #{country}" if country.present?
      address += ", #{zip_code}" if zip_code.present?
      address
    end
  end
end
