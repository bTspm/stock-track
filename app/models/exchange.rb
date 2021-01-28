class Exchange < ApplicationRecord
  has_many :companies

  validates_presence_of :code, :country, :name, case_sensitive: false
  validates_uniqueness_of :code, scope: :country

  NAS = 2
  NMS = 7
  NYS = 11
end
