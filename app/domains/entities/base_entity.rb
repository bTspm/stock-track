module Entities
  class BaseEntity
    def initialize(args = {})
      self.class::ATTRIBUTES.each do |attribute|
        instance_variable_set(:"@#{attribute}", args.dig(attribute))
      end
    end
  end
end
