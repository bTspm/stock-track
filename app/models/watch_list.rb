class WatchList < ApplicationRecord
  belongs_to :user

  validates_presence_of :name, :user_id
  validates_uniqueness_of :name, scope: :user_id, case_sensitive: false
  validates_presence_of :symbols, on: :create
end
