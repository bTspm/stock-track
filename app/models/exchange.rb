class Exchange < ApplicationRecord
  has_many :companies

  validates_presence_of :code, :country, :name, case_sensitive: false
  validates_uniqueness_of :code, scope: :country

  NASDAQ_CAPITAL_MARKET_ID = 2
  NASDAQ_GLOBAl_MARKET_ID = 7
  NEW_YORK_STOCK_EXCHANGE_ID = 11

  NASDAQ_IDS = [NASDAQ_CAPITAL_MARKET_ID, NASDAQ_GLOBAl_MARKET_ID]
end
