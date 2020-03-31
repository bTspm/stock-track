class IssuerTypeStore
  def by_code(code)
    Entities::IssuerType.from_db_entity(IssuerType.where(code: code).first)
  end

  def by_id(id)
    Entities::IssuerType.from_db_entity(IssuerType.find(id))
  end
end
