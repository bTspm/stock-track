module DbDeserializers
  class Exchange
    def from_db_entity(entity)
      args = {
          code: entity.code,
          country: entity.country,
          id: entity.id,
          name: entity.name
      }

      Entities::Exchange.new(args)
    end
  end
end
