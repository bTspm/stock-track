class Snp500Worker
  include Sidekiq::Worker

  def perform
    symbols = CompanyService.new.snp500_company_symbols
    symbols.each_with_index do |symbol, index|
      time = index * 20.seconds
      CompanyWorker.perform_in(time, symbol)
    end
  end
end
