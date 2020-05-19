class BaseBuilder
  attr_accessor :db_entity

  def initialize(db_entity = nil)
    @db_entity = db_entity || _db_entity_class.new
  end

  def self.build(db_entity)
    builder = new(db_entity)
    yield(builder)
    builder.db_entity
  end

  def self.build_base_entity(db_entity: nil, domain_entity:)
    build(db_entity) { |builder| builder.build_base_entity(domain_entity) }
  end

  def build_base_entity(domain_entity)
    @db_entity.tap do |d|
      _base_column_names.each do |column_name|
        d.send("#{column_name}=", domain_entity.send(column_name))
      end
    end
  end

  protected

  def _base_column_names
    raise NotImplementedError
  end

  def _db_entity_class
    raise NotImplementedError
  end
end
