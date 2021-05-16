class String
  def to_float
    return if blank?

    delete(',').scan(/[+-]?[0-9]*\.?[0-9]+(?:[eE][-+]?[0-9]+)?/)&.first&.to_f
  end

  def to_integer
    return if blank?

    scan(/\d/).join.to_i
  end

  def to_floats
    return if blank?

    delete(',').scan(/[+-]?[0-9]*\.?[0-9]+(?:[eE][-+]?[0-9]+)?/).map(&:to_float)
  end
end
