module Utils
  DATA_OBJECT_METHOD_PREFIX = "data_object_"

  def method_missing(method_name, *args, &block)
    method_name = method_name.to_s

    if method_name.include? DATA_OBJECT_METHOD_PREFIX
      data_object.send(method_name.gsub(DATA_OBJECT_METHOD_PREFIX, "").to_sym, *args)
    else
      method_name = method_name.to_sym
      super
    end
  end

  def value_or_na(value)
    value.blank? ? "N/A" : value
  end
end
