module Services
  extend ActiveSupport::Concern
  included do

    def company_service
      @company_service ||= CompanyService.new
    end

    def stock_service
      @stock_service ||= StockService.new
    end
  end
end
