class Date
  def quarter
    (self.month / 3.0).ceil
  end
end