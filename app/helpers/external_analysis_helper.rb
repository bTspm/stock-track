module ExternalAnalysisHelper

  # @param [ExternalAnalyses::AnalysesPresenter::Scalar] analysis; analysis presenter
  def source_with_external_link(analysis)
    return analysis.formatted_source if analysis.url.blank? || analysis.original_rating.blank?

    link_to fontawesome_icon(name_icon_with_style: "fas fa-external-link-alt", text: analysis.formatted_source),
            analysis.url,
            target: "_blank",
            title: "Navigate to #{analysis.formatted_source}",
            data: { tooltip: :tooltip }
  end
end
