class Company < ApplicationRecord
  belongs_to :address, optional: true, autosave: true
  belongs_to :exchange, required: true
  belongs_to :issuer_type, required: true
  has_many :company_executives, autosave: true

  validates_presence_of :industry,
                        :name,
                        :sector,
                        :security_name,
                        :symbol
  validates_uniqueness_of :symbol, scope: :exchange_id, case_sensitive: false
end
