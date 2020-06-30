class CompanyWorker
  include Sidekiq::Worker
  sidekiq_options retry: 2

  def perform(symbol)
    CompanyService.new.save_company_by_symbol(symbol)
  end
end
