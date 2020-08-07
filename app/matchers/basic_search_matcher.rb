class BasicSearchMatcher
  SECURITY_NAME_BOOST = 1.5
  STANDARD_ANALYZER = "standard".freeze
  SYMBOL_BOOST = 500

  def initialize(search_text)
    @search_text = search_text
  end

  def build_query
    matches = []
    matches << _name_symbol_query
    matches << _symbol_query
    { query: { bool: { should: matches } }, _source: _source }
  end

  private

  def _name_symbol_query
    { match: { name_symbol: { query: @search_text, boost: SECURITY_NAME_BOOST, analyzer: STANDARD_ANALYZER } } }
  end

  def _source
    %w[exchange_country_alpha2
         exchange_country_code
         exchange_name
         name
         security_name
         symbol]
  end

  def _symbol_query
    { match: { symbol: { query: @search_text, boost: SYMBOL_BOOST } } }
  end
end
