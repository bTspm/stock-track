module Entities
  class NewsArticle < ::Entities::BaseEntity
    ATTRIBUTES = %i[datetime
                    headline
                    image
                    language
                    related
                    source
                    summary
                    url].freeze

    attr_reader *ATTRIBUTES

    def self.from_iex_response(response)
      args = {
       datetime: DateTime.strptime(response[:datetime].to_s,'%Q'),
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
