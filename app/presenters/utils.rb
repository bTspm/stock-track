module Utils
  def epoch_to_datetime(epoch, format = "%b %d, %Y %-l:%M %p EST")
    return "N/A" if epoch.blank?

    formatted_epoch = _formatted_epoch(epoch)
    Time.at(formatted_epoch.to_i).strftime(format)
  end

  def format_percentage(percentage)
    return "N/A" if percentage.blank?

    "#{(percentage * 100).round(2)}%"
  end

  def readable_date(date, format = '%b %d, %Y')
    return "N/A" if date.blank?

    date.strftime(format)
  end

  def value_or_na(value)
    value.blank? ? "N/A" : value
  end

  def yes_or_no(flag)
    flag ? 'Yes' : 'No'
  end

  private

  def _formatted_epoch(epoch)
    epoch = Integer epoch
    digits = epoch.digits.count
    return epoch if digits == 10

    epoch / 10 ** (digits - 10)
  end
end

