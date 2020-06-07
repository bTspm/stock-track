class Integer
  def to_datetime
    return if blank?

    DateTime.strptime(to_s, "%Q")
  end
end
