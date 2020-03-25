module DbDeserializers
  class Address
    def from_db_entity(entity)
      return Entities::Address.null_object if entity.blank?

      args = {
          city: entity.city,
          country: entity.country,
          id: entity.id,
          line_1: entity.line_1,
          line_2: entity.line_2,
          state: entity.state,
          zip_code: entity.zip_code
      }

      Entities::Address.new(args)
    end
  end
end
