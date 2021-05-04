module Utils
  def format_percentage(percentage)
    return "N/A" if percentage.blank?

    value = percentage_value(percentage)
    h.number_to_percentage(value, precision: 2, delimiter: ',', separator: '.', strip_insignificant_zeros: true)
  end

  def percentage_value(percentage)
    percentage ? (percentage * 100).round(2) : percentage
  end

  def value_or_na(value)
    value.blank? ? "N/A" : value
  end
end
