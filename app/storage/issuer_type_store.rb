class IssuerTypeStore
  def by_code(code)
    DbDeserializers::IssuerType.new.from_db_entity(IssuerType.where(code: code).first)
  end

  def by_id(id)
    DbDeserializers::IssuerType.new.from_db_entity(IssuerType.find(id))
  end
end
