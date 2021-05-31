module Utils
  def value_or_na(value)
    value.blank? ? "N/A" : value
  end
end
