module DbDeserializers
  class IssuerType
    def from_db_entity(entity)
      args = {
          code: entity.code,
          id: entity.id,
          name: entity.name
      }

      Entities::IssuerType.new(args)
    end
  end
end
