module Scraper
  class BaseScraper
    def initialize
      @browser = Watir::Browser.new :chrome, _options
    end

    def get_response
      yield(self)
    ensure
      @browser.close
    end

    private

    def _options
      options = { headless: true }
      # When using from local development, it uses the chrome installed in the system.
      # Hence not passing the binary.
      return options if Rails.env.development?

      options.merge(options: { binary: ENV["WD_CHROME_PATH"] })
    end
  end
end
