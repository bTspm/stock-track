class String
  def to_float
    return if blank?

    delete(',').match(/\d+\.\d+/)[0]&.to_f
  end

  def to_integer
    return if blank?

    scan(/\d/).join.to_i
  end

  def to_floats
    return if blank?

    scan(/\d+[,.]\d+/).map(&:to_float)
  end
end
