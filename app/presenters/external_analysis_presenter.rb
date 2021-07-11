class ExternalAnalysisPresenter
  include Btspm::Presenters::Presentable

  class Scalar < Btspm::Presenters::ScalarPresenter
    include Utils

    def formatted_refreshed_at
      ("Refreshed: #{h.time_ago(refreshed_at)}").html_safe
    end

    def analyses
      ExternalAnalyses::AnalysesPresenter.present(data_object_analyses, h)
    end

    def average_rating_rank
      return "N/A" if data_object_average_rating_rank.blank?

      data_object_average_rating_rank.round(StConstants::DEFAULT_DECIMALS_COUNT)
    end

    def average_rating_signal
      return "N/A" if data_object_average_rating_signal.blank?

      I18n.t("analysis_signal.#{data_object_average_rating_signal}")
    end
  end
end
