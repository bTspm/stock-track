class ExternalAnalysisPresenter
  include Btspm::Presenters::Presentable

  class Scalar < Btspm::Presenters::ScalarPresenter
    def formatted_refreshed_at
      ("Refreshed: #{h.time_ago(refreshed_at)}").html_safe
    end

    def analyses
      ExternalAnalyses::AnalysesPresenter.present(data_object.analyses, h)
    end
  end
end
