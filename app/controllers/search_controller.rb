class SearchController < ApplicationController
  def basic
    companies = company_service.basic_search(params[:query])
    companies = present(companies, CompaniesPresenter) if companies.any?

    respond_to do |format|
      format.json { render json: { suggestions: companies.search_response } }
    end
  end
end
