class Snp500Worker
  include Sidekiq::Worker

  def perform
    symbols = CompanyService.new.snp500_company_symbols
    symbols.each { |symbol| CompanyWorker.perform_async(symbol) }
  end
end
