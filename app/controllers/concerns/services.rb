module Services
  extend ActiveSupport::Concern
  included do
    def company_service
      @company_service ||= CompanyService.new
    end

    def stock_service
      @stock_service ||= StockService.new
    end

    def watch_list_service
      @watch_list_service ||= WatchListService.new(user: current_user)
    end
  end
end
