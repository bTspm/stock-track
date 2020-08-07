require "rails_helper"

describe BasicSearchMatcher do
  let(:search_text) { "ABC" }
  let(:matcher) { described_class.new(search_text) }

  describe "#build_query" do
    context "name_symbol_query" do
      subject { matcher.build_query[:query][:bool][:should][0][:match] }
      it "expect to include name_symbol_query with boost" do
        expect(subject).to eq(name_symbol: { query: "ABC", boost: 1.5, analyzer: "standard" })
      end
    end

    context "symbol_query" do
      subject { matcher.build_query[:query][:bool][:should][1][:match] }
      it "expect to include name_symbol_query with boost" do
        expect(subject).to eq(symbol: { query: "ABC", boost: 500 })
      end
    end

    context "meta" do
      context "source" do
        subject { matcher.build_query[:_source] }
        it "expect to include source" do
          expect(subject).to match_array %w[exchange_country_alpha2
                                                  exchange_country_code
                                                  exchange_name
                                                  name
                                                  security_name
                                                  symbol]
        end
      end
    end
  end
end
