class SearchController < ApplicationController
  def basic
    respond_to do |format|
      format.json { render json: { suggestions: _results.autocomplete_response } }
    end
  end

  def search_for_dropdown
    render json: _results.select_picker_response
  end

  private

  def _results
    companies = company_service.basic_search(params[:query])
    present(companies, CompaniesPresenter)
  end
end
