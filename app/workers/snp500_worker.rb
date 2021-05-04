class Snp500Worker
  include Sidekiq::Worker
  INTERVAL_TIME_IN_SECONDS = 20

  def perform
    symbols = CompanyService.new.snp500_company_symbols
    symbols.each_with_index do |symbol, index|
      time = (index * INTERVAL_TIME_IN_SECONDS).seconds
      CompanyWorker.perform_async(symbol)
    end
  end
end
