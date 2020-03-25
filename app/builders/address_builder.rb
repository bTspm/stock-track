class AddressBuilder

  def initialize(address = nil)
    @address = address || Address.new
  end

  def build_address(address_entity)
    @address.tap do |a|
      a.line_1 = address_entity.line_1
      a.line_2 = address_entity.line_2
      a.city = address_entity.city
      a.state = address_entity.state
      a.country = address_entity.country
      a.zip_code = address_entity.zip_code
    end
  end
end
