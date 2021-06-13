module Utils
  DATA_OBJECT_METHOD_PREFIX = "data_object_"

  def method_missing(method_name, *args, &block)
    method_name = method_name.to_s

    if method_name.include? DATA_OBJECT_METHOD_PREFIX
      data_object.send(method_name.gsub(DATA_OBJECT_METHOD_PREFIX, ""), *args)
    else
      super
    end
  end

  def value_or_na(value)
    value.blank? ? "N/A" : value
  end
end
