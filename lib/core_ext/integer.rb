class Integer
  def to_datetime
    return if self.blank?

    DateTime.strptime(self.to_s, "%Q")
  end
end
