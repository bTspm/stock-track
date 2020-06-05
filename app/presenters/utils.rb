module Utils
  DEFAULT_DATE_FORMAT = "%b %d, %Y"
  DEFAULT_DATETIME_FORMAT = "%b %d, %Y %-l:%M:%S %p"
  DEFAULT_TIME_ZONE = "Eastern Time (US & Canada)"

  def format_percentage(percentage)
    percentage.blank? ? "N/A" : "#{(percentage * 100).round(2)}%"
  end

  def percentage_value(percentage)
    percentage ? (percentage * 100).round(2) : percentage
  end

  def readable_date(date:, format: DEFAULT_DATE_FORMAT)
    date.blank? ? "N/A" : date.strftime(format)
  end

  def readable_datetime(datetime:, format: DEFAULT_DATETIME_FORMAT)
    return "N/A" if datetime.blank?

    datetime.in_time_zone(DEFAULT_TIME_ZONE).strftime(format)
  end

  def value_or_na(value)
    value.blank? ? "N/A" : value
  end
end
