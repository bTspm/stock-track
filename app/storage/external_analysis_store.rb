class ExternalAnalysisStore
  SOURCES_BY_COMPANY = [
    Entities::ExternalAnalyses::Analysis::WE_BULL
  ]
  SOURCES_BY_SYMBOL = [
    Entities::ExternalAnalyses::Analysis::BAR_CHART,
    Entities::ExternalAnalyses::Analysis::CNN,
    Entities::ExternalAnalyses::Analysis::ROBIN_HOOD,
    Entities::ExternalAnalyses::Analysis::TIP_RANKS,
    Entities::ExternalAnalyses::Analysis::THE_STREET,
    Entities::ExternalAnalyses::Analysis::ZACKS,
  ]

  def by_company(company)
    analyses = SOURCES_BY_SYMBOL.map { |source| _rating_from_source_by_symbol(source: source, symbol: company.symbol) }
    analyses += SOURCES_BY_COMPANY.map { |source| _rating_from_source_by_company(source: source, company: company) }
    analyses
    Entities::ExternalAnalysis.new(analyses: analyses, refreshed_at: DateTime.now)
  end

  private

  def _rating_from_source_by_company(source:, company:)
    client = _source_to_client(source)
    Allocator.public_send(client).analysis_by_company(company)
  rescue StandardError => e
    Rails.logger.error("Analysis failed for client: #{source.to_s}. Symbol: #{company.symbol}. Error: #{e.message}")
    Entities::ExternalAnalyses::Analysis.null_object_with_source(source)
  end

  def _rating_from_source_by_symbol(source:, symbol:)
    client = _source_to_client(source)
    Allocator.public_send(client).analysis_by_symbol(symbol)
  rescue StandardError => e
    Rails.logger.error("Analysis failed for client: #{source.to_s}. Symbol: #{symbol}. Error: #{e.message}")
    Entities::ExternalAnalyses::Analysis.null_object_with_source(source)
  end

  private

  def _source_to_client(source)
    "#{source}_client".to_sym
  end
end
