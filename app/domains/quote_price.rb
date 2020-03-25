class QuotePrice
  def initialize(args = {})
    @amount = args[:amount]
    @change = args[:change]
    @change_percent = args[:change_percent]
  end
end
