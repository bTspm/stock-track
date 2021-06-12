module StNumbersHelper
  def st_number_with_delimiter(number, options = {})
    return "N/A" if number.blank?

    number_with_delimiter(number, options)
  end

  def st_number_to_currency(number, options = {})
    return "N/A" if number.blank?

    options = options.reverse_merge(precision: StConstants::DEFAULT_PRECISION)
    number_to_currency(number, options)
  end

  def st_number_to_human(number, options = {})
    return "N/A" if number.blank?

    options = options.reverse_merge(precision: StConstants::DEFAULT_PRECISION)
    tooltip_wrapper(number_with_delimiter(number)) { number_to_human(number, options) }
  end

  def st_number_to_percentage(percentage)
    return "N/A" if percentage.blank?

    number_to_percentage(
      percentage.round(StConstants::DEFAULT_DECIMALS_COUNT),
      precision: StConstants::DEFAULT_PRECISION,
      delimiter: ',',
      separator: '.'
    )
  end
end
