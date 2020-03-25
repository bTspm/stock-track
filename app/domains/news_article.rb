  class NewsArticle

    attr_reader :datetime,
                :has_paywall,
                :headline,
                :image,
                :language,
                :related,
                :source,
                :summary,
                :url

    def initialize(response = {})
      @datetime = response[:datetime]
      @has_paywall = response[:hasPaywall]
      @headline = response[:headline]
      @image = response[:image]
      @language = response[:lang]
      @related = response[:related]
      @source = response[:source]
      @summary = response[:summary]
      @url = response[:url]
    end

  end

