require "rails_helper"

describe Entities::Stock do
  it_behaves_like "Entities::BaseEntity#initialize"

  let(:args) do
    {
      company: company,
      growth: growth,
      quote: quote,
      stats: stats,
    }
  end
  let(:company) { double(:company) }
  let(:growth) { double(:growth) }
  let(:quote) { double(:quote) }
  let(:stats) { double(:stats) }
  let(:stock) { described_class.new(args) }
end
