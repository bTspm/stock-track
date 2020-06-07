require "rails_helper"

describe Entities::NewsArticle do
  it_behaves_like "Entities::BaseEntity#initialize"

  let(:args) do
    {
      datetime: datetime,
      headline: headline,
      image: image,
      language: language,
      related: related,
      source: source,
      summary: summary,
      url: url
    }
  end
  let(:datetime) { double(:datetime) }
  let(:headline) { double(:headline) }
  let(:image) { double(:image) }
  let(:language) { double(:language) }
  let(:related) { double(:related) }
  let(:source) { double(:source) }
  let(:summary) { double(:summary) }
  let(:url) { double(:url) }

  describe ".from_iex_response" do
    let(:args) do
      {
        datetime: converted_datetime,
        headline: "Apple says nearly 100 of its stores have reopened globally",
        image: "https://cloud.iexapis.com/v1/news/image/4f8d347e-62b0-4a79-bd10-183fa469ce05",
        language: "en",
        related: "AAPL",
        source: "South China Morning Post",
        summary: "News Summary",
        url: "https://cloud.iexapis.com/v1/news/article/4f8d347e-62b0-4a79-bd10-183fa469ce05"
      }
    end
    let(:converted_datetime) { DateTime.new(2020, 0o1, 0o1, 0o0, 0o0, 0o0) }
    let!(:response) { json_fixture("/api_responses/iex/news.json").last }

    subject { described_class.from_iex_response(response) }

    it "expect to create an entity with args" do
      expect(described_class).to receive(:new).with(args)

      subject
    end
  end
end
