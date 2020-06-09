class IssuerTypeStore
  include Cacheable

  def by_code(code)
    fetch_cached(key: "#{self.class.name}/#{__method__}/#{code}") do
      Entities::IssuerType.from_db_entity(IssuerType.where(code: code).first)
    end
  end

  def by_id(id)
    fetch_cached(key: "#{self.class.name}/#{__method__}/#{id}") do
      Entities::IssuerType.from_db_entity(IssuerType.find(id))
    end
  end
end
