class IssuerType < ApplicationRecord
  has_many :companies

  validates :code, :name, presence: true, case_sensitive: false, uniqueness: true
end
