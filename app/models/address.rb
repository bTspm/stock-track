class Address < ApplicationRecord
  validates_presence_of :country, :line_1
end
