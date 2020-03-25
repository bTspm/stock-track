class Company < ApplicationRecord
  belongs_to :address, optional: true
  belongs_to :exchange
  belongs_to :issuer_type

  has_many :company_executives
end
