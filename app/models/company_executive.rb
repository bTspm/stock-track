class CompanyExecutive < ApplicationRecord
  belongs_to :company, required: true, dependent: :destroy

  validates_presence_of :name, :titles
end
