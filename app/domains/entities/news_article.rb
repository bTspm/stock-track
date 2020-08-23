module Entities
  class NewsArticle < BaseEntity
    ATTRIBUTES = %i[datetime
                    headline
                    image
                    language
                    related
                    source
                    summary
                    url].freeze

    attr_accessor *ATTRIBUTES

    def self.from_iex_response(response)
      args = {
        datetime: response[:datetime]&.to_datetime,
        headline: response[:headline],
        image: response[:image],
        language: response[:lang],
        related: response[:related],
        source: response[:source],
        summary: response[:summary],
        url: response[:url]
      }

      new(args)
    end
  end
end
