module Scraper
  module Github
    class Client < ::BaseClient
      def snp500_symbols
        get "https://raw.githubusercontent.com/datasets/s-and-p-500-companies/master/data/constituents_symbols.txt"
      end
    end
  end
end
